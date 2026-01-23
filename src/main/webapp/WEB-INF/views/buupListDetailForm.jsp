<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/common.jsp" %>
<!DOCTYPE html>
<html>

<head>

  
</head>
<body>
  <div id="container">    
    
   <%@ include file="header.jsp" %>


 <div class="container"  id="wrap">
    <h1 style="text-align: center;">부업글 상세보기</h1>
      <form action="submit.php" method="POST">
      <center>
      
      <c:if test="${!empty requestScope.buupDTO}">
          <table>
              
           <tr>
               <th style="height: 40px; width: 200px;">항목</th>
               <th>등록 사항</th>
           </tr>
      
      <tr>
	    <td>제목:</td>
	    <td>${requestScope.buupDTO.subject}</td>     
	  </tr>
           
              
	  <tr>
	    <td>이름:</td>
	    <td>${requestScope.buupDTO.name}</td>     
	  </tr>

         <tr>
            <td>휴대폰 번호:</td>
            <td>${requestScope.buupDTO.phone}</td>    
         </tr>  
             
         <tr>                                                       
             <td>주소</td>                                           
            <td>${requestScope.buupDTO.addr}</td>               
         </tr>                                                      
	                
	<tr>
    <td rowspan="5">경력</td>
    <c:choose>
        <c:when test="${not empty requestScope.buupDTO.career1}">
            <td>${requestScope.buupDTO.career1}</td>
        </c:when>
        <c:otherwise>
            <td>등록한 경력이 없습니다.</td>
        </c:otherwise>
    </c:choose>
</tr>

<tr>
    <c:if test="${not empty requestScope.buupDTO.career2}">
        <td>${requestScope.buupDTO.career2}</td>
    </c:if>
</tr>
<tr>
    <c:if test="${not empty requestScope.buupDTO.career3}">
        <td>${requestScope.buupDTO.career3}</td>
    </c:if>
</tr>
<tr>
    <c:if test="${not empty requestScope.buupDTO.career4}">
        <td>${requestScope.buupDTO.career4}</td>
    </c:if>
</tr>
<tr>
    <c:if test="${not empty requestScope.buupDTO.career5}">
        <td>${requestScope.buupDTO.career5}</td>
    </c:if>
</tr>

<tr>
    <td rowspan="5">보유자격증</td>
    <c:choose>
        <c:when test="${not empty requestScope.buupDTO.license_name1}">
            <td>${requestScope.buupDTO.license_name1}</td>
        </c:when>
        <c:otherwise>
            <td>등록한 자격증이 없습니다.</td>
        </c:otherwise>
    </c:choose>
</tr>

<tr>
    <c:if test="${not empty requestScope.buupDTO.license_name2}">
        <td>${requestScope.buupDTO.license_name2}</td>
    </c:if>
</tr>
<tr>
    <c:if test="${not empty requestScope.buupDTO.license_name3}">
        <td>${requestScope.buupDTO.license_name3}</td>
    </c:if>
</tr>
<tr>
    <c:if test="${not empty requestScope.buupDTO.license_name4}">
        <td>${requestScope.buupDTO.license_name4}</td>
    </c:if>
</tr>
<tr>
    <c:if test="${not empty requestScope.buupDTO.license_name5}">
        <td>${requestScope.buupDTO.license_name5}</td>
    </c:if>
</tr>

	   
	   
	    <tr>
	        <td>희망업무</td>
	        <td>${requestScope.buupDTO.hope_work}</td>
	    </tr>
	    

	     
	     <tr> 
	        <td>희망근무 시간</td>   
	        <td>${requestScope.buupDTO.start_time}시 ~ ${requestScope.buupDTO.end_time}시</td>
	    </tr>
         
        <tr>
            <td>지원 기간</td>
           <td><label for="start_date">시작일:</label> 
     		   <input type="date" id="start_date" name="start_date" value=${requestScope.buupDTO.start_date} min="2024-01-01" max="2030-12-31"  readonly/>
           ~
           <label for="end_date">마감일:</label> 
       			<input type="date" id="end_date" name="end_dat" value=${requestScope.buupDTO.end_date}  min="2024-01-01" max="2030-12-31" readonly/>
            </td>
        </tr>
         
           
          <tr>
             <td>내용</td>
             <td>${requestScope.buupDTO.content}</td>
          <tr>  
          
          
    <tr>
	    <td>이미지</td>
	      <td>
	      <c:if test ="${!empty requestScope.buupDTO.img_name}">
	      <img src="/img/${requestScope.buupDTO.img_name}"   height="400px"> 
	      </c:if>
	      </td>
	</tr>
          
                      
	  <tr>
	    <td>작성일</td>
	    <td>${requestScope.buupDTO.reg_date}</td>     
	</tr>
	
		
 
 <input type="hidden" name="b_no" class="b_no">
 <input type="hidden" name="resume_no" class="resume_no">
 </table>
          
           <span style= cursor:pointer  onClick="location.replace('/buupList.do')">[목록으로]</span>
            <c:if test="${sessionScope.p_no==buupDTO.p_no}">
           <input type="button" value="수정/삭제" onclick="document.buupListUpDelForm.submit();">
          	</c:if>
           <form name="buupListDetailForm" action="/buupListDetailForm.do" method="post">
				<input type="hidden" name="b_no" value="${requestScope.buupDTO.b_no}">
		   </form>
		   
		    <form name="buupListUpDelForm" action="/buupListUpDelForm.do" method="post">		
				<input type="hidden" name="b_no" value="${requestScope.buupDTO.b_no}">
			</form>
          
            <form name="buupListRegForm" action="/buupListRegForm.do" method="post">
				<input type="hidden" name="b_no" value="${requestScope.buupDTO.b_no}">

			</form>
			
         </center>
      </form>
    </c:if>  
 </div>
 

		<c:if test="${empty requestScope.buupDTO}">
				<script>
					alert("게시판이 삭제되었습니다.");
					location.replace("/buupList.do");
				</script>
		</c:if>
		
		</div>
</body>

    <%@ include file="footer.jsp" %>
</html>
