<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>12Wa~</title>
	
	<script>
	function gonoticeDetailForm(n_no){
	      $("[name='noticeDetailForm']").find("[name='n_no']").val(n_no);

	       document.noticeDetailForm.submit();
	   
	}

	
	
	
	
	
	//상세보기 화면으로 이동하는
	//goBoardDetailForm 함수 선언하기.
	// 	매개변수로 게시판의 고유번호가 들어온다.
// 	function goBoardDetailForm(b_no){
// // 			name='boardDetailForm' 을 간 form 태그 후손 중에
// // 			name='b_no' 가진 태그에 매개변수로 들어온 게시판의 고유번호를 삽입하기
// // 			location.replace("/boardDetailForm.do?b_no="+b_no);		>> get 방식.
//  		$("[name='freedomeDetailForm']").find("[name='b_no']").val(b_no);
//  		$("[name='freedomeDetailForm']").find("[name='table']").val("freeboard");
// //  		----------------------------------
// //  		name='boardDetailForm' 을 가진 
// //  		form 태그의 action 에 설정된 URL 주소로 WAS 접속해서 
// //  		얻은 새 HTML 를 웹브라우저 열기.
// //  		즉 화면 이동하기.
// //  		----------------------------------
//  		document.freedomeDetailForm.submit();
// 	}
	
// 	function pageNoClick( clickPageNo ){
// // 		alert(clickPageNo);
// 		//---------------------------------------------
// 		// name='selectPageNo' 를 가진 태그의 value 값에 
// 		// 매개변수로 들어오는 [클릭한 페이지 번호]를 저장하기
// 		// 즉 <input type="hidden" name="selectPageNo" value="1"> 태그에
// 		// value 값에 [클릭한 페이지 번호]를 저장하기
// 		//---------------------------------------------
// 		$("[name='boardSearchForm']").find(".SelectPageNo").val(clickPageNo);
		
// 		search("freedome");
		
// 	}
	
	</script>

</head>
  
<body>

 <div id="container">
 
   <%@ include file="header.jsp" %>

	
    <div class="container"  id="wrap">
      <h1 style="text-align: center;">공지 사항</h1>
      
      <form name="boardSearchForm">
        <div style="text-align: center; margin-bottom: 20px;">
			<input type="hidden" name="boardname" class="boardname" value="freeboard">
            <input type="text"   name="keyword" class="keyword">
            <input type="button" value="검색"   class="searchBtn" onclick="search('freedome')"></input>
            <input type="hidden" name="SelectPageNo" class="SelectPageNo" value="1">
			<input type="hidden" name="rowCntPerPage" class="rowCntPerPage">
			
			
        </div>
     </form>
      
      <div class="noticeListDiv">
      <form action="submit.php" method="POST">
          <table style="border:1px solid black;margin-left:auto;margin-right:auto;">
              
              <tr>
                  <th>번호</th>
                  <th>작성자</th>
                  <th>제목</th>    
                  <th>작성일</th>
                  <th>조회수</th>
                   <th>카테고리</th>
                  
              </tr>

              <c:forEach var="board" items="${requestScope.noticeList }"  varStatus="status">
								
              <tr style="cursor:pointer" onCLick= "gonoticeDetailForm(${board.n_no});">
              	<td align="center"> ${requestScope.boardMap.begin_serialNo_desc - status.index}</td>
              	<td align="center"> 관리자</td>
              	<td align="center"> ${board.subject }</td>
              	<td align="center"> ${board.reg_date }</td>
              	<td align="center"> ${board.read_count }</td>
              	<td align="center"> 
              		<c:if test="${board.category eq 'trade'}"> 중고게시판</c:if>
             	 	<c:if test="${board.category eq 'main'}">  메인 공지</c:if>
              		<c:if test="${board.category eq 'qna'}"> Q&A 게시판</c:if>
              		<c:if test="${board.category eq 'job'}">취업준비 게시판</c:if>
              		<c:if test="${board.category eq 'newbie'}">신입 게시판</c:if>
              		<c:if test="${board.category eq 'board'}">전체 게시판</c:if>
             	 	 <c:if test="${board.category eq 'interview'}">면접 게시판</c:if>
             	 	  <c:if test="${board.category eq 'free'}">자유 게시판</c:if>
             	 	 
              	</td>

              	
              	
              	
              	
              
              	
              	
<!--               </tr> -->
              </c:forEach>
			              
          </table>
		 </form>
          </div>
					
       					<center> 
<!--nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn-->
<!--- 게시판 페이징 번호 출력하기.  시작   -->
<!--nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn-->

<span class="pagingNos">
<c:if test="${requestScope.noticeListCnt==0}">
               		<tr>
			              <center>
			              	<b>
			              	조회할 데이터가 없습니다.
			              	</b>
			              </center>
			              </tr>
			              </c:if>
		<!--------------------------------------------->
		<!-- [처음] [이전] 출력하기 -->
		<!--------------------------------------------->
		<span style="cursor:pointer" 
				onClick="pageNoClick(1)">[처음]</span>
		<span style="cursor:pointer" 
				onClick="pageNoClick(${requestScope.boardMap.selectPageNo}-1)">[이전]</span>&nbsp;&nbsp;
		
		<!--------------------------------------------->
		<!--  [반복문 C코어 태그]를 사용하여 페이지 번호 출력하기 -->
		<!--------------------------------------------->
		<c:forEach var="pageNo"  begin = "${requestScope.boardMap.begin_pageNo}"    
								 end   = "${requestScope.boardMap.end_pageNo}">
			<!--------------------------------------------->
			<!--  만약에 [선택한 페이지 번호]와 [화면에 출력할 페이지 번호]가 같으면  -->
			<!--------------------------------------------->
			<c:if test="${requestScope.boardMap.selectPageNo==pageNo}">
				${pageNo}
			</c:if>
			<!--------------------------------------------->
			<!--  만약에 [선택한 페이지 번호]와 [화면에 출력할 페이지 번호]가 다르면  -->
			<!--------------------------------------------->
			<c:if test="${requestScope.boardMap.selectPageNo!=pageNo}">
				<span style="cursor:pointer" onClick="pageNoClick(${pageNo})">[${pageNo}]</span>
			</c:if>
		</c:forEach>&nbsp;&nbsp;
		<!--------------------------------------------->
		<!-- [다음] [마지막] 출력하기 -->
		<!--------------------------------------------->
		<span style="cursor:pointer" 
				onClick="pageNoClick(${requestScope.boardMap.selectPageNo}+1)">[다음]</span>
		<span style="cursor:pointer" 
				onClick="pageNoClick(${requestScope.boardMap.last_pageNo})">[마지막]</span>
		&nbsp;&nbsp;&nbsp;		
		<!--------------------------------------------->
		[${requestScope.noticeListCnt}/${requestScope.noticeListAllCnt}]개 	
		
		<!--------------------------------------------->
		&nbsp;&nbsp;
</span>
<!--nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn-->
<!--- 게시판 페이징 번호 출력하기.  끝   -->
<!--nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn-->

<select name="rowCntPerPage" class="rowCntPerPage" onChange="search('freedome')">
	<option value="10">10
	<option value="15">15
	<option value="20">20
</select>행보기 &nbsp;&nbsp;&nbsp;
	</center>
				
		
		<c:if test="${sessionScope.member=='admin'}"> 
		<center>
	          <input type="button" value="등록"  onCLick= "location.replace('/noticeRegForm.do')">
     </center>
      		</c:if>
  </div>
					
					</div>
       			    <form name="noticeDetailForm" action="/noticeDetail.do"	method="post">
						<!-- 클릭한 행의 게시판 고유번호가 저장될 히든태그 선언 -->
						<input type="hidden" name="n_no"  value="${board.n_no}">
												
		       </form>  
       
</body>
	<%@include file="/WEB-INF/views/common.jsp" %>
    <%@ include file="footer.jsp" %>
</html>