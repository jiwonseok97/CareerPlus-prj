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
