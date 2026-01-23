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
  <h1 style="text-align: center;">구매 게시판 상세페이지</h1>    
     <table style="border:1px solid black;margin-left:auto;margin-right:auto;">
            
            
            <tr>
              <td>번호</td>
              <td></td>
			</tr>
			  
            <tr>
              <td>거래종류</td>
              <td></td>
			</tr>
              
            <tr>
                <td>닉네임</td>
			    <td></td>
            </tr>
                 
             <tr>
                  <td>제목</td>
                  <td></td>
              </tr>   
              
             <tr>
                  <td>가격</td>
                  <td></td>
            </tr>  
   
             <tr>
                  <td>내용</td>
                  <td></td>
              </tr>
            
               <tr>
                  <td>작성일</td>  
                  <td></td>    
              </tr>  
  
              <tr>
                  <td>조회수</td>  
                  <td></td>                    
              </tr>

              <tr>
                  <td>댓글</td>
                  <td>
                   <textarea textarea style="width:100%; height:100%;" rows="4"></textarea>
                  	 <input type="button" value="등록" > 
                  </td>               
              </tr>   
          </table>
          
          
          <center>
             <span onCLick= "location.replace('/buyItems.do')">[목록으로]</span>
         </center>
         
     </form>
  </div>     
</body>
<%@include file="/WEB-INF/views/common.jsp" %>
<%@ include file="footer.jsp" %>
</html>
