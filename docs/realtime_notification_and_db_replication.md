# CareerPlus Portfolio Links

레포지토리: [https://github.com/jiwonseok97/CareerPlus-prj](https://github.com/jiwonseok97/CareerPlus-prj)

## ⚙️ 문제 → 과정 → 해결

### 1) 캐시 고도화 (공고/마이페이지 중심)
- 문제: 동일/유사 데이터 반복 조회로 요청당 DB 접근 증가
- 과정: 조회 빈도 vs 변경 빈도 분석 -> 캐시 후보 분류 -> TTL 차등(3~30분) -> 무효화 지점 매핑
- 해결: `@Cacheable`, `@CacheEvict`, `@Caching` + L1 Caffeine/L2 Redis 2-Level 캐시

코드 상세:
- [application.properties (cache 설정)](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/resources/application.properties)
- [BoardServiceImpl.java (@Cacheable)](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/BoardServiceImpl.java)
- [RegUpDelServiceImpl.java (@CacheEvict/@Caching)](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/RegUpDelServiceImpl.java)
- [CacheEvictService.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/service/CacheEvictService.java)
- [BoardDTO.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/BoardDTO.java)
- [BoardSearchDTO.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/BoardSearchDTO.java)

### 2) 알림 시스템 고도화 (공고/지원/프리랜서 연동)
- 문제: 문자열 분기 구조 확장성 한계 + 단건 처리 중심 구조의 대량 발송 병목
- 과정: 채널 추상화 설계 -> 전략 패턴 적용 -> 큐 기반 비동기 전환
- 해결:
  - `NotificationChannel enum + Handler + Dispatcher Map`
  - `SSE + Redis Pub/Sub + Redis Stream`
  - 청크 enqueue + batch consume + ACK

코드 상세:
- [NotificationController.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/NotificationController.java)
- [NotificationSseService.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/NotificationSseService.java)
- [NotificationPublisher.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/NotificationPublisher.java)
- [NotificationPubSubSubscriber.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/NotificationPubSubSubscriber.java)
- [NotificationQueueService.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/NotificationQueueService.java)
- [NotificationStreamConsumer.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/NotificationStreamConsumer.java)
- [NotificationChannel.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/NotificationChannel.java)
- [NotificationChannelHandler.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/NotificationChannelHandler.java)
- [InAppNotificationChannelHandler.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/InAppNotificationChannelHandler.java)
- [WebPushNotificationChannelHandler.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/WebPushNotificationChannelHandler.java)
- [EmailNotificationChannelHandler.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/EmailNotificationChannelHandler.java)
- [NotificationDispatchService.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/NotificationDispatchService.java)
- [RedisNotificationConfig.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/config/RedisNotificationConfig.java)
- [NotificationAsyncConfig.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/config/NotificationAsyncConfig.java)
- [header.jsp (SSE 프론트 연동)](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/webapp/WEB-INF/views/header.jsp)

### 3) DB 이중화 고도화
- 문제: 조회 트래픽 집중 시 Master 부하 증가 가능성
- 해결: `@Transactional(readOnly=true) -> Slave`, `Write -> Master`, `LazyConnectionDataSourceProxy` 적용

코드 상세:
- [ReplicationRoutingDataSource.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/config/datasource/ReplicationRoutingDataSource.java)
- [DatabaseReplicationConfig.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/config/datasource/DatabaseReplicationConfig.java)
- [DatabaseType.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/config/datasource/DatabaseType.java)
- [application.properties (DB replication 설정)](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/resources/application.properties)

### 4) 인덱스/쿼리 튜닝 (공고 검색 중심)
- 문제: 검색/정렬/중복체크 구간 Full Scan 위험
- 과정: 실제 WHERE/ORDER BY 패턴 분석 + 실행계획 비교
- 해결: 복합 인덱스 + 핵심 단일 인덱스 적용, 쿼리 경로 최적화

코드 상세(쿼리/호출 경로):
- [GonggoDAO.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/GonggoDAO.java)
- [mapper_Gonoggo.xml](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/resources/com/wa/erp/mapper_Gonoggo.xml)
- [MainController.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/MainController.java)

## 🧪 검증/테스트

- Redis Stream 100만 건 이상 시나리오 테스트
- 검증 포인트:
  - enqueue 처리량
  - consumer lag
  - ACK 성공률
  - 재시도 동작
- 운영 관점:
  - 단일 경로 병목 여부
  - 인스턴스 확장 시 처리량 증가 추세 확인

실측 자료:
- [validation_report.md](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/docs/metrics/validation_report.md)
- [redis_benchmark_results.json](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/docs/metrics/redis_benchmark_results.json)
- [throughput_ops_sec.png](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/docs/metrics/throughput_ops_sec.png)
- [latency_ms.png](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/docs/metrics/latency_ms.png)

## 📈 성과

- 메인 조회 응답시간: **245ms -> 6ms** (Cache HIT 기준)
- 요청당 DB 접근: 다중 조회 -> **0회** (Cache HIT 기준)
- 단건 알림 구조 -> 대량 비동기 파이프라인 전환
- 구조 성과: 신규 채널 추가 시 Handler 추가 중심으로 변경 범위 최소화

성과 근거 링크:
- [MainController.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/MainController.java)
- [BoardServiceImpl.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/BoardServiceImpl.java)
- [NotificationQueueService.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/NotificationQueueService.java)
- [NotificationStreamConsumer.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/NotificationStreamConsumer.java)

## 🧯 트러블슈팅

1. 채널 분기 복잡도 증가
  - 해결: enum + 전략 패턴 도입
  - 코드: [NotificationDispatchService.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/NotificationDispatchService.java)

2. Redis 초기화 실패 리스크
  - 해결: Lazy init + BUSYGROUP/연결 예외 처리
  - 코드: [NotificationQueueService.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/NotificationQueueService.java)

3. 대량 알림 병목
  - 해결: 청크 분할 + 병렬 enqueue + batch consume
  - 코드:
    - [PopularJobNotificationService.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/PopularJobNotificationService.java)
    - [NotificationStreamConsumer.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/NotificationStreamConsumer.java)

트러블슈팅 로그 근거:
- [compile_failure.log](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/docs/metrics/compile_failure.log)
