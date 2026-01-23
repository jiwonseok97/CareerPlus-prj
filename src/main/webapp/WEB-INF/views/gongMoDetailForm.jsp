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
	<c:if test="${!empty requestScope.boardDTO}">
   <table align="center"border="1"cellpadding="7"style="border-collapse:collapse">
   		<br>
        <h1 style="text-align: center;">공모전 상세</h1>
        <br>  
        <tr>
            <th>제목</th>
            <td>
            ${boardDTO.subject}
            </td>
        </tr>
        
        <tr>
            <th>기업명</th>
            <td>
            ${boardDTO.name}
            </td>
        </tr>
        
        <tr>
            <th>작성일</th>
            <td>
            ${boardDTO.reg_date}
            </td>
        </tr>
        
        <tr> 
	        <th>기간</th>   
	        <td>${boardDTO.start_time} ~ ${boardDTO.end_time}</td>
	    </tr>  
        
        <tr>
            <th>분야</th>
            <td>
            ${boardDTO.field_name}
            </td>
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
          <input type="button" onClick="location.replace('/gongMo.do')" value="목록으로"> 
          <c:if test="${boardDTO.c_no == sessionScope.c_no}">
      	  <input type="button" value="수정/삭제" onclick="document.gongMoUpDelForm.submit();">
          </c:if>
          </center>
          	<!-- 수정 삭제를 위한 히든 태그 선언 -->
	        <form name="gongMoUpDelForm" action="/gongMoUpDelForm.do" method="post">
			<!-- 게시판 고유번호가 저장된 hidden 태그 선언하기 -->
			<input type="hidden" name="comp_pk" value="${requestScope.boardDTO.comp_pk}">
			</form>
		</div>         
          
          
        </c:if>
</body>
<%@ include file="footer.jsp" %>
</html>
