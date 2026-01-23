<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>


</head>

<body>
    <div id="container">    
  <%@ include file="header.jsp" %>

     <h1 style="text-align: center;">[자유게시판 수정/삭제 페이지]</h1>

    <center>
       <form name="boardUpDelForm">
          <table> 


           <tr>     
               <td>닉네임</td>
               <td>
					<!-------------------------------------------------------->
					${requestScope.boardDTO.nickname}
					<!-------------------------------------------------------->
				</td>  
			</tr>   
          
                      
            <tr>     
               <td>제목</td>
               <td>
					<!-------------------------------------------------------->
					<input type="text" name="subject" class="subject" size="20" maxlength="15" 
									value="${requestScope.boardDTO.subject}">
					<!-------------------------------------------------------->
				</td>  
			</tr>
			
       		  <tr>     
                <td>내용</td>
               <td>
					<!-------------------------------------------------------->
					<textarea type="text" name="content" class="content" style="width: 800px;"
       						  rows="10" cols="50">${requestScope.boardDTO.content}</textarea>
					<!-------------------------------------------------------->
				</td>  
			</tr>
			
				<tr>
			        <td>조회수</td>
			        <td>
			         	${requestScope.boardDTO.read_count}
			         </td>
			    </tr>

				<tr>
			        <td>작성일</td>
			        <td>
			         	${requestScope.boardDTO.reg_date}
			         </td>
			    </tr>

				<tr>
			        <td>추천수</td>
			        <td>
			         	${requestScope.boardDTO.rec_count}
			         </td>
			    </tr>
				<tr>
			        <td>암호</td>
			        <td>
			         	<input type="password" name="pwd" class="pwd" size="10" maxlength="15" >
			         </td>
			    </tr>
              
          </table>
          
               <input type="hidden" name="b_no" value="${requestScope.boardDTO.b_no}">
               <input type="hidden" name="table" value="freeboard">
               <input type="hidden" name="p_no" value="${sessionScope.p_no}">
          
			      
              <center>
                 <span style= "cursor:pointer"  onClick="pushboardname('freeboard','freedome')">[목록화면]</span>
                 <input type="button" value="수정" onClick= "checkboardUpForm('freeboard','freedome');">
                 <input type="button" value="삭제" onClick= "checkboardDelForm('freeboard','freedome');">
     	     </center>
      </form>
  </div>
</body>


</body>
<%@include file="/WEB-INF/views/common.jsp" %>
<%@ include file="footer.jsp" %>
</html>
