# 검증 리포트 (실측 기반)

## 1. 측정 개요

- 측정 일시: `2026-02-21 17:04:46`
- 환경:
  - Redis: `localhost:6379`
  - 단일 노드, 로컬 측정
  - Stream 소비 배치: `500`
- 데이터 소스: `docs/metrics/redis_benchmark_results.json`

## 2. 핵심 결과

| 항목 | 처리량 (ops/sec) | 평균 지연 (ms) | p95 (ms) |
|---|---:|---:|---:|
| Redis SET (20k) | 1,497.2 | 0.668 | 0.941 |
| Redis GET (20k) | 1,467.8 | 0.681 | 1.010 |
| Stream XADD (100k) | 1,414.2 | 0.707 | 1.101 |
| Stream READ+ACK (100k) | 8,923.0 | 56.035 (batch) | 64.317 (batch) |

해석:
- 캐시 SET/GET, Stream XADD는 모두 ~1.4k ops/sec 수준으로 유사
- Stream `READ+ACK`는 배치 처리 효과로 `8.9k ops/sec` 수준
- 대량 알림 파이프라인에서 소비 측 처리량 여유를 확인

## 3. 시각화

### 처리량 비교

![Throughput](./throughput_ops_sec.png)

### 지연시간 비교 (Avg vs p95)

![Latency](./latency_ms.png)

### 종합 대시보드

![Dashboard](./benchmark_dashboard.png)

### 캐시 vs 스트림 처리량 비교

![Cache vs Stream](./stream_vs_cache_comparison.png)

## 4. 검증 항목 및 방법

1. Redis PING 200회 지연 측정
2. 캐시 SET 20,000회 / GET 20,000회 측정
3. Stream XADD 100,000건 적재 측정
4. Consumer Group READ+ACK 100,000건 배치 소비 측정

사용 스크립트:
- `docs/metrics/generate_charts.py`

원본 결과:
- `docs/metrics/redis_benchmark_results.json`

## 5. 트러블슈팅 근거

### 이슈

- 프로젝트 `compileJava` 실패로 API E2E 성능 측정이 제한됨

### 근거 로그

- `docs/metrics/compile_failure.log`

핵심 에러:
- `java.lang.ExceptionInInitializerError`
- `Caused by: java.lang.NoSuchFieldException: com.sun.tools.javac.code.TypeTag :: UNKNOWN`
- `lombok.javac...` 관련 스택

### 분석

- Lombok annotation processor와 현재 JDK 조합 간 호환성 이슈로 판단

### 대응 방향

1. JDK toolchain 버전 고정(권장: 17)
2. Lombok 버전 상향 후 재빌드
3. 빌드 정상화 후 API 응답시간/처리량 E2E 재측정

## 6. 포트폴리오 기재 문구(권장)

- "Redis Stream 100,000건 실측에서 XADD 1,414.2 ops/sec, READ+ACK 8,923.0 ops/sec를 확인해 대량 알림 처리 구조의 실효성을 검증했습니다."
- "빌드 단계의 Lombok-JDK 호환 이슈를 로그 기반으로 원인 분리하고, 성능 검증 파이프라인을 복구 가능한 상태로 정리했습니다."
