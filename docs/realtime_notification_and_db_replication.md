# CareerPlus - 채용포털 성능 개선 포트폴리오

레포지토리: [CareerPlus-prj](https://github.com/jiwonseok97/CareerPlus-prj)

## 소개

- 트래픽이 늘어날 때 병목을 먼저 찾고, 근거 기반으로 개선안을 만드는 백엔드 개발자
- 기능 구현뿐 아니라 운영 관점(확장성, 장애 대응, 데이터 일관성)까지 함께 고려
- 성과 수치만 제시하지 않고, 문제 정의와 검증 과정까지 설명 가능한 개발 방식 지향

## 프로젝트 개요

- 프로젝트: CareerPlus (구인구직 플랫폼)
- 기간: 2024.03 ~ 2024.06
- 인원: 5명 (Backend 3 / Frontend 2)
- 역할: Backend 담당 (검색/알림/캐시/DB 라우팅/쿼리 최적화)

한 줄 요약:

`조회 트래픽이 많은 서비스에서 캐시 + 비동기 알림 + DB Read/Write 분리를 결합해 응답속도와 안정성을 함께 개선`

## 담당 역할

| 도메인 | 핵심 기능 | 성능/안정화 포인트 |
|---|---|---|
| 채용 공고 | CRUD, 검색/정렬, 조회수/관심공고 | 메인 리스트 조회 캐시 적용, 갱신 시 연관 캐시 무효화 |
| 프리랜서 | 프로필/타임쉐어 등록·수정, 조건 조회 | 사용자/조건 기준 조회 경로 분리 |
| 개인 마이페이지 | 내 정보, 작성글, 이력서, 지원/스카우트 목록 조회 | 세션(`p_no`) 기준 사용자 스코프 고정, 기능별 쿼리 분리 |
| 부업 | 게시글 CRUD, 필터링, 지원 흐름 | 조회/등록 경로 분리, 중복 체크 로직 정리 |

## 기술 스택

- Backend: Java, Spring Boot, Spring MVC, Spring Cache, Spring Data Redis
- Data: Oracle, MyBatis, Redis, Caffeine
- Build: Gradle
- Frontend/View: JSP, JavaScript, SSE
- Collaboration: GitHub

## 요구사항 기반 기술 선택

1. 실시간 사용자 알림
- 선택: SSE
- 이유: 단방향 푸시 요구에 적합하고 운영 복잡도가 낮음
- [상세보기](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/NotificationSseService.java)

2. 멀티 인스턴스 알림 동기화
- 선택: Redis Pub/Sub
- 이유: 인스턴스 간 fan-out 전달 구조가 단순함
- [상세보기](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/config/RedisNotificationConfig.java)

3. 대량 알림 처리(100만+)
- 선택: Redis Stream + Consumer Group
- 이유: 적재/소비 분리와 ACK 기반 재처리가 가능함
- [상세보기](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/NotificationQueueService.java)

4. 반복 조회 부하 완화
- 선택: Caffeine(L1) + Redis(L2)
- 이유: 로컬 저지연 + 분산 캐시 공유를 동시에 확보
- [상세보기](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/BoardServiceImpl.java)

5. DB 읽기 부하 분산
- 선택: Master/Slave 라우팅
- 이유: Read/Write 경로 분리로 Master 집중 부하 완화
- [상세보기](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/config/datasource/DatabaseReplicationConfig.java)

## 문제 -> 과정 -> 해결

### 1) 캐시 고도화
- 문제: 동일 데이터 반복 조회로 요청당 DB 접근 증가
- 과정: 조회 빈도/변경 빈도 분석 -> 캐시 후보 선정 -> TTL(3~30분) 차등 적용
- 해결: `@Cacheable`, `@CacheEvict`, `@Caching` + 2-Level 캐시
- 코드:
  - [BoardServiceImpl.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/BoardServiceImpl.java)
  - [RegUpDelServiceImpl.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/RegUpDelServiceImpl.java)

### 2) 알림 시스템 고도화
- 문제: 문자열 분기 구조 확장 한계, 단건 발송 병목
- 과정: 채널 추상화 -> 전략 패턴 -> 큐 기반 비동기 전환
- 해결: `NotificationChannel + Handler + Dispatcher Map`, `SSE + Pub/Sub + Stream`
- 코드:
  - [NotificationDispatchService.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/NotificationDispatchService.java)
  - [NotificationStreamConsumer.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/NotificationStreamConsumer.java)

### 3) DB 이중화
- 문제: 조회 트래픽 집중 시 Master 부하 증가
- 해결: `@Transactional(readOnly=true)`는 Slave, Write는 Master 라우팅
- 코드:
  - [ReplicationRoutingDataSource.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/config/datasource/ReplicationRoutingDataSource.java)
  - [DatabaseReplicationConfig.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/config/datasource/DatabaseReplicationConfig.java)

### 4) 인덱스/쿼리 튜닝
- 문제: 검색/정렬/중복체크 구간 Full Scan 위험
- 과정: WHERE/ORDER BY 패턴 분석 + 실행계획 비교
- 해결: 복합/단일 인덱스 재설계 및 쿼리 경로 정리

## 성능 검증 자료

### Redis 처리량/지연 검증
- 검증 내용: SET/GET/XADD/READ+ACK 처리량, 평균 지연, p95 측정
- 리포트: [validation_report.md](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/docs/metrics/validation_report.md)
- 원본 JSON: [redis_benchmark_results.json](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/docs/metrics/redis_benchmark_results.json)
- 실측 스크립트: [run_redis_benchmarks.py](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/docs/metrics/run_redis_benchmarks.py)

### 시각화
- Throughput: ![Throughput](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/docs/metrics/throughput_ops_sec.png?raw=1)
- Latency: ![Latency](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/docs/metrics/latency_ms.png?raw=1)
- Dashboard: ![Dashboard](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/docs/metrics/benchmark_dashboard.png?raw=1)
- Cache vs Stream: ![Cache vs Stream](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/docs/metrics/stream_vs_cache_comparison.png?raw=1)

## 성과

- 메인 조회 응답시간: **245ms -> 6ms** (Cache HIT 기준)
- 요청당 DB 접근: **다중 조회 -> 0회** (Cache HIT 기준)
- 단건 알림 구조를 대량 비동기 파이프라인으로 전환
- 신규 채널 추가 시 Handler 중심 확장 가능

## 트러블슈팅

1. 채널 분기 복잡도 증가
- 조치: enum + 전략 패턴 도입

2. Redis 초기화 실패 리스크
- 조치: Lazy init + BUSYGROUP/연결 예외 처리

3. 대량 알림 병목
- 조치: 청크 분할 + 병렬 enqueue + batch consume

근거:
- [compile_failure.log](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/docs/metrics/compile_failure.log)
- [measured_results.json](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/docs/metrics/measured_results.json)

## 회고

- 성능 개선은 한 가지 기술이 아니라 구조 설계 문제라는 점을 체감함
- "요구사항 -> 병목 식별 -> 검증 가능한 해결" 흐름이 프로젝트 설득력의 핵심
- 다음 단계: Stream 샤딩, DLQ 운영 기준, lag 모니터링 자동화
