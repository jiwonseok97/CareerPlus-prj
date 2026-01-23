<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/common.jsp" %>

<!DOCTYPE html>
<html>

<head>
    <style>
        /* Form container */
        .form-container {
            text-align: center;
            margin-bottom: 20px;
        }

        /* Select box */
        select {
            padding: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
            margin-right: 10px;
        }

        /* Text input field */
        .keyword {
            padding: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
            margin-right: 10px;
            width: 200px; /* Adjust width as needed */
        }

        /* 버튼 스타일링 */
form[name="buupSearchForm"] input[type="button"] {
    padding: 5px 10px;
    border-radius: 5px;
    border: none;
    background-color: #007bff;
    color: #fff;
    cursor: pointer;
}

/* 버튼 호버 효과 */
form[name="buupSearchForm"] input[type="button"]:hover {
    background-color: #0056b3;
}
        

    </style>
<script>

//현재 채용가능 글만 보기 함수
function buuping() {
    // 현재 날짜 가져오기
    var currentDate = new Date();
    var year = currentDate.getFullYear();
    var month = ('0' + (currentDate.getMonth() + 1)).slice(-2);
    var day = ('0' + currentDate.getDate()).slice(-2);
    var formattedCurrentDate = year + month + day;

    // 현재 날짜를 기준으로 조건값 계산
    var ingValue = formattedCurrentDate;

    // 부업 검색 폼에서 ing 필드 설정
    $("[name='buupSearchForm']").find("[name='ing']").val(ingValue);
    // 검색 함수 호출
    search1();
	}

//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
// 상세보기 화면으로 이동하는 
// gobuupDetailForm 함수 선언하기
// 매개변수로 게시판의 고유번호가 들어온다.
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
function gobuupDetailForm(b_no){
	
	//----------------------------------
	// name='boardDetailForm' 을 가진 form 태그 후손중에 
	// name='b_no' 가진 태그에 매개변수로 들어온 게시판의 고유번호를 
	// 삽입하기
	//----------------------------------
	$("[name='buupListDetailForm']").find("[name='b_no']").val(b_no);
	//----------------------------------
	// name='buupListDetailForm' 을 가진 
	// form 태그의 action 에 설정된 URL 주소로 WAS 접속해서 
	// 얻은 새 HTML 를 웹브라우저 열기.
	// 즉 화면 이동하기.
	//---------------------------------- 
	document.buupListDetailForm.submit();
}

    //정렬함수
	function searchWithSort(sort){
		$("[name='buupSearchForm']").find("[name='sort']").val(sort);		
		$(".searchBtn").click();	
	    }



		//페이징 함수 
		function pageNoClick( clickPageNo ){
			$("[name='buupSearchForm']").find(".selectPageNo").val(clickPageNo);		
		    search1();		
		}

//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
// body 태그 안의 내용을 모드 읽은 후 실행할 자스 코드 설정
// $(function(){자스코드})
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
$(function(){
	// class=rowCntPerPage 를 가진 태그에 value 값으로 20을 넣어주기
	$(".rowCntPerPage").val("10"); 
	// search 함수 호출하기
	search1();
	})	

//	게시판 검색하는 함수 search() 선언.
//	[검색] 버튼 클릭 시 호출되는 함수이다.
	function search1(){
	
	var buupSearchFormObj = $("[name='buupSearchForm']");
	var keywordObj = buupSearchFormObj.find(".keyword");
//		var checkboxObj = buupSearchFormObj.find(".checkdate:checked")
	
	
	//---------------------------------------------
	// 입력된 키워드 읽어와서 변수 keyword 에 저장하기
	// 만약에 변수 keyword 에 문자가 안들어 있으면 "" 저장하기
	// 변수 keyword 에 앞뒤공백 제거하기
	//---------------------------------------------
	var keyword = keywordObj.val();
	
	if(typeof(keyword)!='string'){ keyword=""; }
	
	keyword = $.trim(keyword);
	keywordObj.val(keyword);

	
	
	buupSearchFormObj.find(".rowCntPerPage").val($("select")
			                   .filter(".rowCntPerPage").val() )
	
	//alert(buupSearchFormObj.serialize());
	
	$.ajax(
			{

				url      : "/buupList.do"	
				,type    : "post"					
				,data    : buupSearchFormObj.serialize( )		
				,success : function(responseHtml){
			
					var obj = $(responseHtml);
			
					$(".buupListDiv").html(obj.find(".buupListDiv").html());
					$(".pagingNos").html(
							obj.find(".pagingNos").html()
					);
					
// 					 $("body").append(
// 			                  "<textarea cols=100 rows=100>" +obj.find(".buupListDiv").html() +   "</textarea>"   
// 			               )
					/*$(".xxx").remove();
					$("body").prepend(
						"<textarea class=xxx cols=100 rows=100>"
						+ obj.filter(".boardListDiv").html()
						+"</textarea>"
					)*/
					
				}
				,error   : function(){
					alert("검색 실패! 관리자에게 문의 바람니다.");
				}
			}
		);
	}  // search( ) 종료부분
//******************************************************************* //

function searchReset() {
    var buupSearchFormObj = $("[name='buupSearchForm']");
    buupSearchFormObj.find(".keyword").val("");
    buupSearchFormObj.find("[name='sort']").val("");
    buupSearchFormObj.find("[name='work_place']").val("");
    buupSearchFormObj.find("[name='BuupsearchType']").val("");
    buupSearchFormObj.find("[name='ing']").val("");
    buupSearchFormObj.find("[name='rowCntPerPage']").val("10");
    search1(); // 초기화 후 다시 검색
}



</script>
  
</head>

<body>

   <div id="container">     
   <%@ include file="header.jsp" %>



	
    <div class="container"  id="wrap">
    
     <span style="cursor:pointer" onclick="location.replace('/buupList.do')">      
 		<h1 style="text-align: center;">부업</h1></span>
 
      <form name="buupSearchForm">
         <div style="text-align: center; margin-bottom: 20px;">
				
		   지역
           <select name="work_place" id="work_place">
            <option value="">지역을 선택해 주세요
            <option value="서울특별시">서울특별시
            <option value="인천광역시">인천광역시
            <option value="부산광역시">부산광역시
            <option value="경기도">경기도
            <option value="강원도">강원도
          </select>
          
          <select name="BuupsearchType" class="BuupsearchType">
            <option value="">전체</option>
            <option value="subject">제목</option>
            <option value="name">이름</option>
            <option value="content">내용</option>
             <option value="hope_work">희망업무</option>
            <option value="phone">휴대폰 번호</option>
        </select>


     


        	    <input type="text" name="keyword" class="keyword" >
        		<input type="button" value="검색"  class="searchBtn" onclick="search1();">
        		 <input type="button" value="초기화" class="resetBtn" onclick="searchReset()">	 
				<input type="hidden" name="sort"  class="sort" >
				<input type="hidden" name="selectPageNo" class="selectPageNo"  value="1">
				<input type="hidden" name="rowCntPerPage" class="rowCntPerPage">
		 		<input type="hidden" name="ing"  class="ing">

		  		<br>
		  		<span onclick="buuping();" >[현재 채용가능 글만 보기]</span>	    	
		  		
		 <select name="rowCntPerPage" class="rowCntPerPage" onChange="search1()">
				<option value="10">10
				<option value="15">15
				<option value="20">20
			</select>행보기 &nbsp;&nbsp;&nbsp;
			
		         </div>

     <div class="buupListDiv">
         <form action="submit.php" method="POST">
           <table style="border:1px solid black;margin-left:auto;margin-right:auto;">
                          
              <tr> 
                   <th>번호</th>
                   <th>제목</th> 
                   <th>희망업무</th>
                   <th>주소</th>
                   <th>지원기간</th>
                <! --============================================================= -->
				<!-- 만약 파명 "sort" 의 파값이 비었으면 -->
				<!-- 즉 정렬 의지가 없으면               -->
				<!--============================================================= -->
				<c:if test="${param.sort!='reg_date asc' and param.sort!='reg_date desc'}">
					<th style="cursor:pointer" onClick="searchWithSort('reg_date desc')">작성일</th>
				</c:if>
				<!--============================================================= -->
				<!-- 만약 파명 "sort" 의 파값이 'reg_date desc' 면 -->
				<!-- 즉 정렬 의지가 'reg_date desc' 면             -->
				<!--============================================================= -->
				<c:if test="${param.sort=='reg_date desc'}">
					<th  style="cursor:pointer" onClick="searchWithSort('reg_date asc')">작성일▼</th>
				</c:if>
				<!--============================================================= -->
				<!-- 만약 파명 "sort" 의 파값이 'reg_date asc' 면 -->
				<!-- 즉 정렬 의지가 'reg_date asc' 면             -->
				<!--============================================================= -->
				<c:if test="${param.sort=='reg_date asc'}">
					<th style="cursor:pointer" onClick="searchWithSort('')">작성일▲</th>
				</c:if>  
              </tr>
 
           <c:forEach var="buup" items="${requestScope.buupList}"  varStatus="status">
              <tr style="cursor:pointer" onClick="gobuupDetailForm(${buup.b_no});">
                  <td>${requestScope.boardMap.begin_serialNo_desc-status.index}</td>             
                  <td>${buup.subject}</td>
                  <td>${buup.hope_work}</td>
                  <td>${buup.addr}</td>
                  <td>${buup.start_date} ~<br> ${buup.end_date}</td>
                  <td>${buup.reg_date}</td>
              </tr>   
           </c:forEach>
            
            
         </table>
        </div>
                 <c:if test="${empty requestScope.buupList}">
			              <center>
			              	<b>조회할 데이터가 없습니다.</b>
			              </center>
			              
			      </c:if>
		
<center> 
	<!--nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn-->
	<!--- 게시판 페이징 번호 출력하기.  시작   -->
	<!--nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn-->
	
	<span class="pagingNos">
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
		[${requestScope.buupListCnt}/${requestScope.buupListAllCnt}]개 	
		<!--------------------------------------------->
	&nbsp;&nbsp;
	</span>
	<!--nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn-->
	<!--- 게시판 페이징 번호 출력하기.  끝   -->
	<!--nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn-->
	     <center>
			 <input type="button" value="등록" onCLick= "location.replace('/buupListRegForm.do')"> 
		</center> 
		
      </form>
      
      
		<form name="buupListDetailForm" action="/buupListDetailForm.do" method="post">
			<input type="hidden" name="b_no" class="b_no">
			<input type="hidden" name="resume_no" class="resume_no">
		</form>
	
   </div>
</body>


    <%@ include file="footer.jsp" %>
</html>