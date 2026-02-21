package com.wa.erp.notification;

import com.wa.erp.notification.dto.NotificationMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component
public class WebPushNotificationGateway {

    private static final Logger log = LoggerFactory.getLogger(WebPushNotificationGateway.class);

    public void send(NotificationMessage message) {
        log.info("WEB_PUSH placeholder send. userId={}, title={}", message.getUserId(), message.getTitle());
    }
}
