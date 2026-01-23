package com.wa.erp.service;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Caching;
import org.springframework.stereotype.Service;

@Service
public class CacheEvictService {

    // 게시판 관련 캐시 전체 삭제
    @Caching(evict = {
        @CacheEvict(value = "boardList", allEntries = true),
        @CacheEvict(value = "noticeList", allEntries = true)
    })
    public void evictBoardCache() {
        // 캐시만 삭제
    }

    // 회사 관련 캐시 전체 삭제
    @Caching(evict = {
        @CacheEvict(value = "companyList", allEntries = true),
        @CacheEvict(value = "popularCom", allEntries = true)
    })
    public void evictCompanyCache() {
        // 캐시만 삭제
    }

    // 통계 캐시 전체 삭제
    @Caching(evict = {
        @CacheEvict(value = "salaryData", allEntries = true),
        @CacheEvict(value = "fieldGonggoData", allEntries = true),
        @CacheEvict(value = "regionCounts", allEntries = true)
    })
    public void evictStatisticsCache() {
        // 캐시만 삭제
    }

    // 공지사항 캐시 삭제
    @CacheEvict(value = "noticeList", allEntries = true)
    public void evictNoticeCache() {
        // 캐시만 삭제
    }

    // 모든 캐시 삭제 (관리자용)
    @Caching(evict = {
        @CacheEvict(value = "boardList", allEntries = true),
        @CacheEvict(value = "noticeList", allEntries = true),
        @CacheEvict(value = "companyList", allEntries = true),
        @CacheEvict(value = "popularCom", allEntries = true),
        @CacheEvict(value = "salaryData", allEntries = true),
        @CacheEvict(value = "fieldGonggoData", allEntries = true),
        @CacheEvict(value = "regionCounts", allEntries = true)
    })
    public void evictAllCache() {
        // 모든 캐시 삭제
    }
}
