<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@include file="/WEB-INF/views/common.jsp"%>  

<!DOCTYPE html>
<html>

<head>

  
</head>
<body> 
 <%@ include file="header.jsp" %>

<%@ include file="boardSideCategori.jsp" %>

    <div id="wrap" class="container"  >
      <h1 style="text-align: center;">중고 게시글 작성</h1>
      <form action="submit.php" method="POST" name="boardRegForm">
        <table style="border:1px solid black;margin-left:auto;margin-right:auto;">
              
              <tr>
	            <td>구분</td>
	            <td><input type="radio" id="trade_type" name="trade_type" value="buy">구매
    			
    			<input type="radio" id="trade_type" name="trade_type" value="sell">판매
              </tr>
              
              <tr>
                  <td>닉네임</td>
                  <td>${sessionScope.nickname}</td>  
              </tr>
              
               <tr>
                  <td>제목</td>
                  <td> <input type="text" name="subject"></td>  
              </tr>
              
               <tr>
                  <td>가격</td>
                  <td><input type="text" name="price">원</td>   
              </tr>
              
              <tr>
                  <td>내용</td>
                  <td>
                   <textarea name="content" textarea style="width:100%; height:100%;" rows="4"></textarea>
                  </td>  
  			 
  			  <tr>
                  <td>사진 파일:</td>
                  <td><input type="file" name="fileToUpload" id="fileToUpload">
                      <input type="submit" value="업로드" name="submit"></td>
              </tr>  

             <tr>
                  <td>비밀번호 : </td>
                  <td>  
                   <input type="password" name="pwd">
                  </td>                       
              </tr>
                
          </table>
           <input type="hidden" name="table" value="tradeboard">
           <input type="hidden" name="p_no" value="${sessionScope.p_no}">
          <center>
          <input type="button" value="등록"  onClick="checkboardRegForm('tradeboard','joongGo')">
        </center>
      </form>
  </div>
       
       
</body>
<%@ include file="footer.jsp" %>
</html>
