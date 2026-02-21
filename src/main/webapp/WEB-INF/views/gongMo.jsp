<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공모전 - 12Wa~ 취업포털</title>
    <style>
        /* ===================================
           Inflearn Style - Contest Page (Blue Theme)
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

        /* Page Container */
        .page-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 40px 32px;
        }

        /* Page Header */
        .page-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .page-header h1 {
            font-size: 32px;
            font-weight: 700;
            color: #1b1b1b;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }

        .page-header h1 i {
            color: #1A6DFF;
        }

        .page-header p {
            font-size: 16px;
            color: #666;
        }

        /* Search Section */
        .search-section {
            background: #fff;
            border-radius: 16px;
            padding: 32px;
            margin-bottom: 32px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
        }

        .search-bar {
            display: flex;
            gap: 12px;
            align-items: center;
            max-width: 800px;
            margin: 0 auto 24px;
        }

        .search-input-wrap {
            flex: 1;
            position: relative;
        }

        .search-input-wrap i {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
            font-size: 18px;
        }

        .search-input {
            width: 100%;
            padding: 16px 20px 16px 52px;
            border: 2px solid #e8e8e8;
            border-radius: 50px;
            font-size: 16px;
            transition: all 0.2s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: #1A6DFF;
            box-shadow: 0 0 0 4px rgba(26, 109, 255, 0.1);
        }

        .search-btn {
            padding: 16px 32px;
            background: linear-gradient(135deg, #1A6DFF 0%, #0052CC 100%);
            color: #fff;
            border: none;
            border-radius: 50px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            white-space: nowrap;
        }

        .search-btn:hover {
            background: linear-gradient(135deg, #0052CC 0%, #003d99 100%);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(26, 109, 255, 0.3);
        }

        .reset-btn {
            padding: 16px 24px;
            background: #f5f5f5;
            color: #666;
            border: none;
            border-radius: 50px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .reset-btn:hover {
            background: #e8e8e8;
        }

        /* Filter Options */
        .filter-options {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 16px;
            flex-wrap: wrap;
        }

        .filter-select {
            padding: 12px 40px 12px 16px;
            border: 1px solid #e8e8e8;
            border-radius: 8px;
            font-size: 14px;
            color: #333;
            background: #fff url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23666' d='M6 8L1 3h10z'/%3E%3C/svg%3E") no-repeat right 16px center;
            appearance: none;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .filter-select:focus {
            outline: none;
            border-color: #1A6DFF;
        }

        .filter-link {
            padding: 10px 20px;
            background: #E8F2FF;
            color: #1A6DFF;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
            border: 1px solid #1A6DFF;
        }

        .filter-link:hover {
            background: #1A6DFF;
            color: #fff;
        }

        /* Sort Tabs */
        .sort-tabs {
            display: flex;
            gap: 8px;
            margin-bottom: 24px;
            border-bottom: 1px solid #e8e8e8;
            padding-bottom: 16px;
        }

        .sort-tab {
            padding: 10px 20px;
            background: transparent;
            border: none;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
            color: #666;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .sort-tab:hover {
            background: #f5f5f5;
            color: #333;
        }

        .sort-tab.active {
            background: #1A6DFF;
            color: #fff;
        }

        /* Results Info */
        .results-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }

        .results-count {
            font-size: 14px;
            color: #666;
        }

        .results-count strong {
            color: #1A6DFF;
            font-weight: 600;
        }

        /* Card Grid */
        .card-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 24px;
        }

        @media (max-width: 1200px) {
            .card-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }

        @media (max-width: 900px) {
            .card-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 600px) {
            .card-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Contest Card */
        .contest-card {
            background: #fff;
            border-radius: 16px;
            border: 1px solid #e8e8e8;
            overflow: hidden;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
            min-height: 300px;
        }

        .contest-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.08);
            border-color: #1A6DFF;
        }

        .card-header {
            padding: 24px 24px 0;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }

        .card-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 600;
        }

        .badge-it {
            background: #dbeafe;
            color: #1d4ed8;
        }

        .badge-design {
            background: #fce7f3;
            color: #be185d;
        }

        .badge-media {
            background: #fef3c7;
            color: #b45309;
        }

        .badge-edu {
            background: #d1fae5;
            color: #047857;
        }

        .badge-medical {
            background: #ede9fe;
            color: #6d28d9;
        }

        .badge-default {
            background: #f3f4f6;
            color: #374151;
        }

        .card-body {
            padding: 16px 24px 24px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .card-title {
            font-size: 18px;
            font-weight: 700;
            color: #1b1b1b;
            margin-bottom: 12px;
            line-height: 1.4;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .card-field {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 4px 10px;
            background: #f5f7fa;
            border-radius: 4px;
            font-size: 13px;
            color: #666;
            margin-bottom: 12px;
            width: fit-content;
        }

        .card-period {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
            color: #666;
            margin-bottom: 16px;
        }

        .card-period i {
            color: #1A6DFF;
        }

        .card-footer {
            margin-top: auto;
            padding-top: 16px;
            border-top: 1px solid #f0f0f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-date {
            font-size: 13px;
            color: #999;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .card-views {
            display: flex;
            align-items: center;
            gap: 4px;
            font-size: 13px;
            color: #999;
        }

        .card-views i {
            font-size: 12px;
        }

        /* Empty State */
        .empty-state {
            grid-column: 1 / -1;
            text-align: center;
            padding: 80px 40px;
            background: #fff;
            border-radius: 16px;
            border: 1px solid #e8e8e8;
        }

        .empty-state i {
            font-size: 64px;
            color: #ddd;
            margin-bottom: 24px;
        }

        .empty-state h3 {
            font-size: 20px;
            color: #333;
            margin-bottom: 8px;
        }

        .empty-state p {
            color: #999;
        }

        /* Pagination */
        .pagination-section {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 24px;
            margin-top: 48px;
            padding-top: 32px;
            border-top: 1px solid #e8e8e8;
            flex-wrap: wrap;
        }

        .pagination {
            display: flex;
            gap: 4px;
            align-items: center;
        }

        .page-btn {
            min-width: 40px;
            height: 40px;
            padding: 0 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid #e8e8e8;
            border-radius: 8px;
            background: #fff;
            color: #666;
            font-size: 14px;
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

        .page-btn.nav {
            font-weight: 600;
        }

        .page-info {
            font-size: 14px;
            color: #666;
        }

        .page-info strong {
            color: #1A6DFF;
        }

        /* Write Button */
        .write-section {
            display: flex;
            justify-content: flex-end;
            margin-top: 24px;
        }

        .write-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 14px 28px;
            background: linear-gradient(135deg, #1A6DFF 0%, #0052CC 100%);
            color: #fff;
            border: none;
            border-radius: 12px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .write-btn:hover {
            background: linear-gradient(135deg, #0052CC 0%, #003d99 100%);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(26, 109, 255, 0.3);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .page-container {
                padding: 20px 16px;
            }

            .page-header h1 {
                font-size: 24px;
            }

            .search-section {
                padding: 20px;
            }

            .search-bar {
                flex-direction: column;
            }

            .search-btn, .reset-btn {
                width: 100%;
            }

            .filter-options {
                flex-direction: column;
            }

            .filter-select {
                width: 100%;
            }

            .pagination-section {
                flex-direction: column;
                gap: 16px;
            }
        }
    </style>

    <script>
        function timeShareing() {
            var currentDate = new Date();
            var year = currentDate.getFullYear();
            var month = ('0' + (currentDate.getMonth() + 1)).slice(-2);
            var day = ('0' + currentDate.getDate()).slice(-2);
            var formattedCurrentDate = year + month + day;
            $("[name='gongMoSearchForm']").find("[name='ing']").val(formattedCurrentDate);
            $(".searchBtn").click();
        }

        function searchWithSort(sort) {
            $("[name='gongMoSearchForm']").find("[name=sort]").val(sort);
            $(".searchBtn").click();
        }

        function goGongMoDetailForm(comp_pk) {
            $("[name='gongMoDetailForm']").find("[name='comp_pk']").val(comp_pk);
            document.gongMoDetailForm.submit();
        }

        function search() {
            var gongMoSearchFormObj = $("[name=gongMoSearchForm]");
            var keywordObj = gongMoSearchFormObj.find(".keyword");
            var keyword = keywordObj.val();
            if (typeof(keyword) != 'string') { keyword = ""; }
            keyword = $.trim(keyword);
            keywordObj.val(keyword);

            gongMoSearchFormObj.find(".rowCntPerPage").val(
                $("select").filter(".rowCntPerPage").val()
            );

            $.ajax({
                url: "/gongMo.do",
                type: "post",
                data: gongMoSearchFormObj.serialize(),
                success: function(responseHtml) {
                    var obj = $(responseHtml);
                    $(".gongMoListDiv").html(obj.find(".gongMoListDiv").html());
                    $(".pagingNos").html(obj.find(".pagingNos").html());
                },
                error: function() {
                    alert("검색 실패! 관리자에게 문의 바랍니다.");
                }
            });
        }

        function pageNoClick(clickPageNo) {
            $("[name='gongMoSearchForm']").find(".selectPageNo").val(clickPageNo);
            search();
        }

        function searchReset() {
            var gongMoSearchFormObj = $("[name='gongMoSearchForm']");
            gongMoSearchFormObj.find(".keyword").val("");
            gongMoSearchFormObj.find("[name='sort']").val("");
            gongMoSearchFormObj.find("[name='field_name']").val("");
            gongMoSearchFormObj.find("[name='ing']").val("");
            gongMoSearchFormObj.find("[name='rowCntPerPage']").val("12");
            search();
        }

        function getBadgeClass(fieldName) {
            if (fieldName.includes('IT') || fieldName.includes('인터넷')) return 'badge-it';
            if (fieldName.includes('디자인')) return 'badge-design';
            if (fieldName.includes('미디어')) return 'badge-media';
            if (fieldName.includes('교육')) return 'badge-edu';
            if (fieldName.includes('의료')) return 'badge-medical';
            return 'badge-default';
        }
    </script>
</head>

<body>
    <%@ include file="header.jsp"%>

    <div class="page-container">
        <!-- Page Header -->
        <div class="page-header">
            <h1><i class="fas fa-trophy"></i> 공모전</h1>
            <p>다양한 공모전에 참여하여 실력을 뽐내고 경험을 쌓아보세요</p>
        </div>

        <!-- Search Section -->
        <div class="search-section">
            <form name="gongMoSearchForm" onsubmit="return false">
                <div class="search-bar">
                    <div class="search-input-wrap">
                        <i class="fas fa-search"></i>
                        <input type="text" name="keyword" class="search-input keyword" placeholder="공모전 검색...">
                    </div>
                    <button type="button" class="search-btn searchBtn" onclick="search()">
                        <i class="fas fa-search"></i> 검색
                    </button>
                    <button type="button" class="reset-btn" onclick="searchReset()">
                        <i class="fas fa-redo"></i> 초기화
                    </button>
                </div>

                <div class="filter-options">
                    <select name="field_name" class="filter-select field_name">
                        <option value="">전체 분야</option>
                        <option value="IT·인터넷">IT·인터넷</option>
                        <option value="디자인">디자인</option>
                        <option value="미디어">미디어</option>
                        <option value="교육">교육</option>
                        <option value="의료">의료</option>
                    </select>

                    <select name="rowCntPerPage" class="filter-select rowCntPerPage" onchange="search()">
                        <option value="12">12개씩 보기</option>
                        <option value="24">24개씩 보기</option>
                        <option value="36">36개씩 보기</option>
                    </select>

                    <span class="filter-link" onclick="timeShareing();">
                        <i class="fas fa-clock"></i> 진행중인 공모전만 보기
                    </span>
                </div>

                <input type="hidden" name="field_code" class="field_code">
                <input type="hidden" name="ing" class="ing">
                <input type="hidden" name="sort" class="sort">
                <input type="hidden" name="selectPageNo" class="selectPageNo" value="1">
                <input type="hidden" name="rowCntPerPage" class="rowCntPerPage">
            </form>
        </div>

        <!-- Sort & Results -->
        <div class="results-info">
            <div class="sort-tabs">
                <button class="sort-tab ${empty param.sort ? 'active' : ''}" onclick="searchWithSort('')">최신순</button>
                <button class="sort-tab ${param.sort == 'reg_date desc' ? 'active' : ''}" onclick="searchWithSort('reg_date desc')">등록일순</button>
                <button class="sort-tab ${param.sort == 'read_count desc' ? 'active' : ''}" onclick="searchWithSort('read_count desc')">조회순</button>
            </div>
            <div class="results-count">
                총 <strong>${requestScope.gongMoListAllCnt}</strong>개의 공모전
            </div>
        </div>

        <!-- Contest Cards -->
        <div class="gongMoListDiv">
            <div class="card-grid">
                <c:choose>
                    <c:when test="${empty gongMoList}">
                        <div class="empty-state">
                            <i class="fas fa-trophy"></i>
                            <h3>등록된 공모전이 없습니다</h3>
                            <p>새로운 공모전이 곧 등록될 예정입니다!</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="gongMo" items="${requestScope.gongMoList}" varStatus="status">
                            <div class="contest-card" onclick="goGongMoDetailForm(${gongMo.comp_pk})">
                                <div class="card-header">
                                    <c:choose>
                                        <c:when test="${gongMo.field_name.contains('IT') || gongMo.field_name.contains('인터넷')}">
                                            <span class="card-badge badge-it"><i class="fas fa-laptop-code"></i> IT·인터넷</span>
                                        </c:when>
                                        <c:when test="${gongMo.field_name.contains('디자인')}">
                                            <span class="card-badge badge-design"><i class="fas fa-palette"></i> 디자인</span>
                                        </c:when>
                                        <c:when test="${gongMo.field_name.contains('미디어')}">
                                            <span class="card-badge badge-media"><i class="fas fa-video"></i> 미디어</span>
                                        </c:when>
                                        <c:when test="${gongMo.field_name.contains('교육')}">
                                            <span class="card-badge badge-edu"><i class="fas fa-graduation-cap"></i> 교육</span>
                                        </c:when>
                                        <c:when test="${gongMo.field_name.contains('의료')}">
                                            <span class="card-badge badge-medical"><i class="fas fa-heartbeat"></i> 의료</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="card-badge badge-default"><i class="fas fa-tag"></i> ${gongMo.field_name}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="card-body">
                                    <h3 class="card-title">${gongMo.subject}</h3>
                                    <div class="card-period">
                                        <i class="fas fa-calendar-alt"></i>
                                        <span>${gongMo.start_time} ~ ${gongMo.end_time}</span>
                                    </div>
                                    <div class="card-footer">
                                        <span class="card-date">
                                            <i class="fas fa-clock"></i> ${gongMo.reg_date}
                                        </span>
                                        <span class="card-views">
                                            <i class="fas fa-eye"></i> ${gongMo.read_count}
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Pagination -->
        <div class="pagination-section">
            <span class="pagingNos">
                <div class="pagination">
                    <button class="page-btn nav" onclick="pageNoClick(1)">
                        <i class="fas fa-angle-double-left"></i>
                    </button>
                    <button class="page-btn nav" onclick="pageNoClick(${requestScope.boardMap.selectPageNo - 1})">
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

                    <button class="page-btn nav" onclick="pageNoClick(${requestScope.boardMap.selectPageNo + 1})">
                        <i class="fas fa-angle-right"></i>
                    </button>
                    <button class="page-btn nav" onclick="pageNoClick(${requestScope.boardMap.last_pageNo})">
                        <i class="fas fa-angle-double-right"></i>
                    </button>
                </div>

                <div class="page-info">
                    <strong>${requestScope.gongMoListCnt}</strong> / ${requestScope.gongMoListAllCnt}개
                </div>
            </span>
        </div>

        <!-- Write Button -->
        <c:if test="${sessionScope.member == 'company'}">
            <div class="write-section">
                <button class="write-btn" onclick="location.replace('/gongMoRegForm.do')">
                    <i class="fas fa-plus"></i> 공모전 등록
                </button>
            </div>
        </c:if>
    </div>

    <!-- Hidden Form -->
    <form name="gongMoDetailForm" action="/gongMoDetailForm.do" method="post">
        <input type="hidden" name="comp_pk">
    </form>

    <%@ include file="footer.jsp"%>
</body>
</html>
