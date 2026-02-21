<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>채용정보 - 12Wa~ 취업포털</title>
    <style>
        /* ===================================
           JobKorea Style - Job List Page
           =================================== */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: #f5f7fa;
            color: #1b1b1b;
            line-height: 1.6;
        }

        /* Main Layout */
        .job-page-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 30px 20px;
            display: flex;
            gap: 24px;
        }

        /* Left Content Area */
        .job-main-content {
            flex: 1;
            min-width: 0;
        }

        /* Right Sidebar */
        .job-sidebar {
            width: 280px;
            flex-shrink: 0;
        }

        /* Page Header */
        .job-page-header {
            background: linear-gradient(135deg, #1A6DFF 0%, #0052CC 100%);
            color: #fff;
            padding: 40px 20px;
            text-align: center;
            margin-bottom: 0;
        }

        .job-page-header h1 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .job-page-header p {
            font-size: 15px;
            opacity: 0.9;
        }

        /* ===================================
           Search Filter Section (JobKorea Style)
           =================================== */
        .search-filter-section {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
            margin-bottom: 20px;
            overflow: hidden;
        }

        /* Filter Tabs */
        .filter-tabs {
            display: flex;
            border-bottom: 1px solid #e8e8e8;
            background: #fafafa;
        }

        .filter-tab {
            padding: 14px 24px;
            font-size: 14px;
            font-weight: 500;
            color: #666;
            cursor: pointer;
            border: none;
            background: transparent;
            position: relative;
            transition: all 0.2s ease;
        }

        .filter-tab:hover {
            color: #1A6DFF;
            background: #f0f7ff;
        }

        .filter-tab.active {
            color: #1A6DFF;
            font-weight: 600;
            background: #fff;
        }

        .filter-tab.active::after {
            content: '';
            position: absolute;
            bottom: -1px;
            left: 0;
            right: 0;
            height: 2px;
            background: #1A6DFF;
        }

        .filter-tab i {
            margin-right: 6px;
        }

        /* Filter Content Panels */
        .filter-panels {
            padding: 20px;
        }

        .filter-panel {
            display: none;
        }

        .filter-panel.active {
            display: block;
        }

        /* Search Input Row */
        .search-input-row {
            display: flex;
            gap: 12px;
            margin-bottom: 16px;
        }

        .search-input-wrap {
            flex: 1;
            position: relative;
        }

        .search-input-wrap input {
            width: 100%;
            padding: 12px 16px 12px 44px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.2s ease;
        }

        .search-input-wrap input:focus {
            outline: none;
            border-color: #1A6DFF;
            box-shadow: 0 0 0 3px rgba(26, 109, 255, 0.1);
        }

        .search-input-wrap i {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
        }

        .search-btn {
            padding: 12px 28px;
            background: #1A6DFF;
            color: #fff;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .search-btn:hover {
            background: #0052CC;
        }

        .reset-btn {
            padding: 12px 20px;
            background: #f5f5f5;
            color: #666;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .reset-btn:hover {
            background: #e8e8e8;
        }

        /* Filter Options Grid */
        .filter-options-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(140px, 1fr));
            gap: 10px;
        }

        .filter-option {
            padding: 10px 14px;
            background: #f8f9fa;
            border: 1px solid #e8e8e8;
            border-radius: 6px;
            font-size: 13px;
            color: #333;
            cursor: pointer;
            transition: all 0.2s ease;
            text-align: center;
        }

        .filter-option:hover {
            border-color: #1A6DFF;
            background: #f0f7ff;
            color: #1A6DFF;
        }

        .filter-option.selected {
            border-color: #1A6DFF;
            background: #1A6DFF;
            color: #fff;
        }

        .filter-option .count {
            font-size: 11px;
            color: #999;
            margin-left: 4px;
        }

        .filter-option.selected .count {
            color: rgba(255,255,255,0.8);
        }

        /* Selected Filters Tags */
        .selected-filters {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-top: 16px;
            padding-top: 16px;
            border-top: 1px solid #e8e8e8;
        }

        .selected-filter-tag {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 12px;
            background: #E8F2FF;
            color: #1A6DFF;
            border-radius: 20px;
            font-size: 13px;
        }

        .selected-filter-tag .remove {
            cursor: pointer;
            font-weight: bold;
        }

        .selected-filter-tag .remove:hover {
            color: #0052CC;
        }

        /* ===================================
           Results Info & Sort
           =================================== */
        .results-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
            padding: 16px 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }

        .results-count {
            font-size: 15px;
            color: #333;
        }

        .results-count strong {
            color: #1A6DFF;
            font-weight: 700;
        }

        .sort-options {
            display: flex;
            gap: 8px;
        }

        .sort-option {
            padding: 8px 16px;
            background: transparent;
            border: 1px solid #ddd;
            border-radius: 20px;
            font-size: 13px;
            color: #666;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .sort-option:hover {
            border-color: #1A6DFF;
            color: #1A6DFF;
        }

        .sort-option.active {
            background: #1A6DFF;
            border-color: #1A6DFF;
            color: #fff;
        }

        /* ===================================
           Job List Cards (List Style)
           =================================== */
        .gongGoListDiv {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .job-card {
            background: #fff;
            border-radius: 12px;
            border: 1px solid #e8e8e8;
            padding: 24px;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            gap: 20px;
        }

        .job-card:hover {
            border-color: #1A6DFF;
            box-shadow: 0 4px 16px rgba(26, 109, 255, 0.1);
            transform: translateY(-2px);
        }

        .job-card-logo {
            width: 80px;
            height: 80px;
            border-radius: 8px;
            overflow: hidden;
            flex-shrink: 0;
            background: #f5f5f5;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .job-card-logo img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .job-card-content {
            flex: 1;
            min-width: 0;
        }

        .job-card-company {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 8px;
        }

        .company-name {
            font-size: 14px;
            color: #666;
            font-weight: 500;
        }

        .company-badge {
            display: inline-flex;
            align-items: center;
            padding: 2px 8px;
            background: #E8F2FF;
            color: #1A6DFF;
            border-radius: 4px;
            font-size: 11px;
            font-weight: 500;
        }

        .job-card-title {
            font-size: 18px;
            font-weight: 700;
            color: #1b1b1b;
            margin-bottom: 12px;
            line-height: 1.4;
        }

        .job-card-info {
            display: flex;
            flex-wrap: wrap;
            gap: 8px 16px;
            margin-bottom: 12px;
            font-size: 13px;
            color: #666;
        }

        .job-card-info span {
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .job-card-info i {
            color: #999;
            font-size: 12px;
        }

        .job-card-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 6px;
        }

        .job-tag {
            padding: 4px 10px;
            background: #f5f7fa;
            border-radius: 4px;
            font-size: 12px;
            color: #666;
        }

        .job-card-right {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            justify-content: space-between;
            min-width: 120px;
        }

        .job-card-date {
            font-size: 13px;
            color: #999;
        }

        .job-card-deadline {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }

        .deadline-active {
            background: #dcfce7;
            color: #16a34a;
        }

        .deadline-urgent {
            background: #fee2e2;
            color: #dc2626;
        }

        .deadline-closed {
            background: #f3f4f6;
            color: #9ca3af;
        }

        .apply-btn {
            padding: 10px 20px;
            background: #1A6DFF;
            color: #fff;
            border: none;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .apply-btn:hover {
            background: #0052CC;
        }

        /* ===================================
           Pagination
           =================================== */
        .pagination-section {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 20px;
            margin-top: 32px;
            padding: 24px;
            background: #fff;
            border-radius: 12px;
        }

        .pagination {
            display: flex;
            gap: 4px;
            align-items: center;
        }

        .page-btn {
            min-width: 36px;
            height: 36px;
            padding: 0 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid #e8e8e8;
            border-radius: 6px;
            background: #fff;
            color: #666;
            font-size: 13px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .page-btn:hover {
            background: #f5f5f5;
            border-color: #1A6DFF;
            color: #1A6DFF;
        }

        .page-btn.active {
            background: #1A6DFF;
            border-color: #1A6DFF;
            color: #fff;
        }

        .page-info {
            font-size: 13px;
            color: #666;
        }

        .page-info strong {
            color: #1A6DFF;
        }

        .per-page-select {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 13px;
        }

        /* ===================================
           Recently Viewed Sidebar
           =================================== */
        .sidebar-section {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
            position: sticky;
            top: 100px;
        }

        .sidebar-header {
            padding: 16px 20px;
            border-bottom: 1px solid #e8e8e8;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .sidebar-header h3 {
            font-size: 15px;
            font-weight: 600;
            color: #333;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .sidebar-header h3 i {
            color: #1A6DFF;
        }

        .sidebar-count {
            background: #1A6DFF;
            color: #fff;
            padding: 2px 8px;
            border-radius: 10px;
            font-size: 11px;
            font-weight: 600;
        }

        .sidebar-content {
            max-height: 600px;
            overflow-y: auto;
        }

        .recent-job-item {
            padding: 14px 20px;
            border-bottom: 1px solid #f0f0f0;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .recent-job-item:hover {
            background: #f8f9fa;
        }

        .recent-job-item:last-child {
            border-bottom: none;
        }

        .recent-job-company {
            font-size: 12px;
            color: #999;
            margin-bottom: 4px;
        }

        .recent-job-title {
            font-size: 13px;
            font-weight: 500;
            color: #333;
            line-height: 1.4;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .recent-job-deadline {
            font-size: 11px;
            color: #1A6DFF;
            margin-top: 6px;
        }

        .sidebar-empty {
            padding: 40px 20px;
            text-align: center;
            color: #999;
        }

        .sidebar-empty i {
            font-size: 32px;
            margin-bottom: 12px;
            color: #ddd;
        }

        .sidebar-empty p {
            font-size: 13px;
        }

        .clear-history-btn {
            width: 100%;
            padding: 12px;
            background: #f5f5f5;
            border: none;
            color: #666;
            font-size: 13px;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .clear-history-btn:hover {
            background: #e8e8e8;
        }

        /* ===================================
           Empty State
           =================================== */
        .empty-state {
            text-align: center;
            padding: 60px 40px;
            background: #fff;
            border-radius: 12px;
            border: 1px solid #e8e8e8;
        }

        .empty-state i {
            font-size: 48px;
            color: #ddd;
            margin-bottom: 16px;
        }

        .empty-state h3 {
            font-size: 18px;
            color: #333;
            margin-bottom: 8px;
        }

        .empty-state p {
            font-size: 14px;
            color: #999;
        }

        /* ===================================
           Write Button
           =================================== */
        .write-section {
            margin-top: 20px;
            text-align: right;
        }

        .write-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 14px 28px;
            background: linear-gradient(135deg, #1A6DFF 0%, #0052CC 100%);
            color: #fff;
            border: none;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .write-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(26, 109, 255, 0.3);
        }

        /* ===================================
           Responsive
           =================================== */
        @media (max-width: 1024px) {
            .job-page-container {
                flex-direction: column;
            }

            .job-sidebar {
                width: 100%;
                order: -1;
            }

            .sidebar-section {
                position: static;
            }

            .sidebar-content {
                max-height: 200px;
            }
        }

        @media (max-width: 768px) {
            .filter-tabs {
                flex-wrap: wrap;
            }

            .filter-tab {
                padding: 10px 16px;
                font-size: 13px;
            }

            .job-card {
                flex-direction: column;
                gap: 16px;
            }

            .job-card-right {
                flex-direction: row;
                align-items: center;
                width: 100%;
                min-width: auto;
            }

            .search-input-row {
                flex-direction: column;
            }

            .results-header {
                flex-direction: column;
                gap: 12px;
                align-items: flex-start;
            }

            .sort-options {
                flex-wrap: wrap;
            }
        }
    </style>
</head>

<body>
<%@ include file="header.jsp" %>

<!-- Page Header -->
<div class="job-page-header">
    <h1><i class="fas fa-briefcase"></i> 채용정보</h1>
    <p>다양한 기업의 채용공고를 확인하고 지원해보세요</p>
</div>

<div class="job-page-container">
    <!-- Main Content -->
    <div class="job-main-content">
        <!-- Search Filter Section -->
        <div class="search-filter-section">
            <form name="gonggoSearchForm" onsubmit="return false">
                <!-- Filter Tabs -->
                <div class="filter-tabs">
                    <button type="button" class="filter-tab active" data-panel="search">
                        <i class="fas fa-search"></i> 검색
                    </button>
                    <button type="button" class="filter-tab" data-panel="location">
                        <i class="fas fa-map-marker-alt"></i> 근무지역
                    </button>
                    <button type="button" class="filter-tab" data-panel="job">
                        <i class="fas fa-briefcase"></i> 직무
                    </button>
                    <button type="button" class="filter-tab" data-panel="industry">
                        <i class="fas fa-industry"></i> 업종
                    </button>
                    <button type="button" class="filter-tab" data-panel="status">
                        <i class="fas fa-clock"></i> 공고상태
                    </button>
                </div>

                <!-- Filter Panels -->
                <div class="filter-panels">
                    <!-- Search Panel -->
                    <div class="filter-panel active" id="panel-search">
                        <div class="search-input-row">
                            <div class="search-input-wrap">
                                <i class="fas fa-search"></i>
                                <input type="text" class="keyword" name="keyword" placeholder="기업명, 공고제목, 키워드로 검색">
                            </div>
                            <button type="button" class="search-btn searchBtn" onclick="searchForm()">
                                검색
                            </button>
                            <button type="button" class="reset-btn" onclick="resetSearch()">
                                <i class="fas fa-redo"></i> 초기화
                            </button>
                        </div>
                    </div>

                    <!-- Location Panel -->
                    <div class="filter-panel" id="panel-location">
                        <div class="filter-options-grid">
                            <button type="button" class="filter-option" data-type="work_place" data-value="서울">서울</button>
                            <button type="button" class="filter-option" data-type="work_place" data-value="경기">경기</button>
                            <button type="button" class="filter-option" data-type="work_place" data-value="인천">인천</button>
                            <button type="button" class="filter-option" data-type="work_place" data-value="부산">부산</button>
                            <button type="button" class="filter-option" data-type="work_place" data-value="대전">대전</button>
                            <button type="button" class="filter-option" data-type="work_place" data-value="대구">대구</button>
                            <button type="button" class="filter-option" data-type="work_place" data-value="광주">광주</button>
                            <button type="button" class="filter-option" data-type="work_place" data-value="강원">강원</button>
                            <button type="button" class="filter-option" data-type="work_place" data-value="충남">충남</button>
                            <button type="button" class="filter-option" data-type="work_place" data-value="충북">충북</button>
                            <button type="button" class="filter-option" data-type="work_place" data-value="전남">전남</button>
                            <button type="button" class="filter-option" data-type="work_place" data-value="전북">전북</button>
                            <button type="button" class="filter-option" data-type="work_place" data-value="경남">경남</button>
                            <button type="button" class="filter-option" data-type="work_place" data-value="경북">경북</button>
                            <button type="button" class="filter-option" data-type="work_place" data-value="제주">제주</button>
                        </div>
                    </div>

                    <!-- Job Field Panel (직무) -->
                    <div class="filter-panel" id="panel-job">
                        <div class="filter-options-grid">
                            <button type="button" class="filter-option" data-type="field_name" data-value="백엔드">백엔드</button>
                            <button type="button" class="filter-option" data-type="field_name" data-value="프론트엔드">프론트엔드</button>
                            <button type="button" class="filter-option" data-type="field_name" data-value="풀스택">풀스택</button>
                            <button type="button" class="filter-option" data-type="field_name" data-value="데이터">데이터</button>
                            <button type="button" class="filter-option" data-type="field_name" data-value="AI">AI/ML</button>
                            <button type="button" class="filter-option" data-type="field_name" data-value="보안">보안</button>
                            <button type="button" class="filter-option" data-type="field_name" data-value="QA">QA/테스트</button>
                            <button type="button" class="filter-option" data-type="field_name" data-value="DevOps">DevOps</button>
                            <button type="button" class="filter-option" data-type="field_name" data-value="모바일">모바일</button>
                            <button type="button" class="filter-option" data-type="field_name" data-value="게임">게임</button>
                            <button type="button" class="filter-option" data-type="field_name" data-value="마케팅">마케팅</button>
                            <button type="button" class="filter-option" data-type="field_name" data-value="디자인">디자인</button>
                            <button type="button" class="filter-option" data-type="field_name" data-value="기획">기획</button>
                            <button type="button" class="filter-option" data-type="field_name" data-value="영업">영업</button>
                            <button type="button" class="filter-option" data-type="field_name" data-value="인사">인사/HR</button>
                            <button type="button" class="filter-option" data-type="field_name" data-value="재무">재무/회계</button>
                        </div>
                    </div>

                    <!-- Industry Panel -->
                    <div class="filter-panel" id="panel-industry">
                        <div class="filter-options-grid">
                            <button type="button" class="filter-option" data-type="industry" data-value="소프트웨어">IT/소프트웨어</button>
                            <button type="button" class="filter-option" data-type="industry" data-value="금융">금융/보험</button>
                            <button type="button" class="filter-option" data-type="industry" data-value="의료">의료/보건</button>
                            <button type="button" class="filter-option" data-type="industry" data-value="건설">건설/건축</button>
                            <button type="button" class="filter-option" data-type="industry" data-value="전자상거래">전자상거래</button>
                            <button type="button" class="filter-option" data-type="industry" data-value="교육">교육</button>
                            <button type="button" class="filter-option" data-type="industry" data-value="여행">여행/관광</button>
                            <button type="button" class="filter-option" data-type="industry" data-value="뷰티">뷰티/화장품</button>
                            <button type="button" class="filter-option" data-type="industry" data-value="식품">식품/음료</button>
                            <button type="button" class="filter-option" data-type="industry" data-value="통신">통신/네트워크</button>
                            <button type="button" class="filter-option" data-type="industry" data-value="자동차">자동차</button>
                            <button type="button" class="filter-option" data-type="industry" data-value="패션">패션/의류</button>
                        </div>
                    </div>

                    <!-- Status Panel -->
                    <div class="filter-panel" id="panel-status">
                        <div class="filter-options-grid">
                            <button type="button" class="filter-option" data-type="gonggoStatus" data-value="ing">진행중인 공고</button>
                            <button type="button" class="filter-option" data-type="gonggoStatus" data-value="end">마감된 공고</button>
                        </div>
                    </div>

                    <!-- Selected Filters Display -->
                    <div class="selected-filters" id="selectedFilters" style="display:none;"></div>
                </div>

                <!-- Hidden inputs -->
                <input type="hidden" name="gonggoStatus" id="gonggoStatus">
                <input type="hidden" name="work_place" id="work_place">
                <input type="hidden" name="industry" id="industry">
                <input type="hidden" name="field_name" id="field_name">
                <input type="hidden" name="sort" class="sort">
                <input type="hidden" name="selectPageNo" class="selectPageNo" value="1">
                <input type="hidden" name="rowCntPerPage" class="rowCntPerPage">
            </form>
        </div>

        <!-- Results Header -->
        <div class="results-header">
            <div class="results-count">
                전체 <strong>${requestScope.gonggoListAllCnt}</strong>건
            </div>
            <div class="sort-options">
                <select class="per-page-select rowCntPerPage" onchange="searchForm()" style="margin-right: 8px;">
                    <option value="10">10개씩</option>
                    <option value="15">15개씩</option>
                    <option value="20">20개씩</option>
                </select>
                <button type="button" class="sort-option ${empty param.sort ? 'active' : ''}" onclick="searchWithSort('')">최신순</button>
                <button type="button" class="sort-option ${param.sort == 'gonggoreg_date desc' ? 'active' : ''}" onclick="searchWithSort('gonggoreg_date desc')">등록일순</button>
                <button type="button" class="sort-option ${param.sort == 'work_place asc' ? 'active' : ''}" onclick="searchWithSort('work_place asc')">지역순</button>
            </div>
        </div>

        <!-- Job List -->
        <div class="gongGoListDiv">
            <c:choose>
                <c:when test="${empty requestScope.gonggoList}">
                    <div class="empty-state">
                        <i class="fas fa-search"></i>
                        <h3>조회할 데이터가 없습니다</h3>
                        <p>다른 검색 조건으로 다시 시도해보세요</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="gonggo" items="${requestScope.gonggoList}" varStatus="status">
                        <div class="job-card" onclick="goGonggoDetailForm(${gonggo.g_no}, '${fn:replace(gonggo.name, "'", "\\'")}', '${fn:replace(gonggo.field_detail1, "'", "\\'")}', ${gonggo.due_date})">
                            <div class="job-card-logo">
                                <img src="images/photo-1.jpg" alt="${gonggo.name}">
                            </div>
                            <div class="job-card-content">
                                <div class="job-card-company">
                                    <span class="company-name">${gonggo.name}</span>
                                    <c:if test="${not empty gonggo.business_industry}">
                                        <span class="company-badge">${gonggo.business_industry}</span>
                                    </c:if>
                                </div>
                                <h3 class="job-card-title">
                                    <c:choose>
                                        <c:when test="${not empty gonggo.field_detail1}">
                                            ${gonggo.field_detail1}
                                        </c:when>
                                        <c:otherwise>
                                            ${gonggo.name} 채용공고
                                        </c:otherwise>
                                    </c:choose>
                                </h3>
                                <div class="job-card-info">
                                    <span><i class="fas fa-graduation-cap"></i> ${gonggo.graduation}</span>
                                    <span><i class="fas fa-briefcase"></i> ${gonggo.career}</span>
                                    <span><i class="fas fa-map-marker-alt"></i> ${gonggo.work_place}</span>
                                </div>
                                <div class="job-card-tags">
                                    <c:if test="${not empty gonggo.graduation}">
                                        <span class="job-tag">${gonggo.graduation}</span>
                                    </c:if>
                                    <c:if test="${not empty gonggo.career}">
                                        <span class="job-tag">${gonggo.career}</span>
                                    </c:if>
                                    <c:if test="${not empty gonggo.field_detail1}">
                                        <span class="job-tag" style="background:#e8f2ff; color:#1A6DFF;">${gonggo.field_detail1}</span>
                                    </c:if>
                                </div>
                            </div>
                            <div class="job-card-right">
                                <span class="job-card-date">${gonggo.gonggoreg_date}</span>
                                <c:choose>
                                    <c:when test="${gonggo.due_date <= 0}">
                                        <span class="job-card-deadline deadline-closed">
                                            <i class="fas fa-times-circle"></i> 마감
                                        </span>
                                    </c:when>
                                    <c:when test="${gonggo.due_date <= 3}">
                                        <span class="job-card-deadline deadline-urgent">
                                            <i class="fas fa-exclamation-circle"></i> D-${gonggo.due_date}
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="job-card-deadline deadline-active">
                                            <i class="fas fa-check-circle"></i> D-${gonggo.due_date}
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Pagination -->
        <div class="pagination-section">
            <span class="pagingNos">
                <div class="pagination">
                    <button class="page-btn" onclick="pageNoClick(1)">
                        <i class="fas fa-angle-double-left"></i>
                    </button>
                    <button class="page-btn" onclick="pageNoClick(${requestScope.boardMap.selectPageNo - 1})">
                        <i class="fas fa-angle-left"></i>
                    </button>

                    <c:forEach var="pageNo" begin="${requestScope.boardMap.begin_pageNo}" end="${requestScope.boardMap.end_pageNo}">
                        <c:choose>
                            <c:when test="${requestScope.boardMap.selectPageNo == pageNo}">
                                <button class="page-btn active">${pageNo}</button>
                            </c:when>
                            <c:otherwise>
                                <button class="page-btn" onclick="pageNoClick(${pageNo})">${pageNo}</button>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <button class="page-btn" onclick="pageNoClick(${requestScope.boardMap.selectPageNo + 1})">
                        <i class="fas fa-angle-right"></i>
                    </button>
                    <button class="page-btn" onclick="pageNoClick(${requestScope.boardMap.last_pageNo})">
                        <i class="fas fa-angle-double-right"></i>
                    </button>
                </div>
            </span>
        </div>

        <!-- Write Button -->
        <c:if test="${sessionScope.member == 'company'}">
            <div class="write-section">
                <button class="write-btn" onclick="location.replace('/gongGoRegForm.do')">
                    <i class="fas fa-plus"></i> 공고 등록
                </button>
            </div>
        </c:if>
    </div>

    <!-- Right Sidebar - Recently Viewed -->
    <div class="job-sidebar">
        <div class="sidebar-section">
            <div class="sidebar-header">
                <h3><i class="fas fa-history"></i> 최근 본 공고</h3>
                <span class="sidebar-count" id="recentCount">0</span>
            </div>
            <div class="sidebar-content" id="recentJobsList">
                <div class="sidebar-empty">
                    <i class="fas fa-eye-slash"></i>
                    <p>최근 본 공고가 없습니다</p>
                </div>
            </div>
            <button type="button" class="clear-history-btn" onclick="clearRecentJobs()" style="display:none;" id="clearHistoryBtn">
                <i class="fas fa-trash-alt"></i> 기록 삭제
            </button>
        </div>
    </div>
</div>

<!-- Hidden Form -->
<form name="gonggoDetailForm" action="/gonggoDetailForm.do" method="post">
    <input type="hidden" name="g_no" class="g_no">
</form>

<script>
// ===================================
// Filter Tab Functionality
// ===================================
document.querySelectorAll('.filter-tab').forEach(tab => {
    tab.addEventListener('click', function() {
        // Remove active from all tabs
        document.querySelectorAll('.filter-tab').forEach(t => t.classList.remove('active'));
        document.querySelectorAll('.filter-panel').forEach(p => p.classList.remove('active'));

        // Add active to clicked tab
        this.classList.add('active');

        // Show corresponding panel
        const panelId = 'panel-' + this.dataset.panel;
        document.getElementById(panelId).classList.add('active');
    });
});

// ===================================
// Filter Option Selection
// ===================================
var selectedFilters = {};

document.querySelectorAll('.filter-option').forEach(option => {
    option.addEventListener('click', function() {
        const type = this.dataset.type;
        const value = this.dataset.value;
        const label = this.textContent.trim();

        // Toggle selection
        if (this.classList.contains('selected')) {
            this.classList.remove('selected');
            delete selectedFilters[type];
            document.getElementById(type).value = '';
        } else {
            // Remove previous selection of same type
            document.querySelectorAll('.filter-option[data-type="' + type + '"]').forEach(o => {
                o.classList.remove('selected');
            });

            this.classList.add('selected');
            selectedFilters[type] = { value: value, label: label };
            document.getElementById(type).value = value;
        }

        // 필터 변경시 페이지를 1로 리셋
        document.querySelector('.selectPageNo').value = '1';

        updateSelectedFiltersDisplay();
        searchForm();
    });
});

function updateSelectedFiltersDisplay() {
    const container = document.getElementById('selectedFilters');
    const keys = Object.keys(selectedFilters);

    if (keys.length === 0) {
        container.style.display = 'none';
        return;
    }

    container.style.display = 'flex';
    container.innerHTML = keys.map(key => {
        return '<span class="selected-filter-tag">' +
               selectedFilters[key].label +
               '<span class="remove" onclick="removeFilter(\'' + key + '\')">×</span>' +
               '</span>';
    }).join('');
}

function removeFilter(type) {
    delete selectedFilters[type];
    document.getElementById(type).value = '';
    document.querySelectorAll('.filter-option[data-type="' + type + '"]').forEach(o => {
        o.classList.remove('selected');
    });
    updateSelectedFiltersDisplay();
    searchForm();
}

function resetSearch() {
    selectedFilters = {};
    document.querySelectorAll('.filter-option').forEach(o => o.classList.remove('selected'));
    document.getElementById('gonggoStatus').value = '';
    document.getElementById('work_place').value = '';
    document.getElementById('industry').value = '';
    document.getElementById('field_name').value = '';
    document.querySelector('.keyword').value = '';
    document.querySelector('.sort').value = '';
    document.querySelector('.selectPageNo').value = '1';
    updateSelectedFiltersDisplay();
    searchForm();
}

// ===================================
// Search Functions
// ===================================
$(function() {
    $(".results-header select.rowCntPerPage").val("10");
    $("[name='gonggoSearchForm']").find(".rowCntPerPage").val("10");
    // 페이지 초기 로드시에는 서버에서 이미 데이터를 렌더링했으므로 AJAX 호출 불필요
    // searchForm();
    loadRecentJobs();
});

function goGonggoDetailForm(g_no, companyName, role, dueDate) {
    // Save to recently viewed
    saveToRecentJobs(g_no, companyName, role, dueDate);

    $("[name='gonggoDetailForm']").find("[name='g_no']").val(g_no);
    document.gonggoDetailForm.submit();
}

function searchForm() {
    var gonggoSearchFormObj = $("[name='gonggoSearchForm']");
    var keywordObj = gonggoSearchFormObj.find(".keyword");
    var keyword = keywordObj.val();

    if (typeof(keyword) != 'string') {
        keyword = "";
    }
    keyword = $.trim(keyword);
    keywordObj.val(keyword);

    gonggoSearchFormObj.find(".rowCntPerPage").val($(".results-header select.rowCntPerPage").val());

    console.log("searchForm 호출됨:", gonggoSearchFormObj.serialize());

    var currentRowCnt = $(".results-header select.rowCntPerPage").val();

    $.ajax({
        url: "/gongGoList.do",
        type: "post",
        data: gonggoSearchFormObj.serialize(),
        success: function(responseHtml) {
            var obj = $(responseHtml);
            $(".gongGoListDiv").html(obj.find(".gongGoListDiv").html());
            $(".pagingNos").html(obj.find(".pagingNos").html());
            // 결과 카운트 업데이트
            $(".results-count").html(obj.find(".results-count").html());
            // 셀렉트박스 값 유지
            $(".results-header select.rowCntPerPage").val(currentRowCnt);
            console.log("검색 완료");
        },
        error: function(xhr, status, error) {
            console.error("검색 실패:", status, error);
            alert("검색 실패: " + error);
        }
    });
}

function searchWithSort(sort) {
    $("[name='gonggoSearchForm']").find("[name='sort']").val(sort);

    // Update sort button styles
    document.querySelectorAll('.sort-option').forEach(btn => btn.classList.remove('active'));
    event.target.classList.add('active');

    $(".searchBtn").click();
}

function pageNoClick(clickPageNo) {
    $("[name='gonggoSearchForm']").find(".selectPageNo").val(clickPageNo);
    searchForm();
}

// ===================================
// Recently Viewed Jobs (localStorage)
// ===================================
const RECENT_JOBS_KEY = 'recentViewedJobs';
const MAX_RECENT_JOBS = 20;

function saveToRecentJobs(g_no, companyName, role, dueDate) {
    let recentJobs = JSON.parse(localStorage.getItem(RECENT_JOBS_KEY) || '[]');

    // Remove if already exists
    recentJobs = recentJobs.filter(job => job.g_no !== g_no);

    // Add to beginning
    recentJobs.unshift({
        g_no: g_no,
        companyName: companyName || '기업명',
        role: role || '채용공고',
        dueDate: dueDate,
        viewedAt: new Date().toISOString()
    });

    // Keep only last 20
    if (recentJobs.length > MAX_RECENT_JOBS) {
        recentJobs = recentJobs.slice(0, MAX_RECENT_JOBS);
    }

    localStorage.setItem(RECENT_JOBS_KEY, JSON.stringify(recentJobs));
    loadRecentJobs();
}

function loadRecentJobs() {
    const recentJobs = JSON.parse(localStorage.getItem(RECENT_JOBS_KEY) || '[]');
    const container = document.getElementById('recentJobsList');
    const countBadge = document.getElementById('recentCount');
    const clearBtn = document.getElementById('clearHistoryBtn');

    countBadge.textContent = recentJobs.length;

    if (recentJobs.length === 0) {
        container.innerHTML = '<div class="sidebar-empty"><i class="fas fa-eye-slash"></i><p>최근 본 공고가 없습니다</p></div>';
        clearBtn.style.display = 'none';
        return;
    }

    clearBtn.style.display = 'block';

    container.innerHTML = recentJobs.map(job => {
        let deadlineText = '';
        if (job.dueDate !== undefined && job.dueDate !== null) {
            if (job.dueDate <= 0) {
                deadlineText = '마감';
            } else {
                deadlineText = 'D-' + job.dueDate;
            }
        }

        return '<div class="recent-job-item" onclick="goGonggoDetailForm(' + job.g_no + ', \'' + (job.companyName || '').replace(/'/g, "\\'") + '\', \'' + (job.role || '').replace(/'/g, "\\'") + '\', ' + job.dueDate + ')">' +
               '<div class="recent-job-company">' + (job.companyName || '기업명') + '</div>' +
               '<div class="recent-job-title">' + (job.role || '채용공고') + '</div>' +
               (deadlineText ? '<div class="recent-job-deadline">' + deadlineText + '</div>' : '') +
               '</div>';
    }).join('');
}

function clearRecentJobs() {
    if (confirm('최근 본 공고 기록을 모두 삭제하시겠습니까?')) {
        localStorage.removeItem(RECENT_JOBS_KEY);
        loadRecentJobs();
    }
}
</script>

<%@ include file="footer.jsp" %>
</body>
</html>
