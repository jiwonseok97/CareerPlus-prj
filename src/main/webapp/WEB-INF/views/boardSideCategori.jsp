<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
    <style>
        .sidebar-container {
            position: absolute; 
            top: 100px; 
            width: 145px;
            float: left; 
            z-index: 3;
            background-color: #fff;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .sidebar-container ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .sidebar-container li {
            margin: 10px 0;
            padding: 10px;
            background-color: #fff;
            color: #007bff;
            border: 1px solid #007bff;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.3s ease;
            text-align: left; /* 왼쪽 정렬 */
            font-weight: bold; /* 글씨 굵게 */
            font-size: 12px; /* 글씨 크기 작게 */
        }

        .sidebar-container li:hover {
            background-color: #f0f0f0;
            transform: scale(1.05);
        }
    </style>
</head>
<body>
	<div class="sidebar-container">
		<br>
		<br>
		<li onClick="pushboardname('freeboard','freedome')">자유 게시판</li>
		<li onClick="pushboardname('newbieboard','newComer')">신입 게시판</li>
		<li onClick="pushboardname('qnaboard','qna')">QnA 게시판</li>
		<li onClick="pushboardname('jobsearchboard','jobReady')">취업 게시판</li>
		<li onClick="pushboardname('interviewboard','interview')">면접 게시판</li>
		<li onClick="pushboardname('tradeboard','joongGo')">중고 게시판</li>

	</div>


	<form name="freedome" action="/freedome.do" method="post">
		<input type="hidden" name="boardname" class="boardname">
	</form>

	<form name="freedomeDetailForm" action="/freedomeDetailForm.do" method="post">
		<input type="hidden" name="Detail_b_no"> 
		<input type="hidden" name="Detail_board">
		<input type="hidden" name="Comment_board">
		<input type="hidden" name="comment_sort">
		<input type="hidden" name="p_no" value=0>
		<input type="hidden" name="c_no" value=0>
	</form>

	<form name="freedomeRegForm" action="/freedomeRegForm.do" method="post">
		<input type="hidden" name="b_no" >
	</form>
	
 <form name="freedomeUpDelForm" action="/freedomeUpDelForm.do" method="post">
		<input type="hidden" name="UpDel_b_no" >
		<input type="hidden" name="UpDel_board">
	</form>
	
</body>
</html>