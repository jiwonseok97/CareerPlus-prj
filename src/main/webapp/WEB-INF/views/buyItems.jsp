<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 

<!DOCTYPE html>
<html>

<head>
<script>
  function showItems(type) {
    if (type === 'BuyOrSell') {
      document.getElementById('buyItems').style.display = 'block';

    } 
  }
</script>
<style>
  .hidden {
    display: none;
  }
</style>
  
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
      <h1 style="text-align: center;">구매 게시판</h1>
      <form action="submit.php" method="POST">
          <table style="border:1px solid black;margin-left:auto;margin-right:auto;"> 
          
                    <table style="border:1px solid black;margin-left:auto;margin-right:auto;">
              
              <tr>             	
                  <th>번호</th>
                  <th>거래종류</th>
                  <th>닉네임</th>
                  <th>제목</th>
                  <th>가격</th>
                  <th>작성일</th>
                  <th>조회수</th>         
              </tr>
               <tr onCLick= "location.replace('/buyItemsDetailForm.do')">
                  <td></td>
                  <td></td>
                  <td></td> 
                  <td></td>
                  <td></td>   
                  <td></td>
                  <td></td>  
              </tr>                
          </table>

          <center>
          <input type="button" value="등록"  onCLick= "location.replace('/buyItemsRegForm.do')">
     </center>
      </form>
  </div>
       
</body>
<%@include file="/WEB-INF/views/common.jsp" %>
<%@ include file="footer.jsp" %>
</html>
