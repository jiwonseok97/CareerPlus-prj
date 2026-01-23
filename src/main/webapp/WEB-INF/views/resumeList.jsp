<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common.jsp"%>

<!DOCTYPE html>
<html>

<head>
<style>
    /* Form container */
    .form-container {
        text-align: center;
        margin-bottom: 20px;
    }

    /* Fieldset container */
    .fieldset-container {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        width:1200px;
        margin:0 auto;
    }

    /* Fieldset */
    fieldset {
        border: 1px solid #ccc;
        border-radius: 5px;
        padding: 10px;
        margin: 10px;
        flex: 0 0 calc(50% - 20px); /* Adjust width as needed */
        max-width: 250px; /* Limit maximum width */
    }

    /* Legend */
    legend {
        font-weight: bold;
    }

    /* Radio and checkbox labels */
    label {
        margin-right: 10px;
    }

    /* Search button */
    .searchBtn, .resetBtn {
        padding: 8px 20px;
        border-radius: 5px;
        border: none;
        background-color: #007bff;
        color: #fff;
        cursor: pointer;
        margin: 0 10px;
    }

    /* Search button hover effect */
    .searchBtn:hover, .resetBtn:hover {
        background-color: #0056b3;
    }
    </style>
<script>
function search(){
	//---------------------------------------------
	// 변수 boardSearchFormObj 선언하고 
	// name='boardSearchForm' 를 가진 form 태그 관리 JQuery 객체를 생성하고 저장하기
	//---------------------------------------------
	var boardSearchFormObj = $("[name='boardSearchForm']");
	var sidoObj            = boardSearchFormObj.find(".sido").val();
	var gugunObj           = boardSearchFormObj.find(".gugun").val();
	var sexObj = boardSearchFormObj.find('[name="sex"]:checked').val();
	var ageObj = boardSearchFormObj.find('[name="age"]:checked').val();
	var educationObj = boardSearchFormObj.find('[name="education"]:checked').val();
	var hope_salaryObj = boardSearchFormObj.find('[name="hope_salary"]:checked').val();
	var field_codeObj = boardSearchFormObj.find('[name="field_code"]').val();
	var careerObj = boardSearchFormObj.find('[name="career"]:checked').val();
	var skill_nameObj = boardSearchFormObj.find('[name="skill_name"]:checked').map(function() { return this.value; }).get();
	
	
	boardSearchFormObj.find(".rowCntPerPage").val($("select").filter(".rowCntPerPage").val());


	// 검색 함수 호출


	//-----------------------------------------------------
	// JQuery 객체의 [ajax 메소드]를 호출하여
	// WAS 에 "/boardList.do" 주소로 접속하고 
	// boardList.jsp 페이지의 실행 결과인 HTML 코드를 문자로 받아서
	// <div class='boardListDiv'> 태그 내부의 게시판 관련 검색 결과 목록 부분을
	// 현화면의 <div class='boardListDiv'> 태그 내부에 덮어쓰기
	//-----------------------------------------------------
	$.ajax(
		{
			//-------------------------------
			// WAS 로 접속할 주소 설정
			//-------------------------------
			url      : "/resumeList.do"
			//-------------------------------
			// WAS 로 접속하는 방법 설정. get 또는 post
			//-------------------------------
			,type    : "post"
			//--------------------------------------
			// WAS 에 보낼 파명과 파값을 설정하기. "파명=파값&파명=파값~"
			//--------------------------------------
			,data    : boardSearchFormObj.serialize( )
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
            $(".boardListDiv").html(obj.filter(".boardListDiv").html());
            $(".pagingNos").html(obj.filter(".pagingNos").html());
         

			

				
				
// 				$("body").append(
// 					"<textarea class=xxx cols=100 rows=100>"
// 					+ obj.filter(".pagingNos").html()
// 					+"</textarea>"
// 				)
				
			}
			,error   : function(){
				alert("검색 실패! 관리자에게 문의 바람니다.");
			}
		}
	);
}
///////////////////////search()종료부분

function searchReset(){

   var boardSearchFormObj = $("[name='boardSearchForm']");
   boardSearchFormObj.find(".keyword").val("");
    $("[name='boardSearchForm']").find("[name='sido']").val("시/도 선택");
    $("[name='boardSearchForm']").find("[name='gugun']").val("구/군 선택");
    document.getElementById('other-sex').checked = true;
    document.getElementById('other-age').checked = true;
    document.getElementById('age_10').checked = false;
    document.getElementById('age_20').checked = false;
    document.getElementById('age_30').checked = false;
    document.getElementById('age_40').checked = false;
    document.getElementById('age_50').checked = false;
    document.getElementById('university').checked = false;
    document.getElementById('college').checked = false;
    document.getElementById('1').checked = false;
    document.getElementById('2').checked = false;
    document.getElementById('3').checked = false;
    document.getElementById('4').checked = false;
    document.getElementById('5').checked = false;
    document.getElementById('6').checked = false;
    document.getElementById('7').checked = false;
    document.getElementById('8').checked = false;
    document.getElementById('9').checked = false;
    document.getElementById('10').checked = false;
    document.getElementById('11').checked = false;
    document.getElementById('12').checked = false;
    document.getElementById('other-education').checked = true;
    document.getElementById('other-hope_salary').checked = true;
    document.getElementById('other-career').checked = true;

    $("[name='boardSearchForm']").find("[name='field_code']").val("");
    $(".searchBtn").click();
    
}
function goresumeListDetailForm(p_no,resume_no){
	$("[name='resumeListDetailForm']").find("[name='p_no']").val(p_no);
	$("[name='resumeListDetailForm']").find("[name='resume_no']").val(resume_no);

	document.resumeListDetailForm.submit();

}
function handleUncheckAge(groupName, otherCheckboxId) {
	
     	document.getElementById('age_10').checked = false;
	    document.getElementById('age_20').checked = false;
	    document.getElementById('age_30').checked = false;
	    document.getElementById('age_40').checked = false;
	    document.getElementById('age_50').checked = false;

};
function handleCheckAge(groupName, checkboxId) {
	if(checkboxId!='other-age'){
	    document.getElementById('other-age').checked = false;

	}

};
function handleUncheckEdu(groupName, otherCheckboxId) {
	
 	document.getElementById('college').checked = false;
    document.getElementById('university').checked = false;


};
function handlecheckEdu(groupName, checkboxId) {
	if(checkboxId!='other-education'){
	    document.getElementById('other-education').checked = false;

	}

};

function pageNoClick(clickPageNo){
//		alert(clickPageNo);
	//---------------------------------------------
	// name='selectPageNo' 를 가진 태그의 value 값에 
	// 매개변수로 들어오는 [클릭한 페이지 번호]를 저장하기
	// 즉 <input type="hidden" name="selectPageNo" value="1"> 태그에
	// value 값에 [클릭한 페이지 번호]를 저장하기
	//---------------------------------------------
	$("[name='boardSearchForm']").find(".selectPageNo").val(clickPageNo);
	search();
}
// function uncheckOtherIfChecked(groupName, checkboxId) {
//     var checkboxes = document.getElementsByName(groupName);
//     checkboxes.forEach(function(checkbox) {
//         if (checkbox.id === checkboxId) {
//             if (checkbox.checked) {
//                 document.getElementById('other-' + groupName).checked = false;
//             }
//         } else {
//             checkbox.onchange = function() {
//                 document.getElementById('other-' + groupName).checked = false;
//             };
//         }
//     });
// }




</script>

</head>
<body>

		<%@ include file="header.jsp"%>


			<h1 style="text-align: center;">이력서 열람</h1>

			<form name="boardSearchForm" >
				<div style="text-align: center;">
			
					 <br>
								<h2>인재 검색</h2>
			<div class="fieldset-container" >
  			<fieldset>
    		<legend>성별 선택</legend>
    		<input type="radio" id="male" name="sex" value="남">
    		<label for="male">남성</label><br>
    		<input type="radio" id="female" name="sex" value="여">
    		<label for="female">여성</label><br>
    		<input type="radio" id="other-sex" name="sex" value=""  checked>
    		<label for="other-sex">무관</label>			
  			</fieldset>
  			 <fieldset>
            <legend>나이</legend>
            <input type="checkbox" id="age_10" name="age" value="10" onClick="handleCheckAge('age', 'age_10')" >
    		<label for="age_10">10대</label><br>
    		<input type="checkbox" id="age_20" name="age" value="20" onClick="handleCheckAge('age', 'age_20')">
    		<label for="age_20">20대</label><br>
    		<input type="checkbox" id="age_30" name="age" value="30"  onClick="handleCheckAge('age', 'age_30')">
    		<label for="age_30">30대</label><br>
    		<input type="checkbox" id="age_40" name="age" value="40"  onClick="handleCheckAge('age', 'age_40')">
    		<label for="age_40">40대</label><br>
    		<input type="checkbox" id="age_50" name="age" value="50" onClick="handleCheckAge('age', 'age_50')">
    		<label for="age_50">50대</label><br>
    		<input type="checkbox" id="other-age" name="age"  onClick="handleUncheckAge('age', 'other-age')"   value=""  checked>
    		<label for="other-age">무관</label>	           
            </fieldset>
  			<fieldset>
  			<legend>거주지 선택</legend>
  			<select name="sido" id="sido" class="sido"></select>
            <select name="gugun" id="gugun" class="gugun"></select>  
            </fieldset>
             <fieldset>
            <legend>최종 학력</legend>  
            	 <input type="checkbox" id="university" name="education" value="4년제 졸업"  onclick="handlecheckEdu('education', 'university')">
    			<label for="university">4년제 졸업</label><br>
    			<input type="checkbox" id="college" name="education" value="전문대 졸업" onclick="handlecheckEdu('education', 'college')">
    			<label for="college">전문대 졸업</label><br>
    			<input type="checkbox" id="other-education" name="education" onclick="handleUncheckEdu('education', 'other-education')"  value=""  checked>
    		<label for="other-education">무관</label>		          
            </fieldset>
            
            
            <fieldset>
            <legend>희망 급여</legend>
             <input type="radio"  id="salary2000" name="hope_salary" value="2000">
    		<label for="salary2000">2000 만원~ 2500 만원</label><br>
    		<input type="radio"  id="salary2500" name="hope_salary" value="2500">
    		<label for="salary2500">2500만원 ~ 3000만원</label><br>
    		<input type="radio"  id="salary3000" name="hope_salary" value="3000" >
    		<label for="salary3000">3000만원 ~ 3500만원</label><br>
    		<input type="radio"  id="salaryAll" name="hope_salary" value="3500" >
    		<label for="salaryAll">3500만원 이상</label><br> 
    		  <input type="radio"  id="other-hope_salary" name="hope_salary" value=""  checked>
    		<label for="other-hope_salary">무관</label>
            </fieldset>
            <fieldset>
            <legend>관심 분야</legend> 
            <select name='field_code'>
            		  <option value="" > 분야 선택 </option>
                      <option value="경영·사무"> 경영·사무 </option>
                      <option value="영업·고객상담"> 영업·고객상담 </option>
                      <option value="IT·인터넷"> IT·인터넷 </option>
                      <option value="디자인 "> 디자인 </option>
                      <option value="미디어"> 미디어 </option>
                      <option value="건설"> 건설 </option>
                      <option value="교육"> 교육 </option>
                      <option value="의료"> 의료 </option>
                      <option value="생산"> 생산 </option>          
                      </select> 
            </fieldset>
            
            <fieldset>
            <legend>경력 유/무</legend>
            <input type="radio" id="Y" name="career" value="Y">
    		<label for="Y">경력자</label><br>
            <input type="radio" id="newbie" name="career" value="newbie" >
    		<label for="newbie">신입</label><br>
			<input type="radio"  id="other-career" name="career"  onClick="careerReset();" value="" checked>
    		<label for="other-career">무관</label>
            
            </fieldset>
                   
            <fieldset>
            <legend>보유 스킬</legend> 
                   <div style="display: flex; flex-wrap: wrap;">
				        <label style="margin-right: 20px;"><input type="checkbox" name="skill_name" value="JAVA" id="1"> JAVA</label>
				        <label style="margin-right: 20px;"><input type="checkbox" name="skill_name" value="Servlet/JSP" id="2"> Servlet/JSP</label>
				        <label style="margin-right: 20px;"><input type="checkbox" name="skill_name" value="XML" id="3"> XML</label>
				        <label style="margin-right: 20px;"><input type="checkbox" name="skill_name" value="DataBase" id="4"> DataBase</label>
				        <label style="margin-right: 20px;"><input type="checkbox" name="skill_name" value="MVC" id="5"> MVC</label>
				        <label style="margin-right: 20px;"><input type="checkbox" name="skill_name" value="Spring" id="6"> Spring</label>
				        <label style="margin-right: 20px;"><input type="checkbox" name="skill_name" value="Front-End" id="7"> Front-End</label>
				        <label style="margin-right: 20px;"><input type="checkbox" name="skill_name" value="Excel" id="8"> Excel</label>
				        <label style="margin-right: 20px;"><input type="checkbox" name="skill_name" value="PPT" id="9"> PPT</label>
				        <label style="margin-right: 20px;"><input type="checkbox" name="skill_name" value="OS" id="10"> OS</label>
				        <label style="margin-right: 20px;"><input type="checkbox" name="skill_name" value="CAD" id="11"> CAD</label>
				        <label><input type="checkbox" name="skill_name" value="3D PRINTING" id="12"> 3D PRINTING</label>
				    </div>
            </fieldset>
     
            
  			</div >
  	<input type="hidden" name="selectPageNo" class="selectPageNo" value="1">
	<input type="hidden" name="rowCntPerPage" class="rowCntPerPage">
	<input type="button" value="검색" class="searchBtn" onclick="search()"></input>
	
	 <input type="button" value="초기화" class="resetBtn" onclick="searchReset()">
				</div>
				     
				

				<p align="right">
                <!-- 여기에 기업정보 업종같은 검색조건 넣기 -->
				</p>
			
			<br>
	<center>
    <select name="rowCntPerPage" class="rowCntPerPage" onChange="search()" >
		<option value="10">10</option>
		<option value="20">20</option>
		<option value="30">30</option>
    </select>행보기 &nbsp;&nbsp;&nbsp;
			</center>			
</form>

			<br>
	         <div class="boardListDiv" id="container">

				<form action="submit.php" method="POST">
					<table
						style="border: 1px solid black; margin-left: auto; margin-right: auto;">
							<th>번호</th>
							<th>회원 정보</th>
						
						
					       <c:forEach var="board" items="${requestScope.resumeList }"  varStatus="status">
					              <tr style="cursor:pointer" onClick= "goresumeListDetailForm(${board.p_no},${board.resume_no});">
					       				<td> ${requestScope.boardMap.begin_serialNo_desc - status.index}</td>
										<td>
									<div style="display: flex; align-items: center;">
										<img width="80" src="images/photo-1.jpg"
											style="margin-right: 10px;"> 
										&nbsp;&nbsp;&nbsp;&lt이름&gt &nbsp;&nbsp; ${board.name} <br>
										&nbsp;&nbsp;&nbsp;&lt나이&gt &nbsp;&nbsp; 만 ${board.age}  세    <br>
										&nbsp;&nbsp;&nbsp;&lt성별&gt &nbsp;&nbsp; ${board.sex}       <br>
										&nbsp;&nbsp;&nbsp;&lt주소&gt &nbsp;&nbsp; ${board.addr}    <br>
										&lt보유스킬&gt <c:if test="${empty board.skills}">없음</c:if> ${board.skills}    <br>
		                         
									</div>
						

								</td>
							
							</tr>
                             </c:forEach>				

					</table>

				</form>
				</div>
					
	<span class="pagingNos">			
	<c:if test="${empty requestScope.resumeList}">
						<center>
							<b> 조회할 데이터가 없습니다. </b>
						</center>
					</c:if>
					<center>
							<span style="cursor:pointer" 
				onClick="pageNoClick(1)">[처음]</span>
		<span style="cursor:pointer" 
				onClick="pageNoClick(${requestScope.boardMap.selectPageNo}-1)">[이전]</span>&nbsp;&nbsp;
		
		<!--------------------------------------------->
		<!--  [반복문 C코어 태그]를 사용하여 페이지 번호 출력하기 -->
		<!--------------------------------------------->
		<c:forEach var="pageNo"  begin = "${requestScope.boardMap.begin_pageNo}"    
								 end   = "${requestScope.boardMap.end_pageNo}">
			<!--------------------------------------------->
			<!--  만약에 [선택한 페이지 번호]와 [화면에 출력할 페이지 번호]가 같으면  -->
			<!--------------------------------------------->
			<c:if test="${requestScope.boardMap.selectPageNo==pageNo}">
				${pageNo}
			</c:if>
			<!--------------------------------------------->
			<!--  만약에 [선택한 페이지 번호]와 [화면에 출력할 페이지 번호]가 다르면  -->
			<!--------------------------------------------->
			<c:if test="${requestScope.boardMap.selectPageNo!=pageNo}">
				<span style="cursor:pointer" onClick="pageNoClick(${pageNo})">[${pageNo}]</span>
			</c:if>
		</c:forEach>&nbsp;&nbsp;
		<!--------------------------------------------->
		<!-- [다음] [마지막] 출력하기 -->
		<!--------------------------------------------->
		<span style="cursor:pointer" 
				onClick="pageNoClick(${requestScope.boardMap.selectPageNo}+1)">[다음]</span>
		<span style="cursor:pointer" 
				onClick="pageNoClick(${requestScope.boardMap.last_pageNo})">[마지막]</span>
		&nbsp;&nbsp;&nbsp;		
		<!--------------------------------------------->
		[${requestScope.resumeListCnt}/${requestScope.resumeListAllCnt}]개 	
		
		<!--------------------------------------------->
		&nbsp;&nbsp;


			    <form name="resumeListDetailForm" action="/resumeListDetail.do"	method="post">
						<!-- 클릭한 행의 게시판 고유번호가 저장될 히든태그 선언 -->
						<input type="hidden" name="p_no"  value="${board.p_no}">
						<input type="hidden" name="resume_no"  value="${board.resume_no}">						
		       </form>      
		<!--nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn-->
<!--- 게시판 페이징 번호 출력하기.  시작   -->
<!--nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn-->

		<!--------------------------------------------->
		<!-- [처음] [이전] 출력하기 -->
		<!--------------------------------------------->

<!--nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn-->
<!--- 게시판 페이징 번호 출력하기.  끝   -->
<!--nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn-->

	
	
</span>
		
</center>



</body>
<%@ include file="footer.jsp"%>
</html>
