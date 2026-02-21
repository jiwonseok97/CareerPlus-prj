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
