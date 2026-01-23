<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@include file="/WEB-INF/views/common.jsp"%>  

<!DOCTYPE html>
<html>

<head>
<style>
input[type="checkbox"] {
    width: 20px;
    height: 20px;
    text-align: center;
    display: inline-block;
    vertical-align: middle; /* 수직 가운데 정렬을 위한 추가 속성 */
    margin: 0; /* 체크박스 사이의 여백 제거 */
}
        .form-container {
            text-align: center;
            margin-bottom: 20px;
        }

        /* Text input field */
        .keyword {
            padding: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
            margin-right: 10px;
        }

        /* Search button */
        .searchBtn {
            padding: 5px 20px;
            border-radius: 5px;
            border: none;
            background-color: #007bff;
            color: #fff;
            cursor: pointer;
        }

        /* Search button hover effect */
        .searchBtn:hover {
            background-color: #0056b3;
        }
</style>
  <script>

  function handleCheckboxClick(event) {
      event.stopPropagation(); // 이벤트 버블링 방지
  }
  function pageNoClick( clickPageNo ){

		$("[name='boardSearchForm']").find(".selectPageNo").val(clickPageNo);
		
		search("interview");
		
	}
  
  
	function gonoticeDetailForm(n_no){
	    $("[name='noticeDetailForm']").find("[name='n_no']").val(n_no);

	     document.noticeDetailForm.submit();
	 
	}
	function searchWithSort(sort){
	      $("[name='boardSearchForm']").find("[name='sort']").val(sort);
	       $(".searchBtn").click();

	   }
//	게시판 검색하는 함수 search() 선언.
//	[검색] 버튼 클릭 시 호출되는 함수이다.
// 	function search(){
		
// 		var boardSearchFormObj = $("[name='boardSearchForm']");
		
// 		var keywordObj = boardSearchFormObj.find(".keyword");

// 		var keyword = keywordObj.val();
		
// 		if(typeof(keyword)!='string'){ keyword=""; }
		
// 		keyword = $.trim(keyword);
// 		keywordObj.val(keyword);

// 		boardSearchFormObj.find(".rowCntPerPage").val($("select").filter(".rowCntPerPage").val());
		
// 		alert(boardSearchFormObj.serialize());
// 		$.ajax(
// 			{
// 				url: "/interview.do"
// 				,type: "post"
// 				,data: boardSearchFormObj.serialize()
// 				,success: function(responseHtml){
// 					var obj = $(responseHtml);
// 					alert(
// 							boardSearchFormObj.serialize()
// 					)
					
// 					$(".interviewListDiv").html(
// 							obj.find(".interviewListDiv").html()
// 					);
// 					$(".pagingNos").html(
// 							obj.find(".pagingNos").html()
// 					);

// 				}
// 				,error: function(){
// 					alert("검색 실패! 관리자에게 문의 바람");
// 				}
// 			}		
// 		);


// 		}
</script>

</head>
<body>
    <div id="container">    
 <%@ include file="header.jsp" %>
 <%@ include file="boardSideCategori.jsp" %>



    <div id="wrap" class="container">
      <h1 style="text-align: center;">면접 게시판</h1>
      
     <form name="boardSearchForm">
        <div style="text-align: center; margin-bottom: 20px;">
            <input type="text"   name="keyword" class="keyword">
            <input type="button" value="검색"   class="searchBtn" onclick="search('interview')"></input>
            <input type="hidden" name="SelectPageNo" class="SelectPageNo" value="1">
			<input type="hidden" name="rowCntPerPage" class="rowCntPerPage">
			<input type="hidden" name="boardname" class="boardname" value="interviewboard">
			<input type="hidden" name="sort" class="sort" value="">
        </div>
     </form>
      
      <form action="submit.php" method="POST">
				<div class="interviewListDiv">
					<table
                		  style="border: 1px solid black; margin-left: auto; margin-right: 90px;" >

						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>닉네임</th>
							<th>작성일</th>
							<c:if test="${sessionScope.member!='admin'}">
								<th>조회수</th>
							</c:if>
							<!--                   <th>추천수</th> -->
							<c:if test="${sessionScope.member == 'admin' }">
								<c:if test="${param.sort!='read_count asc' and param.sort!='read_count desc'}">
									<th style="cursor: pointer font-weight: bold;" onClick="searchWithSort('read_count desc')">조회수</th>
								</c:if>
								<c:if test="${param.sort=='read_count desc'}">
									<th style="cursor: pointer font-weight: bold;" onClick="searchWithSort('read_count asc')">조회수▼</th>
								</c:if>
								<c:if test="${param.sort=='read_count asc'}">
									<th style="cursor: pointer font-weight: bold;" onClick="searchWithSort('')">조회수▲</th>
								</c:if>
								<th>글 선택</th>
							</c:if>
						</tr>
						<c:if test="${sessionScope.member == 'admin' }">

							<c:if test='${requestScope.boardMap.selectPageNo==1}'>
								<c:forEach var="board" items="${requestScope.noticeList}"
									varStatus="status">
									<c:if test="${board.category eq 'board'}">
										<tr onClick="gonoticeDetailForm(${board.n_no})">
											<td bgcolor='pink'>※</td>
											<td bgcolor='pink'>${board.subject}</td>
											<td bgcolor='pink'>관리자</td>
											<td bgcolor='pink'>${board.reg_date}</td>
											<td bgcolor='pink'>${board.read_count}</td>
											<td bgcolor='pink'>※</td>
										</tr>
									</c:if>
								</c:forEach>
							</c:if>
							<c:if test='${requestScope.boardMap.selectPageNo==1}'>
								<c:forEach var="board" items="${requestScope.noticeList}"
									varStatus="status">
									<c:if test="${board.category eq 'interview'}">
										<tr onClick="gonoticeDetailForm(${board.n_no})">
											<td bgcolor='lightblue'>※</td>
											<td bgcolor='lightblue'>${board.subject}</td>
											<td bgcolor='lightblue'>관리자</td>
											<td bgcolor='lightblue'>${board.reg_date}</td>
											<td bgcolor='lightblue'>${board.read_count}</td>
											<td bgcolor='lightblue'>※</td>
										</tr>
									</c:if>
								</c:forEach>
							</c:if>
							<c:forEach var="board" items="${requestScope.interviewList }"
								varStatus="status">

								<tr style="cursor: pointer"
									onCLick="goBoardDetailForm(${board.b_no},'interview', 'interviewboard', 'interviewboard','');">
									<td align="center">
										${requestScope.boardMap.begin_serialNo_desc - status.index}</td>
									<td align="center">${board.subject }</td>
									<td align="center">${board.nickname }</td>
									<td align="center">${board.reg_date }</td>
									<td align="center">${board.read_count }</td>
									<c:if test="${sessionScope.member == 'admin' }">
										<td><input type="checkbox" value="${board.b_no }"
											onclick="handleCheckboxClick(event)"></td>
									</c:if>
								</tr>

							</c:forEach>
						</c:if>
						<c:if test="${sessionScope.member == 'person' || sessionScope.member == 'company' || sessionScope.member==null}">
							<c:if test='${requestScope.boardMap.selectPageNo==1}'>
								<c:forEach var="board" items="${requestScope.noticeList}"
									varStatus="status">
									<c:if test="${board.category eq 'board'}">
										<tr onClick="gonoticeDetailForm(${board.n_no})">
											<td bgcolor='pink'>※</td>
											<td bgcolor='pink'>${board.subject}</td>
											<td bgcolor='pink'>관리자</td>
											<td bgcolor='pink'>${board.reg_date}</td>
											<td bgcolor='pink'>${board.read_count}</td>
<!-- 											<td bgcolor='pink'>※</td> -->
										</tr>
									</c:if>
								</c:forEach>
							</c:if>
							<c:if test='${requestScope.boardMap.selectPageNo==1}'>
								<c:forEach var="board" items="${requestScope.noticeList}"
									varStatus="status">
									<c:if test="${board.category eq 'interview'}">
										<tr onClick="gonoticeDetailForm(${board.n_no})">
											<td bgcolor='lightblue'>※</td>
											<td bgcolor='lightblue'>${board.subject}</td>
											<td bgcolor='lightblue'>관리자</td>
											<td bgcolor='lightblue'>${board.reg_date}</td>
											<td bgcolor='lightblue'>${board.read_count}</td>
<!-- 											<td bgcolor='lightblue'>※</td> -->
										</tr>
									</c:if>
								</c:forEach>
							</c:if>
							<c:forEach var="board" items="${requestScope.interviewList }"
								varStatus="status">

								<tr style="cursor: pointer"
									onCLick="goBoardDetailForm(${board.b_no},'interview', 'interviewboard', 'interviewboard','');">
									<td align="center">
										${requestScope.boardMap.begin_serialNo_desc - status.index}</td>
									<td align="center">${board.subject }</td>
									<td align="center">${board.nickname }</td>
									<td align="center">${board.reg_date }</td>
									<td align="center">${board.read_count }</td>
									<c:if test="${sessionScope.member == 'admin' }">
										<td><input type="checkbox" value="${board.b_no }"
											onclick="handleCheckboxClick(event)"></td>
									</c:if>
								</tr>

							</c:forEach>
						</c:if>
					</table>
				</div>
				<center>
					<span class="pagingNos"> <c:if
							test="${empty requestScope.interviewList }">
							<center>
								<b> 조회할 데이터가 없습니다. </b>
							</center>
						</c:if> <span style="cursor: pointer" onClick="pageNoClick(1)">[처음]</span>
						<span style="cursor: pointer"
						onClick="pageNoClick(${requestScope.boardMap.selectPageNo}-1)">[이전]</span>&nbsp;&nbsp;


						<c:forEach var="pageNo"
							begin="${requestScope.boardMap.begin_pageNo}"
							end="${requestScope.boardMap.end_pageNo}">

							<c:if test="${requestScope.boardMap.selectPageNo==pageNo}">
				${pageNo}
			</c:if>

							<c:if test="${requestScope.boardMap.selectPageNo!=pageNo}">
								<span style="cursor: pointer" onClick="pageNoClick(${pageNo})">[${pageNo}]</span>
							</c:if>
						</c:forEach>&nbsp;&nbsp; <span style="cursor: pointer"
						onClick="pageNoClick(${requestScope.boardMap.selectPageNo}+1)">[다음]</span>
						<span style="cursor: pointer"
						onClick="pageNoClick(${requestScope.boardMap.last_pageNo})">[마지막]</span>
						&nbsp;&nbsp;&nbsp;

						[${requestScope.interviewListCnt}/${requestScope.interviewListAllCnt}]개

						&nbsp;&nbsp;
					</span> <select name="rowCntPerPage" class="rowCntPerPage"
						onChange="search('interview')">
						<option value="10">10
						<option value="15">15
						<option value="20">20
					</select>행보기 &nbsp;&nbsp;&nbsp;
				</center>
				<c:if test="${sessionScope.member=='person'}">
					<center>
						<input type="button" value="등록"
							onCLick="location.replace('/interviewRegForm.do')">
					</center>
				</c:if>
				<c:if test="${sessionScope.member == 'admin' }">
					<center>
						<input type="button" value="선택 게시글 삭제"
							onclick="deleteSelectedPosts('INTERVIEWBOARD')">
					</center>
					</c:if>
			</form>

  </div>
       	  <form name="noticeDetailForm" action="/noticeDetail.do"	method="post">
						<!-- 클릭한 행의 게시판 고유번호가 저장될 히든태그 선언 -->
						<input type="hidden" name="n_no"  value="${board.n_no}">
												
		       </form>  
</body>
<%@ include file="footer.jsp" %>
</html>
