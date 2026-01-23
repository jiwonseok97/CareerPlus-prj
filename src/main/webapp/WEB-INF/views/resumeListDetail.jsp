<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@include file="/WEB-INF/views/common.jsp"%>  

<!DOCTYPE html>
<html>

<head>
<script>
function search(){
	var reviewUpFormObj = $("[name='reviewUpForm']");
	$.ajax(
			{
				//-------------------------------
				// WAS 로 접속할 주소 설정
				//-------------------------------
				url      : "/resumeListDetail.do"
				//-------------------------------
				// WAS 로 접속하는 방법 설정. get 또는 post
				//-------------------------------
				,type    : "post"
				//--------------------------------------
				// WAS 에 보낼 파명과 파값을 설정하기. "파명=파값&파명=파값~"
				//--------------------------------------
				,data    : reviewUpFormObj.serialize()
				//----------------------------------------------------------
				// WAS 의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
				// 이때 익명함수의 매개변수로 WAS 의 응답물이 들어 온다.
				// "/boardList.do" 주소의 응답물은  boardList.jsp 페이지의
				// 실행결과인 HTML 문서 문자열이이다.
				//----------------------------------------------------------
				,success : function(responseHtml){
					//-----------------------------------
					// 매개변수로 들어오는 HTML 문자열을 관리하는 
					// JQuery 객체 생성하여 변수 obj 에 저장하기
					//-----------------------------------
					var obj = $(responseHtml);
					//-----------------------------------
					// 매개변수로 받은 HTML 문자열 중에 
					// <div class='boardListDiv'> 태그 안의 html 문자열을
					// 현 화면의 <div class='boardListDiv'> 태그 안에  덮어쓰기
					//-----------------------------------boardListDiv pagingNos
					$(".reviewListDiv").html( 
							obj.find(".reviewListDiv").html() 
					);
				

					/*$(".xxx").remove();
					$("body").prepend(
						"<textarea class=xxx cols=100 rows=100>"
						+ obj.filter(".boardListDiv").html()
						+"</textarea>"
					)*/
					
				}
				,error   : function(){
					alert("정렬 실패! 관리자에게 문의 바람니다.");
				}
			}
		);

}
function searchWithSort(sort){
	$("[name='reviewUpForm']").find("[name='reviewSort']").val(sort);
   search();
}
function scout(resume_no, c_no, p_no) {
    if (confirm('${boardDTO.name}님에게 스카웃 제안하시겠습니까?')) {
        $.ajax({
            type: 'POST',
            url: '/comtoperProc.do',
            data: { resume_no: resume_no, c_no: c_no, p_no: p_no },
            dataType: 'json',
            success: function(response) {
                if (response.result === "check") {
                    alert('이미 해당 이력서에 대해 스카웃 제안을 했습니다.');
                } else {
                    alert('스카웃 제안을 성공적으로 보냈습니다.');
                    window.location.reload();
                }
            },
            error: function(xhr, status, error) {
                console.error('AJAX 요청 실패:', error);
            }
        });
    }
}
</script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div id="container">    
  
	<%@ include file="header.jsp" %>


       <br>
       <center>
      <h1 style="text-align: center;">이력서 상세 페이지</h1><br>
     
          
            <div class="table-container">
            <table  bordercolor="gray" border="1" cellpadding="7" style="margin-left:auto%; 
    margin-right:auto%;">
      
    
                
                
                
                <tr >
                    <th style="text-align: center;">이름</th>
                	<td>${boardDTO.name}</td> 
                	    
                </tr>
                <tr>
                
                   <th style="text-align: center;"> 연락처</th>
                    <td>${boardDTO.phone}</td> 
                    
                    
                </tr>
                   <tr>
                
                    <th style="text-align: center;"> 이메일</th>
                    <td>${boardDTO.email}</td> 
                    
                    
                </tr>
                
                <tr>
                
                    <th style="text-align: center;">거주지</th>
                    <td>${boardDTO.addr}</td> 
                </tr>
                <tr>
                
                  <th style="text-align: center;"> 관심 분야</th>
                    <td>${boardDTO.field_name}</td> 
                </tr>
                <tr>
                
                   <th style="text-align: center;"> 성별 </th>
                 <td>${boardDTO.sex}</td> 
                    
                </tr>
                <tr>
                  <th style="text-align: center;"> 출생년도 </th>
                 <td>${boardDTO.birth}  출생  &nbsp;  <b>만 ${boardDTO.age}세</b></td> 
                </tr>

                <tr>
                 <th style="text-align: center;"> 취업여부 </th>
                 <td>${boardDTO.is_job}</td> 
                </tr>
                <tr>
                <th style="text-align: center;"> 결혼여부 </th>
               <td>${boardDTO.married}</td> 
                    
                </tr>
                <tr>
                 <th style="text-align: center;"> 군필여부</th>
                  <td>${boardDTO.military}</td> 
                    
                </tr>
                <tr>
                
                
 <th rowspan="<c:choose>
                <c:when test='${not empty boardDTO.name4}'>5</c:when>
                <c:when test='${not empty boardDTO.name3}'>4</c:when>
                <c:when test='${not empty boardDTO.name2}'>3</c:when>
                <c:otherwise>1</c:otherwise>
            </c:choose>" style="text-align: center;">
            
            
            
    <c:choose>
        <c:when test="${not empty boardDTO.name1}">
            수상경력
        </c:when>
        <c:otherwise>
        	수상경력
            <td>수상경력이 없습니다.</td>
        </c:otherwise>
    </c:choose>
</th>


<c:if test='${not empty boardDTO.name1 and empty boardDTO.name2}'>
        <td> ${boardDTO.name1} ${boardDTO.type1}</td>
</c:if>

<c:if test='${not empty boardDTO.name1 and not empty boardDTO.name2}' >
	<tr>
        <td>${boardDTO.name1} ${boardDTO.type1}</td>
 	</tr>
</c:if>


<c:if test='${not empty boardDTO.name2}'>
    <tr>
        <td>${boardDTO.name2} ${boardDTO.type2}</td>
    </tr>
</c:if>

<c:if test='${not empty boardDTO.name3}'>
    <tr>
        <td>${boardDTO.name3} ${boardDTO.type3}</td>
    </tr>
</c:if>

<c:if test='${not empty boardDTO.name4}'>
    <tr>
        <td>${boardDTO.name4} ${boardDTO.type4}</td>
    </tr>
</c:if>





                <tr>
                   <th style="text-align: center;"> 보유스킬</th>
                   <td>
                   <c:forEach var="board" items="${requestScope.skillList }"  varStatus="status">
                     ${board.skill_name} <br>
                    </c:forEach>
                    <c:if test='${empty requestScope.skillList}'>
                    보유 스킬이 없습니다.
                    </c:if>
                    </td>
                      </tr>
         
                <tr>
         <th rowspan="<c:choose>
              <c:when test='${not empty boardDTO.career5}'>5</c:when>
                <c:when test='${not empty boardDTO.career4}'>4</c:when>
                <c:when test='${not empty boardDTO.career3}'>3</c:when>
                <c:when test='${not empty boardDTO.career2}'>2</c:when>
                <c:otherwise>1</c:otherwise>
            </c:choose>" style="text-align: center;">     
        <c:choose>
        <c:when test="${not empty boardDTO.career1}">
            경력
        </c:when>
        <c:otherwise>
        	경력
            <td>경력이 없습니다.</td>
        </c:otherwise>
    </c:choose>
</th>


<c:if test='${not empty boardDTO.career1}'>
        <td>${boardDTO.career1}</td>
</c:if>

<c:if test='${not empty boardDTO.career2}'>
    <tr>
        <td>${boardDTO.career2} </td>
    </tr>
</c:if>

<c:if test='${not empty boardDTO.career3}'>
    <tr>
        <td>${boardDTO.career3}</td>
    </tr>
</c:if>

<c:if test='${not empty boardDTO.career4}'>
    <tr>
        <td>${boardDTO.career4} </td>
    </tr>
</c:if>
<c:if test='${not empty boardDTO.career5}'>
    <tr>
        <td>${boardDTO.career5} </td>
    </tr>
</c:if>
</tr>

<tr>
     <th rowspan="<c:choose>
              <c:when test='${not empty boardDTO.license_name5}'>5</c:when>
                <c:when test='${not empty boardDTO.license_name4}'>4</c:when>
                <c:when test='${not empty boardDTO.license_name3}'>3</c:when>
                <c:when test='${not empty boardDTO.license_name2}'>2</c:when>
                <c:otherwise>1</c:otherwise>
            </c:choose>" style="text-align: center;">     
          <c:choose>
        <c:when test="${not empty boardDTO.license_name1}">
            자격증
        </c:when>
        <c:otherwise>
        	자격증
            <td>보유 자격증이 없습니다.</td>
        </c:otherwise>
    </c:choose>
</th>


<c:if test='${not empty boardDTO.license_name1}'>
        <td>${boardDTO.license_name1}</td>
</c:if>

<c:if test='${not empty boardDTO.license_name2}'>
    <tr>
        <td>${boardDTO.license_name2} </td>
    </tr>
</c:if>

<c:if test='${not empty boardDTO.license_name3}'>
    <tr>
        <td>${boardDTO.license_name3}</td>
    </tr>
</c:if>

<c:if test='${not empty boardDTO.license_name4}'>
    <tr> 
        <td>${boardDTO.license_name4} </td>
</tr>
</c:if>

<c:if test='${not empty boardDTO.license_name5}'>
    <tr> 
        <td>${boardDTO.license_name5} </td>
</tr>
</c:if>
          </tr>      
           
                <tr>
                 <th  style="text-align: center;"> 최종학력</th>
                 
                       <td>${boardDTO.education}
                       <br>
							  
					   
						     학교명 :  ${boardDTO.school_name}   
						       <br>
						       입학 : ${boardDTO.enter_date}년 &nbsp;&nbsp;졸업: ${boardDTO.graduation_date} 	   
                    </td> 
                 
                    
                </tr>
                <tr>
                  <th style="text-align: center;"> 자기소개</th>
                    <td>${boardDTO.introduce}</td> 
                    
                </tr>
                <tr>
       <th style="text-align: center;"> 희망연봉</th>
                    <td>${boardDTO.hope_salary}</td> 
                    
                </tr>
                
                
            </table>
            <form name="comtoperForm" action="/comtoperProc.do" method="post">
            <input type="hidden" name="resume_no" value="${boardDTO.resume_no}">
            <input type="hidden" name= "c_no" value = " ${sessionScope.c_no}">
             <input type="hidden" name= "p_no" value = " ${boardDTO.p_no}">
            </form>
            
        </div>
        
      
      <form name="resumeUpDelForm" action="/resumeUpDelForm.do" method="post">		
				 <input type="hidden" name="resume_no"  value = "${boardDTO.resume_no}">
				 <input type="hidden" name= "p_no"             value  = " ${sessionScope.p_no}">
		  </form>
 
    
    
    
          <input type="button" value="뒤로가기"  onClick="location.replace('/resumeList.do')">
          	<c:if test="${sessionScope.p_no==boardDTO.p_no}">
            <input type="button" value="수정/삭제" onclick="document.resumeUpDelForm.submit();">
          	</c:if>
            <c:if test="${sessionScope.member=='company'}">
   			  <input type="button" value="스카우트 제안하기"  onClick="scout(${boardDTO.resume_no},${sessionScope.c_no},${boardDTO.p_no},${boardDTO.category })">
   		  </c:if>
      <br>
      <br>
      
      
 
  
</body>
<%@ include file="footer.jsp" %>
</html>
