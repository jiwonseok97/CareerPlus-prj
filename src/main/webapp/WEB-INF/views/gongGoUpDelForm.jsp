<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common.jsp"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>12Wa~</title>
<link
   href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css"
   rel="stylesheet">


<style>
.table-container {
   display: flex;
   justify-content: space-between;
   margin: 0 auto; /* 가운데 정렬을 위해 추가 */
}

.table-container table {
   border-collapse: collapse;
   border: 1px solid gray;
   padding: 7px;
}

#links {
   float: left;
}

.circle {
   width: 200px;
   height: 200px;
   border-radius: 50%;
   display: flex;
   align-items: center;
   justify-content: center;
   border: 2px solid blue;
   overflow: hidden;
}

img {
   width: 100%;
   height: 100%;
   object-fit: cover;
}
</style>

</head>

<script>

   var formObj = $("[name='gonggoUpDelForm']");



	

// 세부분야 테이블 초기화1
function clearTable1() {
    alert("초기화를 시작합니다.");
    var table = document.getElementById('Table_Clear1');
    
    // 모든 input 요소들을 초기화
    var inputs = table.querySelectorAll('input[type="text"]');
    inputs.forEach(function(input) {
        input.value = '';
    });
    
    // 모든 select 요소들을 초기화
    var selects = table.querySelectorAll('select');
    selects.forEach(function(select) {
        select.selectedIndex = 0;
    });

    // field_detail1 input 초기화
    var fieldDetailInput = document.getElementById('field_detail1');
    if (fieldDetailInput) {
        fieldDetailInput.value = "";
        
        document.getElementById('field_detail1').removeAttribute('name');
    }
}
   
   // 세부분야 테이블 초기화2
   function clearTable2() {

       var table = document.getElementById('Table_Clear2');
       
       // 모든 input 요소들을 초기화
       var inputs = table.querySelectorAll('input[type="text"]');
       var result = confirm("테이블을 삭제하시겠습니까?");
       if(result){
       inputs.forEach(function(input) {
           input.value = '';
       });
       
       // 모든 select 요소들을 초기화
       var selects = table.querySelectorAll('select');
       selects.forEach(function(select) {
           select.selectedIndex = 0;
       });

       // field_detail2 input 초기화
       var fieldDetailInput = document.getElementById('field_detail2');
       if (fieldDetailInput) {
           fieldDetailInput.value = "";
           
           document.getElementById('field_detail2').removeAttribute('name');
           $("#Table_Clear2").hide();
       }
   }
   }
	function showTable2(){
		var result = confirm("테이블을 추가하시겠습니까?");
		   if(result){
		$("#Table_Clear2").show();
		   }
	
	}
   
   // 세부분야 테이블 초기화3
   function clearTable3() {
       
       var table = document.getElementById('Table_Clear3');
       var result = confirm("테이블을 삭제하시겠습니까?");
       
       // 모든 input 요소들을 초기화
       var inputs = table.querySelectorAll('input[type="text"]');
       if(result){
       inputs.forEach(function(input) {
           input.value = '';
       });
       
       // 모든 select 요소들을 초기화
       var selects = table.querySelectorAll('select');
       selects.forEach(function(select) {
           select.selectedIndex = 0;
       });

       // field_detail3 input 초기화
       var fieldDetailInput = document.getElementById('field_detail3');
       if (fieldDetailInput) {
           fieldDetailInput.value = "";
           
           document.getElementById('field_detail3').removeAttribute('name');
           $("#Table_Clear3").hide();
       }
       }
   }
   
	function showTable3(){
		var result = confirm("테이블을 추가하시겠습니까?");
		if(result){
			$("#Table_Clear3").show();	
		}
		
	}

//연봉 히든숨기기 ---------------------------
   function toggleOtherSalary() {
            var selectBox = document.getElementById("salary");
            var otherSalaryInput = document.getElementById("other_salary");
            if (selectBox.value === "0") {
                otherSalaryInput.classList.remove("hidden");
            } else {
                otherSalaryInput.classList.add("hidden");
                otherSalaryInput.value = ""; // 선택이 변경될 때 입력 필드를 초기화
            }
        }
 

// 우대 행추가---------------------------

   function removeBenefit(button) {
        // 삭제 버튼이 속한 행을 찾아서 각 입력 요소의 값을 초기화
        var row = button.parentNode.parentNode;
        var inputs = row.querySelectorAll('input[type="radio"], select');
        inputs.forEach(function(input) {
            if (input.tagName === 'INPUT' && input.type === 'radio') {
                input.checked = false;
            } else if (input.tagName === 'SELECT') {
                input.value = '0'; // 초기값으로 변경
            }
        });
    }

   // ----------------------------------세부분야 히든 숨기기-----------------------------------------
   
   var field_detailIndex = 2;
   var customInput = clonedRow.find('.hidden');
function toggleTextbox(selectElement) {
    var selectBox = $(selectElement);
    var customInput = selectBox.next('input[type="text"]');
    var selectedValue = selectBox.val();

    // 직접입력 옵션을 선택한 경우에만 숨겨진 텍스트 필드를 토글합니다.
    if (selectedValue === ",") {
        customInput.removeClass('hidden');
    } else {
        customInput.addClass('hidden');
    }
}

function row_plus() {
    var rowToClone = $(".row").first();
    var clonedRow = rowToClone.clone();

    // 필드 상세 셀렉트 박스 name 및 id 속성 변경
    var selectField_detail = clonedRow.find('select[name="field_detail1"]');
    var newField_detailName = "field_detail" + field_detailIndex;
    selectField_detail.attr("name", newField_detailName);
    selectField_detail.attr("id", newField_detailName);

    // 필드 상세 직접 입력 텍스트 박스 name 및 id 속성 변경
    var customInput = clonedRow.find('input[type="text"]');
    var newCustomFieldName = "field_detail" + field_detailIndex;
    customInput.attr("name", newCustomFieldName);
    customInput.attr("id", newCustomFieldName);

    // 인덱스 증가
    field_detailIndex++;

    // 복제된 행 숨기기
    clonedRow.hide();

    // 폼에 복제된 행 추가
    $(".row_plus").before(clonedRow);
}

// 페이지 로드될 때 숨겨진 텍스트 필드 초기화
$(document).ready(function() {
    toggleTextbox($('select[name="field_detail1"]'));
});

   
   // ----------------------------공고수정 ------------------------
   function checkGonggoUpForm() {

      var formObj = $("[name='gonggoUpDelForm']");


  	// 	// 담당자 성함
  	var manager_nameObj = formObj.find(".manager_name");
  // // 부서/직책/분야/내용
  	 var dept_code1Obj = formObj.find(".dept_code1");
  	var position_code1Obj = formObj.find(".position_code1");
  	var field_detail1Obj = formObj.find(".field_detail1");	
  	var fidel_detail1_textObj = formObj.find("#text_field_detail1");
  	var content1Obj = formObj.find(".content1");
  	
  	 var dept_code2Obj = formObj.find(".dept_code2");
  		var position_code2Obj = formObj.find(".position_code2");
  		var field_detail2Obj = formObj.find(".field_detail2");	
  		var fidel_detail2_textObj = formObj.find("#text_field_detail2");
  		var content2Obj = formObj.find(".content2");
  		
  		 var dept_code3Obj = formObj.find(".dept_code3");
  			var position_code3Obj = formObj.find(".position_code3");
  			var field_detail3Obj = formObj.find(".field_detail3");	
  			var fidel_detail3_textObj = formObj.find("#text_field_detail3");
  			var content3Obj = formObj.find(".content3");
//   		//경력여부
  		var careerObj = formObj.find(".career");

//   		 //최종학력
  		 var graduationObj = formObj.find("select[name='graduation']");
//   		 //지원자 성별
  		 var seeker_sexObj = formObj.find(".seeker_sex");
//   		 //나이
	
  		 var seeker_ageObj1 = formObj.find(".seeker_age1");
  		 var seeker_ageObj2 = formObj.find(".seeker_age2");
  		 var age_irrelevantObj = formObj.find("#age_irrelevant");
   		 //필수 우대조건
   		var choice1Obj =  formObj.find('input[name=choice1]');  
  		 var benefit_code1Obj = formObj.find("select[name='benefit_code1']");
  		 var choice2Obj =  formObj.find('input[name=choice2]');  
  		 var benefit_code2Obj = formObj.find("select[name='benefit_code2']");
  		 var choice3Obj =  formObj.find('input[name=choice3]');  
  		 var benefit_code3Obj = formObj.find("select[name='benefit_code3']");
  		 var choice4Obj =  formObj.find('input[name=choice4]');  
  		 var benefit_code4Obj = formObj.find("select[name='benefit_code4']");
  		 var choice5Obj =  formObj.find('input[name=choice5]');  
  		 var benefit_code5Obj = formObj.find("select[name='benefit_code5']");


		 

		 
		if( new RegExp(/^[가-힣]{2,15}$/).test(manager_nameObj.val())==false ){
			alert("담당자 성함은 2~15자 한글이어야합니다.");
			manager_nameObj.val("");
			return false;
		}
	
 		if(dept_code1Obj.val() != "0" && position_code1Obj.val() === "0" && content1Obj.val() == ''){
 			 			alert("부서,직책,분야,업무내용을 작성해주세요1");
 			return false;
 		}
 		if(dept_code1Obj.val() == "0" && position_code1Obj.val() != "0" && content1Obj.val() == ''){
 			 			alert("부서,직책,분야,업무내용을 작성해주세요1");
 			return false;
 		}
 		if(dept_code1Obj.val() == "0" && position_code1Obj.val() == "0" && content1Obj.val() != ''){
 			 			alert("부서,직책,분야,업무내용을 작성해주세요1");
 			return false;
 		}
	if(field_detail1Obj.val() == ',' && fidel_detail1_textObj.val() == ''){
		alert("부서,직책,분야,업무내용을 작성해주세요11")
		return false;
	}
	if(field_detail1Obj.val() == ',' && dept_code1Obj.val() != "0"){
		alert("부서,직책,분야,업무내용을 작성해주세요11")
		return false;
	}
	

 		if(dept_code2Obj.val() != "0" && position_code2Obj.val() === "0" && content2Obj.val() == ''){
 			 			alert("부서,직책,분야,업무내용을 작성해주세요2");
 			return false;
 		}
 		if(dept_code2Obj.val() == "0" && position_code2Obj.val() != "0" && content2Obj.val() == ''){
 			 			alert("부서,직책,분야,업무내용을 작성해주세요2");
 			return false;
 		}
 		if(dept_code2Obj.val() == "0" && position_code2Obj.val() == "0" && content2Obj.val() != ''){
 			 			alert("부서,직책,분야,업무내용을 작성해주세요2");
 			return false;
 		}
	if(field_detail2Obj.val() == ',' && fidel_detail2_textObj.val() == ''){
		alert("부서,직책,분야,업무내용을 작성해주세요22")
		return false;
	}
	if(field_detail2Obj.val() == ',' && dept_code2Obj.val() != "0"){
		alert("부서,직책,분야,업무내용을 작성해주세요22")
		return false;
	}
	

	if(dept_code3Obj.val() != "0" && position_code3Obj.val() === "0" && content3Obj.val() == ''){
			alert("부서,직책,분야,업무내용을 작성해주세요3");
return false;
}
if(dept_code3Obj.val() == "0" && position_code3Obj.val() != "0" && content3Obj.val() == ''){
			alert("부서,직책,분야,업무내용을 작성해주세요3");
return false;
}
if(dept_code3Obj.val() == "0" && position_code3Obj.val() == "0" && content3Obj.val() != ''){
			alert("부서,직책,분야,업무내용을 작성해주세요3");
return false;
}
if(field_detail3Obj.val() == ',' && fidel_detail3_textObj.val() == ''){
alert("부서,직책,분야,업무내용을 작성해주세요33")
return false;
}
if(field_detail3Obj.val() == ',' && dept_code3Obj.val() != "0"){
	alert("부서,직책,분야,업무내용을 작성해주세요33")
	return false;
}



	


 		

	
  		if(careerObj.is(':checked') == false){
  		    alert("경력 여부를 선택해 주세요");
  		    return false;
 		}
  

	if(graduationObj.val()==''){
		alert("최종학력을 선택해주세요")
	}
	if(seeker_sexObj.is(':checked') == false){
		    alert("지원자 성별을 선택해 주세요");
		    return false;
		}



	
	if(new RegExp(/^[0-9]{1,2}$/).test(seeker_ageObj1.val()) == false && age_irrelevantObj.is(':checked')== false ){
		alert("지원자의 나이는 2자리까지만 입력해주세요1");
		return false;
	} 
	if(new RegExp(/^[0-9]{1,2}$/).test(seeker_ageObj2.val()) == false && age_irrelevantObj.is(':checked') == false){
		alert("지원자의 나이는 2자리까지만 입력해주세요2");
		return false;
		} 
	
	if((seeker_ageObj1.val() > seeker_ageObj2.val()) && age_irrelevantObj.is(':checked') == false){
		alert("나이를 정확히 입력해주세요")
		return false;
	}

	if(age_irrelevantObj.is(':checked') == true && seeker_ageObj1.val() != ''&& seeker_ageObj2.val() != ''){
		alert("나이를 적고 나이무관을 선택하면 나이무관이 선택됩니다.");
	}


	if(choice2Obj.is(':checked') == true && benefit_code2Obj.val() == '0'){
		alert("필수/우대 조건을 선택해 주세요2")
		return false;
	}
	if(choice2Obj.is(':checked') == false && benefit_code2Obj.val() != '0'){
		alert("필수/우대 조건을 선택해 주세요2")
		return false;
	}
	if(choice3Obj.is(':checked') == true && benefit_code3Obj.val() == '0'){
		alert("필수/우대 조건을 선택해 주세요3")
		return false;
	}
	if(choice3Obj.is(':checked') == false && benefit_code3Obj.val() != '0'){
		alert("필수/우대 조건을 선택해 주세요3")
		return false;
	}
	if(choice4Obj.is(':checked') == true && benefit_code4Obj.val() == '0'){
		alert("필수/우대 조건을 선택해 주세요4")
		return false;
	}
	if(choice4Obj.is(':checked') == false && benefit_code4Obj.val() != '0'){
		alert("필수/우대 조건을 선택해 주세요4")
		return false;
	}
	if(choice5Obj.is(':checked') == true && benefit_code5Obj.val() == '0'){
		alert("필수/우대 조건을 선택해 주세요5")
		return false;
	}
	if(choice5Obj.is(':checked') == false && benefit_code5Obj.val() != '0'){
		alert("필수/우대 조건을 선택해 주세요5")
		return false;
	}


    
      
      var field_detail1 = formObj.find("#field_detail1")
      var text_field_detail1 = formObj.find("#text_field_detail1")
      var field_detail2 = formObj.find("#field_detail2")
      var text_field_detail2 = formObj.find("#text_field_detail2")
      var field_detail3 = formObj.find("#field_detail3")
      var text_field_detail3 = formObj.find("#text_field_detail3")
      
      if(field_detail1.val() != "" ){
         text_field_detail1.removeAttr("name");
      }      
      if(   text_field_detail1.val() != ""){
         field_detail1.removeAttr("name");
      }
      
      if(field_detail2.val() != "" ){
         text_field_detail2.removeAttr("name");
      }      
      if(   text_field_detail2.val() != ""){
         field_detail2.removeAttr("name");
      }
      
      if(field_detail3.val() != "" ){
         text_field_detail3.removeAttr("name");
      }      
      if(   text_field_detail3.val() != ""){
         field_detail3.removeAttr("name");
      }

      alert(formObj.serialize())
      
      if(age_irrelevantObj.is(':checked') == true){
    		seeker_ageObj1.remove();
    		seeker_ageObj2.remove();
    		$("#age_irrelevant").attr("name","seeker_age");

    	}
   
   alert("11")
      $.ajax({

         url : "/gonggoUpProc.do"

         ,
         type : "post"

         ,
         data : formObj.serialize()

         ,
         success : function(json) {
            var result = json["result"];
            if (result == -1) {
               alert("공고가 없습니다");

            }

            else {
               alert("공고 수정 성공입니다.");
               document.gonggoDetailForm.submit();
            }
         }
         //----------------------------------------------------------
         // WAS 의 응답이 실패했을 실행할 익명함수 설정.
         //----------------------------------------------------------
         ,
         error : function() {
            alert("수정 실패! 관리자에게 문의 바람니다.");
         }
      });
   }

   // -----------------------------공고삭제--------------------------------
   function checkGonggoDelForm() {
   
      var formObj = $("[name='gonggoUpDelForm']");
      alert(formObj.serialize())
      $.ajax({

         url : "/gonggoDelProc.do"

         ,
         type : "post"

         ,
         data : formObj.serialize()

         ,
         success : function(json) {

            var result = json["result"];
            if (result == -1) {
               alert(" 틀립니다.");
            } else {
               alert("공고삭제 성공입니다.")
               location.replace("gongGoList.do")
               
            }
         }

         ,
         error : function() {
            alert("삭제 실패! 관리자에게 문의 바람니다.");
         }
      });

   }
</script>

<body>
   <div id="container">
      <%@ include file="header.jsp"%>

      <br>
      <br> 기업 -${requestScope.gonggoDTO.name}
      <td></td>



      <form name="gonggoUpDelForm">
         <div class="table-container">
            <table align="center" bordercolor="gray" border="1" cellpadding="7"
               style="border-collapse: collapse">
               <tr>
                  <td>경력 : <input type="radio" name="career" id="career"
                     class="career" value="신입" ${requestScope.gonggoDTO.career == '신입' ? 'checked' : ''}> 신입 <input type="radio"
                     name="career" id="career" class="career" value="경력" ${requestScope.gonggoDTO.career == '경력' ? 'checked' : ''}> 경력 <input
                     type="radio" name="career" id="career" class="career"
                     value="경력무관" ${requestScope.gonggoDTO.career == '경력무관' ? 'checked' : ''}> 경력무관
               

                  </td>
      <%-- 체크박스 -> "ture" ${requestScope.gonggoDTO.isChecked ? 'checked' : ''} --%>
               </tr>
               <tr>
                  <td>학력 : <select id="graduation" class="graduation"
                     name="graduation">
                        <option value="" ${requestScope.gonggoDTO.graduation == '' ? 'selected' : ''}>최종 학력 선택</option>
                        <option value="초등학교 졸업" ${requestScope.gonggoDTO.graduation == '초등학교 졸업' ? 'selected' : ''}>초등학교 졸업</option>
                        <option value="중학교 졸업" ${requestScope.gonggoDTO.graduation == '중학교 졸업' ? 'selected' : ''}>중학교 졸업</option>
                        <option value="고등학교 졸업" ${requestScope.gonggoDTO.graduation == '고등학교 졸업' ? 'selected' : ''}>고등학교 졸업</option>
                        <option value="대학교 졸업" ${requestScope.gonggoDTO.graduation == '대학교 졸업' ? 'selected' : ''}>대학교 졸업 (4년 이상)</option>
                  </select> <input type="checkbox" id="ph_d_candidate" name="ph_d_candidate"
                  value="졸업예정자 지원가능" ${requestScope.gonggoDTO.ph_d_candidate == '졸업예정자 지원가능' ? 'checked' : ''}>졸업예정자 지원가능
                     <%-- value="졸업예정자 지원가능" ${requestScope.gonggoDTO.ph_d_candidate ? 'checked' : ''}> 졸업예정자 지원가능 --%>
                     
                     
                  </td>
               </tr>
               <tr>
                  <td>나이 : <input type="text" class="seeker_age1"
                     name="seeker_age" size="7" onChange="abc()"
                     <c:if test="${requestScope.gonggoDTO.seeker_age1!='나이'}">
                      value=${requestScope.gonggoDTO.seeker_age1}
                     </c:if>
                    > ~ <input
                     type="text" class="seeker_age2" name="seeker_age"
                     size="7"
                      <c:if test="${requestScope.gonggoDTO.seeker_age1!='나이'}">
                      value=${requestScope.gonggoDTO.seeker_age2}
                     </c:if>
                      > 
                     <input type="checkbox"
                     value="나이무관"  id="age_irrelevant"
                     <c:if test="${requestScope.gonggoDTO.seeker_age1=='나이'}">
                      checked
                     </c:if>
                     >나이무관
                    <%-- <%--   value="true" ${requestScope.gonggoDTO.age_irrelevant ? 'checked' : ''}>나이무관 --%> 
                  


                  </td>
               </tr>
               <tbody id="benefit_row">
               
                 <tr> 
    <td colspan="2">필수/우대조건 :
        <input type="radio" name="choice1" value="필수" ${requestScope.gonggoDTO.choice1 == '필수' ? 'checked' : ''} class="choice" id="choice"> 필수  
            <input type="radio" name="choice1" value="우대" ${requestScope.gonggoDTO.choice1 == '우대' ? 'checked' : ''} class="choice" id="choice"> 우대
            <select name="benefit_code1" id="benefit_code" class="benefit_code">
               <option value="0" ${requestScope.gonggoDTO.benefit_code1 == '0' ? 'selected' : ''}>필수/우대조건 선택</option> 
                <option value="1" ${requestScope.gonggoDTO.benefit_code1 == '1' ? 'selected' : ''}>운전면허</option>
                <option value="2" ${requestScope.gonggoDTO.benefit_code1 == '2' ? 'selected' : ''}>지게차운전기능사</option>
                <option value="3" ${requestScope.gonggoDTO.benefit_code1 == '3' ? 'selected' : ''}>요양보호사자격증</option>
                <option value="4" ${requestScope.gonggoDTO.benefit_code1 == '4' ? 'selected' : ''}>사회복지사자격증</option>
                <option value="5" ${requestScope.gonggoDTO.benefit_code1 == '5' ? 'selected' : ''}>간호조무사자격증</option>
                <option value="6" ${requestScope.gonggoDTO.benefit_code1 == '6' ? 'selected' : ''}>영양사자격증</option>
                <option value="7" ${requestScope.gonggoDTO.benefit_code1 == '7' ? 'selected' : ''}>보육교사자격증</option>
                <option value="8" ${requestScope.gonggoDTO.benefit_code1 == '8' ? 'selected' : ''}>건축기사자격증</option>
                <option value="9" ${requestScope.gonggoDTO.benefit_code1 == '9' ? 'selected' : ''}>전기기능사자격증</option>
                <option value="10" ${requestScope.gonggoDTO.benefit_code1 == '10' ? 'selected' : ''}>전기산업기사자격증</option>
                <option value="11" ${requestScope.gonggoDTO.benefit_code1 == '11' ? 'selected' : ''}>용접기능사자격증</option>
                <option value="12" ${requestScope.gonggoDTO.benefit_code1 == '12' ? 'selected' : ''}>전산회계1급자격증</option>
                <option value="13" ${requestScope.gonggoDTO.benefit_code1 == '13' ? 'selected' : ''}>전산세무2급자격증</option>
                <option value="14" ${requestScope.gonggoDTO.benefit_code1 == '14' ? 'selected' : ''}>직업상담사2급자격증</option>
                <option value="15" ${requestScope.gonggoDTO.benefit_code1 == '15' ? 'selected' : ''}>정보처리기사자격증</option>
            </select>
            <input type="button" value="삭제" onclick="removeBenefit(this)">
            </td>
<br>
           
         <tr>
         <td>   필수/우대조건 :
        <input type="radio" name="choice2" value="필수" ${requestScope.gonggoDTO.choice2 == '필수' ? 'checked' : ''} class="choice" id="choice"> 필수  
            <input type="radio" name="choice2" value="우대" ${requestScope.gonggoDTO.choice2 == '우대' ? 'checked' : ''} class="choice" id="choice"> 우대
            <select name="benefit_code2" id="benefit_code" class="benefit_code">
               <option value="0" ${requestScope.gonggoDTO.benefit_code2 == '0' ? 'selected' : ''}>필수/우대조건 선택</option> 
                <option value="1" ${requestScope.gonggoDTO.benefit_code2 == '1' ? 'selected' : ''}>운전면허</option>
                <option value="2" ${requestScope.gonggoDTO.benefit_code2 == '2' ? 'selected' : ''}>지게차운전기능사</option>
                <option value="3" ${requestScope.gonggoDTO.benefit_code2 == '3' ? 'selected' : ''}>요양보호사자격증</option>
                <option value="4" ${requestScope.gonggoDTO.benefit_code2 == '4' ? 'selected' : ''}>사회복지사자격증</option>
                <option value="5" ${requestScope.gonggoDTO.benefit_code2 == '5' ? 'selected' : ''}>간호조무사자격증</option>
                <option value="6" ${requestScope.gonggoDTO.benefit_code2 == '6' ? 'selected' : ''}>영양사자격증</option>
                <option value="7" ${requestScope.gonggoDTO.benefit_code2 == '7' ? 'selected' : ''}>보육교사자격증</option>
                <option value="8" ${requestScope.gonggoDTO.benefit_code2 == '8' ? 'selected' : ''}>건축기사자격증</option>
                <option value="9" ${requestScope.gonggoDTO.benefit_code2 == '9' ? 'selected' : ''}>전기기능사자격증</option>
                <option value="10" ${requestScope.gonggoDTO.benefit_code2 == '10' ? 'selected' : ''}>전기산업기사자격증</option>
                <option value="11" ${requestScope.gonggoDTO.benefit_code2 == '11' ? 'selected' : ''}>용접기능사자격증</option>
                <option value="12" ${requestScope.gonggoDTO.benefit_code2 == '12' ? 'selected' : ''}>전산회계1급자격증</option>
                <option value="13" ${requestScope.gonggoDTO.benefit_code2 == '13' ? 'selected' : ''}>전산세무2급자격증</option>
                <option value="14" ${requestScope.gonggoDTO.benefit_code2 == '14' ? 'selected' : ''}>직업상담사2급자격증</option>
                <option value="15" ${requestScope.gonggoDTO.benefit_code2 == '15' ? 'selected' : ''}>정보처리기사자격증</option>
            </select><input type="button" value="삭제" onclick="removeBenefit(this)"><br></td></tr>
          
       
           <tr> 
         <td>  필수/우대조건 :
        <input type="radio" name="choice3" value="필수" ${requestScope.gonggoDTO.choice3 == '필수' ? 'checked' : ''} class="choice" id="choice"> 필수  
            <input type="radio" name="choice3" value="우대" ${requestScope.gonggoDTO.choice3 == '우대' ? 'checked' : ''} class="choice" id="choice"> 우대
            <select name="benefit_code3" id="benefit_code" class="benefit_code">
               <option value="0" ${requestScope.gonggoDTO.benefit_code3 == '0' ? 'selected' : ''}>필수/우대조건 선택</option> 
                <option value="1" ${requestScope.gonggoDTO.benefit_code3 == '1' ? 'selected' : ''}>운전면허</option>
                <option value="2" ${requestScope.gonggoDTO.benefit_code3 == '2' ? 'selected' : ''}>지게차운전기능사</option>
                <option value="3" ${requestScope.gonggoDTO.benefit_code3 == '3' ? 'selected' : ''}>요양보호사자격증</option>
                <option value="4" ${requestScope.gonggoDTO.benefit_code3 == '4' ? 'selected' : ''}>사회복지사자격증</option>
                <option value="5" ${requestScope.gonggoDTO.benefit_code3 == '5' ? 'selected' : ''}>간호조무사자격증</option>
                <option value="6" ${requestScope.gonggoDTO.benefit_code3 == '6' ? 'selected' : ''}>영양사자격증</option>
                <option value="7" ${requestScope.gonggoDTO.benefit_code3 == '7' ? 'selected' : ''}>보육교사자격증</option>
                <option value="8" ${requestScope.gonggoDTO.benefit_code3 == '8' ? 'selected' : ''}>건축기사자격증</option>
                <option value="9" ${requestScope.gonggoDTO.benefit_code3 == '9' ? 'selected' : ''}>전기기능사자격증</option>
                <option value="10" ${requestScope.gonggoDTO.benefit_code3 == '10' ? 'selected' : ''}>전기산업기사자격증</option>
                <option value="11" ${requestScope.gonggoDTO.benefit_code3 == '11' ? 'selected' : ''}>용접기능사자격증</option>
                <option value="12" ${requestScope.gonggoDTO.benefit_code3 == '12' ? 'selected' : ''}>전산회계1급자격증</option>
                <option value="13" ${requestScope.gonggoDTO.benefit_code3 == '13' ? 'selected' : ''}>전산세무2급자격증</option>
                <option value="14" ${requestScope.gonggoDTO.benefit_code3 == '14' ? 'selected' : ''}>직업상담사2급자격증</option>
                 <option value="15" ${requestScope.gonggoDTO.benefit_code3 == '15' ? 'selected' : ''}>정보처리기사자격증</option>
            </select><input type="button" value="삭제" onclick="removeBenefit(this)"><br></td></tr>
             
  
        <tr>
        <td>
        
         
            필수/우대조건 :
        <input type="radio" name="choice4" value="필수" ${requestScope.gonggoDTO.choice4 == '필수' ? 'checked' : ''} class="choice" id="choice"> 필수  
            <input type="radio" name="choice4" value="우대" ${requestScope.gonggoDTO.choice4 == '우대' ? 'checked' : ''} class="choice" id="choice"> 우대
            <select name="benefit_code4" id="benefit_code" class="benefit_code">
               <option value="0" ${requestScope.gonggoDTO.benefit_code4 == '0' ? 'selected' : ''}>필수/우대조건 선택</option> 
                <option value="1" ${requestScope.gonggoDTO.benefit_code4 == '1' ? 'selected' : ''}>운전면허</option>
                <option value="2" ${requestScope.gonggoDTO.benefit_code4 == '2' ? 'selected' : ''}>지게차운전기능사</option>
                <option value="3" ${requestScope.gonggoDTO.benefit_code4 == '3' ? 'selected' : ''}>요양보호사자격증</option>
                <option value="4" ${requestScope.gonggoDTO.benefit_code4 == '4' ? 'selected' : ''}>사회복지사자격증</option>
                <option value="5" ${requestScope.gonggoDTO.benefit_code4 == '5' ? 'selected' : ''}>간호조무사자격증</option>
                <option value="6" ${requestScope.gonggoDTO.benefit_code4 == '6' ? 'selected' : ''}>영양사자격증</option>
                <option value="7" ${requestScope.gonggoDTO.benefit_code4 == '7' ? 'selected' : ''}>보육교사자격증</option>
                <option value="8" ${requestScope.gonggoDTO.benefit_code4 == '8' ? 'selected' : ''}>건축기사자격증</option>
                <option value="9" ${requestScope.gonggoDTO.benefit_code4 == '9' ? 'selected' : ''}>전기기능사자격증</option>
                <option value="10" ${requestScope.gonggoDTO.benefit_code4 == '10' ? 'selected' : ''}>전기산업기사자격증</option>
                <option value="11" ${requestScope.gonggoDTO.benefit_code4 == '11' ? 'selected' : ''}>용접기능사자격증</option>
                <option value="12" ${requestScope.gonggoDTO.benefit_code4 == '12' ? 'selected' : ''}>전산회계1급자격증</option>
                <option value="13" ${requestScope.gonggoDTO.benefit_code4 == '13' ? 'selected' : ''}>전산세무2급자격증</option>
                <option value="14" ${requestScope.gonggoDTO.benefit_code4 == '14' ? 'selected' : ''}>직업상담사2급자격증</option>
                 <option value="15" ${requestScope.gonggoDTO.benefit_code4 == '15' ? 'selected' : ''}>정보처리기사자격증</option>
            </select><input type="button" value="삭제" onclick="removeBenefit(this)"><br></td></tr>
          

            
       <tr>
       <td>
            필수/우대조건 :
        <input type="radio" name="choice5" value="필수" ${requestScope.gonggoDTO.choice5 == '필수' ? 'checked' : ''} class="choice" id="choice"> 필수  
            <input type="radio" name="choice5" value="우대" ${requestScope.gonggoDTO.choice5 == '우대' ? 'checked' : ''} class="choice" id="choice"> 우대
            <select name="benefit_code5" id="benefit_code" class="benefit_code">
               <option value="0" ${requestScope.gonggoDTO.benefit_code5 == '0' ? 'selected' : ''}>필수/우대조건 선택</option> 
                <option value="1" ${requestScope.gonggoDTO.benefit_code5 == '1' ? 'selected' : ''}>운전면허</option>
                <option value="2" ${requestScope.gonggoDTO.benefit_code5 == '2' ? 'selected' : ''}>지게차운전기능사</option>
                <option value="3" ${requestScope.gonggoDTO.benefit_code5 == '3' ? 'selected' : ''}>요양보호사자격증</option>
                <option value="4" ${requestScope.gonggoDTO.benefit_code5 == '4' ? 'selected' : ''}>사회복지사자격증</option>
                <option value="5" ${requestScope.gonggoDTO.benefit_code5 == '5' ? 'selected' : ''}>간호조무사자격증</option>
                <option value="6" ${requestScope.gonggoDTO.benefit_code5 == '6' ? 'selected' : ''}>영양사자격증</option>
                <option value="7" ${requestScope.gonggoDTO.benefit_code5 == '7' ? 'selected' : ''}>보육교사자격증</option>
                <option value="8" ${requestScope.gonggoDTO.benefit_code5 == '8' ? 'selected' : ''}>건축기사자격증</option>
                <option value="9" ${requestScope.gonggoDTO.benefit_code5 == '9' ? 'selected' : ''}>전기기능사자격증</option>
                <option value="10" ${requestScope.gonggoDTO.benefit_code5 == '10' ? 'selected' : ''}>전기산업기사자격증</option>
                <option value="11" ${requestScope.gonggoDTO.benefit_code5 == '11' ? 'selected' : ''}>용접기능사자격증</option>
                <option value="12" ${requestScope.gonggoDTO.benefit_code5 == '12' ? 'selected' : ''}>전산회계1급자격증</option>
                <option value="13" ${requestScope.gonggoDTO.benefit_code5 == '13' ? 'selected' : ''}>전산세무2급자격증</option>
                <option value="14" ${requestScope.gonggoDTO.benefit_code5 == '14' ? 'selected' : ''}>직업상담사2급자격증</option>
                 <option value="15" ${requestScope.gonggoDTO.benefit_code5 == '15' ? 'selected' : ''}>정보처리기사자격증</option>
            </select><input type="button" value="삭제" onclick="removeBenefit(this)">

            
             
 
    </td>
</tr>

</tbody>

            </table>
            <table align="center" bordercolor="gray" border="1" cellpadding="7"
               style="border-collapse: collapse">
               </tr>
               <tr>
                  <td>성 별 : <input type="radio" class="seeker_sex"
                     name="seeker_sex" value="남" ${requestScope.gonggoDTO.seeker_sex == '남' ? 'checked' : ''}> 남 <input type="radio"
                     class="seeker_sex" name="seeker_sex" value="여" ${requestScope.gonggoDTO.seeker_sex == '여' ? 'checked' : ''}> 여 <input
                     type="radio" class="seeker_sex" name="seeker_sex" value="성별무관" ${requestScope.gonggoDTO.seeker_sex == '성별무관' ? 'checked' : ''}
                     > 성별무관
                  </td>
               </tr>
               <tr>
                  <td>급여 : <input type="text" id="salary" class="salary" name="salary" value="${requestScope.gonggoDTO.salary}">    

                  
                  <%-- <select id="salary" class="salary" name="salary" onchange="toggleOtherSalary()">
                        <option value="1000" ${requestScope.gonggoDTO.salary == '1000' ? 'selected' : ''}>1000만원 이하</option>
                        <option value="2000" ${requestScope.gonggoDTO.salary == '2000' ? 'selected' : ''}>2000~3000만원</option>
                        <option value="3000" ${requestScope.gonggoDTO.salary == '3000' ? 'selected' : ''}>3000~4000만원</option>
                        <option value="4000" ${requestScope.gonggoDTO.salary == '4000' ? 'selected' : ''}>4000~5000만원</option>
                        <option value="5000" ${requestScope.gonggoDTO.salary == '5000' ? 'selected' : ''}>5000~6000만원</option>
                        <option value="6000" ${requestScope.gonggoDTO.salary == '6000' ? 'selected' : ''}>6000~7000만원</option>
                        <option value="7000" ${requestScope.gonggoDTO.salary == '7000' ? 'selected' : ''}>7000~8000만원</option>
                        <option value="8000" ${requestScope.gonggoDTO.salary == '8000' ? 'selected' : ''}>8000~9000만원</option>
                        <option value="10000" ${requestScope.gonggoDTO.salary == '10000' ? 'selected' : ''}>1억 이상</option>
                        <option value="0" ${requestScope.gonggoDTO.salary == '0' ? 'selected' : ''}>직접 입력</option>
                        </select>
                        <input type="text" id="other_salary" name="other_salary"
                        value="${requestScope.gonggoDTO.other_salary}" class="hidden"> --%>
                        
                     
                  
                  </td>

               </tr>

               <tr>
                  <td>기업형태 : ${requestScope.gonggoDTO.volume}
                  </td>
                  </td>
               <tr>
                  <td>근무일시/시간 : ${requestScope.gonggoDTO.attendencetime}
                              ~ 
                              ${requestScope.gonggoDTO.leaveworktime}

                  </td>


               </tr>
               <tr>  
                  <td>근무지역 : ${requestScope.gonggoDTO.work_place}
                           
                  </td>
               </tr>
                  
            </table>
         </div>

          <br> 채용부문
          <table align="center" bordercolor="gray" border="1" cellpadding="7" id="Table_Clear1">
            <tr>
               <th colspan="1">담당부서</th>
               <th colspan="2">상세내용</th>
            </tr>
            <tr>
               <th rowspan="4">  <select name="dept_code1" class="dept_code1">
               <option value="0"  ${requestScope.gonggoDTO.dept_code1 == '0' ? 'selected' : ''}>선택</option>
                        <option value="1"  ${requestScope.gonggoDTO.dept_code1 == '1' ? 'selected' : ''}>기획부</option>
                        <option value="2"  ${requestScope.gonggoDTO.dept_code1 == '2' ? 'selected' : ''}>관리부</option>
                        <option value="3"  ${requestScope.gonggoDTO.dept_code1 == '3' ? 'selected' : ''}>회계부</option>
                        <option value="4"  ${requestScope.gonggoDTO.dept_code1 == '4' ? 'selected' : ''}>전산부</option>
                        <option value="5"  ${requestScope.gonggoDTO.dept_code1 == '5' ? 'selected' : ''}>영업부</option>
                        <option value="6"  ${requestScope.gonggoDTO.dept_code1 == '6' ? 'selected' : ''}>자재부</option>
                        <option value="7"  ${requestScope.gonggoDTO.dept_code1 == '7' ? 'selected' : ''}>생산부</option>
                        <option value="8"  ${requestScope.gonggoDTO.dept_code1 == '8' ? 'selected' : ''}>기술연구소</option>
                    </select></th>
            </tr>
            <tr>
            
               <td>세부분야</td>
               <td> <div class="row">
                  <select name="field_detail1" onchange="toggleTextbox(this)" id="field_detail1" class="field_detail1">
                  <c:if test="${empty requestScope.gonggoDTO.field_detail1}">    
                 <option value= "" >선택</option>
                  </c:if>    
                       <c:if test="${not empty requestScope.gonggoDTO.field_detail1}">                       
                <option value= "${requestScope.gonggoDTO.field_detail1}" >${requestScope.gonggoDTO.field_detail1}</option>
                </c:if>            
                <option value="전략기획" ${requestScope.gonggoDTO.field_detail1 == '전략기획' ? 'selected' : ''}>전략기획</option>
                <option value="경영지원" ${requestScope.gonggoDTO.field_detail1 == '경영지원' ? 'selected' : ''}>경영지원</option>
                <option value="인사" ${requestScope.gonggoDTO.field_detail1 == '인사' ? 'selected' : ''}>인사</option>
                <option value="회계" ${requestScope.gonggoDTO.field_detail1 == '회계' ? 'selected' : ''}>회계</option>
                <option value="사무보조" ${requestScope.gonggoDTO.field_detail1 == '사무보조' ? 'selected' : ''}>사무보조</option>
                <option value="영업" ${requestScope.gonggoDTO.field_detail1 == '영업' ? 'selected' : ''}>영업</option>
                <option value="고객상담" ${requestScope.gonggoDTO.field_detail1 == '고객상담' ? 'selected' : ''}>고객상담</option>
                <option value="마케팅·MD" ${requestScope.gonggoDTO.field_detail1 == '마케팅·MD' ? 'selected' : ''}>마케팅·MD</option>
                <option value="HTML·웹퍼블리셔" ${requestScope.gonggoDTO.field_detail1 == 'HTML·웹퍼블리셔' ? 'selected' : ''}>HTML·웹퍼블리셔</option>
                <option value="시스템·네트워크" ${requestScope.gonggoDTO.field_detail1 == '시스템·네트워크' ? 'selected' : ''}>시스템·네트워크</option>
                <option value="데이터베이스" ${requestScope.gonggoDTO.field_detail1 == '데이터베이스' ? 'selected' : ''}>데이터베이스</option>
                <option value="게임·웹툰" ${requestScope.gonggoDTO.field_detail1 == '게임·웹툰' ? 'selected' : ''}>게임·웹툰</option>
                <option value="모바일·APP" ${requestScope.gonggoDTO.field_detail1 == '모바일·APP' ? 'selected' : ''}>모바일·APP</option>
                <option value="QA·테스터" ${requestScope.gonggoDTO.field_detail1 == 'QA·테스터' ? 'selected' : ''}>QA·테스터</option>
                <option value="시스템분석·설계" ${requestScope.gonggoDTO.field_detail1 == '시스템분석·설계' ? 'selected' : ''}>시스템분석·설계</option>
                <option value="그래픽디자인" ${requestScope.gonggoDTO.field_detail1 == '그래픽디자인' ? 'selected' : ''}>그래픽디자인</option>
                <option value="광고·시각디자인" ${requestScope.gonggoDTO.field_detail1 == '광고·시각디자인' ? 'selected' : ''}>광고·시각디자인</option>
                <option value="제품디자인" ${requestScope.gonggoDTO.field_detail1 == '제품디자인' ? 'selected' : ''}>제품디자인</option>
                <option value="인테리어디자인" ${requestScope.gonggoDTO.field_detail1 == '인테리어디자인' ? 'selected' : ''}>인테리어디자인</option>
                <option value="패션디자인" ${requestScope.gonggoDTO.field_detail1 == '패션디자인' ? 'selected' : ''}>패션디자인</option>
                <option value="영상·사진·촬영" ${requestScope.gonggoDTO.field_detail1 == '영상·사진·촬영' ? 'selected' : ''}>영상·사진·촬영</option>
                <option value="영상·사진·편집" ${requestScope.gonggoDTO.field_detail1 == '영상·사진·편집' ? 'selected' : ''}>영상·사진·편집</option>
                <option value="음향" ${requestScope.gonggoDTO.field_detail1 == '음향' ? 'selected' : ''}>음향</option>
                <option value="동영상제작" ${requestScope.gonggoDTO.field_detail1 == '동영상제작' ? 'selected' : ''}>동영상제작</option>
                <option value="촬영물기획" ${requestScope.gonggoDTO.field_detail1 == '촬영물기획' ? 'selected' : ''}>촬영물기획</option>
                <option value="건축" ${requestScope.gonggoDTO.field_detail1 == '건축' ? 'selected' : ''}>건축</option>
                <option value="감리·공무" ${requestScope.gonggoDTO.field_detail1 == '감리·공무' ? 'selected' : ''}>감리·공무</option>
                <option value="시공" ${requestScope.gonggoDTO.field_detail1 == '시공' ? 'selected' : ''}>시공</option>
                <option value="안전·품질" ${requestScope.gonggoDTO.field_detail1 == '안전·품질' ? 'selected' : ''}>안전·품질</option>
                <option value="현장관리" ${requestScope.gonggoDTO.field_detail1 == '현장관리' ? 'selected' : ''}>현장관리</option>
                <option value="유치원·보육·교사" ${requestScope.gonggoDTO.field_detail1 == '유치원·보육·교사' ? 'selected' : ''}>유치원·보육·교사</option>
                <option value="초등학교" ${requestScope.gonggoDTO.field_detail1 == '초등학교' ? 'selected' : ''}>초등학교</option>
                <option value="중·고등학교" ${requestScope.gonggoDTO.field_detail1 == '중·고등학교' ? 'selected' : ''}>중·고등학교</option>
                <option value="특수교육" ${requestScope.gonggoDTO.field_detail1 == '특수교육' ? 'selected' : ''}>특수교육</option>
                <option value="간호조무사" ${requestScope.gonggoDTO.field_detail1 == '간호조무사' ? 'selected' : ''}>간호조무사</option>
                <option value="원무·코디네이터" ${requestScope.gonggoDTO.field_detail1 == '원무·코디네이터' ? 'selected' : ''}>원무·코디네이터</option>
                <option value="의사·의료진" ${requestScope.gonggoDTO.field_detail1 == '의사·의료진' ? 'selected' : ''}>의사·의료진</option>
                <option value="보건·의료관리" ${requestScope.gonggoDTO.field_detail1 == '보건·의료관리' ? 'selected' : ''}>보건·의료관리</option>
                <option value="생산·제조" ${requestScope.gonggoDTO.field_detail1 == '생산·제조' ? 'selected' : ''}>생산·제조</option>
                <option value="조립·가공·포장" ${requestScope.gonggoDTO.field_detail1 == '조립·가공·포장' ? 'selected' : ''}>조립·가공·포장</option>
                <option value="설비·검사·품질" ${requestScope.gonggoDTO.field_detail1 == '설비·검사·품질' ? 'selected' : ''}>설비·검사·품질</option>
                <option value="공정·생산관리" ${requestScope.gonggoDTO.field_detail1 == '공정·생산관리' ? 'selected' : ''}>공정·생산관리</option>
                <option value="창고·물류·유통" ${requestScope.gonggoDTO.field_detail1 == '창고·물류·유통' ? 'selected' : ''}>창고·물류·유통</option>
                <option value=",">직접입력</option>
            </select>
 
               <input type="text" id="text_field_detail1" name="field_detail1" class="hidden" placeholder="${requestScope.gonggoDTO.field_detail1 }"
             										
               
                />
               
                 
               
           
              
           
        </div>
        <div class="row_plus"></div></td>
            </tr>
            <tr>
               <td>직급</td>
               <td><select name="position_code1" class="position_code1">
            		    <option value="0"  ${requestScope.gonggoDTO.position_code1 == '0' ? 'selected' : ''}>선택</option>
                        <option value="1"  ${requestScope.gonggoDTO.position_code1 == '1' ? 'selected' : ''}>사원</option>
                        <option value="2" ${requestScope.gonggoDTO.position_code1 == '2' ? 'selected' : ''}>대리</option>
                        <option value="3" ${requestScope.gonggoDTO.position_code1 == '3' ? 'selected' : ''}>과장</option>
                        <option value="4" ${requestScope.gonggoDTO.position_code1 == '4' ? 'selected' : ''}>차장</option>
                        <option value="5" ${requestScope.gonggoDTO.position_code1 == '5' ? 'selected' : ''}>부장</option>
                        <option value="6" ${requestScope.gonggoDTO.position_code1 == '6' ? 'selected' : ''}>이사</option>
                        <option value="7" ${requestScope.gonggoDTO.position_code1 == '7' ? 'selected' : ''}>상무</option>
                        <option value="8" ${requestScope.gonggoDTO.position_code1 == '8' ? 'selected' : ''}>사장</option>
                        <option value="9" ${requestScope.gonggoDTO.position_code1 == '9' ? 'selected' : ''}>인턴</option>
                    </select></td>
            </tr>
            <tr>
               <td>업무내용</td>
               <td><input type="text" id="content1" class="content1" name="content1" value="${requestScope.gonggoDTO.content1}"></td>
            </tr>
         </table>
         <span type="button" onclick="clearTable1()">초기화</span>
         <br>
      
         
      
         <!-- -------------------------------------------------- -->
         <table align="center" bordercolor="gray" border="1" cellpadding="7" id="Table_Clear2"
        style="${empty requestScope.gonggoDTO.content2 ? 'display:none;' : ''}">
            <tr>
               <th colspan="1">담당부서</th>
               <th colspan="2">상세내용</th>
            </tr>
            <tr>
               <th rowspan="4"> 
                <select name="dept_code2" class="dept_code2">
                <option value="0" ${requestScope.gonggoDTO.dept_code2 == '0' ? 'selected' : ''}>선택</option>
                        <option value="1" ${requestScope.gonggoDTO.dept_code2 == '1' ? 'selected' : ''}>기획부</option>
                        <option value="2" ${requestScope.gonggoDTO.dept_code2 == '2' ? 'selected' : ''}>관리부</option>
                        <option value="3" ${requestScope.gonggoDTO.dept_code2 == '3' ? 'selected' : ''}>회계부</option>
                        <option value="4" ${requestScope.gonggoDTO.dept_code2 == '4' ? 'selected' : ''}>전산부</option>
                        <option value="5" ${requestScope.gonggoDTO.dept_code2 == '5' ? 'selected' : ''}>영업부</option>
                        <option value="6" ${requestScope.gonggoDTO.dept_code2 == '6' ? 'selected' : ''}>자재부</option>
                        <option value="7" ${requestScope.gonggoDTO.dept_code2 == '7' ? 'selected' : ''}>생산부</option>
                        <option value="8" ${requestScope.gonggoDTO.dept_code2 == '8' ? 'selected' : ''}>기술연구소</option>
                    </select></th>
            </tr>
            <tr>
               <td>세부분야</td>
               <td><div class="row">
            <select id="field_detail2" name="field_detail2" onchange="toggleTextbox(this)" id="field_detail2"  class="field_detail2">
               <c:if test="${not empty requestScope.gonggoDTO.field_detail2}">                       
                <option value= "${requestScope.gonggoDTO.field_detail2}" >${requestScope.gonggoDTO.field_detail2}</option>
                </c:if>
                   <c:if test="${empty requestScope.gonggoDTO.field_detail2}">    
                 <option value= "" ${requestScope.gonggoDTO.field_detail2 == '' ? 'selected' : ''}>선택</option>
                  </c:if>
                <option value="전략기획" ${requestScope.gonggoDTO.field_detail2 == '전략기획' ? 'selected' : ''}>전략기획</option>
                <option value="경영지원" ${requestScope.gonggoDTO.field_detail2 == '경영지원' ? 'selected' : ''}>경영지원</option>
                <option value="인사" ${requestScope.gonggoDTO.field_detail2 == '인사' ? 'selected' : ''}>인사</option>
                <option value="회계" ${requestScope.gonggoDTO.field_detail2 == '회계' ? 'selected' : ''}>회계</option>
                <option value="사무보조" ${requestScope.gonggoDTO.field_detail2 == '사무보조' ? 'selected' : ''}>사무보조</option>
                <option value="영업" ${requestScope.gonggoDTO.field_detail2 == '영업' ? 'selected' : ''}>영업</option>
                <option value="고객상담" ${requestScope.gonggoDTO.field_detail2 == '고객상담' ? 'selected' : ''}>고객상담</option>
                <option value="마케팅·MD" ${requestScope.gonggoDTO.field_detail2 == '마케팅·MD' ? 'selected' : ''}>마케팅·MD</option>
                <option value="HTML·웹퍼블리셔" ${requestScope.gonggoDTO.field_detail2 == 'HTML·웹퍼블리셔' ? 'selected' : ''}>HTML·웹퍼블리셔</option>
                <option value="시스템·네트워크" ${requestScope.gonggoDTO.field_detail2 == '시스템·네트워크' ? 'selected' : ''}>시스템·네트워크</option>
                <option value="데이터베이스" ${requestScope.gonggoDTO.field_detail2 == '데이터베이스' ? 'selected' : ''}>데이터베이스</option>
                <option value="게임·웹툰" ${requestScope.gonggoDTO.field_detail2 == '게임·웹툰' ? 'selected' : ''}>게임·웹툰</option>
                <option value="모바일·APP" ${requestScope.gonggoDTO.field_detail2 == '모바일·APP' ? 'selected' : ''}>모바일·APP</option>
                <option value="QA·테스터" ${requestScope.gonggoDTO.field_detail2 == 'QA·테스터' ? 'selected' : ''}>QA·테스터</option>
                <option value="시스템분석·설계" ${requestScope.gonggoDTO.field_detail2 == '시스템분석·설계' ? 'selected' : ''}>시스템분석·설계</option>
                <option value="그래픽디자인" ${requestScope.gonggoDTO.field_detail2 == '그래픽디자인' ? 'selected' : ''}>그래픽디자인</option>
                <option value="광고·시각디자인" ${requestScope.gonggoDTO.field_detail2 == '광고·시각디자인' ? 'selected' : ''}>광고·시각디자인</option>
                <option value="제품디자인" ${requestScope.gonggoDTO.field_detail2 == '제품디자인' ? 'selected' : ''}>제품디자인</option>
                <option value="인테리어디자인" ${requestScope.gonggoDTO.field_detail2 == '인테리어디자인' ? 'selected' : ''}>인테리어디자인</option>
                <option value="패션디자인" ${requestScope.gonggoDTO.field_detail2 == '패션디자인' ? 'selected' : ''}>패션디자인</option>
                <option value="영상·사진·촬영" ${requestScope.gonggoDTO.field_detail2 == '영상·사진·촬영' ? 'selected' : ''}>영상·사진·촬영</option>
                <option value="영상·사진·편집" ${requestScope.gonggoDTO.field_detail2 == '영상·사진·편집' ? 'selected' : ''}>영상·사진·편집</option>
                <option value="음향" ${requestScope.gonggoDTO.field_detail2 == '음향' ? 'selected' : ''}>음향</option>
                <option value="동영상제작" ${requestScope.gonggoDTO.field_detail2 == '동영상제작' ? 'selected' : ''}>동영상제작</option>
                <option value="촬영물기획" ${requestScope.gonggoDTO.field_detail2 == '촬영물기획' ? 'selected' : ''}>촬영물기획</option>
                <option value="건축" ${requestScope.gonggoDTO.field_detail2 == '건축' ? 'selected' : ''}>건축</option>
                <option value="감리·공무" ${requestScope.gonggoDTO.field_detail2 == '감리·공무' ? 'selected' : ''}>감리·공무</option>
                <option value="시공" ${requestScope.gonggoDTO.field_detail2 == '시공' ? 'selected' : ''}>시공</option>
                <option value="안전·품질" ${requestScope.gonggoDTO.field_detail2 == '안전·품질' ? 'selected' : ''}>안전·품질</option>
                <option value="현장관리" ${requestScope.gonggoDTO.field_detail2 == '현장관리' ? 'selected' : ''}>현장관리</option>
                <option value="유치원·보육·교사" ${requestScope.gonggoDTO.field_detail2 == '유치원·보육·교사' ? 'selected' : ''}>유치원·보육·교사</option>
                <option value="초등학교" ${requestScope.gonggoDTO.field_detail2 == '초등학교' ? 'selected' : ''}>초등학교</option>
                <option value="중·고등학교" ${requestScope.gonggoDTO.field_detail2 == '중·고등학교' ? 'selected' : ''}>중·고등학교</option>
                <option value="특수교육" ${requestScope.gonggoDTO.field_detail2 == '특수교육' ? 'selected' : ''}>특수교육</option>
                <option value="간호조무사" ${requestScope.gonggoDTO.field_detail2 == '간호조무사' ? 'selected' : ''}>간호조무사</option>
                <option value="원무·코디네이터" ${requestScope.gonggoDTO.field_detail2 == '원무·코디네이터' ? 'selected' : ''}>원무·코디네이터</option>
                <option value="의사·의료진" ${requestScope.gonggoDTO.field_detail2 == '의사·의료진' ? 'selected' : ''}>의사·의료진</option>
                <option value="보건·의료관리" ${requestScope.gonggoDTO.field_detail2 == '보건·의료관리' ? 'selected' : ''}>보건·의료관리</option>
                <option value="생산·제조" ${requestScope.gonggoDTO.field_detail2 == '생산·제조' ? 'selected' : ''}>생산·제조</option>
                <option value="조립·가공·포장" ${requestScope.gonggoDTO.field_detail2 == '조립·가공·포장' ? 'selected' : ''}>조립·가공·포장</option>
                <option value="설비·검사·품질" ${requestScope.gonggoDTO.field_detail2 == '설비·검사·품질' ? 'selected' : ''}>설비·검사·품질</option>
                <option value="공정·생산관리" ${requestScope.gonggoDTO.field_detail2 == '공정·생산관리' ? 'selected' : ''}>공정·생산관리</option>
                <option value="창고·물류·유통" ${requestScope.gonggoDTO.field_detail2 == '창고·물류·유통' ? 'selected' : ''}>창고·물류·유통</option>
                <option value=",">직접입력</option>
            </select>
<%--               <c:if test="${requestScope.gonggoDTO.field_detail2 == ','}"> --%>
          										
            <input type="text" id="text_field_detail2" name="field_detail2" class="hidden"
            placeholder="${requestScope.gonggoDTO.field_detail2 }" 
           />
           

<%--        </c:if> --%>
           
        </div>
        <div class="row_plus"></div></td>
            </tr>
            <tr>
               <td>직급</td>
               <td><select name="position_code2" class="position_code2">
                   <option value="0" ${requestScope.gonggoDTO.position_code2 == '0' ? 'selected' : ''}>선택</option>
                        <option value="1" ${requestScope.gonggoDTO.position_code2 == '1' ? 'selected' : ''}>사원</option>
                        <option value="2" ${requestScope.gonggoDTO.position_code2 == '2' ? 'selected' : ''}>대리</option>
                        <option value="3" ${requestScope.gonggoDTO.position_code2 == '3' ? 'selected' : ''}>과장</option>
                        <option value="4" ${requestScope.gonggoDTO.position_code2 == '4' ? 'selected' : ''}>차장</option>
                        <option value="5" ${requestScope.gonggoDTO.position_code2 == '5' ? 'selected' : ''}>부장</option>
                        <option value="6" ${requestScope.gonggoDTO.position_code2 == '6' ? 'selected' : ''}>이사</option>
                        <option value="7" ${requestScope.gonggoDTO.position_code2 == '7' ? 'selected' : ''}>상무</option>
                        <option value="8" ${requestScope.gonggoDTO.position_code2 == '8' ? 'selected' : ''}>사장</option>
                        <option value="9" ${requestScope.gonggoDTO.position_code2 == '9' ? 'selected' : ''}>인턴</option>
                    </select></td>
            </tr>
            <tr>
               <td>업무내용</td>
               <td><input type="text" id="content2" class="content2" name="content2" value=${requestScope.gonggoDTO.content2}></td>
            </tr>
         </table>
         <span type="button" onclick="clearTable2()">삭제</span>
			<span type="button" onclick="showTable2()">추가</span>
    
         <!-- -------------------------------------------------- -->
         </table>
         <br>
         
         <table align="center" bordercolor="gray" border="1" cellpadding="7" id="Table_Clear3"
       style="${empty requestScope.gonggoDTO.content3 ? 'display:none;' : ''}">
            <tr>
               <th colspan="1">담당부서</th>
               <th colspan="2">상세내용</th>
            </tr>
            <tr>
               <th rowspan="4">  <select name="dept_code3" class="dept_code3">
                  <option value="0"  ${requestScope.gonggoDTO.dept_code3 == '0' ? 'selected' : ''}>선택</option>
                        <option value="1"  ${requestScope.gonggoDTO.dept_code3 == '1' ? 'selected' : ''}>기획부</option>
                        <option value="2"  ${requestScope.gonggoDTO.dept_code3 == '2' ? 'selected' : ''}>관리부</option>
                        <option value="3"  ${requestScope.gonggoDTO.dept_code3 == '3' ? 'selected' : ''}>회계부</option>
                        <option value="4"  ${requestScope.gonggoDTO.dept_code3 == '4' ? 'selected' : ''}>전산부</option>
                        <option value="5"  ${requestScope.gonggoDTO.dept_code3 == '5' ? 'selected' : ''}>영업부</option>
                        <option value="6"  ${requestScope.gonggoDTO.dept_code3 == '6' ? 'selected' : ''}>자재부</option>
                        <option value="7"  ${requestScope.gonggoDTO.dept_code3 == '7' ? 'selected' : ''}>생산부</option>
                        <option value="8"  ${requestScope.gonggoDTO.dept_code3 == '8' ? 'selected' : ''}>기술연구소</option>
                    </select></th>
            </tr>
            <tr>
               <td>세부분야</td>
               <td>
               <div class="row">
            <select id="field_detail3" name="field_detail3" onchange="toggleTextbox(this)" id="field_detail3" class="field_detail3">
               <c:if test="${not empty requestScope.gonggoDTO.field_detail3}">                       
                <option value= "${requestScope.gonggoDTO.field_detail3}" >${requestScope.gonggoDTO.field_detail3}</option>
                </c:if>
                   <c:if test="${empty requestScope.gonggoDTO.field_detail3}">    
                 <option value= "" ${requestScope.gonggoDTO.field_detail3 == '' ? 'selected' : ''}>선택</option>
                  </c:if>
                <option value="전략기획" ${requestScope.gonggoDTO.field_detail3 == '전략기획' ? 'selected' : ''}>전략기획</option>
                <option value="경영지원" ${requestScope.gonggoDTO.field_detail3 == '경영지원' ? 'selected' : ''}>경영지원</option>
                <option value="인사" ${requestScope.gonggoDTO.field_detail3 == '인사' ? 'selected' : ''}>인사</option>
                <option value="회계" ${requestScope.gonggoDTO.field_detail3 == '회계' ? 'selected' : ''}>회계</option>
                <option value="사무보조" ${requestScope.gonggoDTO.field_detail3 == '사무보조' ? 'selected' : ''}>사무보조</option>
                <option value="영업" ${requestScope.gonggoDTO.field_detail3 == '영업' ? 'selected' : ''}>영업</option>
                <option value="고객상담" ${requestScope.gonggoDTO.field_detail3 == '고객상담' ? 'selected' : ''}>고객상담</option>
                <option value="마케팅·MD" ${requestScope.gonggoDTO.field_detail3 == '마케팅·MD' ? 'selected' : ''}>마케팅·MD</option>
                <option value="HTML·웹퍼블리셔" ${requestScope.gonggoDTO.field_detail3 == 'HTML·웹퍼블리셔' ? 'selected' : ''}>HTML·웹퍼블리셔</option>
                <option value="시스템·네트워크" ${requestScope.gonggoDTO.field_detail3 == '시스템·네트워크' ? 'selected' : ''}>시스템·네트워크</option>
                <option value="데이터베이스" ${requestScope.gonggoDTO.field_detail3 == '데이터베이스' ? 'selected' : ''}>데이터베이스</option>
                <option value="게임·웹툰" ${requestScope.gonggoDTO.field_detail3 == '게임·웹툰' ? 'selected' : ''}>게임·웹툰</option>
                <option value="모바일·APP" ${requestScope.gonggoDTO.field_detail3 == '모바일·APP' ? 'selected' : ''}>모바일·APP</option>
                <option value="QA·테스터" ${requestScope.gonggoDTO.field_detail3 == 'QA·테스터' ? 'selected' : ''}>QA·테스터</option>
                <option value="시스템분석·설계" ${requestScope.gonggoDTO.field_detail3 == '시스템분석·설계' ? 'selected' : ''}>시스템분석·설계</option>
                <option value="그래픽디자인" ${requestScope.gonggoDTO.field_detail3 == '그래픽디자인' ? 'selected' : ''}>그래픽디자인</option>
                <option value="광고·시각디자인" ${requestScope.gonggoDTO.field_detail3 == '광고·시각디자인' ? 'selected' : ''}>광고·시각디자인</option>
                <option value="제품디자인" ${requestScope.gonggoDTO.field_detail3 == '제품디자인' ? 'selected' : ''}>제품디자인</option>
                <option value="인테리어디자인" ${requestScope.gonggoDTO.field_detail3 == '인테리어디자인' ? 'selected' : ''}>인테리어디자인</option>
                <option value="패션디자인" ${requestScope.gonggoDTO.field_detail3 == '패션디자인' ? 'selected' : ''}>패션디자인</option>
                <option value="영상·사진·촬영" ${requestScope.gonggoDTO.field_detail3 == '영상·사진·촬영' ? 'selected' : ''}>영상·사진·촬영</option>
                <option value="영상·사진·편집" ${requestScope.gonggoDTO.field_detail3 == '영상·사진·편집' ? 'selected' : ''}>영상·사진·편집</option>
                <option value="음향" ${requestScope.gonggoDTO.field_detail3 == '음향' ? 'selected' : ''}>음향</option>
                <option value="동영상제작" ${requestScope.gonggoDTO.field_detail3 == '동영상제작' ? 'selected' : ''}>동영상제작</option>
                <option value="촬영물기획" ${requestScope.gonggoDTO.field_detail3 == '촬영물기획' ? 'selected' : ''}>촬영물기획</option>
                <option value="건축" ${requestScope.gonggoDTO.field_detail3 == '건축' ? 'selected' : ''}>건축</option>
                <option value="감리·공무" ${requestScope.gonggoDTO.field_detail3 == '감리·공무' ? 'selected' : ''}>감리·공무</option>
                <option value="시공" ${requestScope.gonggoDTO.field_detail3 == '시공' ? 'selected' : ''}>시공</option>
                <option value="안전·품질" ${requestScope.gonggoDTO.field_detail3 == '안전·품질' ? 'selected' : ''}>안전·품질</option>
                <option value="현장관리" ${requestScope.gonggoDTO.field_detail3 == '현장관리' ? 'selected' : ''}>현장관리</option>
                <option value="유치원·보육·교사" ${requestScope.gonggoDTO.field_detail3 == '유치원·보육·교사' ? 'selected' : ''}>유치원·보육·교사</option>
                <option value="초등학교" ${requestScope.gonggoDTO.field_detail3 == '초등학교' ? 'selected' : ''}>초등학교</option>
                <option value="중·고등학교" ${requestScope.gonggoDTO.field_detail3 == '중·고등학교' ? 'selected' : ''}>중·고등학교</option>
                <option value="특수교육" ${requestScope.gonggoDTO.field_detail3 == '특수교육' ? 'selected' : ''}>특수교육</option>
                <option value="간호조무사" ${requestScope.gonggoDTO.field_detail3 == '간호조무사' ? 'selected' : ''}>간호조무사</option>
                <option value="원무·코디네이터" ${requestScope.gonggoDTO.field_detail3 == '원무·코디네이터' ? 'selected' : ''}>원무·코디네이터</option>
                <option value="의사·의료진" ${requestScope.gonggoDTO.field_detail3 == '의사·의료진' ? 'selected' : ''}>의사·의료진</option>
                <option value="보건·의료관리" ${requestScope.gonggoDTO.field_detail3 == '보건·의료관리' ? 'selected' : ''}>보건·의료관리</option>
                <option value="생산·제조" ${requestScope.gonggoDTO.field_detail3 == '생산·제조' ? 'selected' : ''}>생산·제조</option>
                <option value="조립·가공·포장" ${requestScope.gonggoDTO.field_detail3 == '조립·가공·포장' ? 'selected' : ''}>조립·가공·포장</option>
                <option value="설비·검사·품질" ${requestScope.gonggoDTO.field_detail3 == '설비·검사·품질' ? 'selected' : ''}>설비·검사·품질</option>
                <option value="공정·생산관리" ${requestScope.gonggoDTO.field_detail3 == '공정·생산관리' ? 'selected' : ''}>공정·생산관리</option>
                <option value="창고·물류·유통" ${requestScope.gonggoDTO.field_detail3 == '창고·물류·유통' ? 'selected' : ''}>창고·물류·유통</option>
                <option value=",">직접입력</option>
            </select>
<%--               <c:if test="${ empty requestScope.gonggoDTO.field_detail3}"> --%>
          
            <input type="text" id="text_field_detail3" name="field_detail3" class="hidden" placeholder="${requestScope.gonggoDTO.field_detail3}"/>
<%--           </c:if> --%>
           
        </div>
        <div class="row_plus"></div></td>
            </tr>
            <tr>
               <td>직급 </td>
               <td><select name="position_code3" class="position_code3">
                <option value="0" ${requestScope.gonggoDTO.position_code3 == '0' ? 'selected' : ''}>선택</option>
                        <option value="1" ${requestScope.gonggoDTO.position_code3 == '1' ? 'selected' : ''}>사원</option>
                        <option value="2" ${requestScope.gonggoDTO.position_code3 == '2' ? 'selected' : ''}>대리</option>
                        <option value="3" ${requestScope.gonggoDTO.position_code3 == '3' ? 'selected' : ''}>과장</option>
                        <option value="4" ${requestScope.gonggoDTO.position_code3 == '4' ? 'selected' : ''}>차장</option>
                        <option value="5" ${requestScope.gonggoDTO.position_code3 == '5' ? 'selected' : ''}>부장</option>
                        <option value="6" ${requestScope.gonggoDTO.position_code3 == '6' ? 'selected' : ''}>이사</option>
                        <option value="7" ${requestScope.gonggoDTO.position_code3 == '7' ? 'selected' : ''}>상무</option>
                        <option value="8" ${requestScope.gonggoDTO.position_code3 == '8' ? 'selected' : ''}>사장</option>
                        <option value="9" ${requestScope.gonggoDTO.position_code3 == '9' ? 'selected' : ''}>인턴</option>
                    </select></td>
            </tr>
            <tr>
               <td>업무내용</td>
               <td><input type="text" id="content3" class="content3" name="content3" value="${requestScope.gonggoDTO.content3}"></td>
               							
            </tr>
         </table> 
        
         	<span type="button" onclick="clearTable3()">삭제</span>			
			<span type="button" onclick="showTable3()">추가</span>

         <br> 채용절차        
    <table align="center">

    <div class="container mx-auto px-4 py-10">
        <div class="grid grid-cols-3 gap-8">
            <div class="text-center">
            <c:if test="${not empty requestScope.gonggoDTO.process_name1 }">
                <div class="circle">
                    <img src="https://source.unsplash.com/random/200x200?sig=1" alt="Image 1">
                </div>
                <p class="mt-2">${requestScope.gonggoDTO.process_name1}</p>
            </div>
              </c:if>
            <div class="text-center">          
             <c:if test="${not empty requestScope.gonggoDTO.process_name2 }">
                <div class="circle">
                    <img src="https://source.unsplash.com/random/200x200?sig=2" alt="Image 2">
                </div>
                <p class="mt-2">${requestScope.gonggoDTO.process_name2}</p>
            </div>
              </c:if>
            <div class="text-center">           
                <c:if test="${not empty requestScope.gonggoDTO.process_name3 }">
                <div class="circle">
                    <img src="https://source.unsplash.com/random/200x200?sig=3" alt="Image 3">
                </div>
                <p class="mt-2">${requestScope.gonggoDTO.process_name3}</p>
            </div>
            </c:if>
             <div class="text-center">              
              <c:if test="${not empty requestScope.gonggoDTO.process_name4 }">
                <div class="circle">
                    <img src="https://source.unsplash.com/random/200x200?sig=4" alt="Image 4">
                </div>
                <p class="mt-2">${requestScope.gonggoDTO.process_name4}</p>
            </div>
            </c:if>
              <c:if test="${not empty requestScope.gonggoDTO.process_name5 }">
             <div class="text-center">           
                <div class="circle">
                    <img src="https://source.unsplash.com/random/200x200?sig=5" alt="Image 5">
                </div>
                <p class="mt-2">${requestScope.gonggoDTO.process_name5}</p>
            </div>
            </c:if>
             <c:if test="${not empty requestScope.gonggoDTO.process_name6 }">
             <div class="text-center">
                <div class="circle">
                    <img src="https://source.unsplash.com/random/200x200?sig=6" alt="Image 6">
                </div>
                <p class="mt-2">${requestScope.gonggoDTO.process_name6}</p>
            </div>
            </c:if>
             <c:if test="${not empty requestScope.gonggoDTO.process_name7 }">
             <div class="text-center">
                <div class="circle">
                    <img src="https://source.unsplash.com/random/200x200?sig=7" alt="Image 7">
                </div>
                <p class="mt-2">${requestScope.gonggoDTO.process_name7}</p>
            </div>
             </c:if>
        </div>
    </div>
            <tr>  
               <td>사내복지 : ${requestScope.gonggoDTO.welfare_name}
                
               </td>
            </tr>
            <tr>
               <td>내용 :<textarea name="content" class="content" style="width:100%; height:100%;" rows="4">${requestScope.gonggoDTO.content}</textarea>
               </td>
            </tr>
      

         </table>
       <input type="hidden" name="g_no" value="${requestScope.gonggoDTO.g_no}"> 
   
      
      <br> <br> 접수기간 및 담당자 이름
      <table>

         <tr>
            <td rowspan="4">남은기간 : <br> <label for="opendate">시작일:</label> 
                  <input type="date" id="opendate"
                  class="opendate"
                   name="opendate" value=${requestScope.gonggoDTO.opendate} min="1970-01-01" max="2040-12-31" />
                   <label for="closedate"><br>마감일:</label> 
                  <input type="date" id="closedate" name="closedate" value=${requestScope.gonggoDTO.closedate} min="1970-01-01" max="2040-12-31" />
            <!-- 마감날 - sysdate 추후에 추가해서 남은 시간 넣기 -->

            <td>담당자 이름 : <input type="text" name="manager_name" 
            class="manager_name"	value=${requestScope.gonggoDTO.manager_name}></td>
            
         </tr>
   
</form>


      </table>
 <input type="button" value="삭제" onclick="checkGonggoDelForm()"> <input type="button"
         value="수정" onclick="checkGonggoUpForm()">    <input type="reset" value="다시작성">
         <input type="button" value="뒤로가기" onClick="document.gonggoDetailForm.submit();" >
         
     <form name="gonggoDetailForm" action="/gonggoDetailForm.do" method="post">
      <input type="hidden" name="g_no" value="${requestScope.gonggoDTO.g_no}">
   </form>


   </div>


   <script src="js/slideshow.js"></script>
   <%@ include file="footer.jsp"%>
</body>
</html>