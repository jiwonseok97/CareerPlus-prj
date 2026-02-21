package com.wa.erp.notification;

import org.springframework.stereotype.Component;

import javax.servlet.http.HttpSession;

@Component
public class NotificationUserResolver {

    public String resolveUserId(HttpSession session, String requestedUserId) {
        if (requestedUserId != null && !requestedUserId.trim().isEmpty()) {
            return requestedUserId.trim();
        }

        Object memberType = session.getAttribute("member");
        if (memberType == null) {
            throw new IllegalArgumentException("Login required for notification subscription.");
        }

        String member = memberType.toString();
        if ("person".equals(member) && session.getAttribute("p_no") != null) {
            return "person:" + session.getAttribute("p_no");
        }
        if ("company".equals(member) && session.getAttribute("c_no") != null) {
            return "company:" + session.getAttribute("c_no");
        }
        if ("admin".equals(member) && session.getAttribute("admin_no") != null) {
            return "admin:" + session.getAttribute("admin_no");
        }

        throw new IllegalArgumentException("Unable to resolve user id from session.");
    }
}
