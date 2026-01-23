<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.List, java.util.ArrayList" %>
    <%@ page import= "com.wa.erp.BoardDTO"%>
  
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>12Wa~</title>
  <style>
    .hidden-row {
        display: none;
    }
    
    .likeButton.clicked i {
        color: #007bff; /* 좋아요 버튼 클릭 시 색상 */
    }
</style>
  
<script>


function searchWithSort(sort){
// 	   $("[name='reviewUpForm']").find("[name='reviewSort']").val(sort);
	   search();
	}



function search(){
	
	var commentFormObj = $("[name='commentRegForm']");
		return
	$.ajax(
	         {
	            //-------------------------------
	            // WAS 로 접속할 주소 설정
	            //-------------------------------
	            url      : "/freedomeDetailForm.do"
	            //-------------------------------
	            // WAS 로 접속하는 방법 설정. get 또는 post
	            //-------------------------------
	            ,type    : "post"
	            //--------------------------------------
	            // WAS 에 보낼 파명과 파값을 설정하기. "파명=파값&파명=파값~"
	            //--------------------------------------
	            ,data    : commentFormObj.serialize()
	            //----------------------------------------------------------
	            // WAS 의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
	            // 이때 익명함수의 매개변수로 WAS 의 응답물이 들어 온다.
	            // "/boardList.do" 주소의 응답물은  boardList.jsp 페이지의
	            // 실행결과인 HTML 문서 문자열이이다.
	            //----------------------------------------------------------
	            ,success : function(responseHtml){
	               //-----------------------------------
	               // 매개변수로 들어오는 HTML 문자열을 관리하는 
	               // JQuery 객체 생성하여 변수 obj 에 저장하기
	               //-----------------------------------
	               var obj = $(responseHtml);
	               //-----------------------------------
	               // 매개변수로 받은 HTML 문자열 중에 
	               // <div class='boardListDiv'> 태그 안의 html 문자열을
	               // 현 화면의 <div class='boardListDiv'> 태그 안에  덮어쓰기
	               //-----------------------------------boardListDiv pagingNos
	               $(".commentList").html( 
	                     obj.find(".commentList").html() 
	               );
	            

	               /*$(".xxx").remove();
	               $("body").prepend(
	                  "<textarea class=xxx cols=100 rows=100>"
	                  + obj.filter(".boardListDiv").html()
	                  +"</textarea>"
	               )*/
	               
	            }
	            ,error   : function(){
	               alert("정렬 실패! 관리자에게 문의 바람니다.");
	            }
	         }
	      );
		}	
		
		function up_comment(comment_no){
		 	var commentObj = $("form[name='commentRegForm']");
		 	var updatecomment = $("textarea[name='updateContent']").val();
		 	
		 	commentObj.find("[name='updateComment']").val(updatecomment);
		 	commentObj.find("[name='comment_no']").val(comment_no);
		 	
		 	
// 		 	if( 
// 		 			updatecomment.val().trim().length==0 
// 		 			||
// 		 			updatecomment.val().trim().length>20 
// 		 	){
// 		 		alert("댓글은 임의 문자 1~20자 입력해야합니다.");
// 		 		return;
// 		 	}
// 		 	if( confirm("댓글을 입력하시겠습니까?")==false ){ return; }
			$.ajax(
					{ 
						url    : "/upCommentProc.do"
						,type  : "post"
						,data  : commentObj.serialize( )
						,success : function(json){
							var result = json["result"];
							if(result==1){
								alert("댓글 수정 성공입니다.");
								location.reload(); 
							}
							
							else{
								alert("댓글 수정 실패입니다. 관리자에게 문의 바람!");
							}
						}
						,error : function(){
							alert("입력 실패! 관리자에게 문의 바람니다.");
						}
					}
				);
		}

		
		function del_comment(comment_no){
		 	var commentObj = $("form[name='commentRegForm']");
		 	
		 	commentObj.find("[name='comment_no']").val(comment_no);
		 	
			$.ajax(
					{ 
						url    : "/delCommentProc.do"
						,type  : "post"
						,data  : commentObj.serialize( )
						,success : function(json){
							var result = json["result"];
							if(result==1){
								alert("댓글 삭제 성공입니다.");
								location.reload(); 
							}
							
							else{
								alert("댓글 삭제 실패입니다. 관리자에게 문의 바람!");
							}
						}
						,error : function(){
							alert("입력 실패! 관리자에게 문의 바람니다.");
						}
					}
				);
		}
</script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="styles.css">

</head>

  
<body>

 <div id="container">    
    <%@ include file="header.jsp" %>

	<%@ include file="boardSideCategori.jsp" %>


    <div id="wrap" class="container"  >
      <h1 style="text-align: center;">자유 게시판 상세페이지</h1>
      <form action="submit.php" method="POST" name="commentRegForm" class="commentRegForm">
              <table style="border:1px solid black;margin-left:auto;margin-right:auto;">
                   
               <tr>
                  <td>닉네임</td>
                  <td>${boardDTO.nickname }</td> 
              </tr>
                 
               <tr>
                  <td>제목</td>
                  <td>${boardDTO.subject }</td>
              </tr> 
              
              <tr>
                  <td>내용</td>
                  <td>${boardDTO.content }</td>
			  </tr>
			   
               
                 <tr>
                  <td>조회수</td>
                  <td>${boardDTO.read_count }</td>
              </tr> 
               
              <tr>
                  <td>작성일 </td>
                  <td>${boardDTO.reg_date }</td>
              </tr>  
 

			  <tr>
                <td>추천수</td>
                <td>${boardDTO.rec_count }</td>   
                        
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
                   	 <input type="hidden" value="comment_free" name="table" class="table"> 
                  	 <input type="hidden" value="${sessionScope.p_no }" name="p_no" class="p_no"> 
                  	 <input type="hidden" value="${boardDTO.b_no }" name="b_no" class="b_no">
                  	 <input type="hidden" name="commentSort" class="commentSort" value="">
                  	 <input type="hidden" name="updateComment">
                  	 <input type="hidden" name="comment_no" value=0>                   	 
          
          
          <center>
         <span onClick="pushboardname('freeboard','freedome')">[목록으로]</span>
         <c:if test="${sessionScope.p_no==boardDTO.p_no}">
         <input type="button" value="수정/삭제"
							onclick="goUpDelForm(${boardDTO.b_no},'freedome','freeboard');">
		 </c:if>
     </center>
      </form>
      
      <div name="commentList">
      <table style="margin: 0 auto;">
      	<tr>
      		<th>
      			댓글
      		</th>
      			<c:if test="${param.comment_sort!='rec_count asc' and param.comment_sort!='rec_count desc'}">
              <th  style="width: 10%; text-align: center; cursor:pointer; "onCLick= "goBoardDetailForm(${boardDTO.b_no},'freedome', 'freeboard','free','rec_count desc');">좋아요</th>
              </c:if>
             
             <c:if test="${param.comment_sort=='rec_count desc'}">
              <th  style="width: 10%; text-align: center; cursor:pointer; "onCLick= "goBoardDetailForm(${boardDTO.b_no},'freedome', 'freeboard','free','rec_count asc');">좋아요▼</th>
              </c:if>
             
             <c:if test="${param.comment_sort=='rec_count asc'}">
              <th  style="width: 10%; text-align: center; cursor:pointer; "onCLick= "goBoardDetailForm(${boardDTO.b_no},'freedome', 'freeboard','free','');">좋아요▲</th>
              </c:if>
      	</tr>
      	
      	<!-- ==================================================================================================== -->
				
<!--           기존 반복문을 수정하여 좋아요 상태 표시 -->
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
      	
      	 <input type="hidden" name="b_no" class="b_no">
      	 
      </table>
      </div>
  </div>
  </div>
</body>
<%@include file="/WEB-INF/views/common.jsp"%>  
<%@ include file="footer.jsp" %>
</html>
