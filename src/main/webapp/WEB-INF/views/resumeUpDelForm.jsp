<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@include file="/WEB-INF/views/common.jsp"%>  


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<!DOCTYPE html>
<html>

<head>

	
<script>

function removeRow(button) {
    // 삭제 버튼이 속한 행을 가져옴
    var rowToRemove = $(button).closest("tr");

    // 삭제 버튼이 속한 행의 인덱스를 가져옴
    var index = rowToRemove.index();

    // 새로 추가된 행이면 삭제
    if (index >= 6) { // 6번째부터 동적으로 추가된 행이므로 삭제
        $(rowToRemove).remove();
    }
}

function removeLicenseRow(button) {
    // 삭제 버튼이 속한 행을 가져옴
    var rowToRemove = $(button).closest("tr");

    // 삭제 버튼이 속한 행의 인덱스를 가져옴
    var index = rowToRemove.index();

    // 새로 추가된 행이면 삭제
    if (index >= 14) { // 14번째부터 동적으로 추가된 행이므로 삭제
        $(rowToRemove).remove();
    }
}


function addCareerRow() {
    // 현재 선택된 값 가져오기
    var textValue = $(".career:last").val();

    // 현재 선택된 값이 없으면 추가하지 않음
    if (textValue === "") {
        alert("입력란을 채워야 추가 가능합니다.");
        return;
    }

    // 최대 5개까지 추가 가능하도록 설정
    if ($("input[name^='career']").length >= 5) {
        alert("경력은 최대 5개까지 추가할 수 있습니다.");
        return;
    }

    var lastCareerRow = $("input[name^='career']").last().closest("tr");
    var newRow = $("<tr><td><input type='text' name='career" + ($("input[name^='career']").length + 1) + "' class='career1'><input type='button' value='삭제' onclick='removeRow(this)'></td></tr>");

    // 경력 입력 행 추가
    $(newRow).insertAfter(lastCareerRow);
}

function addLicenseRow() {
    // 현재 선택된 값 가져오기
    var textValue = $(".license_code:last").val();

    // 현재 선택된 값이 없으면 추가하지 않음
    if (textValue === "") {
        alert("보유자격증을 선택하세요.");
        return;
    }

    // 최대 5개까지 추가 가능하도록 설정
    if ($("input[name^='license_name']").length >= 5) {
        alert("보유자격증은 최대 5개까지 추가할 수 있습니다.");
        return;
    }

    var lastLicenseRow = $("input[name^='license_name']").last().closest("tr");
    var newRow = $("<tr><td><input type='text' name='license_name" + ($("input[name^='license_name']").length + 1) + "' class='license'><input type='button' value='삭제' onclick='removeLicenseRow(this)'></td></tr>");

    // 보유자격증 입력 행 추가
    $(newRow).insertAfter(lastLicenseRow);
}

    
    
 //이력서 수정 버튼 함수
    function checkResumeUpForm() {
        var formObj = $("[name='ResumeUpDelForm']");
        //alert(formObj.serialize());

        if (confirm("정말 수정하시겠습니까?") == false) { return; }

        $.ajax({
            url: "/resumeUpProc.do",
            type: "post",
            data: formObj.serialize(),
            
            success: function (json) {
                var result = json["result"];

                if (result ==1) {
                    alert("이력서 수정 성공입니다.");
                    location.replace("myPage.do");
                    
                } else {
                    alert("이력서 수정 실패");
                }
            },
            error: function () {
                alert("수정실패! 관리자에게 문의 바랍니다.");
            }
        });
    }

  // 이력서 삭제 버튼 함수
    function checkResumeDelForm() {
        var formObj = $("[name='ResumeUpDelForm']");
        //alert(formObj.serialize());

        if (confirm("정말 삭제하시겠습니까?") == false) { return; }
        
        $.ajax({
            url: "/resumeDelProc.do",
            type: "post",
            data: formObj.serialize(),
            success: function (json) {
                var result = json["result"];

                if (result == 1) {
                    alert("이력서 삭제실패.");
                   
                } else {
                    alert("이력서 삭제 성공");
                    location.replace("myPage.do");
                }
            },
            error: function () {
                alert("이력서 삭제 실패 관리자에게 문의바랍니다.");
             
            }
        });
    }
  
</script>



<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div id="container">    
  
	<%@ include file="header.jsp" %>



  <div class="container"  id="wrap"><br>
  
  
  <center>
      <h1 style="text-align: center;">이력서 수정/삭제</h1><br>
     
          

     <form name= "ResumeUpDelForm">
          <table  bordercolor="gray" border="1" cellpadding="7" style="margin-left:auto%;  margin-right:auto%;">
      

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
  
  
		 <tr>
		     <th style="text-align: center;"> 성별 </th>
		    <td>
		        <input type="radio" id="sex_male" name="sex" value="남" 
		            <c:if test="${requestScope.boardDTO.sex == '남'}">checked</c:if> disabled>남
		        <input type="radio" id="sex_female" name="sex" value="여" 
		            <c:if test="${requestScope.boardDTO.sex == '여'}">checked</c:if> disabled>여
		    </td>
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
                <td><input type="radio" id="married" class="married" name="married" value="미혼"
                		    <c:if test="${requestScope.boardDTO.married == '미혼'}">checked</c:if>>미혼
                   <input type="radio" id="married" class="married" name="married" value="기혼"
                   		  <c:if test="${requestScope.boardDTO.married == '기혼'}">checked</c:if>>기혼
                </td>
            </tr>
                
                
           <tr>
            <th style="text-align: center;"> 군필여부 </th>              
           
                <td>
                   <input type="radio" id="military" class="military" name="military" value="군필"
                           <c:if test="${requestScope.boardDTO.military == '군필'}">checked</c:if>>군필
                           
                   <input type="radio" id="military" class="military" name="military" value="미필"
                               <c:if test="${requestScope.boardDTO.military == '미필'}">checked</c:if> >미필
                               
                   <input type="radio" id="military" class="military" name="military" value="기타"
                   			    <c:if test="${requestScope.boardDTO.military == '기타'}">checked</c:if> >기타
                </td>
            </tr>     
       

               <tr>
                <th style="text-align: center;"> 수상경력 </th>              
                <td>   대회이름: <input type="text" id="name1"         class="name1" name="name1"                    value="${requestScope.boardDTO.name1}" required>
                           수상명: <input type="text" id="type1"               class="type1"  name="type1"                              value="${requestScope.boardDTO.name1}"  required>
                  <br> 주최기관:<input type="text" id="organizer1"   class="organizer1"   name="organizer1" value="${requestScope.boardDTO.organizer1}"  required>
                             상장번호:<input type="text" id="award_no1"  class="award_no1"    name="award_no1"  value="${requestScope.boardDTO.award_no1}" required>                
                </td>
            </tr>
    
      <tr>
    <th style="text-align: center;">보유스킬</th>
    <td>
			<label><input type="checkbox" name="skill_code" class="skill_code" value="1"
			         <c:if test="${requestScope.skillList.contains('JAVA')}">checked</c:if>>JAVA</label>
			 <label><input type="checkbox" name="skill_code" class="skill_code" value="2"
			         <c:if test="${requestScope.skillList.contains('Servlet/JSP')}">checked</c:if>>Servlet/JSP</label>      
			  <label><input type="checkbox" name="skill_code" class="skill_code" value="3"
		           	<c:if test="${requestScope.skillList.contains('XML')}">checked</c:if>>XML</label>
			  <label><input type="checkbox" name="skill_code" class="skill_code" value="4"
					<c:if test="${requestScope.skillList.contains('DataBase')}">checked</c:if>>DataBase</label> 
			 <label><input type="checkbox" name="skill_code" class="skill_code" value="5"
				  	<c:if test="${requestScope.skillList.contains('MVC')}">checked</c:if>>MVC</label> 
		    <label><input type="checkbox" name="skill_code" class="skill_code" value="6"
			         <c:if test="${requestScope.skillList.contains('Spring')}">checked</c:if>>Spring</label> <br>
			<label><input type="checkbox" name="skill_code" class="skill_code" value="7"
			          <c:if test="${requestScope.skillList.contains('Front-End')}">checked</c:if>>Front-End</label>
			<label><input type="checkbox" name="skill_code" class="skill_code" value="8"
					<c:if test="${requestScope.skillList.contains('Excel')}">checked</c:if>>Excel</label> 
			<label><input type="checkbox" name="skill_code" class="skill_code" value="9"
					 <c:if test="${requestScope.skillList.contains('PPT')}">checked</c:if>>PPT</label> 
			<label><input type="checkbox" name="skill_code" class="skill_code" value="10"
				     <c:if test="${requestScope.skillList.contains('OS')}">checked</c:if>>OS</label>
			<label><input type="checkbox" name="skill_code" class="skill_code" value="11"
			    	  <c:if test="${requestScope.skillList.contains('CAD')}">checked</c:if>>CAD</label>
			<label><input type="checkbox" name="skill_code" class="skill_code" value="12"
					 <c:if test="${requestScope.skillList.contains(' 3D PRINTING')}">checked</c:if>> 3D PRINTING</label>
                 
    </td>
</tr>

 <!-- 경력 -->        
 

<th  style="text-align: center;" rowspan="6"> 경력</th>
<tr>     
        <td>
        <c:if test="${empty requestScope.boardDTO.career1}">
                <b>현재 등록한 경력이 없습니다.</b>  
         </c:if>
         
           <br>
            <input type="text" name="career1" id="career" class="career"  value="${requestScope.boardDTO.career1}">
            <input type="button" onclick="addCareerRow()" value="추가">
        </td>
    </tr>

  <tr>
   <td>
      <c:if test="${not empty requestScope.boardDTO.career2}">
      <input type="text" name="career2" id="career" class="career"  value="${requestScope.boardDTO.career2}">   
      </c:if>
      </td>
  </tr>
  
<tr>
   <c:if test="${not empty requestScope.boardDTO.career3}">
      <td> <input type="text" name="career3" id="career" class="career"  value="${requestScope.boardDTO.career3}"></td>   
   </c:if>
</tr>

<tr>
   <c:if test="${not empty requestScope.boardDTO.career4}">
            <td> <input type="text" name="career4" id="career" class="career"  value="${requestScope.boardDTO.career4}"></td>   
   </c:if>
</tr>

<tr>
   <c:if test="${not empty requestScope.boardDTO.career5}">
          <td> <input type="text" name="career5" id="career" class="career"  value="${requestScope.boardDTO.career5}"></td>   
   </c:if>
</tr>

    
                 

           <tr>
                 <th  style="text-align: center;" rowspan="5">보유자격증</th>
                <td>
                 
                <c:if test="${empty requestScope.boardDTO.license_name1}">
                     <b>현재 등록한 자격증이 없습니다.</b>  
              </c:if>
              
		     <br>     
		                    <input type="text" name="license_name1" class="license_name"   value="${boardDTO.license_name1}"  >
		                    <input type="button" onclick="addLicenseRow()" value="추가">
		             
                </td>
         
            </tr>

    <tr>
        <c:if test="${not empty requestScope.boardDTO.license_name2}">
              <td> <input type="text" name="license_name2" class="license_name" value="${requestScope.boardDTO.license_name2}" ></td>
        </c:if>
    </tr>
    
    <tr>
        <c:if test="${not empty requestScope.boardDTO.license_name3}">
             <td> <input type="text" name="license_name3" class="license_name" value="${requestScope.boardDTO.license_name3}" ></td>
        </c:if>
    </tr>
    
    <tr>
        <c:if test="${not empty requestScope.boardDTO.license_name4}">
               <td> <input type="text" name="license_name4" class="license_name" value="${requestScope.boardDTO.license_name4}" ></td>         
        </c:if>
    </tr>
    
    <tr>
        <c:if test="${not empty requestScope.boardDTO.license_name5}">
                <td> <input type="text" name="license_name5" class="license_name" value="${requestScope.boardDTO.license_name5}" ></td>
        </c:if>
    </tr>
 
           
            
            
<tr>
   <th  style="text-align: center;"> 최종학력</th>
    <td>
        <select id="education" name="education" class="education">
            <option value="none">최종 학력 선택</option>
            <option value="초등학교 졸업" ${boardDTO.education eq '초등학교 졸업' ? 'selected' : ''}>초등학교 졸업</option>
            <option value="중학교 졸업" ${boardDTO.education eq '중학교 졸업'       ? 'selected' : ''}>중학교 졸업</option>
            <option value="고등학교 졸업" ${boardDTO.education eq '고등학교 졸업' ? 'selected' : ''}>고등학교 졸업</option>
            <option value="전문대 졸업" ${boardDTO.education eq '전문대 졸업'        ? 'selected' : ''}>전문대 졸업</option>
            <option value="4년제 졸업" ${boardDTO.education eq '4년제 졸업'          ? 'selected' : ''}>대학교 졸업 (4년 이상)</option>
        </select>
        
        <input type="text" id="school_name" class="school_name" name="school_name" value="${boardDTO.school_name}" onfocus="if(this.value=='학교명') this.value='';">
        <br>
        
            <label for="admission_date">입학일:</label> 
			<input type="date" id="enter_date" name="enter_date" value="${requestScope.boardDTO.enter_date}" min="1970-01-01" max="2040-12-31" />
			~
			<label for="graduation_date">졸업일:</label> 
			<input type="date" id="graduation_date" name="graduation_date" value="${requestScope.boardDTO.graduation_date}" min="1970-01-01" max="2040-12-31" />
	    </td>
	</tr>

   <tr>
      <th  style="text-align: center;"> 자기소개</th>

       <td><textarea id="introduce" name="introduce"  textarea style="width:100%; height:100%;" 
             class="introduce" name="introduce" rows="5" cols="50">${requestScope.boardDTO.introduce}</textarea></td>
    </tr>

     <tr>
            <th style="text-align: center;"> 희망연봉</th>
               <td>
                 <input type="text" id="hope_salary" class="hope_salary" name="hope_salary" value="${boardDTO.hope_salary}">
                </td>
      </tr>
   <input type="hidden" name="resume_no" value="${boardDTO.resume_no}">
    <input type="hidden" name="p_no"           value="${sessionScope.p_no}">
    
        </table> 
        
           
        <!--  뒤로가기, 수정, 삭제 버튼 -->
           <input type="button" value="뒤로가기"  onClick="location.replace('/resumeListDetail.do')">
   		   <input type="button" value="수정"          onClick="checkResumeUpForm();">
   		    <input type="button" value="삭제"         onClick="checkResumeDelForm();"> 
   		    
   		    <br>
   		    <br>
   		
     </form>
      
            <form name="comtoperForm" action="/comtoperProc.do" method="post">
                    <input type="hidden" name="resume_no" value="${boardDTO.resume_no}">
                    <input type="hidden" name= "c_no" value = " ${sessionScope.c_no}">
                    <input type="hidden" name= "p_no" value = " ${boardDTO.p_no}">
            </form>
            
        </div>
       
      <br>
      <br>
      
      </center>
      </div>
 
  
</body>
<%@ include file="footer.jsp" %>
</html>
