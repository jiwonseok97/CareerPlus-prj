"""
Generate benchmark charts from redis_benchmark_results.json.
"""

from __future__ import annotations

import json
from pathlib import Path

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt


ROOT = Path(__file__).resolve().parent
INPUT_JSON = ROOT / "redis_benchmark_results.json"


def load_data() -> dict:
    return json.loads(INPUT_JSON.read_text(encoding="utf-8"))


def chart_throughput(data: dict) -> None:
    b = data["benchmarks"]
    labels = ["SET (20k)", "GET (20k)", "Stream XADD (100k)", "Stream READ+ACK (100k)"]
    values = [
        b["cache_set_20k"]["ops_per_sec"],
        b["cache_get_20k"]["ops_per_sec"],
        b["stream_xadd_100k"]["ops_per_sec"],
        b["stream_read_ack_100k"]["ops_per_sec"],
    ]
    colors = ["#82B366", "#5A9950", "#D6A94A", "#AE4132"]

    fig, ax = plt.subplots(figsize=(10.5, 6))
    ax.set_facecolor("#1C1C2E")
    fig.patch.set_facecolor("#1C1C2E")

    bars = ax.barh(labels, values, color=colors, height=0.55)
    ax.invert_yaxis()
    ax.set_xlabel("Throughput (ops/sec)", color="#CCCCDD")
    ax.set_title("Redis Benchmark Throughput", color="white", fontsize=15, fontweight="bold")
    ax.grid(axis="x", color="#333355", linewidth=0.8)
    ax.tick_params(colors="#CCCCDD")
    for s in ax.spines.values():
        s.set_visible(False)

    for bar, val in zip(bars, values):
        ax.text(val + max(values) * 0.01, bar.get_y() + bar.get_height() / 2, f"{val:,.1f} ops/s", va="center", color="white", fontweight="bold")

    fig.tight_layout()
    fig.savefig(ROOT / "throughput_ops_sec.png", dpi=150, bbox_inches="tight", facecolor=fig.get_facecolor())
    plt.close(fig)


def chart_latency(data: dict) -> None:
    b = data["benchmarks"]
    labels = ["SET (20k)", "GET (20k)", "Stream XADD (100k)"]
    avg = [b["cache_set_20k"]["avg_ms"], b["cache_get_20k"]["avg_ms"], b["stream_xadd_100k"]["avg_ms"]]
    p95 = [b["cache_set_20k"]["p95_ms"], b["cache_get_20k"]["p95_ms"], b["stream_xadd_100k"]["p95_ms"]]

    x = list(range(len(labels)))
    width = 0.35

    fig, ax = plt.subplots(figsize=(10.5, 6))
    ax.set_facecolor("#1C1C2E")
    fig.patch.set_facecolor("#1C1C2E")

    bars1 = ax.bar([i - width / 2 for i in x], avg, width, label="Avg", color="#6FA36F")
    bars2 = ax.bar([i + width / 2 for i in x], p95, width, label="p95", color="#9DC97D")

    ax.set_xticks(x)
    ax.set_xticklabels(labels, color="#CCCCDD")
    ax.set_ylabel("Latency (ms)", color="#CCCCDD")
    ax.set_title("Redis Benchmark Latency (Avg vs p95)", color="white", fontsize=15, fontweight="bold")
    ax.grid(axis="y", color="#333355", linewidth=0.8)
    ax.tick_params(colors="#CCCCDD")
    ax.legend(facecolor="#2A2A3E", edgecolor="#555577", labelcolor="#CCCCDD")
    for s in ax.spines.values():
        s.set_visible(False)

    for bars in (bars1, bars2):
        for bar in bars:
            h = bar.get_height()
            ax.text(bar.get_x() + bar.get_width() / 2, h + 0.01, f"{h:.3f}", ha="center", color="white", fontweight="bold")

    fig.tight_layout()
    fig.savefig(ROOT / "latency_ms.png", dpi=150, bbox_inches="tight", facecolor=fig.get_facecolor())
    plt.close(fig)


def chart_stream_vs_cache(data: dict) -> None:
    b = data["benchmarks"]
    labels = ["SET", "GET", "XADD", "READ+ACK"]
    values = [
        b["cache_set_20k"]["ops_per_sec"],
        b["cache_get_20k"]["ops_per_sec"],
        b["stream_xadd_100k"]["ops_per_sec"],
        b["stream_read_ack_100k"]["ops_per_sec"],
    ]

    fig, ax = plt.subplots(figsize=(10, 5.5))
    ax.set_facecolor("#1C1C2E")
    fig.patch.set_facecolor("#1C1C2E")

    bars = ax.bar(labels, values, color=["#82B366", "#5A9950", "#D6A94A", "#AE4132"], width=0.6)
    ax.set_ylabel("Throughput (ops/sec)", color="#CCCCDD")
    ax.set_title("Cache vs Stream Throughput", color="white", fontsize=15, fontweight="bold")
    ax.grid(axis="y", color="#333355", linewidth=0.8)
    ax.tick_params(colors="#CCCCDD")
    for s in ax.spines.values():
        s.set_visible(False)

    for bar, val in zip(bars, values):
        ax.text(bar.get_x() + bar.get_width() / 2, val + max(values) * 0.015, f"{val:,.1f}", ha="center", color="white", fontweight="bold")

    fig.tight_layout()
    fig.savefig(ROOT / "stream_vs_cache_comparison.png", dpi=150, bbox_inches="tight", facecolor=fig.get_facecolor())
    plt.close(fig)


def chart_dashboard(data: dict) -> None:
    # Simple dashboard: reuse throughput and latency values
    b = data["benchmarks"]
    fig = plt.figure(figsize=(14, 9), facecolor="#12121E")

    ax1 = fig.add_subplot(2, 1, 1)
    ax1.set_facecolor("#1C1C2E")
    labels = ["SET (20k)", "GET (20k)", "XADD (100k)", "READ+ACK (100k)"]
    values = [
        b["cache_set_20k"]["ops_per_sec"],
        b["cache_get_20k"]["ops_per_sec"],
        b["stream_xadd_100k"]["ops_per_sec"],
        b["stream_read_ack_100k"]["ops_per_sec"],
    ]
    bars = ax1.barh(labels, values, color=["#82B366", "#5A9950", "#D6A94A", "#AE4132"])
    ax1.invert_yaxis()
    ax1.grid(axis="x", color="#333355", linewidth=0.8)
    ax1.tick_params(colors="#CCCCDD")
    for s in ax1.spines.values():
        s.set_visible(False)
    for bar, val in zip(bars, values):
        ax1.text(val + max(values) * 0.01, bar.get_y() + bar.get_height() / 2, f"{val:,.1f}", va="center", color="white", fontweight="bold")
    ax1.set_title("Throughput", color="white", fontweight="bold")

    ax2 = fig.add_subplot(2, 2, 3)
    ax2.set_facecolor("#1C1C2E")
    labels2 = ["SET", "GET", "XADD"]
    avg2 = [b["cache_set_20k"]["avg_ms"], b["cache_get_20k"]["avg_ms"], b["stream_xadd_100k"]["avg_ms"]]
    p952 = [b["cache_set_20k"]["p95_ms"], b["cache_get_20k"]["p95_ms"], b["stream_xadd_100k"]["p95_ms"]]
    x2 = range(len(labels2))
    ax2.bar([i - 0.17 for i in x2], avg2, 0.34, label="Avg", color="#6FA36F")
    ax2.bar([i + 0.17 for i in x2], p952, 0.34, label="p95", color="#9DC97D")
    ax2.set_xticks(list(x2))
    ax2.set_xticklabels(labels2, color="#CCCCDD")
    ax2.grid(axis="y", color="#333355", linewidth=0.8)
    ax2.tick_params(colors="#CCCCDD")
    ax2.legend(facecolor="#2A2A3E", edgecolor="#555577", labelcolor="#CCCCDD")
    for s in ax2.spines.values():
        s.set_visible(False)
    ax2.set_title("Latency (ms)", color="white", fontweight="bold")

    ax3 = fig.add_subplot(2, 2, 4)
    ax3.set_facecolor("#1C1C2E")
    avg_batch = b["stream_read_ack_100k"]["avg_batch_ms"]
    p95_batch = b["stream_read_ack_100k"]["p95_batch_ms"]
    ax3.bar(["Avg batch", "p95 batch"], [avg_batch, p95_batch], color=["#E0B14F", "#D96C6C"])
    ax3.grid(axis="y", color="#333355", linewidth=0.8)
    ax3.tick_params(colors="#CCCCDD")
    for s in ax3.spines.values():
        s.set_visible(False)
    ax3.set_title("READ+ACK Batch Latency", color="white", fontweight="bold")
    for i, v in enumerate([avg_batch, p95_batch]):
        ax3.text(i, v + 0.5, f"{v:.3f} ms", ha="center", color="white", fontweight="bold")

    fig.suptitle("Redis Benchmark Dashboard", color="white", fontsize=16, fontweight="bold")
    fig.tight_layout(rect=[0, 0, 1, 0.97])
    fig.savefig(ROOT / "benchmark_dashboard.png", dpi=150, bbox_inches="tight", facecolor=fig.get_facecolor())
    plt.close(fig)


def main() -> None:
    data = load_data()
    chart_throughput(data)
    chart_latency(data)
    chart_stream_vs_cache(data)
    chart_dashboard(data)
    print("[OK] charts generated")


if __name__ == "__main__":
    main()

