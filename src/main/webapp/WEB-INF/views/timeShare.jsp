<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@include file="/WEB-INF/views/common.jsp"%>  
 

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">

<!-- Optional: Include jQuery and Bootstrap 4 JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>
<!DOCTYPE html>
<html>

<head>
    <style>
    
    
           /* Custom styles for the table */
        .timeShareListDiv table {
            width: 90%;
            margin: 0 auto; /* Center the table */
            border: 1px solid black;
        }

        /* Pagination button style */
        .pagination>li>a {
            border-radius: 50% !important;
            margin: 0 5px;
        }
        /* Form container */
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
            width: 200px; /* Adjust width as needed */
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
        
       .regBtn{
            padding: 5px 20px;
            border-radius: 5px;
            border: none;
            background-color: #007bff;
            color: #fff;
            cursor: pointer;
        }
        /* Select box */
        select {
            padding: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
            margin-right: 10px;
        }

 /* Custom styles for pagination */
    .pagination > .page-item > .page-link {
        border-radius: 50% !important;
        margin: 0 5px;
    }
 

.pagination .page-link:hover {
    background-color: #007bff;
    color: #fff;
    border-color: #007bff;
}


/* 버튼 스타일링 */
form[name="timeShareSearchForm"] input[type="button"] {
    padding: 5px 10px;
    border-radius: 5px;
    border: none;
    background-color: #007bff;
    color: #fff;
    cursor: pointer;
}

/* 버튼 호버 효과 */
form[name="timeShareSearchForm"] input[type="button"]:hover {
    background-color: #0056b3;
}



    </style>
<script>

//현재 채용가능 글만 보기 함수
function timeShareing(){
    // 현재 날짜 저장
    var currentDate = new Date();
    var year = currentDate.getFullYear();
    var month = ('0' + (currentDate.getMonth() + 1)).slice(-2);
    var day = ('0' + currentDate.getDate()).slice(-2);
    var formattedCurrentDate = year + month + day;

    // 현재 날짜를 기준으로 조건값 계산
    var ingValue = formattedCurrentDate; 

    $("[name='timeShareSearchForm']").find("[name='ing']").val(ingValue); 
    $(".searchBtn").click();
   }

//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
// 상세보기 화면으로 이동하는 
// gotimeShareDetailForm 함수 선언하기
// 매개변수로 게시판의 고유번호가 들어온다.
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
function gotimeShareDetailForm(b_no){
	
	//----------------------------------
	// name='boardDetailForm' 을 가진 form 태그 후손중에 
	// name='b_no' 가진 태그에 매개변수로 들어온 게시판의 고유번호를 
	// 삽입하기
	//----------------------------------
	$("[name='timeShareDetailForm']").find("[name='b_no']").val(b_no);
	//----------------------------------
	// name='buupListDetailForm' 을 가진 
	// form 태그의 action 에 설정된 URL 주소로 WAS 접속해서 
	// 얻은 새 HTML 를 웹브라우저 열기.
	// 즉 화면 이동하기.
	//---------------------------------- 
	document.timeShareDetailForm.submit();
	}

//정렬함수
function searchWithSort(sort){
	$("[name='timeShareSearchForm']").find("[name='sort']").val(sort);		
	$(".searchBtn").click();	
    }



	function pageNoClick( clickPageNo ){
		//alert(clickPageNo);
		//---------------------------------------------
		// name='selectPageNo' 를 가진 태그의 value 값에 
		// 매개변수로 들어오는 [클릭한 페이지 번호]를 저장하기
		// 즉 <input type="hidden" name="selectPageNo" value="1"> 태그에
		// value 값에 [클릭한 페이지 번호]를 저장하기
		//---------------------------------------------
		$("[name='timeShareSearchForm']").find(".selectPageNo").val(clickPageNo);
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

// 	게시판 검색하는 함수 search() 선언.
// 	[검색] 버튼 클릭 시 호출되는 함수이다.
	function search1(){
		//---------------------------------------------
		// 변수 timeShareSearchFormObj 선언하고 
		// name='timeShareSearchForm' 를 가진 form 태그 관리 JQuery 객체를 생성하고 저장하기
		//---------------------------------------------
		var timeShareSearchFormObj = $("[name='timeShareSearchForm']");
		var keywordObj = timeShareSearchFormObj.find(".keyword");
		
// 		var checkboxObj = timeShareSearchFormObj.find(".checkdate:checked")	
		//---------------------------------------------
		// 입력된 키워드 읽어와서 변수 keyword 에 저장하기
		// 만약에 변수 keyword 에 문자가 안들어 있으면 "" 저장하기
		// 변수 keyword 에 앞뒤공백 제거하기
		//---------------------------------------------
		var keyword = keywordObj.val();
		
		if(typeof(keyword)!='string'){ keyword=""; }
		
		keyword = $.trim(keyword);
		keywordObj.val(keyword);

		timeShareSearchFormObj.find(".rowCntPerPage").val($("select").filter(".rowCntPerPage").val() )		
		
	   
		//alert(timeShareSearchFormObj.serialize());
	
		$.ajax(
				{

					url      : "/timeShare.do"	
					,type    : "post"					
					,data    : timeShareSearchFormObj.serialize( )		
					,success : function(responseHtml){
				
						var obj = $(responseHtml);
				
						$(".timeShareListDiv").html( 
								obj.find(".timeShareListDiv").html() 
						);
						$(".pagingNos").html(
								obj.find(".pagingNos").html()
						);
						
// 						 $("body").append(
// 				                  "<textarea cols=100 rows=100>" +obj.find(".timeShareListDiv").html() +   "</textarea>"   
// 				               )
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
// ******************************************************************* //

function searchReset() {
    var timeShareSearchFormObj = $("[name='timeShareSearchForm']");
    timeShareSearchFormObj.find(".keyword").val("");
    timeShareSearchFormObj.find("[name='sort']").val("");
    timeShareSearchFormObj.find("[name='work_place']").val("");
    timeShareSearchFormObj.find("[name='TimeShareSearchType']").val("");
    timeShareSearchFormObj.find("[name='ing']").val("");
    timeShareSearchFormObj.find("[name='rowCntPerPage']").val("10");
    search1(); // 초기화 후 다시 검색
}


</script>
  
</head>


<body>
    <div id="container">    
	    <%@ include file="header.jsp" %>
 
 
 
 <div class="container"  id="wrap">
     <span onclick="location.replace('/timeShare.do')">
        <h1 style="text-align: center;">프리랜서</h1> </span>

    <form name="timeShareSearchForm">
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
        
   <select name="TimeShareSearchType" class="TimeShareSearchType">
            <option value="">전체</option>
            <option value="subject">제목</option>
            <option value="name">이름</option>
            <option value="content">내용</option>
             <option value="preferred_work">선호업무</option>
            <option value="phone">휴대폰 번호</option>
        </select>
                 
        	<input type="text" name="keyword" class="keyword"  placeholder="검색어를 입력해주세요.">

        	<input type="button" value="검색"  class="searchBtn" onclick="search1();"  style="padding: 5px 5px;">
            <input type="button" value="초기화" class="resetBtn" onclick="searchReset()">	    
			<input type="hidden" name="sort"  class="sort" >
			<input type="hidden" name="selectPageNo"  class="selectPageNo"  value="1">
			<input type="hidden" name="rowCntPerPage" class="rowCntPerPage">
			<input type="hidden" name="ing"  class="ingBtn" >
	  	
 
	   
			
       </div>
       <center>       <span onclick="timeShareing();" >[현재 채용가능 글만 보기]</span>	    	
       
       						<select name="rowCntPerPage" class="rowCntPerPage" onChange="search1()">
									<option value="10">10
									<option value="15">15
									<option value="20">20
								</select>행보기 &nbsp;&nbsp;&nbsp;
       </center>
 </form>
 
    <div class="timeShareListDiv">
         <form action="submit.php" method="POST">
           <table  id="rwd-table" style="border:1px solid black;margin-left:auto;margin-right:auto;">
             
              <tr>
                  <th width="100" >번호</th>
              	  <th>제목</th>
                  <th>선호업무</th> 
                  <th>주소</th>
                  <th width="150">희망 근무시간</th>
                  <th>지원기간</th>
                  
                                                  
               
				<c:if test="${param.sort!='reg_date asc' and param.sort!='reg_date desc'}">
					<th style="cursor:pointer" onClick="searchWithSort('reg_date desc')">등록일</th>
				</c:if>
				
				<c:if test="${param.sort=='reg_date desc'}">
					<th  style="cursor:pointer" onClick="searchWithSort('reg_date asc')">등록일▼</th>
				</c:if>
				
				<c:if test="${param.sort=='reg_date asc'}">
					<th style="cursor:pointer" onClick="searchWithSort('')">등록일▲</th>
				</c:if>
          </tr>
              
          
          <c:forEach var="timeShare" items="${requestScope.timeShare}"  varStatus="status">
              <tr class="KOTRA-fontsize-80" style="cursor:pointer" onClick="gotimeShareDetailForm(${timeShare.b_no});">
                 
                  <td align="center">${requestScope.boardMap.begin_serialNo_desc-status.index}</td>                 
                  <td align="center">${timeShare.subject}</td>
                  <td align="center">${timeShare.preferred_work}</td>
                  <td align="center">${timeShare.addr}</td>
                  <td align="center">${timeShare.start_time}시 ~  ${timeShare.end_time}시</td>
                  <td align="center">${timeShare.start_date} ~<br> ${timeShare.end_date}</td>
                  <td align="center">${timeShare.reg_date}</td>   
              </tr> 
              
                
           </c:forEach>
       
         </table>
        </div>
        
        	   <c:if test="${empty requestScope.timeShare}">
			              <center>
			              	<b>조회할 데이터가 없습니다.</b>
			              </center>       
			   </c:if>


<center> 


<span class="pagingNos">
<div class="container">
    <ul class="pagination justify-content-center">
        <!-- First page link -->
        <li class="page-item">
            <a class="page-link" href="javascript:void(0);" onclick="pageNoClick(1)">처음</a>
        </li>
        <!-- Previous page link -->
        <li class="page-item">
            <a class="page-link" href="javascript:void(0);" onclick="pageNoClick(${requestScope.boardMap.selectPageNo} - 1)">< </a>
        </li>
        <!-- Loop through page numbers -->
        <c:forEach var="pageNo" begin="${requestScope.boardMap.begin_pageNo}" end="${requestScope.boardMap.end_pageNo}">
            <li class="page-item">
                <c:choose>
                    <c:when test="${requestScope.boardMap.selectPageNo == pageNo}">
                        <span class="page-link">${pageNo}</span>
                    </c:when>
                    <c:otherwise>
                        <a class="page-link" href="javascript:void(0);" onclick="pageNoClick(${pageNo})">${pageNo}</a>
                    </c:otherwise>
                </c:choose>
            </li>
        </c:forEach>
        <!-- Next page link -->
        <li class="page-item">
            <a class="page-link" href="javascript:void(0);" onclick="pageNoClick(${requestScope.boardMap.selectPageNo} + 1)">></a>
        </li>
        <!-- Last page link -->
        <li class="page-item">
            <a class="page-link" href="javascript:void(0);" onclick="pageNoClick(${requestScope.boardMap.last_pageNo})">마지막</a>
        </li>
    </ul>
    [${requestScope.timeShareListCnt}/${requestScope.timeShareAllCnt}]개&nbsp;&nbsp;
</div>

</span>


	</center>
	      
          <center>
              <input type="button" value="등록"  class="regBtn"
              				 onCLick= "location.replace('/timeShareRegForm.do')"  style="padding: 5px 5px;">
          </center>
   </form>
   
   <form name="timeShareDetailForm" action="/timeShareDetailForm.do" method="post">
	  <input type="hidden" name="b_no" class="b_no">
	   <input type="hidden" name="p_no" value="${sessionScope.p_no}">   
	  <input type="hidden" name="resume_no" class="resume_no">
    </form>
 </div>
       
</body>
<%@ include file="footer.jsp" %> 
</html>