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

<div class="container"  id="wrap">
   <h1 style="text-align: center;">프리랜서 상세보기</h1> 
     <form action="submit.php" method="POST">     
        <center>
     
       
  <div id="wrap" >  
        <c:if test="${!empty requestScope.timeShareDTO}"> 
          <table  id="rwd-table" >

        <tr>
           <th style="height: 40px; width: 200px;">항목</th>
           <th>등록 사항</th>
        </tr>
        
       <tr>
	    <td>제목:</td>
	    <td>${requestScope.timeShareDTO.subject}</td>     
	  </tr>
        
        <tr>
            <td>이름</td>
             <td>${requestScope.timeShareDTO.name}</td>     
        </tr>   
          
        <tr>
            <td>휴대폰번호</td>
             <td>${requestScope.timeShareDTO.phone}</td>    
        </tr>

		<tr>
            <td>주소</td>
             <td>${requestScope.timeShareDTO.addr}</td>
        </tr>
        
       
 <tr>
    <td rowspan="5">경력</td>
    <c:choose>
        <c:when test="${not empty requestScope.timeShareDTO.career1}">
            <td>${requestScope.timeShareDTO.career1}</td>
        </c:when>
        <c:otherwise>
            <td>등록한 경력이 없습니다.</td>
        </c:otherwise>
    </c:choose>
</tr>

<tr>
    <c:if test="${not empty requestScope.timeShareDTO.career2}">
        <td>${requestScope.timeShareDTO.career2}</td>
    </c:if>
</tr>
<tr>
    <c:if test="${not empty requestScope.timeShareDTO.career3}">
        <td>${requestScope.timeShareDTO.career3}</td>
    </c:if>
</tr>
<tr>
    <c:if test="${not empty requestScope.timeShareDTO.career4}">
        <td>${requestScope.timeShareDTO.career4}</td>
    </c:if>
</tr>
<tr>
    <c:if test="${not empty requestScope.timeShareDTO.career5}">
        <td>${requestScope.timeShareDTO.career5}</td>
    </c:if>
</tr>

       
        
        <tr> 
	        <td>희망근무 시간</td>   
	        <td>${requestScope.timeShareDTO.start_time} ~ ${requestScope.timeShareDTO.end_time}</td>
	    </tr> 

       <tr>
            <td>지원 기간</td>
           <td><label for="start_date">시작일:</label> 
       <input type="date" id="start_date" name="start_date" value="${requestScope.timeShareDTO.start_date}" min="2024-01-01" max="2030-12-31"  readonly/>
           ~
           <label for="end_date">마감일:</label> 
       <input type="date" id="end_date" name="end_date" value="${requestScope.timeShareDTO.end_date}"  min="2024-01-01" max="2030-12-31" readonly/>
            </td>
        </tr>

 <tr>
    <td rowspan="5">보유자격증</td>
    <c:choose>
        <c:when test="${not empty requestScope.timeShareDTO.license_name1}">
            <td>${requestScope.timeShareDTO.license_name1}</td>
        </c:when>
        <c:otherwise>
            <td>등록한 자격증이 없습니다.</td>
        </c:otherwise>
    </c:choose>
</tr>

<tr>
    <c:if test="${not empty requestScope.timeShareDTO.license_name2}">
        <td>${requestScope.timeShareDTO.license_name2}</td>
    </c:if>
</tr>
<tr>
    <c:if test="${not empty requestScope.timeShareDTO.license_name3}">
        <td>${requestScope.timeShareDTO.license_name3}</td>
    </c:if>
</tr>
<tr>
    <c:if test="${not empty requestScope.timeShareDTO.license_name4}">
        <td>${requestScope.timeShareDTO.license_name4}</td>
    </c:if>
</tr>
<tr>
    <c:if test="${not empty requestScope.timeShareDTO.license_name5}">
        <td>${requestScope.timeShareDTO.license_name5}</td>
    </c:if>
</tr>

        

    <tr>
        <td>선호업무</td>
        <td>${requestScope.timeShareDTO.preferred_work}</td>
    </tr>
    
    <tr>
        <td>내용</td>
        <td>${requestScope.timeShareDTO.content}</td>
    </tr>
    
    
     <tr>
	    <td>이미지</td>
	      <td>
	      <c:if test ="${!empty requestScope.timeShareDTO.img_name}">
	      <img src="/img/${requestScope.timeShareDTO.img_name}"   height="400px"> 
	      </c:if>
	      </td>
	</tr>
    
    
     <tr>
	    <td>작성일</td>
	    <td>${requestScope.timeShareDTO.reg_date}</td>     
	</tr>
    
     <input type="hidden" name="b_no" class="b_no">
     <input type="hidden" name="resume_no" class="resume_no">
    
</table>


	 <span style= cursor:pointer  onClick="location.replace('/timeShare.do')">[목록으로]</span>
	 <c:if test="${sessionScope.p_no==timeShareDTO.p_no}">
     <input type="button" value="수정/삭제" onclick="document.timeShareUpDelForm.submit();">
	</c:if>

	<form name="timeShareDetailForm" action="/timeShareDetailForm.do" method="post">
		<input type="hidden" name="b_no" value="${requestScope.timeShareDTO.b_no}">
    </form>
   
    <form name="timeShareUpDelForm" action="/timeShareUpDelForm.do" method="post">		
		<input type="hidden" name="b_no" value="${requestScope.timeShareDTO.b_no}">
	</form>
			
	<form name="timeShareRegForm" action="timeShareRegForm" method="post">
		<input type="hidden" name="b_no" value="${requestScope.timeShareDTO.b_no}">
	</form>
	
	
                </center>
           </form>
      
      </c:if>     
 </div>
</div>
   
   <c:if test="${empty requestScope.timeShareDTO}">
		<script>
			alert("게시판이 삭제되었습니다.");
			location.replace("/timeShare.do");
		</script>
    </c:if>
    
      </div>
</body>

<%@ include file="footer.jsp" %>
</html>
