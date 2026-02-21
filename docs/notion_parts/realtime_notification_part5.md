## 5) 프론트 연동(서비스 상단 알림)

- 파일: `header.jsp`
- 내용: 기존과 동일
  - 로그인 사용자 SSE 구독
  - `notification` 수신 시 우상단 배너 표시
  - `linkUrl` 존재 시 클릭 이동

- 토글: header.jsp 파일 내용

```html
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/WEB-INF/views/common.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>

<style>

</style>

</head>
<body>
 <div id="container">    
  <header>
    <div id="logo">
      <a href="javascript:location.replace('/careerplus.do')">
        <h1 class="logo-text">
          <span class="logo-career">career</span><span class="logo-plus">+</span>
        </h1>
      </a>
    </div>
      
<nav>
    <ul id="topMenu">
    	
        <li>
            <a style="cursor: pointer;" href="javascript:location.replace('/gongGoList.do')">梨꾩슜?뺣낫</a>
<!--             <ul> -->
<!--                 <li><a href="javascript:location.replace('/gongGoList.do')">吏??퀎</a></li> -->
<!--                 <li><a href="javascript:location.replace('/gongGoList.do')">?낅Т蹂?/a></li> -->
<!--                 <li><a href="javascript:location.replace('/gongGoList.do')">TOP100</a></li> -->
<!--             </ul> -->
        </li>
        <li>
            <a href="javascript:location.replace('/companyList.do')">湲곗뾽?뺣낫</a>
        </li>
        <li>
            <a style="cursor: pointer;" onClick="pushboardname('freeboard','freedome')">而ㅻ??덊떚</a>
            <ul>
                <li><a onClick="pushboardname('freeboard','freedome')">?먯쑀 寃뚯떆??/a></li>
                <li><a onClick="pushboardname('newbieboard','newComer')">?좎엯 寃뚯떆??/a></li>
                <li><a onClick="pushboardname('qnaboard','qna')">Q&A 寃뚯떆??/a></li>
                <li><a onClick="pushboardname('jobsearchboard','jobReady')">痍⑥뾽 寃뚯떆??/a></li>
                <li><a onClick="pushboardname('interviewboard','interview')">硫댁젒 寃뚯떆??/a></li>
                <li><a onClick="pushboardname('tradeboard','joongGo')">以묎퀬 寃뚯떆??/a></li>
            </ul>
        </li>
        <li>
            <a style="cursor: pointer;" href="javascript:location.replace('/timeShare.do')">??꾩뎽??/a>
            <ul>
                <li><a href="javascript:location.replace('/timeShare.do')">?꾨━?쒖꽌</a></li>
                <li><a href="javascript:location.replace('/buupList.do')">遺??/a></li>
            </ul>
        </li>
        <li>
            <a href="javascript:location.replace('/prj.do')">?꾨줈?앺듃/怨듬え??/a>
            <ul>
                <li><a href="javascript:location.replace('/prj.do')">?꾨줈?앺듃</a></li>
                <li><a href="javascript:location.replace('/gongMo.do')">怨듬え??/a></li>
            </ul>
        </li>

        <c:if test="${sessionScope.member == 'person'}">
            <li>
                <a style="cursor: pointer;" href="javascript:location.replace('/timeShareRegForm.do')">?꾨━?쒖꽌 ?깅줉</a>
            </li>
        </c:if>
        <c:if test="${sessionScope.member == 'company'}">
            <li>
                <a style="cursor: pointer;" href="javascript:location.replace('/resumeList.do')">?대젰???대엺</a>
            </li>
        
            <li>
                <a style="cursor: pointer;" href="javascript:location.replace('/gongGoRegForm.do')">怨듦퀬 ?깅줉</a>
            </li>
        </c:if>
                <c:if test="${sessionScope.member == 'admin'}">
            <li>
                <a style="cursor: pointer;" href="javascript:location.replace('/memberList.do')">?뚯썝 愿由?/a>
                 <ul>
                <li><a href="javascript:location.replace('/memberList.do')">?뚯썝 愿由?/a></li>
                <li><a href="javascript:location.replace('/blockMemberList.do')">李⑤떒 ?뚯썝 愿由?/a></li>
            </ul>
            </li>
        </c:if>
        <c:if test="${sessionScope.member=='admin'}">
        	<li>
        	 <a style="cursor: pointer;" href="javascript:location.replace('/resumeList.do')">?대젰???대엺</a>
        	</li>
        </c:if>
    </ul>
</nav>
	
	<div id="welCome">
		<c:if test="${sessionScope.member=='person'}">
			${sessionScope.nickname}?? ?섏쁺?⑸땲??
		</c:if>
		<c:if test="${sessionScope.member=='company'}">
			${sessionScope.name}?? ?섏쁺?⑸땲??
		</c:if>
				<c:if test="${sessionScope.member=='admin'}">
			愿由ъ옄?? ?섏쁺?⑸땲??
		</c:if>
		
	</div>
    <!-- Login Button -->
    <c:choose>
				<c:when test="${empty sessionScope.member}">
					 <a href="javascript:location.replace('/loginForm.do')" id="loginButton">濡쒓렇??/a>
				</c:when>
				<c:otherwise>
					<a href="javascript:location.replace('/loginForm.do')" id="logoutButton">濡쒓렇?꾩썐</a>
				</c:otherwise>  
			</c:choose>

			<c:if test="${sessionScope.member=='company'}">
				<a onClick="document.forms['MyCompanyForm'].submit()" id="myPageButton">湲곗뾽留덉씠?섏씠吏</a>
			</c:if>
			<c:if test="${sessionScope.member == 'person'}">
                 <a href="#" onclick="document.MyPageForm.submit();" id="myPageButton">媛쒖씤留덉씠?섏씠吏</a>
           </c:if>
  <input type="hidden" name="p_no" value="${sessionScope.p_no}">
							<c:if test="${sessionScope.member=='admin'}">
				<a href="javascript:location.replace('/notice.do')" id="myPageButton">怨듭??ы빆愿由?/a>
				</c:if>  
						
  </header>
  </div>
  

  <form name="MyCompanyForm"  action="/myCompany.do"  method="post">
		<input type="hidden" name="c_no"  value='${sessionScope.c_no}'>
	</form>
						
     <form name="MyPageForm"  action="/myPage.do"  method="post">
             <input type="hidden" name="p_no" value="${sessionScope.p_no}">
             <input type="hidden" name="b_no" value="${requestScope.b_no}">
      </form>

  <form name="freedome" action="/freedome.do" method="post">
   		 <input type="hidden" name="boardname" class="boardname">
    </form>

  <c:if test="${not empty sessionScope.member}">
    <div id="liveNotificationBanner"
         style="display:none; position:fixed; top:12px; right:12px; z-index:9999; min-width:260px; max-width:360px; padding:12px 14px; border-radius:8px; background:#1f2937; color:#ffffff; font-size:13px; box-shadow:0 8px 20px rgba(0,0,0,0.2);">
      <strong id="liveNotificationTitle"></strong>
      <div id="liveNotificationContent" style="margin-top:4px;"></div>
    </div>
    <script>
      (function () {
        var source = new EventSource("/api/notifications/subscribe");
        var banner = document.getElementById("liveNotificationBanner");
        var title = document.getElementById("liveNotificationTitle");
        var content = document.getElementById("liveNotificationContent");
        var hideTimer = null;

        source.addEventListener("notification", function (event) {
          try {
            var data = JSON.parse(event.data);
            title.textContent = data.title || "???뚮┝";
            content.textContent = data.content || "";
            banner.style.display = "block";

            if (hideTimer) {
              clearTimeout(hideTimer);
            }
            hideTimer = setTimeout(function () {
              banner.style.display = "none";
            }, 4000);

            if (data.linkUrl) {
              banner.style.cursor = "pointer";
              banner.onclick = function () {
                location.href = data.linkUrl;
              };
            } else {
              banner.style.cursor = "default";
              banner.onclick = null;
            }
          } catch (e) {
            console.log("notification parse error", e);
          }
        });

        source.onerror = function () {
          source.close();
          setTimeout(function () {
            location.reload();
          }, 3000);
        };
      })();
    </script>
  </c:if>
    
</body>
</html>
```

---

