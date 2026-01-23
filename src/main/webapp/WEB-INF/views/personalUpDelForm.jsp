<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@include file="/WEB-INF/views/common.jsp" %>

<!DOCTYPE html>
<html>

<head>
<style>
        .button-right {
            float: right;
        }
     
    .hidden-row {
        display: none;
  		}
	</style>
<script>

function showSelect(){
	 $(".hidden-row").css("display", "table-row");
	 $("#showMoreBtn").hide();
	 $("#addr1").removeAttr("name");
	 $("#addr2").removeAttr("name");
	 $("#addr3").removeAttr("name");
	 $("#addr1").val("");
	 $("#addr2").val("");
	 $("#addr3").val("");
}	
// 수정필

// (회원정보 수정버튼 함수)
function checkPrivacyUpForm(){
	var formObj  = $("[name='PrivacyUpDelForm']");
	
	
	if($("#addr1").val()!=""){				
    	$("select#sido1").removeAttr("name"); 	
    	$("select#gugun1").removeAttr("name"); 	
    	$("#addr").removeAttr("name"); 	
		
	}
// 	    var pwdObj   = formObj.find(".pwd");
//  	var contentObj   = formObj.find(".content");
	
// 	if( pwdObj.val().trim().length==0 ){
// 		alert("암호를 입력하십시요");
// 		pwdObj.val("");
// 		return;
// 	}


	if( confirm("정말 수정하시겠습니까?")==false ){ return; }

	$.ajax(
		{ 			
			url    : "/PrivacyUpProc.do"			
			,type  : "post"			
			,data  : formObj.serialize( )
			
			,success : function(json){
				var result = json["result"];
				if(result==-1){
					alert("암호가 틀립니다.");
					pwdObj.val("");
				}
				
				else if(result==0){
					alert(" .");
				}
				
				else{
					alert("개인정보 수정 성공입니다.");
					location.replace("/myPage.do");
				}
				
			}
			,error : function(){
				alert("수정 실패! 관리자에게 문의 바람니다.");
			}
		}
	);
}
//(회원정보 수정버튼 함수)
function checkPrivacyDelForm(){
	var formObj  = $("[name='PrivacyUpDelForm']");
	
	
// 	    var pwdObj   = formObj.find(".pwd");
//  	var contentObj   = formObj.find(".content");
	
// 	if( pwdObj.val().trim().length==0 ){
// 		alert("암호를 입력하십시요");
// 		pwdObj.val("");
// 		return;
// 	}
	if( confirm("정말 탈퇴하시겠습니까?")==false ){ return; }
	$.ajax(
		{ 			
			url    : "/PrivacyDelProc.do"			
			,type  : "post"			
			,data  : formObj.serialize( )
			
			,success : function(json){
				var result = json["result"];
				if(result==-1){
					alert("암호가 틀립니다.");
					pwdObj.val("");
				}
				
				else if(result==0){
					
					alert("삭제가 실패했습니다.");
				}
				
				else{
					alert("회원탈퇴 성공입니다.");
					location.replace("/loginForm.do");
				}
				
			}
			,error : function(){
				alert("탈퇴 실패! 관리자에게 문의 바람니다.");
			}
		}
	);
}
	</script>
</head>


<body>

 <div id="container" > 
    
   <%@ include file="header.jsp" %>


 <div class="container"  id="wrap">
     <h1 style="text-align: center;">[개인정보 수정페이지]</h1>

    <center>
       	<form name="PrivacyUpDelForm">
          <table> 
           
       <tr>
             <th>항목</th>
             <th>등록 사항</th>
         </tr>
         
        <tr>
                <td>닉네임:</td>
                <td><input type="text" id="nickname" name="nickname" value="${requestScope.mypageDTO.nickname}"  required></td>
            </tr>  
         
         <tr>
             <td>아이디:</td>
             <td>${requestScope.mypageDTO.pid}</td>
         </tr>  

        <tr>
            <td>이 름:</td>
            <td>${requestScope.mypageDTO.name} </td>
        </tr> 
       
        
<tr>
    <td>성별</td>
    <td>
        <input type="radio" id="sex_male" name="sex" value="남" 
            <c:if test="${requestScope.mypageDTO.sex == '남'}">checked</c:if> disabled>남
        <input type="radio" id="sex_female" name="sex" value="여" 
            <c:if test="${requestScope.mypageDTO.sex == '여'}">checked</c:if> disabled>여
    </td>
</tr>

	
        
        <tr>
            <td>휴대폰 번호:</td>
            <td><input type="text" id="phone" name="phone" value="${requestScope.mypageDTO.phone}"  required></td>
        </tr> 
        
<!-- 	<tr> -->
<!-- 	    <td>주민 번호</td> -->
<%-- 	    <td> ${requestScope.mypageDTO.jumin_num} </td> --%>
<!-- 	</tr> -->
            
        <tr>
                <td> 주소</td>
                <td id="showMoreBtn">${requestScope.mypageDTO.addr } &nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="수정" onClick="showSelect()"></td>
						<td class="hidden-row">
							<select name="addr1" id="sido1"></select> <select
							name="addr2" id="gugun1"></select>&nbsp; <input type="text"
							name="addr3" id="addr" 
							onfocus="if(this.value=='나머지 상세주소') this.value='';">
							</td>
        </tr>


<tr>
    <td>email:</td>
    <td>
        <input type="text" id="email1" name="email1"  
               value="${fn:substringBefore(requestScope.mypageDTO.email, '@')}">@
        <select name="email2">
            <option value="naver.com" <c:if test="${requestScope.mypageDTO.email2 == 'naver.com'}">selected</c:if>>naver.com</option>
            <option value="daum.net"   <c:if test="${requestScope.mypageDTO.email2 == 'daum.net'}">selected</c:if>>daum.net</option>
            <option value=""                    <c:if test="${requestScope.mypageDTO.email2 == ''}">selected</c:if>>직접입력</option>
        </select>
    </td>
</tr>

<%--  ${mypageDTO.email} --%>
              
<tr>
    <td>취업여부:</td>
    <td>
        <input type="radio" id="is_job_Y" value="Y" name="is_job" 
            <c:if test="${requestScope.mypageDTO.is_job == 'Y'}">checked</c:if>>
        <label for="is_job_Y">Y</label>
                                
        <input type="radio" id="is_job_N" value="N" name="is_job" 
            <c:if test="${requestScope.mypageDTO.is_job == 'N'}">checked</c:if>>
        <label for="is_job_N">N</label>
    </td>
</tr>
            

         <tr>
    <td>관심분야:</td>
    <td>
        <select name='field_code'>
            <option value="1" <c:if test="${requestScope.mypageDTO.field_code == '1'}">selected</c:if>>경영·사무</option>
            <option value="2" <c:if test="${requestScope.mypageDTO.field_code == '2'}">selected</c:if>>영업·고객상담</option>
            <option value="3" <c:if test="${requestScope.mypageDTO.field_code == '3'}">selected</c:if>>IT·인터넷</option>
            <option value="4" <c:if test="${requestScope.mypageDTO.field_code == '4'}">selected</c:if>>디자인</option>
            <option value="5" <c:if test="${requestScope.mypageDTO.field_code == '5'}">selected</c:if>>미디어</option>
            <option value="6" <c:if test="${requestScope.mypageDTO.field_code == '6'}">selected</c:if>>건설</option>
            <option value="7" <c:if test="${requestScope.mypageDTO.field_code == '7'}">selected</c:if>>교육</option>
            <option value="8" <c:if test="${requestScope.mypageDTO.field_code == '8'}">selected</c:if>>의료</option>
            <option value="9" <c:if test="${requestScope.mypageDTO.field_code == '9'}">selected</c:if>>생산</option>
        </select>
    </td>
</tr>

         <tr>
           <td>패스워드:</td>
           <td><input type="password" id="pwd" name="pwd"   required></td>
       </tr>
       
            <input type="hidden" name="p_no" value="${sessionScope.p_no}">
    </table>
		<input type="hidden" id="addr1" name="addr1" value="${addr1}">
		<input type="hidden" id="addr2" name="addr2" value="${addr2}">
		<input type="hidden" id="addr3" name="addr3" value="${addr3}"> 
		<center>
          <input type="button" value="수정" onClick="checkPrivacyUpForm();">
          <input type="button" value="회원탈퇴" onClick="checkPrivacyDelForm();"> 
<!--           <input type="button" value=회원탈퇴 onClick="()"> -->
		</center>
          
          
     
          
         <form name="MyPageForm"  action="/myPage.do"  method="post">
             <input type="hidden" name="p_no" value="${sessionScope.p_no}">
         
      </form>
          
             <input type="hidden" name="p_no" value="${sessionScope.p_no}">
          
      </form>
     </div>
  </div>
</body>

<%@ include file="footer.jsp" %>
</html>
				