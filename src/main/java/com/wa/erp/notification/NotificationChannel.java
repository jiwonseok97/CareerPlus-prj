package com.wa.erp.notification;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

public enum NotificationChannel {
    IN_APP,
    WEB_PUSH,
    EMAIL;

    public static Set<NotificationChannel> normalize(List<String> rawChannels, Set<NotificationChannel> defaultChannels) {
        Set<NotificationChannel> normalized = new LinkedHashSet<>();
        if (rawChannels != null) {
            for (String raw : rawChannels) {
                NotificationChannel parsed = parse(raw);
                if (parsed != null) {
                    normalized.add(parsed);
                }
            }
        }
        return normalized.isEmpty() ? new LinkedHashSet<>(defaultChannels) : normalized;
    }

    public static List<String> normalizeNames(List<String> rawChannels, Set<NotificationChannel> defaultChannels) {
        Set<NotificationChannel> normalized = normalize(rawChannels, defaultChannels);
        List<String> names = new ArrayList<>();
        for (NotificationChannel channel : normalized) {
            names.add(channel.name());
        }
        return names;
    }

    private static NotificationChannel parse(String raw) {
        if (raw == null) {
            return null;
        }
        String normalized = raw.trim().toUpperCase();
        if (normalized.isEmpty()) {
            return null;
        }
        for (NotificationChannel channel : values()) {
            if (channel.name().equals(normalized)) {
                return channel;
            }
        }
        return null;
    }
}
