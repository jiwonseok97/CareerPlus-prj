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
