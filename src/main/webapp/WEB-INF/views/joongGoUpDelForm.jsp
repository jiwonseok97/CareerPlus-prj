<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/common.jsp" %>

<!DOCTYPE html>
<html>

<head>


</head>

<body>
    <div id="container">    
  <%@ include file="header.jsp" %>

     <h1 style="text-align: center;">[중고게시판 수정/삭제 페이지]</h1>

    <center>
       <form name="boardUpDelForm">
          <table> 


           <tr>     
               <td>구매/판매</td>
						<td>
							<c:choose>
								<c:when test="${boardDTO.trade_type == 'buy'}">
										        구매
										    </c:when>
								<c:otherwise>
										        판매
										    </c:otherwise>
							</c:choose>
						</td>
					</tr>   
          
                      
            <tr>     
               <td>제목</td>
               <td>
					<!-------------------------------------------------------->
					<input type="text" name="subject" class="subject" size="10" maxlength="15" 
									value="${requestScope.boardDTO.subject}">
					<!-------------------------------------------------------->
				</td>  
			</tr>
			
       		  <tr>     
                <td>내용</td>
               <td>
					<!-------------------------------------------------------->
					<input type="text" name="content" class="content" size="10" maxlength="15" 
									value="${requestScope.boardDTO.content}">
					<!-------------------------------------------------------->
				</td>  
			</tr>
			
				<tr>
			        <td>가격</td>
			        <td>
			         	<input type="text" name="price" class="price" size="10" maxlength="15" 
									value="${requestScope.boardDTO.price}">
			         </td>
			    </tr>

				<tr>
			        <td>작성일</td>
			        <td>
			         	${requestScope.boardDTO.reg_date}
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
               <input type="hidden" name="table" value="tradeboard">
               <input type="hidden" name="p_no" value="${sessionScope.p_no}">
          
			      
              <center>
                 <span style= "cursor:pointer"  onClick="pushboardname('tradeboard','joongGo')">[목록화면]</span>
                 <input type="button" value="수정" onClick= "checkboardUpForm('tradeboard','joongGo');">
                 <input type="button" value="삭제" onClick= "checkboardDelForm('tradeboard','joongGo');">
     	     </center>
      </form>
  </div>
</body>


</body>
<%@ include file="footer.jsp" %>
</html>
