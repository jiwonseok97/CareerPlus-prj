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
