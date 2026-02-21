package com.wa.erp.notification.dto;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class NotificationMessage {

    private String id;
    private String userId;
    private String title;
    private String content;
    private String linkUrl;
    private String type;
    private long createdAtEpochMillis;
    private List<String> channels;

    public NotificationMessage() {
        this.id = UUID.randomUUID().toString();
        this.createdAtEpochMillis = System.currentTimeMillis();
        this.channels = new ArrayList<>();
    }

    public static NotificationMessage of(String userId, String title, String content, String linkUrl, String type, List<String> channels) {
        NotificationMessage message = new NotificationMessage();
        message.setUserId(userId);
        message.setTitle(title);
        message.setContent(content);
        message.setLinkUrl(linkUrl);
        message.setType(type);
        message.setChannels(channels);
        return message;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getLinkUrl() {
        return linkUrl;
    }

    public void setLinkUrl(String linkUrl) {
        this.linkUrl = linkUrl;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public long getCreatedAtEpochMillis() {
        return createdAtEpochMillis;
    }

    public void setCreatedAtEpochMillis(long createdAtEpochMillis) {
        this.createdAtEpochMillis = createdAtEpochMillis;
    }

    public List<String> getChannels() {
        return channels;
    }

    public void setChannels(List<String> channels) {
        this.channels = channels == null ? new ArrayList<>() : channels;
    }
}
