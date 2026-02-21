package com.wa.erp.notification;

import com.wa.erp.notification.dto.NotificationMessage;
import com.wa.erp.notification.dto.PopularJobNotificationRequest;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.EnumSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.Executor;

@Service
public class PopularJobNotificationService {

    private static final Set<NotificationChannel> DEFAULT_CHANNELS = EnumSet.of(
            NotificationChannel.IN_APP,
            NotificationChannel.WEB_PUSH,
            NotificationChannel.EMAIL
    );

    private final NotificationQueueService notificationQueueService;
    private final Executor notificationTaskExecutor;
    private final int chunkSize;

    public PopularJobNotificationService(
            NotificationQueueService notificationQueueService,
            @Qualifier("notificationTaskExecutor") Executor notificationTaskExecutor,
            @Value("${notification.popular.chunk-size:1000}") int chunkSize
    ) {
        this.notificationQueueService = notificationQueueService;
        this.notificationTaskExecutor = notificationTaskExecutor;
        this.chunkSize = chunkSize;
    }

    public int enqueuePopularJob(PopularJobNotificationRequest request) {
        List<String> normalizedUserIds = normalizeUsers(request.getTargetUserIds());
        if (normalizedUserIds.isEmpty()) {
            return 0;
        }

        List<String> channels = normalizeChannels(request.getChannels());
        List<CompletableFuture<Integer>> futures = new ArrayList<>();

        for (int start = 0; start < normalizedUserIds.size(); start += chunkSize) {
            int end = Math.min(start + chunkSize, normalizedUserIds.size());
            List<String> chunk = normalizedUserIds.subList(start, end);

            futures.add(CompletableFuture.supplyAsync(() -> {
                int queued = 0;
                for (String userId : chunk) {
                    NotificationMessage message = NotificationMessage.of(
                            userId,
                            request.getTitle(),
                            request.getContent(),
                            request.getLinkUrl(),
                            "POPULAR_JOB",
                            channels
                    );
                    notificationQueueService.enqueue(message);
                    queued++;
                }
                return queued;
            }, notificationTaskExecutor));
        }

        CompletableFuture.allOf(futures.toArray(new CompletableFuture[0])).join();
        return futures.stream().mapToInt(CompletableFuture::join).sum();
    }

    private List<String> normalizeUsers(List<String> userIds) {
        if (userIds == null || userIds.isEmpty()) {
            return Collections.emptyList();
        }

        Set<String> deduplicated = new LinkedHashSet<>();
        for (String userId : userIds) {
            if (userId == null) {
                continue;
            }
            String normalized = userId.trim();
            if (!normalized.isEmpty()) {
                deduplicated.add(normalized);
            }
        }
        return new ArrayList<>(deduplicated);
    }

    private List<String> normalizeChannels(List<String> channels) {
        return NotificationChannel.normalizeNames(channels, DEFAULT_CHANNELS);
    }
}
