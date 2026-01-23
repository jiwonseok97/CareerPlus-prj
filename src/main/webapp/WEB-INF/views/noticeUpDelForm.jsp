<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
    
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import= "com.wa.erp.BoardDTO"%>
<%@include file="/WEB-INF/views/common.jsp"%>

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


    function noticeUpdate(n_no,subject,content,category) {

			var noticeUpObj = $("form[name='noticeUpDelForm']");
			  if( confirm("공지를 수정하시겠습니까?")==false ){ return; } 
			  $.ajax({
            url: "/upNoticeProc.do",
            type: "post",
            data: noticeUpObj.serialize(),
            success: function(json) {
                var result = json["result"];
                if (result == 1) {
                    alert("공지 수정 성공입니다.");
                    location.replace('/notice.do')
                } else {
                    alert("공지 수정 실패입니다.!");
                }
            },
            error: function() {
                alert("입력 실패! 관리자에게 문의 바람니다.");
            }
        });
    }

    function noticeDelete(n_no){
    	var noticeDeleteObj = $("form[name='noticeUpDelForm']");
		  if( confirm("공지를 삭제하시겠습니까?")==false ){ return; } 
      $.ajax(
            { 
               //--------------------------------------
               // WAS 에 접속할 URL 주소 지정
               //--------------------------------------
               url    : "/noticeDelProc.do"
               //--------------------------------------
               // 파라미터값을 보내는 방법 지정
               //--------------------------------------
               ,type  : "post"
               //--------------------------------------
               // WAS 에 보낼 파명과 파값을 설정하기. "파명=파값&파명=파값~"
               //--------------------------------------
               ,data  : noticeDeleteObj.serialize( )
               //----------------------------------------------------------
               // WAS 의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
               // 이때 익명함수의 매개변수로 WAS 의 응답물이 들어 온다.
               //----------------------------------------------------------
               ,success : function(json){
                  var result = json["result"];
                  if(result==1){
                     alert("공지가 삭제 되었습니다.");
                     location.replace('/notice.do')
                     }
                  
                  else{
                  	alert(formObj.serialize( ));
                     alert("삭제 실패입니다.");
                  }
               }
               //----------------------------------------------------------
               // WAS 의 응답이 실패했을 실행할 익명함수 설정.
               //----------------------------------------------------------
               ,error : function(){
                  alert("WAS오류");
               }
            }
         );
  }
  </script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="styles.css">
</head>
<body>
	<div id="container">
		<%@ include file="header.jsp"%>
		<div id="wrap" class="container">
			<h1 style="text-align: center;">공지사항 상세페이지</h1>
			<form action="submit.php" method="POST" name="noticeUpDelForm"
				class="commentRegForm">
				<table
					style="border: 1px solid black; margin-left: auto; margin-right: auto;">
					<tr>
						<td>작성자</td>
						<td>관리자</td>
					</tr>
					<tr>
						<td>제목</td>
						<td><input type="text" name="subject" value="${boardDTO.subject}"></td>
					</tr>
					<tr>
						<td>조회수</td>
						<td>${boardDTO.read_count }</td>
					</tr>
					<tr>
						<td>작성일</td>
						<td>${boardDTO.reg_date }</td>
					</tr>
					<tr>
						<td colspan="2"><center>내용</center></td>
					</tr>
					<tr>
					<td colspan="2"><textarea name="content" rows="10" style="width: 100%;">${boardDTO.content}</textarea></td>
					</tr>
					<td>카테고리</td>
					<td><select name="category">
							<option value="main"
								${boardDTO.category == 'main' ? 'selected' : ''}>메인 공지</option>
							<option value="board"
								${boardDTO.category == 'board' ? 'selected' : ''}>전체
								게시판</option>
							<option value="free"
								${boardDTO.category == 'free' ? 'selected' : ''}>자유게시판</option>
							<option value="qna"
								${boardDTO.category == 'qna' ? 'selected' : ''}>Q&A게시판</option>
							<option value="newbie"
								${boardDTO.category == 'newbie' ? 'selected' : ''}>신입게시판</option>
							<option value="job"
								${boardDTO.category == 'job' ? 'selected' : ''}>취업게시판</option>
							<option value="interview"
								${boardDTO.category == 'interview' ? 'selected' : ''}>면접게시판</option>
							<option value="trade"
								${boardDTO.category == 'trade' ? 'selected' : ''}>중고게시판</option>
					</select></td>
				</table>
							<input type="hidden"  name="n_no"  value="${boardDTO.n_no }">				
					<center>
					<span onClick="window.history.back()">[이전 화면으로]</span> <span
						onClick="location.replace('/notice.do')">[공지사항 목록으로]</span>
					<c:if test="${sessionScope.member=='admin'}">
					
					
<%-- 								<input type="hidden"  name="n_no"  value="${boardDTO.n_no }">	 --%>
<%-- 								<input type="hidden"  name="subject"  value="${boardDTO.subject}">	 --%>
<%--        							<input type="hidden"  name="content"  value="${boardDTO.content}">	 --%>
<%-- 								<input type="hidden"  name="category"  value="${boardDTO.category}">						 --%>
					</form>
						<br>
						<input type="button" value="수정하기" onClick="noticeUpdate('${boardDTO.n_no}','${boardDTO.subject}','${boardDTO.content}','${boardDTO.category}');">
						<input type="button" value="삭제하기" onClick="noticeDelete(${boardDTO.n_no});">
					</c:if>
				</center>
			</form>
		</div>
	</div>
	<%@include file="/WEB-INF/views/common.jsp"%>
	<%@ include file="footer.jsp"%>
</body>
</html>
