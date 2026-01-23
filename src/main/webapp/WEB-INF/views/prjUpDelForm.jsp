<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@include file="/WEB-INF/views/common.jsp"%>  

<!DOCTYPE html>
<html>

<head>

  <script>
  function checkPrjUpForm(){
	  
	  	var formObj 			= $("[name='prjUpDelForm']");
		var subjectObj 			= formObj.find(".subject");
		var reg_dateObj 		= formObj.find(".reg_date");
		var project_typeObj 	= formObj.find(".project_type");
		var people_toObj 		= formObj.find(".people_to");
		var start_timeObj 		= formObj.find(".start_time");
		var end_timeObj 		= formObj.find(".end_time");
		var pwdObj 				= formObj.find(".pwd");
	  
	  if(confirm("정말 수정 하시겠습니까?")==false) {return;}
		//-----------------------------------------------------
		// JQuery 객체의 [ajax 메소드]를 호출하여
		// 페이지 이동없이(=현 화면 고정) 
		// WAS 와 비동기 방식으로 통신하고 얻은 데이터를 현재 화면에 반영한다.
		//-----------------------------------------------------
		//-----------------------------------------------------
		// JQuery 객체의 [ajax 메소드]를 호출하여
		// WAS 에 "/boardUpProc.do" 주소로 접속하고 
		// 게시판 수정 결과를 받아서
		// 성공했으면 경고하고 게시판 목록화면으로 이동하고
		// 실패했으면 경고하기
		//-----------------------------------------------------
		alert(formObj.serialize());
		$.ajax(
			{ 
				//--------------------------------------
				// WAS 에 접속할 URL 주소 지정
				//--------------------------------------
				url	: "/prjUpProc.do"
				//--------------------------------------
				// 파라미터값을 보내는 방법 지정
				//--------------------------------------
				,type : "post"
				,data : new FormData(formObj.get(0))				
				,processData: false
				,contentType: false
				//----------------------------------------------------------
				// WAS 의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
				// 이때 익명함수의 매개변수로 WAS 의 응답물이 들어 온다.
				//----------------------------------------------------------
				,success : function(json){
					var result = json["result"];
					if(result==-1){
						alert("암호가 틀립니다.")
						pwdObj.val("")
					}
					
// 					else if(result==0){
// 						alert("삭제된 게시글 입니다.");
// 						location.replace("/prj.do")
// 					}
					
					else if(result==-2){
						alert("삭제된 게시판 입니다.")
						location.replace("/prj.do")
					}
					else if(result==0){
						alert("수정 실패입니다.");
					}
					else{
						alert("수정 성공입니다.")
						location.replace("/prj.do")
					}
				}
				//----------------------------------------------------------
				// WAS 의 응답이 실패했을 실행할 익명함수 설정.
				//----------------------------------------------------------
				,error : function(){
						alert("수정 실패! 관리자에게 문의 바랍니다.");
				}
			}
		);
	}
	
	function checkPrjDelForm(){
	
		var formObj 	= $("[name='prjUpDelForm']");
		var pwdObj 		= formObj.find(".pwd");
		//-----------------------------------------------
		if(pwdObj.val().trim().length==0){
			alert("암호를 입력하십시오.");
			pwdObj.val("");
			return;
		}
		
		if(confirm("정말 삭제 하시겠습니까?")==false) {return;}
		//-----------------------------------------------------
		// JQuery 객체의 [ajax 메소드]를 호출하여
		// WAS 에 "/boardDelProc.do" 주소로 접속하고 
		// 게시판 수정 결과를 받아서
		// 성공했으면 경고하고 게시판 목록화면으로 이동하고
		// 실패했으면 경고하기
		//-----------------------------------------------------
		$.ajax(
				{ 
					//--------------------------------------
					// WAS 에 접속할 URL 주소 지정
					//--------------------------------------
					url	: "/prjDelProc.do"
					//--------------------------------------
					// 파라미터값을 보내는 방법 지정
					//--------------------------------------
					,type : "post"
					//--------------------------------------
					// WAS 에 보낼 파명과 파값을 설정하기. "파명=파값&파명=파값~"
					//--------------------------------------
					,data : formObj.serialize()
					//----------------------------------------------------------
					// WAS 의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
					// 이때 익명함수의 매개변수로 WAS 의 응답물이 들어 온다.
					//----------------------------------------------------------
					,success : function(json){
						var result = json["result"];
						if(result==-1){
							alert("암호가 틀립니다.")
							pwdObj.val("")
						}
						else if(result==0){
							alert("삭제된 게시판 입니다.")
							location.replace("/prj.do")
						}
						else{
							alert("게시판 삭제 성공입니다.")
							location.replace("/prj.do")
						}
					}
					//----------------------------------------------------------
					// WAS 의 응답이 실패했을 실행할 익명함수 설정.
					//----------------------------------------------------------
					,error : function(){
							alert("삭제 실패! 관리자에게 문의 바랍니다.");
					}
				}
			);
		}
  
	
  </script>
</head>
<body>
    <div id="container">    
 <%@ include file="header.jsp" %>



    <center>
    
  <form name="prjUpDelForm"  >
   <table align="center" border="1" cellpadding="7" style="border-collapse:collapse">
   		<br>
        <h1 style="text-align: center;">프로젝트 수정/삭제</h1>
        <br> 
       	<tr>
            <th>제목</th>
            <td style="width: 500px;">
            <input type="text" name="subject" class="subject" size="10" maxlength="15"
							value="${requestScope.boardDTO.subject}">
			</td>
        </tr>
        
        <tr>
            <th>작성일</th>
            <td>${requestScope.boardDTO.reg_date}</td>
        </tr>   
        
        <tr>
            <th>프로젝트 분야</th>
            <td>
            	<select name="field_code" id="field_code" class="field_code">
				    <option value="1" <c:if test="${boardDTO.field_code == 1}">selected</c:if>>IT·인터넷</option>
				    <option value="2" <c:if test="${boardDTO.field_code == 2}">selected</c:if>>디자인</option>
				    <option value="3" <c:if test="${boardDTO.field_code == 3}">selected</c:if>>미디어</option>
				    <option value="4" <c:if test="${boardDTO.field_code == 4}">selected</c:if>>교육</option>
				    <option value="5" <c:if test="${boardDTO.field_code == 5}">selected</c:if>>의료</option>
				</select>
            </td>
        </tr>
         
        <tr>
		    <th>프로젝트 종류</th>   
		    <td>
		        <input type="radio" name="project_type" value="개인" 
		            <c:if test="${requestScope.boardDTO.project_type == '개인'}">checked</c:if>> 개인 
		        <input type="radio" name="project_type" value="공모전" 
		            <c:if test="${requestScope.boardDTO.project_type == '공모전'}">checked</c:if>> 공모전
		    </td>       
		</tr>
        
	    <tr>
            <th>모집인원</th>   
            <td> 
                <input type="number" id="people_to" name="people_to" min="1" max="100" required oninput="checkNumber()"
                	value=${requestScope.boardDTO.people_to}> 명
            </td>
        </tr>
	    
	    <tr>
            <th>기간</th>
            <td>
                <label for="prjstartdate">시작일:</label> 
                <input type="date" id="prjstartdate" name="start_time" min="2000-01-01" max="2050-12-31" 
                	value="${requestScope.boardDTO.start_time}"/>
                ~
                <label for="prjenddate">마감일:</label> 
                <input type="date" id="prjenddate" name="end_time" min="2000-01-01" max="2050-12-31" 
                	value="${requestScope.boardDTO.end_time}"/>
            </td>
        </tr>
        <tr>
            <th>요구기술</th>
            <td>
            	<select name="skill_name" id="skill_name" class="skill_name" value="${requestScope.boardDTO.skill_name}">
            		<option value="JAVA" 		<c:if test="${boardDTO.skill_name == 'JAVA'}">selected</c:if>>JAVA</option>
				    <option value="Servlet/JSP" <c:if test="${boardDTO.skill_name == 'Servlet/JSP'}">selected</c:if>>Servlet/JSP</option>
				    <option value="XML" 		<c:if test="${boardDTO.skill_name == 'XML'}">selected</c:if>>XML</option>
				    <option value="DataBase" 	<c:if test="${boardDTO.skill_name == 'DataBase'}">selected</c:if>>DataBase</option>
				    <option value="MVC" 		<c:if test="${boardDTO.skill_name == 'MVC'}">selected</c:if>>MVC</option>
				    <option value="Spring"		<c:if test="${boardDTO.skill_name == 'Spring'}">selected</c:if>>Spring</option>
				    <option value="Front-End" 	<c:if test="${boardDTO.skill_name == 'Front-End'}">selected</c:if>>Front-End</option>
				    <option value="Excel" 		<c:if test="${boardDTO.skill_name == 'Excel'}">selected</c:if>>Excel</option>
				    <option value="PPT" 		<c:if test="${boardDTO.skill_name == 'PPT'}">selected</c:if>>PPT</option>
				    <option value="OS"			<c:if test="${boardDTO.skill_name == 'OS'}">selected</c:if>>OS</option>
				</select>
            </td>
        </tr>
        
                <tr>
             <th>내용</th>
              <!-------------------------------------------------------->		
    		 <td><textarea name="content"  style="width:80%; height:80%;"rows="4" cols="50" placeholder="최대 500자 까지 입력가능합니다.">${requestScope.boardDTO.content}</textarea>  </td>
    		  <!-------------------------------------------------------->		
           </tr>
        

        
        
             <tr>
		    <th>이미지</th>
		      <td>
			      <c:if test ="${!empty requestScope.boardDTO.img_name}">
			    	  <img src="/img/${requestScope.boardDTO.img_name}"   height="400px"> 
			    	  <br>
			    	  <input type= "checkbox" name= "isdel" value="del">기존파일삭제
			    	  <br>
			      </c:if>
			       <input type="file" name="img"> 
		      </td>
		</tr>            
  		
  		<tr>
            <th>비밀번호</th>
            <td>
                <input  type="password" name="pwd" class="pwd">
            </td>
        </tr>
  		
		</table>
			<input type="hidden" name="prj_no" value="${requestScope.boardDTO.prj_no}">
			<input type="hidden" name="p_no" value="${requestScope.boardDTO.p_no}">
		</form>
		
		<br>
        <input type="button" onClick="location.replace('/prj.do')" value=" 목록으로 ">
        <input type="button" value="수정" onclick="checkPrjUpForm();">
		<input type="button" value="삭제" onclick="checkPrjDelForm();">
        </center>
        <br>
        
          
        
</body>
<%@ include file="footer.jsp" %>
</html>
