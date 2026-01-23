<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
        <%@ page import="java.util.List, java.util.ArrayList" %>
    <%@ page import= "com.wa.erp.BoardDTO"%>

<!DOCTYPE html>
<html>

<head>
<style>
    .hidden-row {
        display: none;
    }
</style>
  
</head>
<body>
    <div id="container">    
<%@ include file="header.jsp" %>

<%@ include file="boardSideCategori.jsp" %>



    <div id="wrap" class="container"  >
  <h1 style="text-align: center;">중고 게시판 상세페이지</h1>    
   <form action="submit.php" method="POST" name="commentRegForm" class="commentRegForm">
     <table style="border:1px solid black;margin-left:auto;margin-right:auto;">
            
            
            
            <tr>
              <td>거래종류</td>
              <td>${boardDTO.trade_type}</td>
			</tr>
              
            <tr>
                <td>닉네임</td>
			    <td>${boardDTO.nickname}</td>
            </tr>
                 
             <tr>
                  <td>제목</td>
                  <td>${boardDTO.subject}</td>
              </tr>   
              
             <tr>
                  <td>가격</td>
                  <td>${boardDTO.price}원</td>
            </tr>  
   
             <tr>
                  <td>내용</td>
                  <td>${boardDTO.content}</td>
              </tr>
            
               <tr>
                  <td>작성일</td>  
                  <td>${boardDTO.reg_date}</td>    
              </tr>  
  
              <tr>
                  <td>조회수</td>  
                  <td>${boardDTO.read_count}</td>                    
              </tr>

                 <c:if test="${sessionScope.member == 'person' }">
              <tr>
                  <td >댓글</td>
                  <td>
                   <textarea  style="width:100%; height:100%;" rows="4"  name="content" class="content"></textarea>
                  	 <input type="button" value="등록"  onClick="checkCommentReg()">
                  </td>                       
              </tr> 
                   
                  </c:if>
          </table>
                   	 <input type="hidden" value="comment_trade" name="table" class="table"> 
                  	 <input type="hidden" value="${sessionScope.p_no }" name="p_no" class="p_no"> 
                  	 <input type="hidden" value="${boardDTO.b_no }" name="b_no" class="b_no">
                  	 <input type="hidden" name="commentSort" class="commentSort" value="">
                  	 <input type="hidden" name="updateComment">
                  	 <input type="hidden" name="comment_no" value=0>  >               
              </tr>   
          </table>
		</form>          

          
          <center>
               <span onClick="pushboardname('tradeboard','joongGo')">[목록으로]</span>
               <c:if test="${sessionScope.p_no==boardDTO.p_no}">
                <input type="button" value="수정/삭제"
							onclick="goUpDelForm(${boardDTO.b_no},'joongGo','tradeboard');">
			    </c:if>
           </center>
           
           
           <table style="margin: 0 auto;">
      	<tr>
      		<td>
      	댓글
      		</td>
      		<c:if test="${param.comment_sort!='rec_count asc' and param.comment_sort!='rec_count desc'}">
              <th  style="width: 10%; text-align: center; cursor:pointer; "onCLick= "goBoardDetailForm(${boardDTO.b_no},'joongGo', 'tradeboard','trade','rec_count desc');">좋아요</th>
              </c:if>
             
             <c:if test="${param.comment_sort=='rec_count desc'}">
              <th  style="width: 10%; text-align: center; cursor:pointer; "onCLick= "goBoardDetailForm(${boardDTO.b_no},'joongGo', 'tradeboard','trade','rec_count asc');">좋아요▼</th>
              </c:if>
             
             <c:if test="${param.comment_sort=='rec_count asc'}">
              <th  style="width: 10%; text-align: center; cursor:pointer; "onCLick= "goBoardDetailForm(${boardDTO.b_no},'joongGo', 'tradeboard','trade','');">좋아요▲</th>
              </c:if>
      	</tr>
           <c:forEach var="board" items="${requestScope.commentList}" varStatus="status">
            <tr class="${status.index >= 5 ? 'hidden-row' : ''}">
              <td>
                <b>${board.nickname}</b> &nbsp;&nbsp;&nbsp; ${board.reg_date}
                &nbsp;&nbsp;<c:if test="${sessionScope.p_no==board.p_no }"><input type="button" name="" value="수정/삭제" onClick="updateForm(${board.comment_no},'${board.content}')"></c:if>
                <br><br>
                <div id="comment${board.comment_no}">
                	${board.content}
                </div>
              </td>
              <td>
                <span class="likeButton" data-comment-no="${board.comment_no}" onclick="toggleLike(this, ${board.comment_no})">
                 <c:choose>
                   <c:when test="${likeNoList.contains(board.comment_no)}">
                     <i class="fas fa-thumbs-up"></i>
                    </c:when>
                    <c:otherwise>
                      <i class="far fa-thumbs-up"></i>
                    </c:otherwise>
                  </c:choose>
                </span>
                <span id="likeCount${board.comment_no}">${board.rec_count}</span>
              </td>
            </tr>
          </c:forEach>
    <tr id="showMoreBtn" <c:if test="${requestScope.commentList.size() <= 5}">style="display: none;"</c:if>>
    	<td colspan="2" style="text-align: center;" onclick="showMoreComments()">
        	더보기
    	</td>
	</tr>
    <c:if test="${empty requestScope.commentList}">
        <tr>
            <td colspan="2">
                댓글이 아직 없습니다.
            </td>
        </tr>
    </c:if>
      </table>
           
           
           
  		</div>
       </div>
</body>
<%@ include file="footer.jsp" %>
    
</html>
