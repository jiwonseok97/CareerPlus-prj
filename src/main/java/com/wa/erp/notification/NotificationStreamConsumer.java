package com.wa.erp.notification;

import com.wa.erp.notification.dto.NotificationMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.connection.stream.Consumer;
import org.springframework.data.redis.connection.stream.MapRecord;
import org.springframework.data.redis.connection.stream.ReadOffset;
import org.springframework.data.redis.connection.stream.StreamOffset;
import org.springframework.data.redis.connection.stream.StreamReadOptions;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.Duration;
import java.util.List;

@Component
public class NotificationStreamConsumer {

    private static final Logger log = LoggerFactory.getLogger(NotificationStreamConsumer.class);

    private final StringRedisTemplate stringRedisTemplate;
    private final NotificationQueueService notificationQueueService;
    private final NotificationPublisher notificationPublisher;
    private final String consumerName;
    private final int batchSize;
    private final int blockSeconds;

    public NotificationStreamConsumer(
            StringRedisTemplate stringRedisTemplate,
            NotificationQueueService notificationQueueService,
            NotificationPublisher notificationPublisher,
            @Value("${notification.stream.consumer-name:${spring.application.name}-${random.uuid}}") String consumerName,
            @Value("${notification.stream.batch-size:500}") int batchSize,
            @Value("${notification.stream.block-seconds:2}") int blockSeconds
    ) {
        this.stringRedisTemplate = stringRedisTemplate;
        this.notificationQueueService = notificationQueueService;
        this.notificationPublisher = notificationPublisher;
        this.consumerName = consumerName;
        this.batchSize = batchSize;
        this.blockSeconds = blockSeconds;
    }

    @Scheduled(fixedDelayString = "${notification.stream.poll-delay-ms:500}")
    public void pollAndDispatch() {
        List<MapRecord<String, Object, Object>> records;
        try {
            notificationQueueService.initConsumerGroup();
            records = stringRedisTemplate.opsForStream().read(
                    Consumer.from(notificationQueueService.getConsumerGroup(), consumerName),
                    StreamReadOptions.empty().count(batchSize).block(Duration.ofSeconds(blockSeconds)),
                    StreamOffset.create(notificationQueueService.getStreamKey(), ReadOffset.lastConsumed())
            );
        } catch (Exception ex) {
            log.warn("Redis stream poll skipped: {}", ex.getMessage());
            return;
        }

        if (records == null || records.isEmpty()) {
            return;
        }

        for (MapRecord<String, Object, Object> record : records) {
            try {
                if ("true".equals(String.valueOf(record.getValue().get("bootstrap")))) {
                    stringRedisTemplate.opsForStream().acknowledge(
                            notificationQueueService.getStreamKey(),
                            notificationQueueService.getConsumerGroup(),
                            record.getId()
                    );
                    continue;
                }

                NotificationMessage message = notificationQueueService.fromStreamBody(record.getValue());
                notificationPublisher.publish(message);

                stringRedisTemplate.opsForStream().acknowledge(
                        notificationQueueService.getStreamKey(),
                        notificationQueueService.getConsumerGroup(),
                        record.getId()
                );
            } catch (Exception ex) {
                log.error("Failed to process stream notification. recordId={}", record.getId(), ex);
            }
        }
    }
}
