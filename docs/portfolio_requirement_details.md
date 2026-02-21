# 요구사항 기반 기술 선택 상세

레포지토리: [CareerPlus-prj](https://github.com/jiwonseok97/CareerPlus-prj)

## 1) 실시간 사용자 알림

- 선택 기술: SSE
- 선택 이유:
  - 서버 -> 클라이언트 단방향 알림 요구에 적합
  - WebSocket 대비 구현 및 운영 복잡도가 낮음
- 관련 코드:
  - [NotificationController.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/NotificationController.java)
  - [NotificationSseService.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/NotificationSseService.java)
  - [header.jsp](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/webapp/WEB-INF/views/header.jsp)

## 2) 멀티 인스턴스 알림 동기화

- 선택 기술: Redis Pub/Sub
- 선택 이유:
  - 인스턴스 간 fan-out 전달 구조를 단순하게 유지 가능
  - 실시간 전달 지연이 작고 운영이 쉬움
- 관련 코드:
  - [NotificationPublisher.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/NotificationPublisher.java)
  - [NotificationPubSubSubscriber.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/NotificationPubSubSubscriber.java)
  - [RedisNotificationConfig.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/config/RedisNotificationConfig.java)

## 3) 대량 알림 처리 (100만+)

- 선택 기술: Redis Stream + Consumer Group + 비동기 병렬 처리
- 선택 이유:
  - 적재/소비 분리로 생산자-소비자 병목 분산
  - ACK 기반 재처리 및 장애 복구 여지 확보
  - 소비자 수평 확장 구조에 유리
- 관련 코드:
  - [PopularJobNotificationService.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/PopularJobNotificationService.java)
  - [NotificationQueueService.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/NotificationQueueService.java)
  - [NotificationStreamConsumer.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/NotificationStreamConsumer.java)
  - [NotificationAsyncConfig.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/config/NotificationAsyncConfig.java)

## 4) 반복 조회 부하 완화

- 선택 기술: Caffeine(L1) + Redis(L2)
- 선택 이유:
  - L1으로 인스턴스 내부 저지연 응답 확보
  - L2로 분산 환경에서 캐시 공유
  - 조회/갱신 분리 정책으로 일관성 관리
- 관련 코드:
  - [BoardServiceImpl.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/BoardServiceImpl.java)
  - [RegUpDelServiceImpl.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/RegUpDelServiceImpl.java)
  - [application.properties](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/resources/application.properties)

## 5) DB 읽기 부하 분산

- 선택 기술: Master/Slave 라우팅 DataSource
- 선택 이유:
  - Read/Write 분리로 Master 집중 부하 완화
  - 트랜잭션 읽기/쓰기 속성 기반으로 라우팅 자동화
- 관련 코드:
  - [ReplicationRoutingDataSource.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/config/datasource/ReplicationRoutingDataSource.java)
  - [DatabaseReplicationConfig.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/config/datasource/DatabaseReplicationConfig.java)
  - [DatabaseType.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/config/datasource/DatabaseType.java)

## 정리

핵심은 기능별로 기술을 나열한 것이 아니라, 각 요구사항의 운영 제약(지연, 확장, 장애 복구, 일관성)에 맞춰 기술을 배치했다는 점입니다.
