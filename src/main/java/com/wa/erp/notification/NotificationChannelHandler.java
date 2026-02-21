package com.wa.erp.notification;

import com.wa.erp.notification.dto.NotificationMessage;

public interface NotificationChannelHandler {

    NotificationChannel channel();

    void send(NotificationMessage message);
}
