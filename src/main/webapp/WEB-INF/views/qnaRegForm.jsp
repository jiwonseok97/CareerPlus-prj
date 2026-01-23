<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@include file="/WEB-INF/views/common.jsp"%>  

<!DOCTYPE html>
<html>

<head>

  
</head>
<body>
    <div id="container">    
 <%@ include file="header.jsp" %>

<%@ include file="boardSideCategori.jsp" %>

    <div id="wrap" class="container"  >
      <h1 style="text-align: center;">QnA 게시판 작성</h1>
      <form action="submit.php" method="POST" name="boardRegForm">
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
          <input type="hidden" name="table" value="qnaboard">
          <input type="hidden" name="p_no" value="${sessionScope.p_no}">
          <center>
          <input type="button" value="등록"  onClick="checkboardRegForm('qnaboard','qna')">
    	 </center>
      </form>
  </div>
            
         
       
</body>
<%@ include file="footer.jsp" %>
</html>
