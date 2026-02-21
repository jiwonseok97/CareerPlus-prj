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
