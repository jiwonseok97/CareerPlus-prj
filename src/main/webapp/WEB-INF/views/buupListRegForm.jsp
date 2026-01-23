<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/common.jsp" %>
<!DOCTYPE html>
<html>

<head>
	<script>
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// 등록 버튼을 클릭하면 호출되는 함수
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	function checkbuupReg(){

	var formObj    = $("[name='buupRegForm']");
	
		var subjectObj     = $("[name='subject']").val();
		var pwdObj         = $("[name='pwd']").val();
		var contentObj     = $("[name='content']").val();
		var hopeworkObj    = $("[name='hope_work']").val();
		var startTimeObj   = $("[name='start_time']").val();
		var endTimeObj     = $("[name='end_time']").val();
		var startDateObj   = $("[name='start_date']").val();
		var endDateObj     = $("[name='end_date']").val();

		//----------------------------------------------
		// 제목의 문자 패턴 검사하기
		//----------------------------------------------
		if (!/^.{2,30}$/.test(subjectObj)) {
			alert("제목은 임의 문자 2~30자 입력해야 합니다.");
			$("[name='subject']").val("").focus();
			return;
		}

		
		//----------------------------------------------
		// 희망업무 문자 패턴 검사하기
		//----------------------------------------------
		if (hopeworkObj.trim().length < 10) {
			alert("희망업무는 최소 10자 이상 입력해야 합니다.");
			return;
		}

		//----------------------------------------------
		// 희망근무 시간 선택 여부 검사하기
		//----------------------------------------------
		if (!startTimeObj || !endTimeObj) {
			alert("희망 근무 시간을 선택해 주세요.");
			return;
		}

		//----------------------------------------------
		// 지원 기간 선택 여부 검사하기
		//----------------------------------------------
		if (!startDateObj || !endDateObj) {
			alert("지원 기간을 선택해 주세요.");
			return;
		}
		//----------------------------------------------
		// 내용 문자 패턴 검사하기
		//----------------------------------------------
		if (contentObj.trim().length == 0 || contentObj.trim().length > 500) {
			alert("내용은 임의 문자 1~500자 입력해야 합니다.");
			return;
		}
		
		//----------------------------------------------
		// 암호 패턴 검사하기
		//----------------------------------------------
		if (!/^\d{4}$/.test(pwdObj.trim())) {
			alert("암호는 공백 없이 4자리 숫자여야 합니다.");
			$("[name='pwd']").val("").focus();
			return;
		}
		
		//----------------------------------------------
		// 정말 등록할 건지 확인하기
		//----------------------------------------------
		if( confirm("정말 등록하시겠습니까?")==false ){ return; }
		//-----------------------------------------------------
		// JQuery 객체의 [ajax 메소드]를 호출하여
		// WAS 에 비동기 방식으로 "/boardRegProc.do" 주소로 접속하고 
		// 게시판 입력 결과를 받아서
		// 성공했으면 경고하고 게시판 목록화면으로 이동하고
		// 실패했으면 경고하기
		//-----------------------------------------------------
		$.ajax(
			{ 
				//--------------------------------------
				// WAS 에 접속할 URL 주소 지정
				//--------------------------------------
				url    : "/buupListRegProc.do"
				//--------------------------------------
				// 파라미터값을 보내는 방법 지정
				//--------------------------------------
				,type  : "post"
			
				
				//
				,data : new FormData(formObj.get(0))				
				,processData: false
				,contentType: false
		
				//----------------------------------------------------------
				// WAS 의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
				// 이때 익명함수의 매개변수로 WAS 의 응답물이 들어 온다.
				//----------------------------------------------------------
				,success : function(json){
					var result = json["result"];
					if(result==1){
						alert("부업 등록 성공입니다.");
						location.replace('/buupList.do');
					}
					
					
					
					else if(result==-11){
						alert("선택한 파일크기가 1M가 넘습니다.");
					}
					else if(result==-12){
						alert("선택한 파일확장자는 jpg,jpeg,png이어야 합니다.");
					}
					

					
					else{
						alert("부업 등록 실패입니다. 관리자에게 문의 바람!");
					}
				}
				//----------------------------------------------------------
				// WAS 의 응답이 실패했을 실행할 익명함수 설정.
				//----------------------------------------------------------
				,error : function(){
					alert("입력 실패! 관리자에게 문의 바람니다.");
				}
			}
		);
	}	
	</script>
</head>

<body>
 
 <div class="container"  id="wrap">
    
  <%@ include file="header.jsp" %>
 <br>
     <h1 style="text-align: center;">부업 등록</h1>
     <form name= "buupRegForm">
      <center>
          <table>
          
             <tr>
                 <th>항목</th>
                 <th>등록 사항</th>
             </tr>
                
         
        <tr>
          <td>제목</td>
        <td>
            <input type="text" id="subject" name="subject" placeholder="제목을 입력해주세요">
        </td>
     </tr>
   
       
	     <tr>
	        <td>희망업무</td>
	        <td>
	            <input type="text" id="hope_work" name="hope_work" >
	        </td>
	     </tr>
     
       <tr> 
	        <td>희망근무시간</td>   
	         <td>        
                <select name="start_time" class="start_time">
				    <% for (int i = 1; i <= 24; i++) { %>
				        <option value="<%= i %>"><%= String.format("%02d", i) %></option>
				    <% } %>
			      
				</select>
				시~
				<select name="end_time" class="end_time">
				    <% for (int i = 1; i <= 24; i++) { %>
				        <option value="<%= i %>"><%= String.format("%02d", i) %></option>
				    <% } %>
				</select>
				시
                </td>
             </tr>   
    
    		 <tr>
                 <td>지원 기간</td>
                <td><label for="start_date">시작일:</label> 
            <input type="date" id="start_date" name="start_date"  min="2024-01-01" max="2030-12-31" />
                ~
                <label for="end_date">마감일:</label> 
            <input type="date" id="end_date" name="end_date"  min="2024-01-01" max="2030-12-31" />
                 </td>
             </tr>
             
            <tr>
               <td>내용</td>
               <td>
                  <textarea name="content" textarea style="width:80%; height:80%;" rows="4" placeholder="최대 500자까지 입력가능합니다."></textarea>
               </td>
            <tr>  
         
 			<tr>
				<td>이미지</td>
				<td>
				<!-------------------------------------------------------->
				<input type="file" name="img">
				<!-------------------------------------------------------->
				</td>
			</tr>
            
	      <tr>
	        <td>암호</td>
	        <td>
	            <input type="password" id="pwd" name="pwd"  size="4"  maxlength="4" placeholder="최대 4자리">
	        </td>
	     </tr>
                     <input type="hidden" name="p_no" value="${sessionScope.p_no}">   
         </table>
          
          <input type="button" value="등록" onClick="checkbuupReg()">
     </center>
   </form>
 </div>     
       
</body>
 <%@ include file="footer.jsp" %>
</html>
