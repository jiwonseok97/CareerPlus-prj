package com.wa.erp;

import com.wa.erp.service.CacheMetricsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class CacheMetricsController {

    @Autowired
    private CacheMetricsService cacheMetricsService;

    @Autowired
    private BoardService boardService;

    @Value("${cache.type:redis}")
    private String currentCacheType;

    // 캐시 성능 비교 페이지
    @GetMapping("/cacheMetrics.do")
    public ModelAndView cacheMetricsPage() {
        ModelAndView mav = new ModelAndView();
        mav.addObject("currentCacheType", currentCacheType);
        mav.setViewName("cacheMetrics.jsp");
        return mav;
    }

    // 메트릭 데이터 API (JSON)
    @GetMapping("/api/cache/metrics")
    @ResponseBody
    public Map<String, Object> getMetrics() {
        Map<String, Object> result = cacheMetricsService.getMetrics();
        result.put("currentCacheType", currentCacheType);
        return result;
    }

    // 시계열 데이터 API (차트용)
    @GetMapping("/api/cache/timeseries")
    @ResponseBody
    public Map<String, List<Long>> getTimeSeries() {
        return cacheMetricsService.getTimeSeriesData();
    }

    // 최근 로그 API
    @GetMapping("/api/cache/logs")
    @ResponseBody
    public List<CacheMetricsService.RequestLog> getRecentLogs() {
        return cacheMetricsService.getRecentLogs();
    }

    // 메트릭 초기화
    @PostMapping("/api/cache/reset")
    @ResponseBody
    public Map<String, String> resetMetrics() {
        cacheMetricsService.reset();
        Map<String, String> result = new HashMap<>();
        result.put("status", "success");
        result.put("message", "Metrics reset completed");
        return result;
    }

    // 벤치마크 실행 (Redis vs Caffeine vs No Cache 비교)
    @PostMapping("/api/cache/benchmark")
    @ResponseBody
    public Map<String, Object> runBenchmark() {
        Map<String, Object> result = new HashMap<>();

        int iterations = 10;

        // 1. 캐시 없이 DB 직접 조회 시간 측정
        long noCacheTotal = 0;
        for (int i = 0; i < iterations; i++) {
            long start = System.currentTimeMillis();
            // 직접 DAO 호출 (캐시 우회)
            boardService.getSalaryData();
            boardService.getpopularCom();
            noCacheTotal += System.currentTimeMillis() - start;
        }

        // 2. 캐시 적용 후 조회 시간 측정 (두 번째부터 캐시 히트)
        long cacheTotal = 0;
        for (int i = 0; i < iterations; i++) {
            long start = System.currentTimeMillis();
            boardService.getSalaryData();
            boardService.getpopularCom();
            cacheTotal += System.currentTimeMillis() - start;
        }

        result.put("noCacheAvg", noCacheTotal / iterations);
        result.put("cacheAvg", cacheTotal / iterations);
        result.put("improvement", ((noCacheTotal - cacheTotal) * 100.0 / noCacheTotal));
        result.put("iterations", iterations);
        result.put("cacheType", currentCacheType);

        return result;
    }
}
