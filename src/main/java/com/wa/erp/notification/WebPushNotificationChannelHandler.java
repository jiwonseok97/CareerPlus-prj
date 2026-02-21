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
