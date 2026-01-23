<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/common.jsp" %>

<!DOCTYPE html>
<html>

<head>
<script>

// (부업 수정버튼 함수)
function checkbuupUpForm(){
	var formObj  = $("[name='buupUpDelForm']");
	var pwdObj   = formObj.find(".pwd");
	var contentObj   = formObj.find(".content");
	
	if( pwdObj.val().trim().length==0 ){
		alert("암호를 입력하십시요");
		pwdObj.val("");
		return;
	}
	
	/* 	
	if( 
			contentObj.val().trim().length==0 
			||
			contentObj.val().trim().length>500 
	){
		alert("내용은 임의 문자 1~500자 입력해야합니다.");
		return;
	}
	
 
	//----------------------------------------------
	var nameObj      = formObj.find(".name");
	var phoneObj     = formObj.find(".phone");
	var hope_workObj = formObj.find(".hope_work");
	
	//----------------------------------------------
	if( new RegExp(/^[가-힣]{2,15}$/).test(writerObj.val())==false ){
		alert("이름은 2~15자 한글이어야합니다.");
		nameObj.val("");
		return;
	}
	
	if( new RegExp( /^010[0-9]{4}[0-9]{4}$/).test(phoneObj.val())==false ){
	alert("휴대폰 번호는 010 제외 8자리 숫자로 채워야합니다.");
	phoneObj.val("");
	return;
	}
	
	if( 
	hope_work.val().trim().length==0 
	||
	hope_work.val().trim().length>4
	){
	alert("희망업무는 임의 문자 1~4자 입력해야합니다.");
	return;
	}
*/
	
	if( confirm("정말 수정하시겠습니까?")==false ){ return; }

	
	$.ajax(
		{ 			
			url    : "/buupUpProc.do"			
			,type  : "post"			
			
			,data : new FormData(formObj.get(0))				
			,processData: false
			,contentType: false
			
			,success : function(json){
				var result = json["result"];
				if(result==-1){
					alert("암호가 틀립니다.");
					pwdObj.val("");
				}
				
				else if(result==0){
					alert("삭제된 게시글 입니다.");
					location.replace("/buupList.do");
				}
				
				else{
					alert("게시글 수정 성공입니다.");
					location.replace("/buupList.do");
				}
				
			}
			,error : function(){
				alert("수정 실패! 관리자에게 문의 바람니다.");
			}
		}
	);
}


//(부업 삭제버튼 함수)
function checkbuupDelForm(){
	//----------------------------------------------
	var formObj    = $("[name='buupUpDelForm']");
	var pwdObj     = formObj.find(".pwd");
	//----------------------------------------------
	if( pwdObj.val().trim().length==0 ){
		alert("암호를 입력하십시요");
		pwdObj.val("");
		return;
	}
	if( confirm("정말 삭제 하시겠습니까?")==false ){ return; }
	
	$.ajax(
		{ 	
			url    : "/buupDelProc.do"			
			,type  : "post"
			,data  : formObj.serialize( )
			
			,success : function(json){
				var result = json["result"];
				if(result==-1){
					alert("암호가 틀립니다.");
				}
				else if(result==0){
					alert("삭제된 글 입니다.")
					location.replace("/buupList.do");
				}
				else{
					alert("게시글 삭제 성공입니다.")
					location.replace("/buupList.do");
				}
			}
		
			,error : function(){
				alert("삭제 실패! 관리자에게 문의 바람니다.");
			}
		}
	);
}
	</script>
</head>


<body>

 <div id="container" > 
    
   <%@ include file="header.jsp" %>

     <h1 style="text-align: center;">[부업 수정/삭제 페이지]</h1>

       <center>
       	<form name="buupUpDelForm">
          <table> 
           
           <tr>
               <th style="height: 40px; width: 200px;">항목</th>
               <th>등록 사항</th>
           </tr>
           
             <tr>
			    <td>제목</td>
			     <!-------------------------------------------------------->		
			    <td><input type="text" name="subject" class="subject" value="${requestScope.buupDTO.subject}"> </td>
			     <!-------------------------------------------------------->		 
			</tr>
            
  
            
	          <!-- select값 꺼내오기 수정중 -->           
<!-- 	          <tr>     -->
<!-- 	            <td>주소</td> -->
<!-- 	            <td> -->
<!-- 	                <select name="addr1" id="sido1"></select> -->
<!-- 	                <select name="addr2" id="gugun1"></select>  -->
<!-- 	                <input type="text" name="addr3" id="detailadress" value="나머지 상세주소" onfocus="if(this.value=='나머지 상세주소') this.value='';"> -->
<!-- 	            </td> -->
<!-- 	         </tr> -->
                   
            
			
			
       		  <tr>     
                <td>희망업무</td>
               <td>
					<!-------------------------------------------------------->
					<input type="text" name="hope_work" class="hope_work" size="10" maxlength="15" 
									value="${requestScope.buupDTO.hope_work}">
					<!-------------------------------------------------------->
				</td>  
			</tr>
                  
  		
  		<!-- select값 꺼내오기 수정중 -->          
  		 <tr> 
	        <td>희망근무시간</td>   
	         <td>    
	             
	         <select name="start_time" class="start_time"  value="${requestScope.buupDTO.start_time}">
	          <% for (int i = 1; i <= 24; i++) { %>
				        <option value="<%= i %>"><%= String.format("%02d", i) %></option>
				    <% } %>
	        </select>
					  
			      
				</select>
				시~
				<select name="end_time" class="end_time"  value="${requestScope.buupDTO.end_time}">
				    <% for (int i = 1; i <= 24; i++) { %>
				        <option value="<%= i %>"><%= String.format("%02d", i) %></option>
				    <% } %>
				</select>
				시
                </td>
             </tr>   
   			
   		     <tr>
                 <td>지원 기간</td>
                 <!-------------------------------------------------------->
                <td><label for="start_date">시작일:</label> 
            		<input type="date" id="start_date" name="start_date" value=${requestScope.buupDTO.start_date} min="2024-01-01" max="2030-12-31" />
               		 ~
                	<label for="end_date">마감일:</label> 
           		    <input type="date" id="end_date" name="end_date" value=${requestScope.buupDTO.end_date}  min="2024-01-01" max="2030-12-31" />
                 </td>
                 <!-------------------------------------------------------->
             </tr>
 
             
           <tr>
             <td>내용</td>
             <td>
              <div style="height: 100px;">
    				<textarea name="content"  style="width:80%; height:80%;"rows="4" cols="50">${requestScope.buupDTO.content}</textarea>
			  </div>
             </td>
           </tr>
           
           
	          <tr>
			    <td>이미지</td>
			      <td>
				      <c:if test ="${!empty requestScope.buupDTO.img_name}">
				    	  <img src="/img/${requestScope.buupDTO.img_name}"   height="400px"> 
				    	  <br>
				    	  <input type= "checkbox" name= "isdel" value="del">기존파일삭제
				    	  <br>
				      </c:if>
				       <input type="file" name="img"> 
			      </td>
			</tr>           
	                               
		     <tr>
			    <td>암호</td>
			    <td><input type="password" name="pwd" class="pwd"  size="4"  maxlength="4"> </td> 
			</tr>  
			
			    	<input type="hidden" name="b_no" value="${requestScope.buupDTO.b_no}">
				   <input type="hidden" name="p_no" value="${sessionScope.p_no}">   
        </table>

	              <center>
	                 <span style= "cursor:pointer"  onClick="location.replace('/buupList.do')">[목록화면]</span>
	                 <input type="button" value="수정" onClick= "checkbuupUpForm();">
	                 <input type="button" value="삭제" onClick= "checkbuupDelForm();">
	     	     </center>
      </form>
    </div>
</body>

   <%@ include file="footer.jsp" %>
   
</html>
