# 검증 리포트 (실측 기반)

## 1. 측정 개요

- 측정 대상: Redis cache/stream 처리량 및 지연
- 측정 환경:
  - Redis: `localhost:6379`
  - 단일 노드 로컬 환경
  - Stream READ+ACK batch size: `500`
- 원본 데이터: `docs/metrics/redis_benchmark_results.json`

## 2. 핵심 결과

| 항목 | 처리량 (ops/sec) | 평균 지연 (ms) | p95 (ms) |
|---|---:|---:|---:|
| Redis SET (20k) | 1,303.1 | 0.765 | 1.139 |
| Redis GET (20k) | 1,110.9 | 0.898 | 1.431 |
| Stream XADD (100k) | 1,189.5 | 0.840 | 1.236 |
| Stream READ+ACK (100k) | 9,586.4 | 52.156 (batch) | 60.274 (batch) |

해석 (2026-02-21 18:28 실측):

- SET/GET/XADD는 약 `1.1k ~ 1.3k ops/sec` 구간
- READ+ACK는 배치 처리로 `9.5k ops/sec` 수준
- 대량 알림 처리에서 batch 소비의 유효성을 확인

## 3. 시각화

### 처리량 비교

![Throughput](./throughput_ops_sec.png)

### 지연시간 (Avg vs p95)

![Latency](./latency_ms.png)

### 종합 대시보드

![Dashboard](./benchmark_dashboard.png)

### Cache vs Stream 처리량

![Cache vs Stream](./stream_vs_cache_comparison.png)

## 4. 실행 방법 (재현 가능)

```powershell
python docs/metrics/run_redis_benchmarks.py
python docs/metrics/generate_charts.py
```

## 5. 보완 포인트

- API 단 E2E 부하는 `k6`로 별도 측정: `docs/metrics/k6_careerplus.js`
- SQL 요청수는 요청 단위 집계 로그(p6spy/datasource-proxy)로 추가 정량화 권장
