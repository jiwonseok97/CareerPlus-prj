package com.wa.erp.service;

import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;

@Service
public class CacheMetricsService {

    // 캐시 타입별 메트릭 저장
    private final Map<String, CacheMetrics> metricsMap = new ConcurrentHashMap<>();

    // 최근 요청 기록 (시각화용)
    private final List<RequestLog> requestLogs = new ArrayList<>();
    private static final int MAX_LOGS = 100;

    public void recordRequest(String cacheType, String methodName, long responseTime, boolean cacheHit) {
        String key = cacheType + ":" + methodName;
        metricsMap.computeIfAbsent(key, k -> new CacheMetrics(cacheType, methodName))
                  .record(responseTime, cacheHit);

        synchronized (requestLogs) {
            if (requestLogs.size() >= MAX_LOGS) {
                requestLogs.remove(0);
            }
            requestLogs.add(new RequestLog(cacheType, methodName, responseTime, cacheHit, System.currentTimeMillis()));
        }
    }

    public Map<String, Object> getMetrics() {
        Map<String, Object> result = new HashMap<>();

        Map<String, Object> redis = new HashMap<>();
        Map<String, Object> caffeine = new HashMap<>();
        Map<String, Object> noCache = new HashMap<>();

        long redisTotalTime = 0, caffeineTotalTime = 0, noCacheTotalTime = 0;
        long redisCount = 0, caffeineCount = 0, noCacheCount = 0;
        long redisHits = 0, caffeineHits = 0;

        for (CacheMetrics metrics : metricsMap.values()) {
            if ("redis".equals(metrics.cacheType)) {
                redisTotalTime += metrics.totalResponseTime.get();
                redisCount += metrics.requestCount.get();
                redisHits += metrics.cacheHits.get();
            } else if ("caffeine".equals(metrics.cacheType)) {
                caffeineTotalTime += metrics.totalResponseTime.get();
                caffeineCount += metrics.requestCount.get();
                caffeineHits += metrics.cacheHits.get();
            } else {
                noCacheTotalTime += metrics.totalResponseTime.get();
                noCacheCount += metrics.requestCount.get();
            }
        }

        redis.put("avgResponseTime", redisCount > 0 ? redisTotalTime / redisCount : 0);
        redis.put("totalRequests", redisCount);
        redis.put("cacheHits", redisHits);
        redis.put("hitRate", redisCount > 0 ? (double) redisHits / redisCount * 100 : 0);

        caffeine.put("avgResponseTime", caffeineCount > 0 ? caffeineTotalTime / caffeineCount : 0);
        caffeine.put("totalRequests", caffeineCount);
        caffeine.put("cacheHits", caffeineHits);
        caffeine.put("hitRate", caffeineCount > 0 ? (double) caffeineHits / caffeineCount * 100 : 0);

        noCache.put("avgResponseTime", noCacheCount > 0 ? noCacheTotalTime / noCacheCount : 0);
        noCache.put("totalRequests", noCacheCount);

        result.put("redis", redis);
        result.put("caffeine", caffeine);
        result.put("noCache", noCache);
        result.put("comparison", getComparison(redis, caffeine, noCache));

        return result;
    }

    public List<RequestLog> getRecentLogs() {
        synchronized (requestLogs) {
            return new ArrayList<>(requestLogs);
        }
    }

    public Map<String, List<Long>> getTimeSeriesData() {
        Map<String, List<Long>> result = new HashMap<>();
        List<Long> redisTimes = new ArrayList<>();
        List<Long> caffeineTimes = new ArrayList<>();
        List<Long> noCacheTimes = new ArrayList<>();

        synchronized (requestLogs) {
            for (RequestLog log : requestLogs) {
                if ("redis".equals(log.cacheType)) {
                    redisTimes.add(log.responseTime);
                } else if ("caffeine".equals(log.cacheType)) {
                    caffeineTimes.add(log.responseTime);
                } else {
                    noCacheTimes.add(log.responseTime);
                }
            }
        }

        result.put("redis", redisTimes);
        result.put("caffeine", caffeineTimes);
        result.put("noCache", noCacheTimes);
        return result;
    }

    private Map<String, Object> getComparison(Map<String, Object> redis, Map<String, Object> caffeine, Map<String, Object> noCache) {
        Map<String, Object> comparison = new HashMap<>();

        long noCacheAvg = (long) noCache.get("avgResponseTime");
        long redisAvg = (long) redis.get("avgResponseTime");
        long caffeineAvg = (long) caffeine.get("avgResponseTime");

        if (noCacheAvg > 0) {
            comparison.put("redisImprovement", noCacheAvg > 0 ? ((noCacheAvg - redisAvg) * 100.0 / noCacheAvg) : 0);
            comparison.put("caffeineImprovement", noCacheAvg > 0 ? ((noCacheAvg - caffeineAvg) * 100.0 / noCacheAvg) : 0);
        }

        if (redisAvg > 0 && caffeineAvg > 0) {
            comparison.put("caffeineFasterThanRedis", ((redisAvg - caffeineAvg) * 100.0 / redisAvg));
        }

        return comparison;
    }

    public void reset() {
        metricsMap.clear();
        synchronized (requestLogs) {
            requestLogs.clear();
        }
    }

    // 내부 클래스: 캐시 메트릭
    public static class CacheMetrics {
        String cacheType;
        String methodName;
        AtomicLong requestCount = new AtomicLong(0);
        AtomicLong totalResponseTime = new AtomicLong(0);
        AtomicLong cacheHits = new AtomicLong(0);
        AtomicLong cacheMisses = new AtomicLong(0);

        public CacheMetrics(String cacheType, String methodName) {
            this.cacheType = cacheType;
            this.methodName = methodName;
        }

        public void record(long responseTime, boolean cacheHit) {
            requestCount.incrementAndGet();
            totalResponseTime.addAndGet(responseTime);
            if (cacheHit) {
                cacheHits.incrementAndGet();
            } else {
                cacheMisses.incrementAndGet();
            }
        }
    }

    // 내부 클래스: 요청 로그
    public static class RequestLog {
        public String cacheType;
        public String methodName;
        public long responseTime;
        public boolean cacheHit;
        public long timestamp;

        public RequestLog(String cacheType, String methodName, long responseTime, boolean cacheHit, long timestamp) {
            this.cacheType = cacheType;
            this.methodName = methodName;
            this.responseTime = responseTime;
            this.cacheHit = cacheHit;
            this.timestamp = timestamp;
        }
    }
}
