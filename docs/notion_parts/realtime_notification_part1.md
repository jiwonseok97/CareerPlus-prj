## 1) 실시간 알림: SSE + Redis Pub/Sub

enum + Handler 구현체 + Dispatcher Map 구조

### 1. 사용자별 SSE 연결/송신

- 파일: `NotificationSseService.java`
- 내용:
  - 사용자별 `SseEmitter` 관리
  - `notification` 이벤트 즉시 push
  - 최근 알림 Redis List(`careerplus:notifications:recent:{userId}`) 저장

- 토글: NotificationSseService.java 파일 내용

```java
package com.wa.erp.notification;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.wa.erp.notification.dto.NotificationMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;

@Service
public class NotificationSseService {

    private static final Logger log = LoggerFactory.getLogger(NotificationSseService.class);
    private static final String RECENT_KEY_PREFIX = "careerplus:notifications:recent:";

    private final ObjectMapper objectMapper;
    private final StringRedisTemplate stringRedisTemplate;
    private final long emitterTimeoutMs;
    private final int maxRecentSize;

    private final Map<String, CopyOnWriteArrayList<SseEmitter>> emitters = new ConcurrentHashMap<>();

    public NotificationSseService(
            ObjectMapper objectMapper,
            StringRedisTemplate stringRedisTemplate,
            @Value("${notification.sse.timeout-ms:3600000}") long emitterTimeoutMs,
            @Value("${notification.recent.max-size:200}") int maxRecentSize
    ) {
        this.objectMapper = objectMapper;
        this.stringRedisTemplate = stringRedisTemplate;
        this.emitterTimeoutMs = emitterTimeoutMs;
        this.maxRecentSize = maxRecentSize;
    }

    public SseEmitter subscribe(String userId) {
        SseEmitter emitter = new SseEmitter(emitterTimeoutMs);
        emitters.computeIfAbsent(userId, key -> new CopyOnWriteArrayList<>()).add(emitter);

        emitter.onCompletion(() -> removeEmitter(userId, emitter));
        emitter.onTimeout(() -> removeEmitter(userId, emitter));
        emitter.onError(ex -> removeEmitter(userId, emitter));

        try {
            emitter.send(SseEmitter.event()
                    .name("connected")
                    .id(UUID.randomUUID().toString())
                    .data("SSE connected"));
        } catch (IOException e) {
            removeEmitter(userId, emitter);
            throw new IllegalStateException("Failed to open SSE connection.", e);
        }

        return emitter;
    }

    public void dispatchInApp(NotificationMessage message) {
        storeRecent(message);
        List<SseEmitter> userEmitters = emitters.get(message.getUserId());
        if (userEmitters == null || userEmitters.isEmpty()) {
            return;
        }

        for (SseEmitter emitter : userEmitters) {
            try {
                emitter.send(SseEmitter.event()
                        .name("notification")
                        .id(message.getId())
                        .data(message));
            } catch (IOException ex) {
                emitter.completeWithError(ex);
                removeEmitter(message.getUserId(), emitter);
            }
        }
    }

    public List<NotificationMessage> findRecent(String userId, int limit) {
        int safeLimit = Math.max(1, Math.min(limit, maxRecentSize));
        String key = RECENT_KEY_PREFIX + userId;
        List<String> rows = stringRedisTemplate.opsForList().range(key, 0, safeLimit - 1);

        List<NotificationMessage> messages = new ArrayList<>();
        if (rows == null) {
            return messages;
        }

        for (String row : rows) {
            try {
                messages.add(objectMapper.readValue(row, NotificationMessage.class));
            } catch (JsonProcessingException ex) {
                log.warn("Failed to deserialize recent notification. key={}", key, ex);
            }
        }
        return messages;
    }

    private void storeRecent(NotificationMessage message) {
        String key = RECENT_KEY_PREFIX + message.getUserId();
        try {
            String payload = objectMapper.writeValueAsString(message);
            stringRedisTemplate.opsForList().leftPush(key, payload);
            stringRedisTemplate.opsForList().trim(key, 0, maxRecentSize - 1);
        } catch (JsonProcessingException ex) {
            log.warn("Failed to persist recent notification. userId={}", message.getUserId(), ex);
        }
    }

    private void removeEmitter(String userId, SseEmitter emitter) {
        List<SseEmitter> userEmitters = emitters.get(userId);
        if (userEmitters == null) {
            return;
        }
        userEmitters.remove(emitter);
        if (userEmitters.isEmpty()) {
            emitters.remove(userId);
        }
    }
}
```

### 2. 멀티 인스턴스 동기화(Pub/Sub)

- 발행: `NotificationPublisher.java`
- 구독: `NotificationPubSubSubscriber.java`
- 설정: `RedisNotificationConfig.java`
- 내용: 기존과 동일
  - `notification.pubsub.channel`로 publish
  - subscriber가 수신 후 Dispatcher로 전달

- 토글: NotificationPublisher.java 파일 내용

```java
package com.wa.erp.notification;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.wa.erp.notification.dto.NotificationMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.redis.listener.ChannelTopic;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

@Component
public class NotificationPublisher {

    private static final Logger log = LoggerFactory.getLogger(NotificationPublisher.class);

    private final StringRedisTemplate stringRedisTemplate;
    private final ChannelTopic notificationTopic;
    private final ObjectMapper objectMapper;

    public NotificationPublisher(
            StringRedisTemplate stringRedisTemplate,
            ChannelTopic notificationTopic,
            ObjectMapper objectMapper
    ) {
        this.stringRedisTemplate = stringRedisTemplate;
        this.notificationTopic = notificationTopic;
        this.objectMapper = objectMapper;
    }

    public void publish(NotificationMessage message) {
        try {
            String payload = objectMapper.writeValueAsString(message);
            stringRedisTemplate.convertAndSend(notificationTopic.getTopic(), payload);
        } catch (JsonProcessingException ex) {
            log.error("Failed to publish notification. userId={}", message.getUserId(), ex);
            throw new IllegalStateException("Failed to publish notification", ex);
        }
    }
}
```

- 토글: NotificationPubSubSubscriber.java 파일 내용

```java
package com.wa.erp.notification;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.wa.erp.notification.dto.NotificationMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component
public class NotificationPubSubSubscriber {

    private static final Logger log = LoggerFactory.getLogger(NotificationPubSubSubscriber.class);

    private final ObjectMapper objectMapper;
    private final NotificationDispatchService notificationDispatchService;

    public NotificationPubSubSubscriber(ObjectMapper objectMapper, NotificationDispatchService notificationDispatchService) {
        this.objectMapper = objectMapper;
        this.notificationDispatchService = notificationDispatchService;
    }

    public void handleMessage(String payload) {
        try {
            NotificationMessage message = objectMapper.readValue(payload, NotificationMessage.class);
            notificationDispatchService.dispatch(message);
        } catch (JsonProcessingException ex) {
            log.warn("Failed to deserialize pub/sub notification payload.", ex);
        }
    }
}
```

- 토글: RedisNotificationConfig.java 파일 내용

```java
package com.wa.erp.config;

import com.wa.erp.notification.NotificationPubSubSubscriber;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.listener.ChannelTopic;
import org.springframework.data.redis.listener.RedisMessageListenerContainer;
import org.springframework.data.redis.listener.adapter.MessageListenerAdapter;
import org.springframework.data.redis.serializer.StringRedisSerializer;

@Configuration
public class RedisNotificationConfig {

    @Value("${notification.pubsub.channel:careerplus:notifications:pubsub}")
    private String notificationTopicName;

    @Value("${notification.pubsub.listener-auto-startup:true}")
    private boolean listenerAutoStartup;

    @Bean
    public ChannelTopic notificationTopic() {
        return new ChannelTopic(notificationTopicName);
    }

    @Bean
    public MessageListenerAdapter notificationMessageListener(NotificationPubSubSubscriber subscriber) {
        MessageListenerAdapter adapter = new MessageListenerAdapter(subscriber, "handleMessage");
        adapter.setSerializer(new StringRedisSerializer());
        return adapter;
    }

    @Bean
    public RedisMessageListenerContainer redisMessageListenerContainer(
            RedisConnectionFactory connectionFactory,
            MessageListenerAdapter notificationMessageListener,
            ChannelTopic notificationTopic
    ) {
        boolean autoStartup = listenerAutoStartup;
        RedisMessageListenerContainer container = new RedisMessageListenerContainer() {
            @Override
            public boolean isAutoStartup() {
                return autoStartup;
            }
        };
        container.setConnectionFactory(connectionFactory);
        container.addMessageListener(notificationMessageListener, notificationTopic);
        return container;
    }
}
```

### 3. 채널 정책 (문자열 분기 -> enum/handler 분리)

- 신규 enum: `NotificationChannel.java`
- 신규 인터페이스: `NotificationChannelHandler.java`
- 신규 구현체:
  - `InAppNotificationChannelHandler.java`
  - `WebPushNotificationChannelHandler.java`
  - `EmailNotificationChannelHandler.java`
- Dispatcher 변경: `NotificationDispatchService.java`
- 결과:
  - 지원 채널: `IN_APP`, `WEB_PUSH`, `EMAIL`
  - 문자열 `if/contains` 분기 제거
  - 신규 채널 추가 시 구현체만 추가하면 됨

- 토글: NotificationChannel.java 파일 내용

```java
package com.wa.erp.notification;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

public enum NotificationChannel {
    IN_APP,
    WEB_PUSH,
    EMAIL;

    public static Set<NotificationChannel> normalize(List<String> rawChannels, Set<NotificationChannel> defaultChannels) {
        Set<NotificationChannel> normalized = new LinkedHashSet<>();
        if (rawChannels != null) {
            for (String raw : rawChannels) {
                NotificationChannel parsed = parse(raw);
                if (parsed != null) {
                    normalized.add(parsed);
                }
            }
        }
        return normalized.isEmpty() ? new LinkedHashSet<>(defaultChannels) : normalized;
    }

    public static List<String> normalizeNames(List<String> rawChannels, Set<NotificationChannel> defaultChannels) {
        Set<NotificationChannel> normalized = normalize(rawChannels, defaultChannels);
        List<String> names = new ArrayList<>();
        for (NotificationChannel channel : normalized) {
            names.add(channel.name());
        }
        return names;
    }

    private static NotificationChannel parse(String raw) {
        if (raw == null) {
            return null;
        }
        String normalized = raw.trim().toUpperCase();
        if (normalized.isEmpty()) {
            return null;
        }
        for (NotificationChannel channel : values()) {
            if (channel.name().equals(normalized)) {
                return channel;
            }
        }
        return null;
    }
}
```

- 토글: NotificationChannelHandler.java 파일 내용

```java
package com.wa.erp.notification;

import com.wa.erp.notification.dto.NotificationMessage;

public interface NotificationChannelHandler {

    NotificationChannel channel();

    void send(NotificationMessage message);
}
```

- 토글: InAppNotificationChannelHandler.java 파일 내용

```java
package com.wa.erp.notification;

import com.wa.erp.notification.dto.NotificationMessage;
import org.springframework.stereotype.Component;

@Component
public class InAppNotificationChannelHandler implements NotificationChannelHandler {

    private final NotificationSseService notificationSseService;

    public InAppNotificationChannelHandler(NotificationSseService notificationSseService) {
        this.notificationSseService = notificationSseService;
    }

    @Override
    public NotificationChannel channel() {
        return NotificationChannel.IN_APP;
    }

    @Override
    public void send(NotificationMessage message) {
        notificationSseService.dispatchInApp(message);
    }
}
```

- 토글: WebPushNotificationChannelHandler.java 파일 내용

```java
package com.wa.erp.notification;

import com.wa.erp.notification.dto.NotificationMessage;
import org.springframework.stereotype.Component;

@Component
public class WebPushNotificationChannelHandler implements NotificationChannelHandler {

    private final WebPushNotificationGateway webPushNotificationGateway;

    public WebPushNotificationChannelHandler(WebPushNotificationGateway webPushNotificationGateway) {
        this.webPushNotificationGateway = webPushNotificationGateway;
    }

    @Override
    public NotificationChannel channel() {
        return NotificationChannel.WEB_PUSH;
    }

    @Override
    public void send(NotificationMessage message) {
        webPushNotificationGateway.send(message);
    }
}
```

- 토글: EmailNotificationChannelHandler.java 파일 내용

```java
package com.wa.erp.notification;

import com.wa.erp.notification.dto.NotificationMessage;
import org.springframework.stereotype.Component;

@Component
public class EmailNotificationChannelHandler implements NotificationChannelHandler {

    private final EmailNotificationGateway emailNotificationGateway;

    public EmailNotificationChannelHandler(EmailNotificationGateway emailNotificationGateway) {
        this.emailNotificationGateway = emailNotificationGateway;
    }

    @Override
    public NotificationChannel channel() {
        return NotificationChannel.EMAIL;
    }

    @Override
    public void send(NotificationMessage message) {
        emailNotificationGateway.send(message);
    }
}
```

- 토글: NotificationDispatchService.java 파일 내용

```java
package com.wa.erp.notification;

import com.wa.erp.notification.dto.NotificationMessage;
import org.springframework.stereotype.Service;

import java.util.EnumMap;
import java.util.EnumSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
public class NotificationDispatchService {

    private static final Set<NotificationChannel> DEFAULT_CHANNELS = EnumSet.of(NotificationChannel.IN_APP);
    private final Map<NotificationChannel, NotificationChannelHandler> channelHandlers = new EnumMap<>(NotificationChannel.class);

    public NotificationDispatchService(
            List<NotificationChannelHandler> handlers
    ) {
        for (NotificationChannelHandler handler : handlers) {
            channelHandlers.put(handler.channel(), handler);
        }
    }

    public void dispatch(NotificationMessage message) {
        Set<NotificationChannel> channels = NotificationChannel.normalize(message.getChannels(), DEFAULT_CHANNELS);
        for (NotificationChannel channel : channels) {
            NotificationChannelHandler handler = channelHandlers.get(channel);
            if (handler != null) {
                handler.send(message);
            }
        }
    }
}
```

---

