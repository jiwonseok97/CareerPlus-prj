<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
	<script>
	var newRow = $("<tr><td><input type='text' name='career" + ($("input[name^='career']").length + 1) + "' class='career1'></td><td><input type='button' value='삭제' onclick='removeRow(this)'></td></tr>");
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
	    
	    
	    

	    
	    // 경력 입력 행 추가
	    var lastCareerRow = $("input[name^='career']").last().closest("tr");
	    var newRow = $("<tr><td></td><td><input type='text' name='career" + ($("input[name^='career']").length + 1) + "' class='career1'><input type='button' value='삭제' onclick='removeRow(this)'></td></tr>");

	    // 원하는 위치에 행 추가 
	    $(newRow).insertAfter(lastCareerRow);
	   }
	   
	function removeRow(button) {
	    // 삭제 버튼이 속한 행을 가져옴
	    var rowToRemove = $(button).closest("tr");

	    // 새로 추가된 행이면 삭제
	    $(rowToRemove).remove();
	}

	//보유자격증 행 추가 함수
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

	    // 보유자격증 입력 행 추가
	    var lastLicenseRow = $("input[name^='license_name']").last().closest("tr");
	    var newRow = $("<tr><td></td><td><input type='text' name='license_name" + ($("input[name^='license_name']").length + 1) + "' class='license'><input type='button' value='삭제' onclick='removeLicenseRow(this)'></td></tr>");

	    // 원하는 위치에 행 추가 
	    $(newRow).insertAfter(lastLicenseRow);
	}

	// 보유자격증 행 삭제 함수
	function removeLicenseRow(button) {
	    // 삭제 버튼이 속한 행을 가져옴
	    var rowToRemove = $(button).closest("tr");

	    // 새로 추가된 행이면 삭제
	    $(rowToRemove).remove();
	}



	

	function checkresumeRegForm(){
		   var formObj = $("[name='resumeRegForm']");
		$.ajax(
		      { 
		         url    : "/resumeRegProc.do"
		         ,type  : "post"
		         ,data  : formObj.serialize( )
		         ,success : function(json){
		            var result = json["result"];
		            
		            if(result==1){
		               alert("이력서 입력 성공입니다.");
		               location.replace("12Wa.do")
		            }
		            else {
		               alert("회원가입 실패")
		            
		            }
		         }
		         ,error : function(){
		            alert("회원가입 실패! 관리자에게 문의 바람니다.");
		         }
		      }
		   );
		}

	</script>
  
</head>
<body>    
  <%@ include file="header.jsp" %>
	
      <h1 style="text-align: center; font-size:2em;">이력서 등록</h1>
      <br>
 <div id="container">
      <form action="submit.php" method="POST" name="resumeRegForm">   
    <table align="center" bordercolor="gray" border=1 cellpadding=7 style="border-collpase:collpase">
              
                
               
               <tr>
                <td>결혼여부</td>
                <td><input type="radio" id="married" class="married" name="married" value="미혼">미혼
                   <input type="radio" id="married" class="married" name="married" value="기혼">기혼
                </td>
            </tr>
            
            <tr>
                <td>군필여부</td>
                <td><input type="radio" id="military" class="military" name="military" value="군필">군필
                   <input type="radio" id="military" class="military" name="military" value="미필">미필
                   <input type="radio" id="military" class="military" name="military" value="기타">기타
                </td>
            </tr>
            
            
            
            
            <tr>
                <td>수상경력</td>
                <td>대회이름: <input type="text" id="name1" class="name1" name="name1" required>
                     수상명: <input type="text" id="type1"   class="type1"  name="type1" required>
                  <br> 주최기관:<input type="text" id="organizer1"  class="organizer1"   name="organizer1" required>
                     상장번호:<input type="text" id="award_no1"  class="award_no1"    name="award_no1"  value=0 required>
                 
                </td>
            </tr>
            
         <tr>
                   <td for="startDate" >보유스킬</td>
                  <td>
        
                  <label><input type="checkbox" name="skill_code" class="skill_code" value=1> JAVA</label>
                    <label><input type="checkbox" name="skill_code" class="skill_code" value=2> Servlet/JSP</label>
                    <label><input type="checkbox" name="skill_code" class="skill_code" value=3> XML</label>
                    <label><input type="checkbox" name="skill_code" class="skill_code" value=4> DataBase</label>
                    <label><input type="checkbox" name="skill_code" class="skill_code" value=5> MVC</label>
                    <label><input type="checkbox" name="skill_code" class="skill_code" value=6> Spring</label>
                    <label><input type="checkbox" name="skill_code" class="skill_code" value=7> Front-End</label>
                    <label><input type="checkbox" name="skill_code" class="skill_code" value=8> Excel</label>
                    <label><input type="checkbox" name="skill_code" class="skill_code" value=9> PPT</label>
                    <label><input type="checkbox" name="skill_code" class="skill_code" value=10> OS</label>
                    <label><input type="checkbox" name="skill_code" class="skill_code" value=11> CAD</label>
                    <label><input type="checkbox" name="skill_code" class="skill_code" value=12> 3D RINTING</label>
              
                    
                  
                   
                   </td>
              </tr>
            
         
            <tr>
             <td>경력</td>
             <td>
                 <input type="text" name="career1" id="career" class="career">
                 <input type="button" onclick="addCareerRow()" value="추가">
             </td>
         </tr>
            
            <tr>
                        <td>보유자격증</td>
                        <td>
                            <input type="text" name="license_name1" class="license_name">
                            <input type="button" onclick="addLicenseRow()" value="추가">
                        </td>
                    </tr>
            
         <tr>
                <td>최종 학력</td>
                <td>
                   <select id="education" name="education" class="education" >
                        <option value="none">최종 학력 선택</option>
                        <option value="초등학교 졸업">초등학교 졸업</option>
                        <option value="중학교 졸업">중학교 졸업</option>
                        <option value="고등학교 졸업">고등학교 졸업</option>
                        <option value="전문대 졸업">전문대 졸업</option>
                        <option value="4년제 졸업">대학교 졸업 (4년 이상)</option>
                   </select>
                       <input type="text" id="school_name"
                       class="school_name"
                        name="school_name"  value="학교명" onfocus="if(this.value=='학교명') this.value='';">              
               
                       <br>
                     <label for="admission_date">입학일:</label> 
                  <input type="date" id="enter_date"
                  class="enter_date"
                   name="enter_date" value="2000-01-01" min="1970-01-01" max="2040-12-31" />
                        ~
                     <label for="graduation_date">졸업일:</label> 
                  <input type="date" id="graduation_date" name="graduation_date" value="2000-01-01" min="1970-01-01" max="2040-12-31" />
                </td>
            </tr>
            
            <tr>
                <td>포트폴리오</td>
                <td><input type="file" id="portfolio" name="portfolio" accept=".pdf, .doc, .docx" ></td>
            </tr>
            
            <tr>
               <td>자기소개</td>
                <td><textarea id="introduce " class="introduce" name="introduce" rows="10" cols="50" ></textarea></td>
            </tr>
            
            
            <tr>
                <td>제안받기</td>
                <td><input type="radio" id="is_offer" class="is_offer" name="is_offer" value="Y">
                    <label for="is_offer">수락</label>
                    <input type="radio" id="is_offer" class="is_offer" name="is_offer" value="N">
                    <label for="is_offer">거절</label>
            </tr> 
             
            <tr>
            <td>
               희망연봉
            </td>
            <td>
               <input type="text" id="hope_salary" class="hope_salary" name="hope_salary">
            </td>
            </tr>
        
      </table>
   				<input type="hidden" name="mem_p_no" value="${sessionScope.p_no}" >

      </form>
      <input type="button"  value="등록"onclick="checkresumeRegForm()">
      </div>
</body>
 <%@include file="/WEB-INF/views/common.jsp"%>  
<%@ include file="footer.jsp" %>  
</html>
