<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@include file="/WEB-INF/views/common.jsp"%>  


<!DOCTYPE html>
<html>

<head>
<script>
function checkmemberRegForm(){
	   var formObj = $("[name='memRegForm']");
	   
	   
	$.ajax(
	      { 
	         
	         url    : "/memProc.do"
	         
	         ,type  : "post"
	         
	         ,data  : formObj.serialize( )
	         
	         ,success : function(json){
	            var result = json["result"];
	            
	            
	            if(result==1){
	               alert("가입 성공입니다.");
	               alert("로그인 후 이력서 등록 후 사용바랍니다.")
	               location.replace("/loginForm.do")
	            }
	            else if(result==2){
	               alert("아이디가 중복 됩니다. 재 입력 바람.")
	               $(".id").val("");
	            }else{
	               alert("입력 실패.");
	            }
	         }
	         //----------------------------------------------------------
	         // WAS 의 응답이 실패했을 실행할 익명함수 설정.
	         //----------------------------------------------------------
	         ,error : function(){
	            alert("회원가입 실패! 관리자에게 문의 바람니다.");
	         }
	      }
	   );
	}
</script>
  
</head>
<body>
    <div id="container">    
 <%@ include file="header.jsp" %>

 <div class="container">
      <h1 style="text-align: center;">개인 회원가입</h1>
      <form action="submit.php" method="POST" name="memRegForm">
      
          <table style="margin: 0 auto;">
              
       <tr>
             <th>항목</th>
             <th>등록 사항</th>
         </tr>
         
         <tr>
             <td>아이디:</td>
             <td><input type="text" id="pid" name="pid"  required></td>
         </tr>  
               
         <tr>
           <td>패스워드:</td>
           <td><input type="password" id="pwd" name="pwd"  required></td>
       </tr>
          
        <tr>
            <td>이 름:</td>
            <td><input type="text" id="name" name="name" required></td>
        </tr> 
        
        <tr>
            <td>휴대폰 번호:</td>
            <td><input type="text" id="phone" name="phone"  required></td>
        </tr> 
        <tr>
            <td>주민 번호</td>
            <td><input type="text" id="jumin_num1" name="jumin_num1" required> - 
               <input type="password" id="jumin_num2" name="jumin_num2"  required>
                                                                  </td>
        </tr> 
            
        <tr>
                <td> 주소</td>
                <td><select name="addr1" id="sido1" value="addr"></select>
                  <select name="addr2" id="gugun1" value="addr"></select>&nbsp; 
                  <input type="text" name="addr3" id="addr" value="나머지 상세주소" onfocus="if(this.value=='나머지 상세주소') this.value='';"></td>
        </tr>

   
              <tr>
                  <td>email:</td>
                  <td><input type="text" id="email1" name="email1" required> @ 
                  <select  name="email2">
                      <option value="@ naver. com "> naver. com </option>
                      <option value="@ daum. net "> daum. net </option>
                      <option value=""> 직접입력 </option>
                  </select>

                  </td>
              </tr>
              <tr>
                <td>취업여부:</td>
                <td><input type="radio" id="is_job" value="Y" name="is_job" >
                    <label for="is_job">Y</label>
                    <input type="radio" id="is_job" value="N" name="is_job" >
                    <label for="is_job">N</label>
            </tr>  
            <tr>
                <td>닉네임:</td>
                <td><input type="text" id="nickname" name="nickname" required></td>
            </tr> 
               <tr>
                <td>성별</td>
                <td><input type="radio" id="sex" name="sex" value="남" >남
                   <input type="radio" id="sex" name="sex" value="여" >여
                   
                </td>
            </tr>
               <tr>
                <td>관심분야:</td>
                <td><select name='field_code'>
								<option value="1">경영·사무</option>
								<option value="2">영업·고객상담</option>
								<option value="3">IT·인터넷</option>
								<option value="4">디자인</option>
								<option value="5">미디어</option>
								<option value="6">건설</option>
								<option value="7">교육</option>
								<option value="8">의료</option>
								<option value="9">생산</option>
								<option value="10">금융</option>
								<option value="11">법률</option>
								<option value="12">마케팅</option>
								<option value="13">공공서비스</option>
								<option value="14">연구·개발</option>
								<option value="15">물류·운송</option>
								<option value="16">예술·문화</option>
								<option value="17">환경</option>
								<option value="18">자원·에너지</option>
								<option value="19">숙박·요식업</option>
								<option value="20">스포츠·레저</option>
								<option value="21">제조·생산</option>
								<option value="22">농업·수산업</option>
								<option value="23">해양·항공</option>
						</select></tr> 
              
            
          </table>

		<center>
          <input type="button" value="가입하기" onClick="checkmemberRegForm()">
		</center>
          
      </form>
  </div>
       
</body>
<%@ include file="footer.jsp" %>
</html>
