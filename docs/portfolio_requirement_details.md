# 요구사항 기반 기술 선정 

레포지토리: [CareerPlus-prj](https://github.com/jiwonseok97/CareerPlus-prj)

## 1. 실시간 사용자 알림 필요

### 선택 기술
- SSE

### 선택 이유
- 서버 -> 클라이언트 단방향 푸시 요구에 적합
- WebSocket 대비 구현/운영 복잡도 낮음

### 코드 상세
- [NotificationController.java (subscribe API)](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/NotificationController.java)
- [NotificationSseService.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/NotificationSseService.java)
- [header.jsp (EventSource 연동)](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/webapp/WEB-INF/views/header.jsp)

## 2. 멀티 인스턴스 알림 동기화 필요

### 선택 기술
- Redis Pub/Sub

### 선택 이유
- 인스턴스 간 fan-out 전달 단순
- 실시간 알림 브로드캐스트에 적합

### 코드 상세
- [NotificationPublisher.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/NotificationPublisher.java)
- [NotificationPubSubSubscriber.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/NotificationPubSubSubscriber.java)
- [RedisNotificationConfig.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/config/RedisNotificationConfig.java)

## 3. 대량 알림(100만+) 처리 필요

### 선택 기술
- Redis Stream + Consumer Group + 비동기 병렬

### 선택 이유
- 적재/소비 분리 구조로 병목 분산
- ACK 기반 재처리 가능
- 소비자 수평 확장 가능

### 코드 상세
- [PopularJobNotificationService.java (청크 enqueue)](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/PopularJobNotificationService.java)
- [NotificationQueueService.java (Stream 직렬화/역직렬화)](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/NotificationQueueService.java)
- [NotificationStreamConsumer.java (batch read + ack)](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/notification/NotificationStreamConsumer.java)
- [NotificationAsyncConfig.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/config/NotificationAsyncConfig.java)

## 4. 반복 조회 부하 완화 필요

### 선택 기술
- Caffeine (L1) + Redis (L2)

### 선택 이유
- 로컬 캐시로 초저지연 응답
- Redis 분산 캐시로 인스턴스 간 일관된 캐시 활용

### 코드 상세
- [application.properties (cache 타입/redis 설정)](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/resources/application.properties)
- [BoardServiceImpl.java (@Cacheable)](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/BoardServiceImpl.java)
- [RegUpDelServiceImpl.java (@CacheEvict/@Caching)](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/RegUpDelServiceImpl.java)

## 5. DB 읽기 부하 분산 필요

### 선택 기술
- Master/Slave 라우팅 DataSource

### 선택 이유
- Read/Write 분리로 Master 부하 완화
- 트랜잭션 readOnly 기준 자동 라우팅

### 코드 상세
- [ReplicationRoutingDataSource.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/config/datasource/ReplicationRoutingDataSource.java)
- [DatabaseReplicationConfig.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/config/datasource/DatabaseReplicationConfig.java)
- [DatabaseType.java](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/src/main/java/com/wa/erp/config/datasource/DatabaseType.java)
