"""
Run Redis benchmarks for recruiter-facing performance evidence.

Outputs:
  - docs/metrics/redis_benchmark_results.json

Requirements:
  - Python 3.9+
  - redis-py
  - Local Redis running (default: localhost:6379)
"""

from __future__ import annotations

import argparse
import json
import statistics
import time
from datetime import datetime
from pathlib import Path
from typing import Dict, List

import redis


def percentile(values: List[float], p: float) -> float:
    if not values:
        return 0.0
    values_sorted = sorted(values)
    idx = int(round((p / 100.0) * (len(values_sorted) - 1)))
    return values_sorted[idx]


def measure_ping(client: redis.Redis, count: int = 200) -> Dict[str, float]:
    samples: List[float] = []
    for _ in range(count):
        start = time.perf_counter()
        client.ping()
        elapsed_ms = (time.perf_counter() - start) * 1000.0
        samples.append(elapsed_ms)
    return {
        "count": count,
        "avg": round(statistics.mean(samples), 3),
        "p95": round(percentile(samples, 95), 3),
        "max": round(max(samples), 3),
    }


def measure_set(client: redis.Redis, ops: int = 20000, key_prefix: str = "bench:set:") -> Dict[str, float]:
    latencies_ms: List[float] = []
    start_all = time.perf_counter()
    for i in range(ops):
        key = f"{key_prefix}{i}"
        start = time.perf_counter()
        client.set(key, "v")
        latencies_ms.append((time.perf_counter() - start) * 1000.0)
    total_sec = time.perf_counter() - start_all
    return {
        "ops": ops,
        "total_sec": round(total_sec, 3),
        "ops_per_sec": round(ops / total_sec, 1),
        "avg_ms": round(statistics.mean(latencies_ms), 3),
        "p95_ms": round(percentile(latencies_ms, 95), 3),
    }


def measure_get(client: redis.Redis, ops: int = 20000, key_prefix: str = "bench:set:") -> Dict[str, float]:
    latencies_ms: List[float] = []
    start_all = time.perf_counter()
    for i in range(ops):
        key = f"{key_prefix}{i}"
        start = time.perf_counter()
        client.get(key)
        latencies_ms.append((time.perf_counter() - start) * 1000.0)
    total_sec = time.perf_counter() - start_all
    return {
        "ops": ops,
        "total_sec": round(total_sec, 3),
        "ops_per_sec": round(ops / total_sec, 1),
        "avg_ms": round(statistics.mean(latencies_ms), 3),
        "p95_ms": round(percentile(latencies_ms, 95), 3),
    }


def measure_xadd(
    client: redis.Redis,
    stream_key: str = "bench:stream",
    ops: int = 100000,
) -> Dict[str, float]:
    client.delete(stream_key)
    latencies_ms: List[float] = []
    start_all = time.perf_counter()
    for i in range(ops):
        start = time.perf_counter()
        client.xadd(stream_key, {"i": i, "payload": "x"})
        latencies_ms.append((time.perf_counter() - start) * 1000.0)
    total_sec = time.perf_counter() - start_all
    return {
        "ops": ops,
        "total_sec": round(total_sec, 3),
        "ops_per_sec": round(ops / total_sec, 1),
        "avg_ms": round(statistics.mean(latencies_ms), 3),
        "p95_ms": round(percentile(latencies_ms, 95), 3),
    }


def measure_read_ack(
    client: redis.Redis,
    stream_key: str = "bench:stream",
    group: str = "bench-group",
    consumer: str = "bench-consumer",
    total_ops: int = 100000,
    batch_size: int = 500,
) -> Dict[str, float]:
    # Reset consumer group for reproducible measurement
    try:
        client.xgroup_destroy(stream_key, group)
    except redis.ResponseError:
        pass

    try:
        client.xgroup_create(stream_key, group, id="0-0", mkstream=True)
    except redis.ResponseError as ex:
        if "BUSYGROUP" not in str(ex):
            raise

    target_batches = total_ops // batch_size
    processed = 0
    batch_latencies_ms: List[float] = []

    start_all = time.perf_counter()
    while processed < total_ops:
        start = time.perf_counter()
        records = client.xreadgroup(
            groupname=group,
            consumername=consumer,
            streams={stream_key: ">"},
            count=batch_size,
            block=5000,
        )
        if not records:
            continue

        # records = [(stream, [(id, {field: value})...])]
        ids: List[str] = []
        for _, entries in records:
            ids.extend([entry_id for entry_id, _ in entries])

        if ids:
            client.xack(stream_key, group, *ids)
            processed += len(ids)
            batch_latencies_ms.append((time.perf_counter() - start) * 1000.0)

    total_sec = time.perf_counter() - start_all
    return {
        "ops": total_ops,
        "batch_size": batch_size,
        "batches": target_batches,
        "total_sec": round(total_sec, 3),
        "ops_per_sec": round(total_ops / total_sec, 1),
        "avg_batch_ms": round(statistics.mean(batch_latencies_ms), 3),
        "p95_batch_ms": round(percentile(batch_latencies_ms, 95), 3),
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--host", default="localhost")
    parser.add_argument("--port", type=int, default=6379)
    parser.add_argument("--db", type=int, default=0)
    parser.add_argument("--output", default="docs/metrics/redis_benchmark_results.json")
    args = parser.parse_args()

    client = redis.Redis(host=args.host, port=args.port, db=args.db, decode_responses=True)
    client.ping()

    ping = measure_ping(client, count=200)
    set_20k = measure_set(client, ops=20000)
    get_20k = measure_get(client, ops=20000)
    xadd_100k = measure_xadd(client, stream_key="bench:stream", ops=100000)
    read_ack_100k = measure_read_ack(
        client,
        stream_key="bench:stream",
        group="bench-group",
        consumer="bench-consumer",
        total_ops=100000,
        batch_size=500,
    )

    result = {
        "timestamp": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
        "benchmarks": {
            "ping_ms": ping,
            "cache_set_20k": set_20k,
            "cache_get_20k": get_20k,
            "stream_xadd_100k": xadd_100k,
            "stream_read_ack_100k": read_ack_100k,
        },
    }

    output_path = Path(args.output)
    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_text(json.dumps(result, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"[OK] wrote {output_path}")


if __name__ == "__main__":
    main()


