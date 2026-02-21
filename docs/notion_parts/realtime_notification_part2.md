## 2) 200만명급 대용량 알림: 비동기/병렬 + Redis Stream (확장형)

### 1. 대량 enqueue 서비스

- 파일: `PopularJobNotificationService.java`
- 변경점:
  - 기본 채널 문자열 하드코딩 제거
  - enum 기반 채널 정규화 적용
  - 대상 사용자 청크 분할 + 병렬 enqueue

- 토글: PopularJobNotificationService.java 파일 내용

```java
package com.wa.erp.notification;

import com.wa.erp.notification.dto.NotificationMessage;
import com.wa.erp.notification.dto.PopularJobNotificationRequest;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.EnumSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.Executor;

@Service
public class PopularJobNotificationService {

    private static final Set<NotificationChannel> DEFAULT_CHANNELS = EnumSet.of(
            NotificationChannel.IN_APP,
            NotificationChannel.WEB_PUSH,
            NotificationChannel.EMAIL
    );

    private final NotificationQueueService notificationQueueService;
    private final Executor notificationTaskExecutor;
    private final int chunkSize;

    public PopularJobNotificationService(
            NotificationQueueService notificationQueueService,
            @Qualifier("notificationTaskExecutor") Executor notificationTaskExecutor,
            @Value("${notification.popular.chunk-size:1000}") int chunkSize
    ) {
        this.notificationQueueService = notificationQueueService;
        this.notificationTaskExecutor = notificationTaskExecutor;
        this.chunkSize = chunkSize;
    }

    public int enqueuePopularJob(PopularJobNotificationRequest request) {
        List<String> normalizedUserIds = normalizeUsers(request.getTargetUserIds());
        if (normalizedUserIds.isEmpty()) {
            return 0;
        }

        List<String> channels = normalizeChannels(request.getChannels());
        List<CompletableFuture<Integer>> futures = new ArrayList<>();

        for (int start = 0; start < normalizedUserIds.size(); start += chunkSize) {
            int end = Math.min(start + chunkSize, normalizedUserIds.size());
            List<String> chunk = normalizedUserIds.subList(start, end);

            futures.add(CompletableFuture.supplyAsync(() -> {
                int queued = 0;
                for (String userId : chunk) {
                    NotificationMessage message = NotificationMessage.of(
                            userId,
                            request.getTitle(),
                            request.getContent(),
                            request.getLinkUrl(),
                            "POPULAR_JOB",
                            channels
                    );
                    notificationQueueService.enqueue(message);
                    queued++;
                }
                return queued;
            }, notificationTaskExecutor));
        }

        CompletableFuture.allOf(futures.toArray(new CompletableFuture[0])).join();
        return futures.stream().mapToInt(CompletableFuture::join).sum();
    }

    private List<String> normalizeUsers(List<String> userIds) {
        if (userIds == null || userIds.isEmpty()) {
            return Collections.emptyList();
        }

        Set<String> deduplicated = new LinkedHashSet<>();
        for (String userId : userIds) {
            if (userId == null) {
                continue;
            }
            String normalized = userId.trim();
            if (!normalized.isEmpty()) {
                deduplicated.add(normalized);
            }
        }
        return new ArrayList<>(deduplicated);
    }

    private List<String> normalizeChannels(List<String> channels) {
        return NotificationChannel.normalizeNames(channels, DEFAULT_CHANNELS);
    }
}
```

### 2. Redis Stream 큐

- 파일: `NotificationQueueService.java`
- 변경점:
  - stream body 직렬화/역직렬화 시 enum 기반 정규화
  - 기본 채널 fallback 일관화

- 토글: NotificationQueueService.java 파일 내용

```java
package com.wa.erp.notification;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.wa.erp.notification.dto.NotificationMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.RedisSystemException;
import org.springframework.data.redis.RedisConnectionFailureException;
import org.springframework.data.redis.connection.stream.ReadOffset;
import org.springframework.data.redis.connection.stream.RecordId;
import org.springframework.data.redis.connection.stream.StreamRecords;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.util.EnumSet;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.atomic.AtomicBoolean;

@Service
public class NotificationQueueService {

    private static final Logger log = LoggerFactory.getLogger(NotificationQueueService.class);
    private static final TypeReference<List<String>> STRING_LIST = new TypeReference<List<String>>() {};
    private static final Set<NotificationChannel> DEFAULT_CHANNELS = EnumSet.of(NotificationChannel.IN_APP);

    private final StringRedisTemplate stringRedisTemplate;
    private final ObjectMapper objectMapper;
    private final String streamKey;
    private final String consumerGroup;
    private final AtomicBoolean consumerGroupReady = new AtomicBoolean(false);

    public NotificationQueueService(
            StringRedisTemplate stringRedisTemplate,
            ObjectMapper objectMapper,
            @Value("${notification.stream.key:careerplus:notifications:stream}") String streamKey,
            @Value("${notification.stream.consumer-group:careerplus-notification-group}") String consumerGroup
    ) {
        this.stringRedisTemplate = stringRedisTemplate;
        this.objectMapper = objectMapper;
        this.streamKey = streamKey;
        this.consumerGroup = consumerGroup;
    }

    @PostConstruct
    public void initConsumerGroup() {
        if (consumerGroupReady.get()) {
            return;
        }
        try {
            Boolean exists = stringRedisTemplate.hasKey(streamKey);
            if (Boolean.FALSE.equals(exists)) {
                Map<String, String> init = new HashMap<>();
                init.put("bootstrap", "true");
                stringRedisTemplate.opsForStream().add(StreamRecords.newRecord().in(streamKey).ofMap(init));
            }
            stringRedisTemplate.opsForStream().createGroup(streamKey, ReadOffset.latest(), consumerGroup);
            consumerGroupReady.set(true);
        } catch (RedisSystemException ex) {
            if (ex.getMessage() == null || !ex.getMessage().contains("BUSYGROUP")) {
                throw ex;
            }
            consumerGroupReady.set(true);
        } catch (RedisConnectionFailureException ex) {
            log.warn("Redis not available at startup. Stream consumer group init will retry lazily.");
        } catch (Exception ex) {
            String msg = ex.getMessage();
            if (msg == null || !msg.contains("BUSYGROUP")) {
                log.warn("Stream consumer group init deferred. cause={}", msg);
                return;
            }
            consumerGroupReady.set(true);
        }
    }

    public RecordId enqueue(NotificationMessage message) {
        initConsumerGroup();
        Map<String, String> body = toStreamBody(message);
        return stringRedisTemplate.opsForStream().add(StreamRecords.newRecord().in(streamKey).ofMap(body));
    }

    public NotificationMessage fromStreamBody(Map<?, ?> rawBody) {
        NotificationMessage message = new NotificationMessage();
        message.setId(readString(rawBody, "id"));
        message.setUserId(readString(rawBody, "userId"));
        message.setTitle(readString(rawBody, "title"));
        message.setContent(readString(rawBody, "content"));
        message.setLinkUrl(readString(rawBody, "linkUrl"));
        message.setType(readString(rawBody, "type"));

        String createdAt = readString(rawBody, "createdAtEpochMillis");
        if (createdAt != null && !createdAt.isEmpty()) {
            try {
                message.setCreatedAtEpochMillis(Long.parseLong(createdAt));
            } catch (NumberFormatException ignore) {
                message.setCreatedAtEpochMillis(System.currentTimeMillis());
            }
        }

        String channelsJson = readString(rawBody, "channels");
        if (channelsJson != null && !channelsJson.isEmpty()) {
            try {
                message.setChannels(objectMapper.readValue(channelsJson, STRING_LIST));
            } catch (JsonProcessingException ex) {
                log.warn("Failed to parse channels from stream body.", ex);
                message.setChannels(NotificationChannel.normalizeNames(null, DEFAULT_CHANNELS));
            }
        } else {
            message.setChannels(NotificationChannel.normalizeNames(null, DEFAULT_CHANNELS));
        }

        return message;
    }

    public String getStreamKey() {
        return streamKey;
    }

    public String getConsumerGroup() {
        return consumerGroup;
    }

    private Map<String, String> toStreamBody(NotificationMessage message) {
        Map<String, String> body = new HashMap<>();
        body.put("id", message.getId());
        body.put("userId", message.getUserId());
        body.put("title", message.getTitle());
        body.put("content", message.getContent());
        body.put("linkUrl", message.getLinkUrl());
        body.put("type", message.getType());
        body.put("createdAtEpochMillis", String.valueOf(message.getCreatedAtEpochMillis()));
        body.put("channels", stringifyChannels(message.getChannels()));
        return body;
    }

    private String stringifyChannels(List<String> channels) {
        try {
            return objectMapper.writeValueAsString(NotificationChannel.normalizeNames(channels, DEFAULT_CHANNELS));
        } catch (JsonProcessingException ex) {
            return "[\"" + NotificationChannel.IN_APP.name() + "\"]";
        }
    }

    private String readString(Map<?, ?> body, String key) {
        Object value = body.get(key);
        return value == null ? null : value.toString();
    }
}
```

### 3. Worker 소비/ACK

- 파일: `NotificationStreamConsumer.java`
- 내용: 기존과 동일 (`poll -> pub/sub 재발행 -> ack`)

- 토글: NotificationStreamConsumer.java 파일 내용

```java
package com.wa.erp.notification;

import com.wa.erp.notification.dto.NotificationMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.connection.stream.Consumer;
import org.springframework.data.redis.connection.stream.MapRecord;
import org.springframework.data.redis.connection.stream.ReadOffset;
import org.springframework.data.redis.connection.stream.StreamOffset;
import org.springframework.data.redis.connection.stream.StreamReadOptions;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.Duration;
import java.util.List;

@Component
public class NotificationStreamConsumer {

    private static final Logger log = LoggerFactory.getLogger(NotificationStreamConsumer.class);

    private final StringRedisTemplate stringRedisTemplate;
    private final NotificationQueueService notificationQueueService;
    private final NotificationPublisher notificationPublisher;
    private final String consumerName;
    private final int batchSize;
    private final int blockSeconds;

    public NotificationStreamConsumer(
            StringRedisTemplate stringRedisTemplate,
            NotificationQueueService notificationQueueService,
            NotificationPublisher notificationPublisher,
            @Value("${notification.stream.consumer-name:${spring.application.name}-${random.uuid}}") String consumerName,
            @Value("${notification.stream.batch-size:500}") int batchSize,
            @Value("${notification.stream.block-seconds:2}") int blockSeconds
    ) {
        this.stringRedisTemplate = stringRedisTemplate;
        this.notificationQueueService = notificationQueueService;
        this.notificationPublisher = notificationPublisher;
        this.consumerName = consumerName;
        this.batchSize = batchSize;
        this.blockSeconds = blockSeconds;
    }

    @Scheduled(fixedDelayString = "${notification.stream.poll-delay-ms:500}")
    public void pollAndDispatch() {
        List<MapRecord<String, Object, Object>> records;
        try {
            notificationQueueService.initConsumerGroup();
            records = stringRedisTemplate.opsForStream().read(
                    Consumer.from(notificationQueueService.getConsumerGroup(), consumerName),
                    StreamReadOptions.empty().count(batchSize).block(Duration.ofSeconds(blockSeconds)),
                    StreamOffset.create(notificationQueueService.getStreamKey(), ReadOffset.lastConsumed())
            );
        } catch (Exception ex) {
            log.warn("Redis stream poll skipped: {}", ex.getMessage());
            return;
        }

        if (records == null || records.isEmpty()) {
            return;
        }

        for (MapRecord<String, Object, Object> record : records) {
            try {
                if ("true".equals(String.valueOf(record.getValue().get("bootstrap")))) {
                    stringRedisTemplate.opsForStream().acknowledge(
                            notificationQueueService.getStreamKey(),
                            notificationQueueService.getConsumerGroup(),
                            record.getId()
                    );
                    continue;
                }

                NotificationMessage message = notificationQueueService.fromStreamBody(record.getValue());
                notificationPublisher.publish(message);

                stringRedisTemplate.opsForStream().acknowledge(
                        notificationQueueService.getStreamKey(),
                        notificationQueueService.getConsumerGroup(),
                        record.getId()
                );
            } catch (Exception ex) {
                log.error("Failed to process stream notification. recordId={}", record.getId(), ex);
            }
        }
    }
}
```

### 4. 비동기 실행기

- 파일: `NotificationAsyncConfig.java`
- 내용: 기존과 동일 (`notification-*` 전용 스레드풀)

- 토글: NotificationAsyncConfig.java 파일 내용

```java
package com.wa.erp.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import java.util.concurrent.Executor;

@Configuration
@EnableAsync
@EnableScheduling
public class NotificationAsyncConfig {

    @Bean(name = "notificationTaskExecutor")
    public Executor notificationTaskExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        executor.setCorePoolSize(8);
        executor.setMaxPoolSize(32);
        executor.setQueueCapacity(20000);
        executor.setThreadNamePrefix("notification-");
        executor.initialize();
        return executor;
    }
}
```

### 5. 200만명 확장 전략

1. Stream 샤딩
  - 단일 stream 대신 `careerplus:notifications:stream:{0..N-1}`로 분산
  - `userId` 해시 기반으로 shard 라우팅
2. 소비자 수평 확장
  - shard별 consumer 분담
  - lag 기반 인스턴스 오토스케일
3. 쓰기/읽기 처리량 최적화
  - enqueue 파이프라이닝
  - batch-size/worker 수를 부하테스트로 단계 상향
4. 실패 처리 강화
  - 재시도 정책(횟수/백오프)
  - DLQ stream 분리
  - idempotency key로 중복 전송 방지
5. 보호 장치
  - 채널별 rate limit
  - backpressure(큐 적체 시 생산 속도 제어)
6. 관측성
  - shard별 lag, 처리량, 실패율 모니터링
  - 임계치 기반 알람 운영

---

