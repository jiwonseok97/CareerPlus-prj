# CareerPlus-prj

CareerPlus는 구인구직 서비스 프로젝트입니다. 이 저장소는 기능 구현 코드뿐 아니라, 성능 개선 과정과 검증 자료까지 함께 관리합니다.

## 프로젝트 개요

- 기간: 2024.03 ~ 2024.06
- 인원: 5명 (Backend 3 / Frontend 2)
- 형태: KOSMO 풀스택 교육과정 최종 프로젝트
- 담당: Backend (검색, 알림, 캐시, DB 라우팅, 쿼리 최적화)

## 내가 집중한 개선 포인트

1. 조회 성능
- Spring Cache + Redis + Caffeine(2-Level) 적용
- `@Cacheable`, `@CacheEvict`, `@Caching`으로 조회/갱신 경로 분리

2. 알림 아키텍처
- SSE로 실시간 사용자 알림 제공
- Redis Pub/Sub로 멀티 인스턴스 동기화
- Redis Stream + Consumer Group으로 대량 발송 파이프라인 구성

3. DB 부하 분산
- Master/Slave 라우팅 적용
- 읽기 트랜잭션과 쓰기 트랜잭션 경로 분리

4. SQL/인덱스 튜닝
- 검색/정렬/중복체크 쿼리 중심으로 실행계획 확인
- 인덱스 재배치로 Full Scan 구간 축소

## 성과 요약

- 메인 조회 응답시간: **245ms -> 6ms** (Cache HIT 기준)
- 요청당 DB 접근: **다중 조회 -> 0회** (Cache HIT 기준)
- 단건 알림 구조에서 대량 비동기 파이프라인으로 전환

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

## 검증 자료

- 검증 리포트: `docs/metrics/validation_report.md`
- 실측 데이터(JSON): `docs/metrics/redis_benchmark_results.json`
- 시각화
  - `docs/metrics/throughput_ops_sec.png`
  - `docs/metrics/latency_ms.png`
  - `docs/metrics/benchmark_dashboard.png`
  - `docs/metrics/stream_vs_cache_comparison.png`
- 재현 가이드: `docs/metrics/benchmark_playbook.md`

## 실행 방법

### 애플리케이션

```bash
./gradlew bootRun
```

Windows:

```powershell
.\gradlew.bat bootRun
```

### Redis 실측 + 차트 생성

```powershell
python docs/metrics/run_redis_benchmarks.py
python docs/metrics/generate_charts.py
```

### API 부하 테스트 (k6)

```powershell
choco install k6 -y
k6 run docs/metrics/k6_careerplus.js
```

## 관련 문서

- 포트폴리오 본문: `docs/realtime_notification_and_db_replication.md`
- 요구사항 기반 기술선정: `docs/portfolio_requirement_details.md`
- DB 최적화 노트: `docs/portfolio_db_optimization.md`
