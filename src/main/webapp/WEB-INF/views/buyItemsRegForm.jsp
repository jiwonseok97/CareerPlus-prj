<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

  
</head>
<body>
    <div id="container">    
    
   <%@ include file="header.jsp" %>

<div style="position:absolute;top;100px;left;150px width:145px; float: left; z-index:3;">
    <br><br>
    <li onClick="location.replace('/interview.do')">면접 게시판</li>
    <li onClick="location.replace('/jobReady.do')">취업준비 게시판</li>
    <li onClick="location.replace('/newComer.do')">신입 게시판</li>
    <li onClick="location.replace('/freedome.do')">자유 게시판</li>
    <li onClick="location.replace('/qna.do')">QnA 게시판    </li>
    
    <li>
        <input id="joongGosubmenu" type="checkbox" />
	    <label for="joongGosubmenu">중고 게시판</label>
	  <ul class="submenu">
		  <li><a onClick="location.replace('/joongGoList.do')"> - 전체</a></li>
		  <li><a onClick="location.replace('/buyItems.do')">    - 구매</a></li>
		  <li><a onClick="location.replace('/sellItems.do')">   - 판매</a></li>
	  </ul>
	</li>	
</div>



    <div id="wrap" class="container"  >
      <h1 style="text-align: center;">구매글 작성</h1>
      <form action="submit.php" method="POST">
       <table style="border:1px solid black;margin-left:auto;margin-right:auto;">
              
              <tr>
	            <td>구분</td>
	            <td><input type="radio" id="TRADE_TYPE" name="TRADE_TYPE" checked>
    			<label for="TRADE_TYPE">구매 </label>
              </tr>
              
               </tr>   
                  <td>닉네임</td>
                  <td> <input type="text" name="NICKNAME"></td>  
              </tr>
              
              
              </tr>   
                  <td>제목</td>
                  <td> <input type="text" name="subject"></td>  
              </tr>
              
               <tr>
                  <td>가격</td>
                  <td><input type="text" name="PRICE">원</td>   
              </tr>
              
              <tr>
                  <td>내용</td>
                  <td>
                    <textarea name="CONTENT" textarea style="width:100%; height:100%;" rows="4"></textarea>
                  </td>  
  			 
  			  <tr>
                  <td>사진 파일:</td>
                  <td><input type="file" name="fileToUpload" id="fileToUpload">
                      <input type="submit" value="업로드" name="submit"></td>
              </tr>  

             <tr>
                  <td>비밀번호 : </td>
                  <td>  
                   <input type="text" name="B_PWD">
                  </td>                       
              </tr>
                
          </table>
          
          <center>
          <input type="button" value="등록" onCLick= "location.replace('/buyItems.do')">
     </center>
      </form>
  </div>
       
       
</body>
<%@include file="/WEB-INF/views/common.jsp" %>
<%@ include file="footer.jsp" %>
</html>
