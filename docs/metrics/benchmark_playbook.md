# CareerPlus Benchmark Playbook

이 문서는 포트폴리오 성과를 재현 가능한 방식으로 측정/시각화하기 위한 실행 가이드입니다.

## 1) Redis 처리량/지연 (실측)

실행:

```powershell
python docs/metrics/run_redis_benchmarks.py
python docs/metrics/generate_charts.py
```

산출물:

- `docs/metrics/redis_benchmark_results.json`
- `docs/metrics/throughput_ops_sec.png`
- `docs/metrics/latency_ms.png`
- `docs/metrics/stream_vs_cache_comparison.png`
- `docs/metrics/benchmark_dashboard.png`

## 2) API 성능 (k6)

사전 설치:

```powershell
choco install k6 -y
```

실행:

```powershell
k6 run docs/metrics/k6_careerplus.js
```

기본 타겟 URL 변경:

```powershell
$env:BASE_URL="http://localhost:8081"; k6 run docs/metrics/k6_careerplus.js
```

## 3) DB 접근 횟수 검증 (요청당 SQL count)

현 프로젝트는 MyBatis stdout 로그가 활성화되어 있어 SQL 발생 여부 확인이 가능합니다.

- 설정 위치: `src/main/resources/application.properties`
- 현재 값: `mybatis.configuration.log-impl=org.apache.ibatis.logging.stdout.StdOutImpl`

권장(정량화):

1. `datasource-proxy` 또는 `p6spy` 적용
2. 요청 단위 SQL count 로깅
3. 캐시 HIT/MISS 별 SQL count 비교표 작성

정리 예시:

- 캐시 HIT: `0 queries/request`
- 캐시 MISS: `N queries/request`

## 4) 결과 시각화

JSON에서 차트를 자동 생성합니다.

```powershell
python docs/metrics/generate_charts.py
```

## 5) 포트폴리오 반영 템플릿

### 성과 표

| 지표 | 개선 전 | 개선 후 | 기준 |
|---|---:|---:|---|
| 메인 조회 응답시간 | 245ms | 6ms | Cache HIT |
| 요청당 DB 접근 | 다중 조회 | 0회 | Cache HIT |
| 알림 처리 구조 | 단건 중심 | 비동기 파이프라인 | Stream + Consumer Group |

### 재현 커맨드(한 줄)

```powershell
python docs/metrics/run_redis_benchmarks.py && python docs/metrics/generate_charts.py
```

