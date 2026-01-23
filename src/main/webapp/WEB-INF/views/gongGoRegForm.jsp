<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/WEB-INF/views/common.jsp"%>  
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>12Wa~</title>
  
  <script>

  $(function(){init(); });

  function init(){
  	$(".manager_name").val("캥거루");
  	$(".work_place").val("인천");
  	
  	$(".career:eq(1)").prop("checked",true);
  	$(".benefit_code:eq(1)").prop("checked",true);
  	$(".role").val("캥거루");

  	$(".graduation:eq(1)").prop("checked",true);
//   	$(".seeker_sex:eq(1)").prop("checked",true);
  	$(".seeker_age1").val("25");
  	$(".seeker_age2").val("22");
  	$(".salary").val("2000");
  	$(".content2").val("2000");
  	
//   	$(".benefit_code1").val("4");
  	$(".choice:eq(1)").prop("checked",true);
  	
  	
  	
  	
  	
  	
  }
  </script>
 <script>

 
 //  ---------------------------- 연봉 히든태그 ------------------------
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
 
// role_detail 행 추가 함수
  
 var deptIndex = 2;
        var positionIndex = 2;
        var field_detailIndex = 2;
        var contentIndex = 2;

        window.onload = function() {
            var firstSelect = document.getElementById("process_code1");
            if (firstSelect) {
                firstSelect.disabled = false;
            }
        };

        function toggleTextbox(selectElement) {
            var selectBox = $(selectElement);
            var customInput = selectBox.siblings('input[type="text"]').first();

            if (selectBox.val() === ',') {
                customInput.removeClass('hidden');
            } else {
                customInput.addClass('hidden');
            }
        }

        function row_plus() {
            var row_plus = $(".row_plus");

            // 복제할 행 선택
            var rowToClone = $(".row").first();
            var clonedRow = rowToClone.clone();

            // 복제된 행의 첫 번째 셀렉트 박스에 name 속성 변경 (부서 코드)
            var selectDept = clonedRow.find('select[name="dept_code1"]');
            var newDeptName = "dept_code" + deptIndex;
            selectDept.attr("name", newDeptName);
            
            selectDept.removeClass().addClass("dept_code" + deptIndex);

            // 복제된 행의 두 번째 셀렉트 박스에 name 속성 변경 (직위 코드)
            var selectPosition = clonedRow.find('select[name="position_code1"]');
            var newPositionName = "position_code" + positionIndex;
            selectPosition.attr("name", newPositionName);
            
            selectPosition.removeClass().addClass("position_code" + positionIndex);

            // 복제된 행의 세 번째 셀렉트 박스에 name 속성 변경 (필드 상세)
            var selectField_detail = clonedRow.find('select[name="field_detail1"]');
            var newField_detailName = "field_detail" + field_detailIndex;
            selectField_detail.attr("name", newField_detailName);
            
            selectField_detail.removeClass().addClass("field_detail" + field_detailIndex);

            // 필드 상세의 id 속성 변경 및 관련 텍스트 입력 필드 id 속성 변경
            var newField_detailId = "field_detail" + field_detailIndex;
            selectField_detail.attr("id", newField_detailId);

            var customInput = clonedRow.find('input[name="field_detail1"]');
            var newCustomFieldName = "field_detail" + field_detailIndex;
            customInput.attr("name", newCustomFieldName);
            customInput.attr("id", "field_detail_text" + field_detailIndex); // Update the id

            customInput.removeClass().addClass("field_detail_text" + field_detailIndex);

            // 복제된 행의 네 번째 텍스트 박스에 name 속성 변경 (내용)
            var textContent = clonedRow.find('input[name="content1"]');
            var newContentName = "content" + contentIndex;
            textContent.attr("name", newContentName);
            
            textContent.removeClass().addClass("content" + contentIndex);

            // 인덱스 증가
            deptIndex++;
            positionIndex++;
            field_detailIndex++;
            contentIndex++;

            if (deptIndex > 4) {
                alert("부서는 3개까지 가능합니다.");
                return;
            }

            // 복제된 행에 입력 필드 초기화
            selectDept.val('');
            selectPosition.val('');
            selectField_detail.val('');
            customInput.val('');
            customInput.addClass('hidden');
            textContent.val('');

            // 삭제 버튼 추가
            var deleteButton = $("<input type='button' value='삭제' onClick='delete_row(this)'>");
            clonedRow.find('td:nth-last-child(1)').append(deleteButton);

            // 행 추가
            clonedRow.appendTo(row_plus);
        }

        function delete_row(btn) {
            $(btn).closest('tr').remove();
            deptIndex--;
        }


/////////////////////필수/우대///////////////////////
function add_row_plus() {
	
    // 테이블의 ID를 이용하여 테이블 요소를 가져옵니다.
    var table = document.getElementById("benefit_row");

    // 새로운 행을 추가합니다.
    var newRow = table.insertRow(table.rows.length);

    // 순서번호를 가진 숨겨진 input 요소 추가
    var order_no = table.rows.length; // 순서번호
    if(order_no >=6){
		alert("필수/우대조건은 5개까지 가능합니다.")
		return;
	}
    
    // 새로운 행에 셀을 추가합니다.
    var cell1 = newRow.insertCell(0);
    var cell2 = newRow.insertCell(1);

   
    var orderInput = document.createElement("input");
    orderInput.type = "hidden";
    orderInput.name = "order_no"; // 배열로 저장되도록 수정
    orderInput.value = order_no;
    cell1.appendChild(orderInput);
    
    

    // radio 버튼 추가
    var radio1 = document.createElement("input");
    radio1.type = "radio";
    radio1.name = "choice" + (table.rows.length); // 각 행마다 고유한 name 속성을 부여
    radio1.value = "필수";
    radio1.className = "choice";
    cell2.appendChild(radio1);
    cell2.appendChild(document.createTextNode(" 필수"));

    var radio2 = document.createElement("input");
    radio2.type = "radio";
    radio2.name = "choice" + (table.rows.length); // 각 행마다 고유한 name 속성을 부여
    radio2.value = "우대";
    radio2.className = "choice";
    cell2.appendChild(radio2);
    cell2.appendChild(document.createTextNode(" 우대"));

    // 필수/우대 조건을 선택하는 드롭다운 메뉴 추가
    var selectBenefit = document.createElement("select");
    selectBenefit.name = "benefit_code" + (table.rows.length); // 각 행마다 고유한 name 속성을 부여
    selectBenefit.className = "benefit_code";
    selectBenefit.innerHTML = `
        <option value="">필수/우대조건 선택</option>
        <option value="1">운전면허</option>
        <option value="2">지게차운전기능사</option>
        <option value="3">요양보호사자격증</option>
        <option value="4">사회복지사자격증</option>
        <option value="5">간호조무사자격증</option>
        <option value="6">영양사자격증</option>
        <option value="7">보육교사자격증</option>
        <option value="8">건축기사자격증</option>
        <option value="9">전기기능사자격증</option>
        <option value="10">전기산업기사자격증</option>
        <option value="11">용접기능사자격증</option>
        <option value="12">전산회계1급자격증</option>
        <option value="13">전산세무2급자격증</option>
        <option value="14">직업상담사2급자격증</option>
        <option value="15">정보처리기사자격증</option>
    `;
    cell2.appendChild(selectBenefit);

    // 삭제 버튼 추가
    var deleteButton = document.createElement("input");
    deleteButton.type = "button";
    deleteButton.value = "삭제";
    deleteButton.onclick = delete_row_pilsu;
    cell2.appendChild(deleteButton);
}
 
function delete_row_pilsu() {
    var row = event.target.parentNode.parentNode;
    row.parentNode.removeChild(row);
}
   

     //////////////////////////////////////////
// 공고 전형 절차
function add_row_seorew() {
	 
    var table = document.getElementById("benefit_row_seorew");
    
    var newRow = table.insertRow(table.rows.length);
    
    // 순서번호를 가진 숨겨진 input 요소 추가
    var order_no = table.rows.length; // 순서번호
    
    if(order_no >=8){
		alert("전형절차는 7개까지 가능합니다.")
		return;
	}
    
    var cell1 = newRow.insertCell(0);
    var cell2 = newRow.insertCell(1);

   
   
   
    
    var orderInput = document.createElement("input");
    orderInput.type = "hidden";
    orderInput.name = "order_no" + order_no;
    orderInput.value = order_no;
    cell1.appendChild(orderInput);
	
  
    
    var selectProcess = document.createElement("select");
    selectProcess.name = "process_code" + table.rows.length; // 이름값 자동 증가
   
    selectProcess.className = "process_code";
    selectProcess.innerHTML = `
    
        <option value="1">서류전형</option>
        <option value="2">1차면접</option>
        <option value="3">2차면접</option>
        <option value="4">3차면접</option>
        <option value="5">AI면접</option>
        <option value="6">인적성 검사</option>
        <option value="7">코딩테스트</option>
        <option value="8">채용검진</option>
        <option value="9">처우협의</option>
        <option value="10">최종입사</option>
    `;
    
    cell2.appendChild(selectProcess);
    
    cell2.appendChild(document.createTextNode(' '));
    
  
    var addButton = document.createElement("input");
    addButton.type = "button";
    addButton.value = "추가";
   
    addButton.onclick = add_row_seorew;
    cell2.appendChild(addButton);
   
    cell2.appendChild(document.createTextNode(' '));
    
    var deleteButton = document.createElement("input");
    deleteButton.type = "button";
    deleteButton.value = "삭제";
    deleteButton.onclick = delete_row_seorew;
    cell2.appendChild(deleteButton);        
}
function delete_row_seorew(event) {
	
    var row = event.target.parentNode.parentNode;
    row.parentNode.removeChild(row);
}

// 첫 번째 셀렉트박스 비활성화 해제
window.onload = function() {
    var firstSelect = document.getElementById("process_code1");
    firstSelect.disabled = false;
};
     
// 공고 등록
function gonGoRegForm(){
	
	var formObj = $("[name='gongGo']");

	//담당자 성함
	var manager_nameObj = formObj.find(".manager_name");
//부서/직책/분야/내용
	 var dept_code1Obj = formObj.find(".dept_code1");
	var position_code1Obj = formObj.find(".position_code1");
	var field_detail1Obj = formObj.find(".field_detail1");	
	var fidel_detail1_textObj = formObj.find("#field_detail1_text1");
	var content1Obj = formObj.find(".content1");
	
	 var dept_code2Obj = formObj.find(".dept_code2");
		var position_code2Obj = formObj.find(".position_code2");
		var field_detail2Obj = formObj.find(".field_detail2");	
		var fidel_detail2_textObj = formObj.find("#field_detail_text2");
		var content2Obj = formObj.find(".content2");
		
		 var dept_code3Obj = formObj.find(".dept_code3");
			var position_code3Obj = formObj.find(".position_code3");
			var field_detail3Obj = formObj.find(".field_detail3");	
			var fidel_detail3_textObj = formObj.find("#field_detail_text3");
			var content3Obj = formObj.find(".content3");
		// 주소
		var work_place1Obj = formObj.find(".work_place1");
		var work_place2Obj = formObj.find(".work_place2");
		var work_place3Obj = formObj.find(".work_place3");
		//경력여부
		var careerObj = formObj.find(".career");
		// 필수/우대조건
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
		 //최종학력
		 var graduationObj = formObj.find("select[name='graduation']");
		 //지원자 성별
		 var seeker_sexObj = formObj.find(".seeker_sex");
		 //나이
		 var seeker_age1Obj = formObj.find(".seeker_age1");
		 var seeker_age2Obj = formObj.find(".seeker_age2");
		 var age_irrelevantObj = formObj.find("#age_irrelevant");
// 		  //전형방법
		  var process_code1Obj = formObj.find("select[name='process_code1']");
		  var process_code2Obj = formObj.find("select[name='process_code2']");
		  var process_code3Obj = formObj.find("select[name='process_code3']");
		  var process_code4Obj = formObj.find("select[name='process_code4']");
		  var process_code5Obj = formObj.find("select[name='process_code5']");
		  var process_code6Obj = formObj.find("select[name='process_code6']");
		  var process_code7Obj = formObj.find("select[name='process_code7']");
 		//  공고등록 날짜
 		var opendateObj = formObj.find(".opendate");
 		var closedateObj = formObj.find(".closedate");

 		
		
		 
		if( new RegExp(/^[가-힣]{2,15}$/).test(manager_nameObj.val())==false ){
			alert("담당자 성함은 2~15자 한글이어야합니다.");
			manager_nameObj.val("");
			return false;
		}
 		if(dept_code1Obj.val() === "" || position_code1Obj.val() === ""  || content1Obj.val() === ""){
 			 			alert("부서,직책,분야,업무내용을 작성해주세요1");
 			return false;
 		}
	if(field_detail1Obj.val() == ',' && fidel_detail1_textObj.val() == '' || field_detail1Obj.val() == ''){
		alert("부서,직책,분야,업무내용을 작성해주세요1")
		return false;
	}
 		if(dept_code2Obj.val() === "" || position_code2Obj.val() === ""  || content2Obj.val() === ""){
 			 			alert("부서,직책,분야,업무내용을 작성해주세요2");
 			return false;
 		}
	if(field_detail2Obj.val() == ',' && fidel_detail2_textObj.val() == '' || field_detail2Obj.val() == ''){
		alert("부서,직책,분야,업무내용을 작성해주세요2")
		return false;
	}
	if(dept_code3Obj.val() === "" || position_code3Obj.val() === ""  || content3Obj.val() === ""){
			alert("부서,직책,분야,업무내용을 작성해주세요3");
return false;
}
if(field_detail3Obj.val() == ',' && fidel_detail3_textObj.val() == '' || field_detail3Obj.val() == ''){
alert("부서,직책,분야,업무내용을 작성해주세요3")
return false;
}
 		
  		if(work_place1Obj.val() == '시/도 선택' || work_place2Obj.val()=='구/군 선택'|| work_place3Obj.val() ==''){
  			alert("주소를 입력해 주세요")
  			return false;
  		}
	
  		if(careerObj.is(':checked') == false){
  		    alert("경력 여부를 선택해 주세요");
  		    return false;
 		}
	
	if(choice1Obj.is(':checked') == true && benefit_code1Obj.val() == ''){
		alert("필수/우대 조건을 선택해 주세요1")
		return false;
	}
	if(choice1Obj.is(':checked') == false && benefit_code1Obj.val() != ''){
		alert("필수/우대 조건을 선택해 주세요1")
		return false;
	}
	
	if(choice2Obj.is(':checked') == true && benefit_code2Obj.val() == ''){
		alert("필수/우대 조건을 선택해 주세요2")
		return false;
	}
// 	if(benefit_code2Obj.val() != ''&&  choice2Obj.is(':checked') == false  ){
// 		alert("필수/우대 조건을 선택해 주세요2")
// 		return false;
// 	}
	
	if(choice3Obj.is(':checked') == true && benefit_code3Obj.val() == ''){
		alert("필수/우대 조건을 선택해 주세요3")
		return false;
	}
// 	if(choice3Obj.is(':checked') == false && benefit_code3Obj.val() != ''){
// 		alert("필수/우대 조건을 선택해 주세요3")
// 		return false;
// 	}
	
	if(choice4Obj.is(':checked') == true && benefit_code4Obj.val() == ''){
		alert("필수/우대 조건을 선택해 주세요4")
		return false;
	}
// 	if(choice4Obj.is(':checked') == false && benefit_code4Obj.val() != ''){
// 		alert("필수/우대 조건을 선택해 주세요4")
// 		return false;
// 	}
	
	if(choice5Obj.is(':checked') == true && benefit_code5Obj.val() == ''){
		alert("필수/우대 조건을 선택해 주세요5")
		return false;
	}
// 	if(choice5Obj.is(':checked') == false && benefit_code5Obj.val() != ''){
// 		alert("필수/우대 조건을 선택해 주세요5")
// 		return false;
// 	}
	
	
	if(graduationObj.val()==''){
		alert("최종학력을 선택해주세요")
		return false;
	}
	if(seeker_sexObj.is(':checked') == false){
		    alert("지원자 성별을 선택해 주세요");
		    return false;
		}
	if(new RegExp(/^[0-9]{1,2}$/).test(seeker_age1Obj.val()) == false && age_irrelevantObj.is(':checked')== false ){
		alert("지원자의 나이는 2자리까지만 입력해주세요1");
		return false;
	} 
	if(new RegExp(/^[0-9]{1,2}$/).test(seeker_age2Obj.val()) == false && age_irrelevantObj.is(':checked') == false){
		alert("지원자의 나이는 2자리까지만 입력해주세요2");
		return false;
		} 
	
	if((seeker_age1Obj.val() > seeker_age2Obj.val()) && age_irrelevantObj.is(':checked') == false){
		alert("나이를 정확히 입력해주세요")
		return false;
	}

	if(age_irrelevantObj.is(':checked') == true && seeker_age1Obj.val() != ''&& seeker_age2Obj.val() != ''){
		alert("나이를 적고 나이무관을 선택하면 나이무관이 선택됩니다.");
	}
	  alert(closedateObj.val())
	if(opendateObj.val() > closedateObj.val()){
		alert("공고 시작일은 마지막일보다 작아야 합니다.")
		return false;
	}
	
	if(process_code1Obj.val() != '1'){
		alert("1 - 첫번째에 서류전형을 선택해주세요")
		process_code1Obj.val('1');
		return false;
	}
	if(process_code2Obj. val() == '1'){
		alert("2 - 중복으로 서류전형을 선택할 수 없습니다.")
		process_code2Obj.val('2');
		return false;
	}
	if ( process_code2Obj. val() == '3' || process_code2Obj. val() == '4' ){
		alert("2 - 면접은 1차면접부터 선택해주세요.")
		process_code2Obj.val('2');
		return false;
	}
	if (process_code3Obj. val() == '4' || process_code3Obj. val() == '1' || process_code3Obj. val() == '2'){
		alert("3 - 2차면접부터 선택해주세요")
		process_code3Obj. val('3');
		return false;
	}

		if(age_irrelevantObj.is(':checked')  == true){
			seeker_age1Obj.remove();
			seeker_age2Obj.remove();
			$("#age_irrelevant").attr("name","seeker_age");

		}



	$.ajax( 
			{ 
				
				url    : "/gongGoReg.do"
				
				,type  : "post"
				
				,data  : formObj.serialize( )
				
				,success : function(json){
					var result = json["result"];
	
					if(result==1){
						alert("공고등록 성공입니다.");
						location.replace("gongGoList.do")
					}
					else {
						alert("공고등록 실패")
					
					}
				}
				//----------------------------------------------------------
				// WAS 의 응답이 실패했을 실행할 익명함수 설정.
				//----------------------------------------------------------
				,error : function(){
					alert("공고등록 실패! 관리자에게 문의 바람니다.");
				}
			}
		);
	}
	
	

</script>


</head>
  
<body>
 <div id="container">    
   <%@ include file="header.jsp" %>
  
    <br>
<center>
  
    <div class="container">
      <h1 style="text-align: center; font-size:2em;">모집공고</h1><br>
      <form  name="gongGo" action="submit.php" method="POST">
          
    <table align="center" bordercolor="gray" border=1 cellpadding=7 style="border-collpase:collpase" 
     >
              
              <tr>
                  <td>담당자 성함</td>
                  <td><input type="text" id="manager_name" name="manager_name" class="manager_name" value="dd" required></td>
             
<!-- </tbody>  -->
              </tr> 
              
            	       <tbody class="row_plus" id="row_plus">
            <tr class="row" id="row">
                <td>부서/직책/분야/내용</td>
                <td>
                    <select name="dept_code1" class="dept_code1">
                        <option value="1">기획부</option>
                        <option value="2">관리부</option>
                        <option value="3">회계부</option>
                        <option value="4">전산부</option>
                        <option value="5">영업부</option>
                        <option value="6">자재부</option>
                        <option value="7">생산부</option>
                        <option value="8">기술연구소</option>
                    </select>
                    <select name="position_code1" class="position_code1">
                        <option value="1">사원</option>
                        <option value="2">대리</option>
                        <option value="3">과장</option>
                        <option value="4">차장</option>
                        <option value="5">부장</option>
                        <option value="6">이사</option>
                        <option value="7">상무</option>
                        <option value="8">사장</option>
                        <option value="9">인턴</option>
                    </select>
                    <select id="field_detail1" name="field_detail1" onchange="toggleTextbox(this)" class="field_detail1">
                        <option value="">선택</option>
                          <option value="전략기획">전략기획</option>
                        <option value="경영지원">경영지원</option>
                        <option value="인사">인사</option>
                        <option value="회계" >회계</option>
                        <option value="사무보조" >사무보조</option>
                        <option value="영업">영업</option>
                        <option value="고객상담">고객상담</option>
                        <option value="마케팅·MD">마케팅·MD</option>
                        <option value="HTML·웹퍼블리셔">HTML·웹퍼블리셔</option>
                        <option value="시스템·네트워크">시스템·네트워크</option>
                        <option value="데이터베이스">데이터베이스</option>
                        <option value="게임·웹툰">게임·웹툰</option>
                        <option value="모바일·APP">모바일·APP</option>
                        <option value="QA·테스터">QA·테스터</option>
                        <option value="시스템분석·설계">시스템분석·설계</option>
                        <option value="그래픽디자인">그래픽디자인</option>
                        <option value="광고·시각디자인">광고·시각디자인</option>
                        <option value="제품디자인">제품디자인</option>
                        <option value="인테리어디자인">인테리어디자인</option>
                        <option value="패션디자인">패션디자인</option>
                        <option value="영상·사진·촬영">영상·사진·촬영</option>
                        <option value="영상·사진·편집">영상·사진·편집</option>
                        <option value="음향">음향</option>
                        <option value="동영상제작">동영상제작</option>
                        <option value="촬영물기획">촬영물기획</option>
                        <option value="건축">건축</option>
                        <option value="감리·공무">감리·공무</option>
                        <option value="시공">시공</option>
                        <option value="안전·품질">안전·품질</option>
                        <option value="현장관리">현장관리</option>
                        <option value="유치원·보육·교사">유치원·보육·교사</option>
                        <option value="초등학교">초등학교</option>
                        <option value="중·고등학교">중·고등학교</option>
                        <option value="특수교육">특수교육</option>
                        <option value="간호조무사">간호조무사</option>
                        <option value="원무·코디네이터">원무·코디네이터</option>
                        <option value="의사·의료진">의사·의료진</option>
                        <option value="보건·의료관리">보건·의료관리</option>
                        <option value="생산·제조">생산·제조</option>
                        <option value="조립·가공·포장">조립·가공·포장</option>
                        <option value="설비·검사·품질">설비·검사·품질</option>
                        <option value="공정·생산관리">공정·생산관리</option>
                        <option value="창고·물류·유통">창고·물류·유통</option>
                        <option value=",">직접입력</option>
                    </select>
                    <input type="text" id="field_detail1_text1" name="field_detail1" class="hidden" placeholder="직접 입력" />
                    <input type="text" id="content1" class="content1" name="content1" value="dd">
                    <input type="button" value="추가" onClick="row_plus()">
                </td>
            </tr>
        </tbody>
  

              <tr>
                <td>주소</td>
                <td>
                  <select  name="work_place1" value="work_place" id="sido1" class="work_place1"></select>
                  <select   name="work_place2" value="work_place" id="gugun1" class="work_place2"></select>&nbsp;
                  <input type="text" name="work_place3" id="work_place" value="나머지 상세주소" onfocus="if(this.value=='나머지 상세주소') this.value='';"
                	  class="work_place3"
                  ></td>
			 </tr>
              
             	
				<tr>
                  <td>경력여부</td>
                  <td>
                  <input type="radio" name="career" id="career" class="career" value="신입" > 신입
                  <input type="radio" name="career" id="career" class="career" value="경력"> 경력
                  <input type="radio" name="career" id="career" class="career" value="경력무관"> 경력무관
                  </td>
              </tr>
              
                     
                     
             </tr>
           
            
               
    
 <tbody id="benefit_row">
    <tr>
        <td>필수/우대 조건</td>
        <td>
      
            <input type="radio" name="choice1" value="필수" class="choice1" id="choice1"  > 필수
            <input type="radio" name="choice1" value="우대" class="choice1" id="choice1"> 우대
            <select name="benefit_code1" id="benefit_code" class="benefit_code1" >
            	<option value="">필수/우대조건 선택</option> 
                <option value="1">운전면허</option>
                <option value="2">지게차운전기능사</option>
                <option value="3">요양보호사자격증</option>
                <option value="4">사회복지사자격증</option>
                <option value="5">간호조무사자격증</option>
                <option value="6">영양사자격증</option>
                <option value="7">보육교사자격증</option>
                <option value="8">건축기사자격증</option>
                <option value="9">전기기능사자격증</option>
                <option value="10">전기산업기사자격증</option>
                <option value="11">용접기능사자격증</option>
                <option value="12">전산회계1급자격증</option>
                <option value="13">전산세무2급자격증</option>
                <option value="14">직업상담사2급자격증</option>
                <option value="15">정보처리기사자격증</option>
            </select>
             
            
             <input type="button" onclick="add_row_plus();" value="추가"> 

             <!-- 행 전체삭제 -->
             <!-- <input type="button" value="삭제" onclick="delete_row(this)"> -->

             

        </td>
    </tr>
</tbody>

              

                
                <tr>
                <td>최종 학력</td>
                <td>
                    <select id="graduation" class="graduation" name="graduation"  >
                        <option value="">최종 학력 선택</option>
                        <option value="초등학교 졸업">초등학교 졸업</option>
                        <option value="중학교 졸업">중학교 졸업</option>
                        <option value="고등학교 졸업" checked>고등학교 졸업</option>
                        <option value="대학교 졸업">대학교 졸업 (4년 이상)</option>
                    </select>
                    <input type="checkbox" id="ph_d_candidate" name="ph_d_candidate" value="졸업예정자 지원가능">
    			졸업예정자 지원가능
                </td>
                </tr>
                
                <tr>
                    <td>지원자 성별</td>
                    <td>
                    <input type="radio" class="seeker_sex" name="seeker_sex" value="남"> 남
                    <input type="radio" class="seeker_sex" name="seeker_sex" value="여"> 여
                    <input type="radio" class="seeker_sex" name="seeker_sex" value="성별무관" > 성별무관
                     </td>
                </tr>
                
                <tr>
                    <td>나이</td>
                    <td>
                    <input type="text"  name="seeker_age" class="seeker_age1" size="7" >
                    ~
                    <input type="text"  name="seeker_age" class="seeker_age2" size="7" >
                    <input type="checkbox" value="나이무관"  id="age_irrelevant">나이무관
                     </td>
                </tr>
                <tr>
                <td>연봉</td>
                <td>
               <input type="text" id="salary" name="salary" placeholder="(선택) 직접기입" > 
                
            <!--     <select id="salary" class="salary" name="salary" onchange="toggleOtherSalary()">
            <option value="1000">1000만원</option>
            <option value="2000">2000만원</option>  
            <option value="3000">3000만원</option>                        
            <option value="4000">4000만원</option>     
            <option value="5000">5000만원</option>
            <option value="6000">6000만원</option>
            <option value="7000">7000만원</option>
            <option value="8000">8000만원</option>
            <option value="10000">1억 이상</option>                       
            <option value="0">직접 입력</option>
        </select>
        <input type="text" id="other_salary" name="other_salary" placeholder="(선택) 직접기입" class="hidden"> -->
                   
                  
                   
                   
                    
                </td>
               </tr>                                      
             <tr>
                <td>시작/마감일</td>
                <td>
                <label for="opendate"> 공고시작날짜:</label> 
						<input type="date" id="opendate"
						class="opendate"
						 name="opendate" value="2000-01-01" min="1970-01-01" max="2040-12-31" />
						 <label for="closedate">공고마지막날짜:</label> 
						<input type="date" id="closedate" class="closedate" name="closedate" value="2000-01-01" min="1970-01-01" max="2040-12-31" />
                </td>
            </tr>
           
               <tr> 
           <td>근무시간</td>   
            <td>        
                <select name="attendencetime" class="attendencetime">
                <% for (int i = 1; i <= 24; i++) { %>
                    <option value="<%= i %>"><%= String.format("%02d", i) %></option>
                <% } %>
               
            </select>
            시~
            <select name="leaveworktime" class="leaveworktime">
                <% for (int i = 1; i <= 24; i++) { %>
                    <option value="<%= i %>"><%= String.format("%02d", i) %></option>
                <% } %>
            </select>
            시
                </td>
             </tr>   
                
              <tbody id="benefit_row_seorew">   
    <tr>
        <td>전형방법</td>
        <td>
            <select id="process_code1" name="process_code1" class="process_code1" >
                <option value="1">서류전형</option>
                <option value="2">1차면접</option>
                <option value="3">2차면접</option>
                <option value="4">3차면접</option>
                <option value="5">AI면접</option>
                <option value="6">인적성 검사</option>
                <option value="7">코딩테스트</option>
                <option value="8">채용검진</option>
                <option value="9">처우협의</option>
                <option value="10">최종입사</option>
            </select>
            <input type="hidden" name="order_no1" value="1"> <!-- order_no 추가 -->
            <input type="button" onclick="add_row_seorew()" value="추가">
        </td>
    </tr>
</tbody>

			
			<tr>
				<td>제출서류</td>
				<td>
				<input type="file" name="file">
				</td>				
			</tr>	
			  <tr>
               <td>내용</td>
               <td>
                  <textarea name="content" class="content2" textarea style="width:100%; height:100%;" rows="4"></textarea>
               </td>
            <tr>  
          </table>
         
     		<input type="hidden" name="c_no" value="${sessionScope.c_no}">
     	
 		
          
          
           </form>
          <br>
          <input type="button" name="gongGoGO" value="등록하기"
          onClick="gonGoRegForm()"  size="20">
		 <br><br>
     
  </div>
 
    </center>
    
     
    
  </div> 
    
     
</body>
   <%@ include file="footer.jsp" %>
</html>