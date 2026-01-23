 <title>12Wa~</title><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>12Wa~</title>
 <script>
    function noticeRegForm(admin_no) {
        var formObj = $("[name='boardRegForm']"); // 폼 객체 선언
        if (formObj.length > 0) {
      	  if( confirm("공지를 작성하시겠습니까?")==false ){ return; }           
      	  $.ajax({
                url: "/noticeRegProc.do",
                type: "post",
                data: formObj.serialize(),
                success: function(json) {
                    var result = json["result"];
                    if (result == 1) {
                        alert("공지사항 작성 성공입니다.");
						location.replace('notice.do');
                    
                    } else {
                        alert("공지사항 작성 실패입니다.");
                    }
                },
                error: function() {
                    alert("작성 실패! 관리자에게 문의 바랍니다.");
                }
            });
        } else {
            alert("폼을 찾을 수 없습니다.");
        }
    }
  </script>
</head>

<body>
  <div id="container">
    <%@ include file="header.jsp" %>

    <form action="submit.php" method="POST" name="boardRegForm">
      <div id="wrap" class="container">
        <h1 style="text-align: center;">공지 작성</h1>
        <table style="border:1px solid black; margin-left:auto; margin-right:auto;">
          <tr>
            <td>제목</td>
            <td><input type="text" name="subject"></td>  
          </tr>
          <tr>
            <td>내용</td>
            <td>
              <textarea name="content" style="width:100%; height:100%;" rows="4"></textarea>
            </td>
          </tr>
             <tr>
            <td>카테고리</td>
            <td>
              <select name="category" >
              		 <option value="main" > 메인 공지 </option>
                      <option value="board"> 전체 게시판 </option>
                      <option value="free"> 자유게시판 </option>
                      <option value="qna"> Q&A게시판 </option>
                      <option value="newbie">신입게시판</option>
                      <option value="job">취업게시판</option>
                      <option value="interview">면접게시판</option>
                      <option value="trade">중고게시판</option>
              </select>
            </td>
          </tr>
        </table>
        <input type="hidden" name="admin_no" value="${sessionScope.admin_no}">
        <center>
          <input type="button" value="등록" onClick="noticeRegForm(${sessionScope.admin_no})">
        </center>
      </div>
    </form>
  </div>

  <%@ include file="/WEB-INF/views/common.jsp" %>
  <%@ include file="footer.jsp" %>
</body>
</html>