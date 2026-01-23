<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@include file="/WEB-INF/views/common.jsp"%>  

<!DOCTYPE html>
<html>

<head>

  
</head>
<body>
    <div id="container">    
 <%@ include file="header.jsp" %>




    <center>
    
  <div id="wrap" >
  	<c:if test="${!empty requestScope.boardDTO }">
   <table align="center" border="1" cellpadding="7" style="border-collapse:collapse">
   		<br>
        <h1 style="text-align: center;">프로젝트상세</h1>
        <br> 
        
          <tr>
           <th style="height: 40px; width: 200px;">항목</th>
           <th>등록 사항</th>
        </tr>
        
       	<tr>
            <th>제목</th>
            <td style="width: 500px;">${boardDTO.subject}</td>
        </tr>
        
        <tr>
            <th>닉네임</th>
            <td>${boardDTO.nickname}</td>
        </tr>
        
        <tr>
            <th>작성일</th>
            <td>${boardDTO.reg_date}</td>
        </tr>   
          
        <tr>
            <th>희망 프로젝트</th>
            <td>${boardDTO.field_name}</td>
        </tr>
         
        <tr>
            <th>프로젝트 종류</th>
            <td>${boardDTO.project_type}</td>
        </tr>
        
	    <tr> 
	        <th>모집인원</th>   
	        <td>${boardDTO.people_to}명</td>
	    </tr>
	    
	    <tr> 
	        <th>기간</th>   
	        <td>${boardDTO.start_time} ~ ${boardDTO.end_time}</td>
	    </tr>
	    
	    <tr>
            <th>요구기술</th>
            <td>${boardDTO.skill_name}</td>
        </tr>  
    
     	<tr>
	        <th>내용</th>
	        <td>
	        ${boardDTO.content}
	        </td>
        </tr>
        
	
	     <tr>
	    <th>이미지</th>
	      <td>
	      <c:if test ="${!empty requestScope.boardDTO.img_name}">
	      <img src="/img/${requestScope.boardDTO.img_name}"   height="400px"> 
	      </c:if>
	      </td>
	</tr>
  		
		</table>
		<br>
        <input type="button" onClick="location.replace('/prj.do')" value=" 목록으로 ">    
         <c:if test="${sessionScope.p_no==boardDTO.p_no}">
        	<input type="button" value="수정/삭제" onclick="document.prjUpDelForm.submit();">
        </c:if>
        </center>
        
        <!-- 수정 삭제를 위한 히든 태그 선언 -->
        <form name="prjUpDelForm" action="/prjUpDelForm.do" method="post">
		<!-- 게시판 고유번호가 저장된 hidden 태그 선언하기 -->
		<input type="hidden" name="prj_no" value="${requestScope.boardDTO.prj_no}">
		</form>
          
        </div>
        
       </c:if>
</body>
<%@ include file="footer.jsp" %>
</html>
