package com.wa.erp.config;

import com.wa.erp.service.CacheMetricsService;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class CachePerformanceAspect {

    @Autowired
    private CacheMetricsService cacheMetricsService;

    @Value("${cache.type:redis}")
    private String cacheType;

    // @Cacheable이 적용된 메소드의 성능 측정
    @Around("@annotation(org.springframework.cache.annotation.Cacheable)")
    public Object measureCacheablePerformance(ProceedingJoinPoint joinPoint) throws Throwable {
        long startTime = System.currentTimeMillis();

        Object result = joinPoint.proceed();

        long endTime = System.currentTimeMillis();
        long responseTime = endTime - startTime;

        String methodName = joinPoint.getSignature().getName();

        // 응답 시간이 5ms 이하면 캐시 히트로 간주
        boolean cacheHit = responseTime <= 5;

        cacheMetricsService.recordRequest(cacheType, methodName, responseTime, cacheHit);

        return result;
    }
}
