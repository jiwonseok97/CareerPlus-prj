package com.wa.erp.config;

import com.wa.erp.notification.NotificationPubSubSubscriber;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.listener.ChannelTopic;
import org.springframework.data.redis.listener.RedisMessageListenerContainer;
import org.springframework.data.redis.listener.adapter.MessageListenerAdapter;
import org.springframework.data.redis.serializer.StringRedisSerializer;

@Configuration
public class RedisNotificationConfig {

    @Value("${notification.pubsub.channel:careerplus:notifications:pubsub}")
    private String notificationTopicName;

    @Value("${notification.pubsub.listener-auto-startup:true}")
    private boolean listenerAutoStartup;

    @Bean
    public ChannelTopic notificationTopic() {
        return new ChannelTopic(notificationTopicName);
    }

    @Bean
    public MessageListenerAdapter notificationMessageListener(NotificationPubSubSubscriber subscriber) {
        MessageListenerAdapter adapter = new MessageListenerAdapter(subscriber, "handleMessage");
        adapter.setSerializer(new StringRedisSerializer());
        return adapter;
    }

    @Bean
    public RedisMessageListenerContainer redisMessageListenerContainer(
            RedisConnectionFactory connectionFactory,
            MessageListenerAdapter notificationMessageListener,
            ChannelTopic notificationTopic
    ) {
        boolean autoStartup = listenerAutoStartup;
        RedisMessageListenerContainer container = new RedisMessageListenerContainer() {
            @Override
            public boolean isAutoStartup() {
                return autoStartup;
            }
        };
        container.setConnectionFactory(connectionFactory);
        container.addMessageListener(notificationMessageListener, notificationTopic);
        return container;
    }
}
