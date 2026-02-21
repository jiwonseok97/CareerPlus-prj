# CareerPlus-prj

CareerPlus는 구인구직 플랫폼 프로젝트입니다.  
이 저장소는 **성능 개선(캐시/알림/DB 라우팅/쿼리 튜닝)** 과 **검증 가능한 측정 자료**를 함께 제공합니다.

## 프로젝트 개요

- 기간: 2024.03 ~ 2024.06
- 인원: 5명 (Backend 3 / Frontend 2)
- 형태: KOSMO 풀스택 교육과정 최종 프로젝트
- 담당: Backend (검색, 알림, 캐시, DB 라우팅, 쿼리 최적화)

## 핵심 개선 내용

1. 캐시 고도화
- Spring Cache + Redis + Caffeine(2-Level)
- `@Cacheable`, `@CacheEvict`, `@Caching` 적용
- 조회 트래픽 완화 및 DB 접근 감소

2. 실시간/대량 알림
- SSE 실시간 푸시
- Redis Pub/Sub 멀티 인스턴스 동기화
- Redis Stream + Consumer Group 대량 비동기 처리
- 채널 전략 패턴(`NotificationChannel` + Handler + Dispatcher Map)

3. DB 이중화 라우팅
- Master/Slave 분리
- `@Transactional(readOnly=true)` -> Slave
- Write -> Master
- `LazyConnectionDataSourceProxy`로 트랜잭션 컨텍스트 기반 라우팅

4. 인덱스/쿼리 최적화
- 검색/정렬/중복 체크 구간 중심 튜닝
- 실행계획 기반 개선

## 성과 요약

- 메인 조회 응답시간: **245ms -> 6ms** (Cache HIT 기준)
- 요청당 DB 접근: 다중 조회 -> **0회** (Cache HIT 기준)
- 단건 알림 중심 구조 -> 대량 비동기 파이프라인 전환

## 기술 스택

- Backend: Java, Spring Boot, Spring MVC, Spring Cache, Spring Data Redis
- Data: Oracle, MyBatis, Redis, Caffeine
- Build: Gradle
- Frontend/View: JSP, JavaScript, SSE
- Collaboration: GitHub

## 주요 코드 위치

- 알림
  - `src/main/java/com/wa/erp/notification/NotificationSseService.java`
  - `src/main/java/com/wa/erp/notification/NotificationQueueService.java`
  - `src/main/java/com/wa/erp/notification/NotificationStreamConsumer.java`
  - `src/main/java/com/wa/erp/config/RedisNotificationConfig.java`
- 캐시
  - `src/main/java/com/wa/erp/BoardServiceImpl.java`
  - `src/main/java/com/wa/erp/RegUpDelServiceImpl.java`
- DB 라우팅
  - `src/main/java/com/wa/erp/config/datasource/ReplicationRoutingDataSource.java`
  - `src/main/java/com/wa/erp/config/datasource/DatabaseReplicationConfig.java`
- 설정
  - `src/main/resources/application.properties`

## 벤치마크/검증 자료

- 검증 리포트: `docs/metrics/validation_report.md`
- 실측 데이터: `docs/metrics/redis_benchmark_results.json`
- 시각화:
  - `docs/metrics/throughput_ops_sec.png`
  - `docs/metrics/latency_ms.png`
  - `docs/metrics/benchmark_dashboard.png`
  - `docs/metrics/stream_vs_cache_comparison.png`

## 실행 가이드

### 1) 애플리케이션 실행

```bash
./gradlew bootRun
```

Windows:

```powershell
.\gradlew.bat bootRun
```

### 2) Redis 실측 벤치마크

```powershell
python docs/metrics/run_redis_benchmarks.py
python docs/metrics/generate_charts.py
```

### 3) API 부하 테스트 (k6)

설치:

```powershell
choco install k6 -y
```

실행:

```powershell
k6 run docs/metrics/k6_careerplus.js
```

### 4) 전체 재현 커맨드 (한 줄)

```powershell
python docs/metrics/run_redis_benchmarks.py && python docs/metrics/generate_charts.py
```

## 참고 문서

- 포트폴리오 문서: `docs/realtime_notification_and_db_replication.md`
- 요구사항 기반 기술선정 상세: `docs/portfolio_requirement_details.md`
- 벤치마크 플레이북: `docs/metrics/benchmark_playbook.md`

