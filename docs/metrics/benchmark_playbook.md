# 성능 측정 플레이북

포트폴리오에 실을 수치와 차트를 재현 가능하게 만들기 위한 실행 절차입니다.

## 1) Redis 처리량/지연 측정

실행:

```powershell
python docs/metrics/run_redis_benchmarks.py
```

산출물:

- `docs/metrics/redis_benchmark_results.json`

## 2) 차트 생성

실행:

```powershell
python docs/metrics/generate_charts.py
```

산출물:

- `docs/metrics/throughput_ops_sec.png`
- `docs/metrics/latency_ms.png`
- `docs/metrics/stream_vs_cache_comparison.png`
- `docs/metrics/benchmark_dashboard.png`

## 3) API 부하 테스트 (k6)

설치:

```powershell
choco install k6 -y
```

실행:

```powershell
k6 run docs/metrics/k6_careerplus.js
```

BASE URL 변경:

```powershell
$env:BASE_URL="http://localhost:8081"; k6 run docs/metrics/k6_careerplus.js
```

## 4) SQL 요청 수 검증

현재 프로젝트는 MyBatis stdout 로그를 통해 SQL 발생 여부를 확인할 수 있습니다.

- 설정 위치: `src/main/resources/application.properties`
- 설정 값: `mybatis.configuration.log-impl=org.apache.ibatis.logging.stdout.StdOutImpl`

정량 검증 권장 방식:

1. `p6spy` 또는 `datasource-proxy` 적용
2. 요청 단위 SQL count 기록
3. 캐시 HIT/MISS 비교표 작성

예시:

- Cache HIT: `0 queries/request`
- Cache MISS: `N queries/request`

## 5) 포트폴리오 반영 템플릿

| 지표 | 개선 전 | 개선 후 | 기준 |
|---|---:|---:|---|
| 메인 조회 응답시간 | 245ms | 6ms | Cache HIT |
| 요청당 DB 접근 | 다중 조회 | 0회 | Cache HIT |
| 알림 처리 구조 | 단건 중심 | 비동기 파이프라인 | Stream + Consumer Group |

## 6) 한 줄 재현 커맨드

```powershell
python docs/metrics/run_redis_benchmarks.py && python docs/metrics/generate_charts.py
```
