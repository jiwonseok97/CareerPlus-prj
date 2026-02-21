package com.wa.erp.notification;

import com.wa.erp.notification.dto.NotificationMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component
public class EmailNotificationGateway {

    private static final Logger log = LoggerFactory.getLogger(EmailNotificationGateway.class);

    public void send(NotificationMessage message) {
        log.info("EMAIL placeholder send. userId={}, title={}", message.getUserId(), message.getTitle());
    }
}
