package com.wa.erp.notification;

import com.wa.erp.notification.dto.NotificationMessage;
import org.springframework.stereotype.Service;

import java.util.EnumMap;
import java.util.EnumSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
public class NotificationDispatchService {

    private static final Set<NotificationChannel> DEFAULT_CHANNELS = EnumSet.of(NotificationChannel.IN_APP);
    private final Map<NotificationChannel, NotificationChannelHandler> channelHandlers = new EnumMap<>(NotificationChannel.class);

    public NotificationDispatchService(
            List<NotificationChannelHandler> handlers
    ) {
        for (NotificationChannelHandler handler : handlers) {
            channelHandlers.put(handler.channel(), handler);
        }
    }

    public void dispatch(NotificationMessage message) {
        Set<NotificationChannel> channels = NotificationChannel.normalize(message.getChannels(), DEFAULT_CHANNELS);
        for (NotificationChannel channel : channels) {
            NotificationChannelHandler handler = channelHandlers.get(channel);
            if (handler != null) {
                handler.send(message);
            }
        }
    }
}
