 <title>12Wa~</title><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@include file="/WEB-INF/views/common.jsp"%>  

<!DOCTYPE html>
<html>

<head>
	<script>
	//취업준비 게시판 등록을 위한 함수 선언
// 	function checkboardRegForm() {
		
// 	    var formObj = $("[name='jobReadyReg']");
	    
// 	    alert(formObj.serialize());
// 	    $.ajax({
	    	
// 	        url: "/boardRegProc.do",
	        
// 	        type: "post",
	        
// 	        data: formObj.serialize(),
	        
// 	        success: function(json) {
	        	
// 	            var result = json["result"];
// 	            if (result == 1) {
// 	                alert("게시판 작성 성공입니다.");
// 	                pushboardname('jobsearchboard','jobReady');
// 	            } else {
// 	                alert("게시판 작성 실패입니다. 관리자에게 문의 바람!");
// 	            }
// 	        },
// 	        error: function() {
// 	            alert("작성 실패! 관리자에게 문의 바람니다.");
// 	        }
// 	    });
// 	}
	</script>
  
</head>
<body>
    <div id="container">    
 <%@ include file="header.jsp" %>

 <%@ include file="boardSideCategori.jsp" %>



    <div id="wrap" class="container"  >
      <h1 style="text-align: center;">취업준비 게시판 작성</h1>
      <form action="submit.php" method="POST"  name="boardRegForm">
         <table style="border:1px solid black;margin-left:auto;margin-right:auto;">

              <tr>
                  <td>제목</td>
                  <td><input type="text" name="subject"></td>  
              </tr>
              
              <tr>
                  <td>닉네임</td>
                  <td>${sessionScope.nickname}</td>  
              </tr>
              
              <tr>
                  <td>내용</td>
                  <td>
                  	<textarea name="content" textarea style="width:100%; height:100%;" rows="4"></textarea>
                  </td>

              <tr>
                  <td>비밀번호 : </td>
                  <td><input type="password" name="pwd"  ></td>                       
              </tr>   
              
           </table>
			<input type="hidden" name="table" value="jobsearchboard">
			<input type="hidden" name="p_no" value="${sessionScope.p_no}">
          <center>
          <input type="button" value="등록"  onClick="checkboardRegForm('jobsearchboard','jobReady')">
     </center>
      </form>
  </div>
  </div>

</body>
<%@ include file="footer.jsp" %>
</html>
