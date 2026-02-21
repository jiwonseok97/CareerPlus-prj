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
