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
    function searchWithSort(sort) {
        search();
    }

    function search() {
        var commentFormObj = $("[name='commentRegForm']");
        return;
        $.ajax({
            url: "/freedomeDetailForm.do",
            type: "post",
            data: commentFormObj.serialize(),
            success: function(responseHtml) {
                var obj = $(responseHtml);
                $(".commentList").html(
                    obj.find(".commentList").html()
                );
            },
            error: function() {
                alert("정렬 실패! 관리자에게 문의 바람니다.");
            }
        });
    }

    function up_comment(comment_no) {
        var commentObj = $("form[name='commentRegForm']");
        var updatecomment = $("textarea[name='updateContent']").val();

        commentObj.find("[name='updateComment']").val(updatecomment);
        commentObj.find("[name='comment_no']").val(comment_no);

        $.ajax({
            url: "/upCommentProc.do",
            type: "post",
            data: commentObj.serialize(),
            success: function(json) {
                var result = json["result"];
                if (result == 1) {
                    alert("댓글 수정 성공입니다.");
                    location.reload();
                } else {
                    alert("댓글 수정 실패입니다. 관리자에게 문의 바람!");
                }
            },
            error: function() {
                alert("입력 실패! 관리자에게 문의 바람니다.");
            }
        });
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
			<form action="submit.php" method="POST" name="commentRegForm"
				class="commentRegForm">
				<table
					style="border: 1px solid black; margin-left: auto; margin-right: auto;">
					<tr>
						<td>작성자</td>
						<td>관리자</td>
					</tr>
					<tr>
						<td>제목</td>
						<td>${boardDTO.subject }</td>
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
						<td colspan="2">${boardDTO.content }</td>
					</tr>
				</table>
				<input type="hidden" name="n_no" value="${boardDTO.n_no }">				
				<center>
					<span onClick="window.history.back()">[이전 화면으로]</span>
					<span onClick="location.replace('/notice.do')">[공지사항 목록으로]</span>
					<c:if test="${sessionScope.member=='admin'}">
						<input type="button" value="수정/삭제" onClick="document.noticeUpDelForm.submit();">
					</c:if>
				</center>
			</form>
			<!-- form 태그가 밖에 존재해야 합니다. -->
			<c:if test="${sessionScope.member=='admin'}">
				<form name="noticeUpDelForm" action="/noticeUpDelForm.do" method="post">
					<input type="hidden" name="n_no" value="${boardDTO.n_no }">
				</form>
			</c:if>
		</div>
	</div>
	<%@include file="/WEB-INF/views/common.jsp"%>
	<%@ include file="footer.jsp"%>
</body>
</html>