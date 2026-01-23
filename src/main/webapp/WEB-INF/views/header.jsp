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
      <a  href="javascript:location.replace('/12Wa.do')">
        <h1>12Wa~</h1> 
        </a>
      </div>
      
<nav>
    <ul id="topMenu">
    	
        <li>
            <a style="cursor: pointer;" href="javascript:location.replace('/gongGoList.do')">채용정보</a>
<!--             <ul> -->
<!--                 <li><a href="javascript:location.replace('/gongGoList.do')">지역별</a></li> -->
<!--                 <li><a href="javascript:location.replace('/gongGoList.do')">업무별</a></li> -->
<!--                 <li><a href="javascript:location.replace('/gongGoList.do')">TOP100</a></li> -->
<!--             </ul> -->
        </li>
        <li>
            <a href="javascript:location.replace('/companyList.do')">기업정보</a>
        </li>
        <li>
            <a style="cursor: pointer;" onClick="pushboardname('freeboard','freedome')">커뮤니티</a>
            <ul>
                <li><a onClick="pushboardname('freeboard','freedome')">자유 게시판</a></li>
                <li><a onClick="pushboardname('newbieboard','newComer')">신입 게시판</a></li>
                <li><a onClick="pushboardname('qnaboard','qna')">Q&A 게시판</a></li>
                <li><a onClick="pushboardname('jobsearchboard','jobReady')">취업 게시판</a></li>
                <li><a onClick="pushboardname('interviewboard','interview')">면접 게시판</a></li>
                <li><a onClick="pushboardname('tradeboard','joongGo')">중고 게시판</a></li>
            </ul>
        </li>
        <li>
            <a style="cursor: pointer;" href="javascript:location.replace('/timeShare.do')">타임쉐어</a>
            <ul>
                <li><a href="javascript:location.replace('/timeShare.do')">프리랜서</a></li>
                <li><a href="javascript:location.replace('/buupList.do')">부업</a></li>
            </ul>
        </li>
        <li>
            <a href="javascript:location.replace('/prj.do')">프로젝트/공모전</a>
            <ul>
                <li><a href="javascript:location.replace('/prj.do')">프로젝트</a></li>
                <li><a href="javascript:location.replace('/gongMo.do')">공모전</a></li>
            </ul>
        </li>

        <c:if test="${sessionScope.member == 'person'}">
            <li>
                <a style="cursor: pointer;" href="javascript:location.replace('/timeShareRegForm.do')">프리랜서 등록</a>
            </li>
        </c:if>
        <c:if test="${sessionScope.member == 'company'}">
            <li>
                <a style="cursor: pointer;" href="javascript:location.replace('/resumeList.do')">이력서 열람</a>
            </li>
        
            <li>
                <a style="cursor: pointer;" href="javascript:location.replace('/gongGoRegForm.do')">공고 등록</a>
            </li>
        </c:if>
                <c:if test="${sessionScope.member == 'admin'}">
            <li>
                <a style="cursor: pointer;" href="javascript:location.replace('/memberList.do')">회원 관리</a>
                 <ul>
                <li><a href="javascript:location.replace('/memberList.do')">회원 관리</a></li>
                <li><a href="javascript:location.replace('/blockMemberList.do')">차단 회원 관리</a></li>
            </ul>
            </li>
        </c:if>
        <c:if test="${sessionScope.member=='admin'}">
        	<li>
        	 <a style="cursor: pointer;" href="javascript:location.replace('/resumeList.do')">이력서 열람</a>
        	</li>
        </c:if>
    </ul>
</nav>
	
	<div id="welCome">
		<c:if test="${sessionScope.member=='person'}">
			${sessionScope.nickname}님, 환영합니다.
		</c:if>
		<c:if test="${sessionScope.member=='company'}">
			${sessionScope.name}님, 환영합니다.
		</c:if>
				<c:if test="${sessionScope.member=='admin'}">
			관리자님, 환영합니다.
		</c:if>
		
	</div>
    <!-- Login Button -->
    <c:choose>
				<c:when test="${empty sessionScope.member}">
					 <a href="javascript:location.replace('/loginForm.do')" id="loginButton">로그인</a>
				</c:when>
				<c:otherwise>
					<a href="javascript:location.replace('/loginForm.do')" id="logoutButton">로그아웃</a>
				</c:otherwise>  
			</c:choose>


			<c:if test="${sessionScope.member=='company'}">
				<a onClick="document.forms['MyCompanyForm'].submit()" id="myPageButton">기업마이페이지</a>
			</c:if>
			<c:if test="${sessionScope.member == 'person'}">
                 <a href="#" onclick="document.MyPageForm.submit();" id="myPageButton">개인마이페이지</a>
           </c:if>
  <input type="hidden" name="p_no" value="${sessionScope.p_no}">
							<c:if test="${sessionScope.member=='admin'}">
				<a href="javascript:location.replace('/notice.do')" id="myPageButton">공지사항관리</a>
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
    
</body>
</html>