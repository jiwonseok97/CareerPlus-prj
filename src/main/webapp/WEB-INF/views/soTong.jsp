<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       <%@include file="/WEB-INF/views/common.jsp"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <div id="container">    
   <%@ include file="header.jsp" %>

<div style="position:absolute;top;100px;left;150px width:145px; float: left; z-index:3;">
    <br><br>
    <li onClick="location.replace('/interview.do')">면접 게시판</li>
    <li onClick="location.replace('/jobReady.do')">취업준비 게시판</li>
    <li onClick="location.replace('/newComer.do')">신입 게시판</li>
    <li onClick="location.replace('/freedome.do')">자유 게시판</li>
    <li onClick="location.replace('/qna.do')">QnA 게시판    </li>
    
    <li>
        <input id="joongGosubmenu" type="checkbox" />
	    <label for="joongGosubmenu">중고 게시판</label>
	  <ul class="submenu">
		  <li><a onClick="location.replace('/joongGoList.do')"> - 전체</a></li>
		  <li><a onClick="location.replace('/buyItems.do')">    - 구매</a></li>
		  <li><a onClick="location.replace('/sellItems.do')">   - 판매</a></li>
	  </ul>
	</li>	
</div>

</body>
<%@ include file="footer.jsp" %>
</html>