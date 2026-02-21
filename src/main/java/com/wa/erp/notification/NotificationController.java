package com.wa.erp.notification;

import com.wa.erp.notification.dto.NotificationMessage;
import com.wa.erp.notification.dto.NotificationPublishRequest;
import com.wa.erp.notification.dto.PopularJobNotificationRequest;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import javax.servlet.http.HttpSession;
import java.util.EnumSet;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

@RestController
@RequestMapping("/api/notifications")
public class NotificationController {

    private static final Set<NotificationChannel> DEFAULT_PUBLISH_CHANNELS = EnumSet.of(NotificationChannel.IN_APP);

    private final NotificationUserResolver notificationUserResolver;
    private final NotificationSseService notificationSseService;
    private final NotificationPublisher notificationPublisher;
    private final PopularJobNotificationService popularJobNotificationService;

    public NotificationController(
            NotificationUserResolver notificationUserResolver,
            NotificationSseService notificationSseService,
            NotificationPublisher notificationPublisher,
            PopularJobNotificationService popularJobNotificationService
    ) {
        this.notificationUserResolver = notificationUserResolver;
        this.notificationSseService = notificationSseService;
        this.notificationPublisher = notificationPublisher;
        this.popularJobNotificationService = popularJobNotificationService;
    }

    @GetMapping(value = "/subscribe", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public SseEmitter subscribe(
            @RequestParam(value = "userId", required = false) String userId,
            HttpSession session
    ) {
        String resolvedUserId = notificationUserResolver.resolveUserId(session, userId);
        return notificationSseService.subscribe(resolvedUserId);
    }

    @GetMapping("/recent")
    public List<NotificationMessage> recent(
            @RequestParam(value = "userId", required = false) String userId,
            @RequestParam(value = "limit", defaultValue = "20") int limit,
            HttpSession session
    ) {
        String resolvedUserId = notificationUserResolver.resolveUserId(session, userId);
        return notificationSseService.findRecent(resolvedUserId, limit);
    }

    @PostMapping("/publish")
    public Map<String, Object> publish(@RequestBody NotificationPublishRequest request, HttpSession session) {
        String resolvedUserId = notificationUserResolver.resolveUserId(session, request.getUserId());
        List<String> channels = NotificationChannel.normalizeNames(request.getChannels(), DEFAULT_PUBLISH_CHANNELS);

        NotificationMessage message = NotificationMessage.of(
                resolvedUserId,
                request.getTitle(),
                request.getContent(),
                request.getLinkUrl(),
                request.getType() == null || request.getType().trim().isEmpty() ? "GENERAL" : request.getType(),
                channels
        );
        notificationPublisher.publish(message);

        Map<String, Object> response = new HashMap<>();
        response.put("status", "ok");
        response.put("notificationId", message.getId());
        return response;
    }

    @PostMapping("/popular-job")
    public Map<String, Object> popularJob(@RequestBody PopularJobNotificationRequest request) {
        int queuedCount = popularJobNotificationService.enqueuePopularJob(request);

        Map<String, Object> response = new HashMap<>();
        response.put("status", "queued");
        response.put("queuedCount", queuedCount);
        return response;
    }
}
