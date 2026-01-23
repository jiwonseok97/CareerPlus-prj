<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common.jsp"%>

<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%> 
<%@ page import="com.wa.erp.BoardDTO" %>
<!DOCTYPE html>
<html>

<head>
<script>
$(document).ready(function() {
    // 페이지 로드 시, 두 번째와 세 번째 셀렉트 박스를 비활성화
 
    $('#multisort2').prop('disabled', true);
    $('#multisort3').prop('disabled', true);
    
    // 첫 번째 셀렉트 박스의 값이 변경될 때
    $('#multisort1').on('change', function() {
        var value = $(this).val();
        if (value) {
            // 첫 번째 셀렉트 박스가 선택되면 두 번째 셀렉트 박스를 활성화
            $('#multisort2').prop('disabled', false);
            $('#multisort3').prop('disabled', true);

            // 두 번째 셀렉트 박스의 옵션 변경
            $('#multisort2 option[value!=""]').remove();
            if (value !== 'sal_avg desc') {
                $('#multisort2').append('<option value=",sal_avg desc">평균 연봉▼</option>');
            }
            if (value !== 'sales desc') {
                $('#multisort2').append('<option value=",sales desc">매출▼</option>');
            }
            if (value !== '7 desc') {
                $('#multisort2').append('<option value=",7 desc">별점▼</option>');
            }
        } else {
            // 선택되지 않으면 나머지 셀렉트 박스를 비활성화하고 초기화
            $('#multisort2').prop('disabled', true).val('');
            $('#multisort3').prop('disabled', true).val('');
        }
        // 호출할 search 함수
       searchWithMultiSort();
    });

    // 두 번째 셀렉트 박스의 값이 변경될 때
    $('#multisort2').on('change', function() {
        var value = $(this).val();
        if (value) {
            // 두 번째 셀렉트 박스가 선택되면 세 번째 셀렉트 박스를 활성화
            $('#multisort3').prop('disabled', false);
            // 세 번째 셀렉트 박스의 옵션 변경
            $('#multisort3 option[value!=""]').remove();
            if (value !== ',sal_avg desc' && $('#multisort1').val()!=='sal_avg desc') {
                $('#multisort3').append('<option value=",sal_avg desc">평균 연봉▼</option>');
            }
            if (value !== ',sales desc' && $('#multisort1').val()!=='sales desc') {
                $('#multisort3').append('<option value=",sales desc">매출▼</option>');
            }
            if (value !== ',7 desc' && $('#multisort1').val()!=='7 desc') {
                $('#multisort3').append('<option value=",7 desc">별점▼</option>');
            }
        } else {
            // 선택되지 않으면 세 번째 셀렉트 박스를 비활성화하고 초기화
            $('#multisort3').prop('disabled', true).val('');
        }
        // 호출할 search 함수
        searchWithMultiSort();
    });

    // 세 번째 셀렉트 박스의 값이 변경될 때
    $('#multisort3').on('change', function() {
        // 호출할 search 함수
searchWithMultiSort()  ;
        });
});
</script>

   <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
       .container {
		    background-color: #fff;
		    border-radius: 10px;
		}
		
		.welfare-box {
			margin:0 auto;
		    padding: 5px;
		    border: 1px solid #ccc;
		    border-radius: 5px;
		}
		
		/* 라벨 스타일링 */
		.welfare-options {
		    display: grid;
		    grid-template-columns: repeat(4, 1fr);
		    grid-column-gap: 10px;
		}
    </style>
<style>

.fas.fa-heart {
    color: red;
}
.star-container { 
       font-size: 18px; 
       display: flex; 
       align-items: center; 
       gap: 10px; 
     } 

    .star {
      background: linear-gradient(to right, #EAB838, #EAB838 50%, #E0E2E7 50%);
      color: transparent;
      -webkit-background-clip: text;
    }

    .star-container .star-grade {
      font-weight: 700;
    }

/* 	        .container { */
/*             text-align: center; */
/*         } */
/*         .welfare-options { */
/*             display: inline-block; */
/*             text-align: left; */
/*             margin: 0 auto; */
/*             columns: 4; /* 두 개의 열로 나누어 정렬 */ 
/*             column-gap: 20px; /* 열 간격 */ 
/*         } */
/*         .welfare-options label { */
/*             display: block; */
/*             margin: 5px 0; */
/* 		} */
		
  #firstSelect {
    text-align: center; /* 텍스트를 수평 가운데 정렬합니다. */
  }
  #firstSelect option {
    text-align: center; /* 옵션 텍스트를 수평 가운데 정렬합니다. */
  }
   #secondSelect {
    text-align: center; /* 텍스트를 수평 가운데 정렬합니다. */
  }
  #secondSelect option {
    text-align: center; /* 옵션 텍스트를 수평 가운데 정렬합니다. */
  }
   #thirdSelect {
    text-align: center; /* 텍스트를 수평 가운데 정렬합니다. */
  }
  #thirdSelect option {
    text-align: center; /* 옵션 텍스트를 수평 가운데 정렬합니다. */
  }
</style>



 <style>
        .company-info {
            margin: 20px auto;
            width: 80%;
            max-width: 600px;
            font-family: Arial, sans-serif;
            line-height: 1.4;
        }
        .company-info .label {
            font-weight: bold;
            color: #333;
            width: 120px;
            display: inline-block;
        }
        .company-info .value {
            color: #555;
        }
        .company-info .row {
            margin-bottom: 5px;
        }
       /* 전체 컨테이너 스타일링 */


/* 라벨 스타일링 */
form[name="boardSearchForm"] label {
    margin-right: 10px;
    margin-bottom: 5px;
}

/* 셀렉트 박스 스타일링 */
form[name="boardSearchForm"] select {
    padding: 5px;
    border-radius: 5px;
    border: 1px solid #ccc;
    margin-right: 10px;
}

/* 키워드 입력 필드 스타일링 */
form[name="boardSearchForm"] input[type="text"] {
    padding: 5px;
    border-radius: 5px;
    border: 1px solid #ccc;
    margin-right: 10px;
}

/* 버튼 스타일링 */
form[name="boardSearchForm"] input[type="button"] {
    padding: 5px 10px;
    border-radius: 5px;
    border: none;
    background-color: #007bff;
    color: #fff;
    cursor: pointer;
}

/* 버튼 호버 효과 */
form[name="boardSearchForm"] input[type="button"]:hover {
    background-color: #0056b3;
}
    </style>
<script>

function search(){
	//---------------------------------------------
	// 변수 boardSearchFormObj 선언하고 
	// name='boardSearchForm' 를 가진 form 태그 관리 JQuery 객체를 생성하고 저장하기
	//---------------------------------------------
	var boardSearchFormObj = $("[name='boardSearchForm']");
	var searchWithIndustry = boardSearchFormObj.find("select").val();
	var sidoObj              = boardSearchFormObj.find(".sido").val();
	var gugunObj           = boardSearchFormObj.find(".gugun").val();
	var welfareObj = boardSearchFormObj.find('[name="welfare"]:checked').map(function() { return this.value; }).get();
	// 검색 함수 호출
	var keywordObj        = boardSearchFormObj.find(".keyword");
	var keyword             = keywordObj.val();
		if( typeof(keyword)!='string' ){ keyword = ""; }
	keyword = $.trim(keyword);
	keywordObj.val(keyword);
	boardSearchFormObj.find(".rowCntPerPage").val($("select").filter(".rowCntPerPage").val())
	   if($('#multisort1').val()==''){
		    $('#multisort2').prop('disabled', true);
		    $('#multisort3').prop('disabled', true);
		    };
// 	   if($('#multisort1').val()==''){
// 		    $('#multisort2').prop('disabled', true);
// 		    $('#multisort3').prop('disabled', true);
// 		    };
	
	//-----------------------------------------------------
	// JQuery 객체의 [ajax 메소드]를 호출하여
	// WAS 에 "/boardList.do" 주소로 접속하고 
	// boardList.jsp 페이지의 실행 결과인 HTML 코드를 문자로 받아서
	// <div class='boardListDiv'> 태그 내부의 게시판 관련 검색 결과 목록 부분을
	// 현화면의 <div class='boardListDiv'> 태그 내부에 덮어쓰기
	//-----------------------------------------------------
	$.ajax(
		{
			//-------------------------------
			// WAS 로 접속할 주소 설정
			//-------------------------------
			url      : "/companyList.do"
			//-------------------------------
			// WAS 로 접속하는 방법 설정. get 또는 post
			//-------------------------------
			,type    : "post"
			//--------------------------------------
			// WAS 에 보낼 파명과 파값을 설정하기. "파명=파값&파명=파값~"
			//--------------------------------------
			,data    : boardSearchFormObj.serialize( )
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
            $(".boardListDiv").html( 
                  obj.filter(".boardListDiv").html() 
            );
            $(".pagingNos").html( 
                  obj.filter(".pagingNos").html() 
            ); 
         }
         ,error   : function(){
            alert("검색 실패! 관리자에게 문의 바람니다.");
         }
      }
   );
}
///////////////////////search()종료부분
function searchReset(){

   var boardSearchFormObj = $("[name='boardSearchForm']");
   boardSearchFormObj.find(".keyword").val("");
    $("[name='boardSearchForm']").find("[name='sort']").val("");
    $("[name='boardSearchForm']").find("[name='selectfield_code']").val("");
    $("[name='boardSearchForm']").find("[name='sido']").val("시/도 선택");
    $("[name='boardSearchForm']").find("[name='gugun']").val("구/군 선택");
    document.getElementById('1').checked = false;
    document.getElementById('2').checked = false;
    document.getElementById('3').checked = false;
    document.getElementById('4').checked = false;
    document.getElementById('5').checked = false;
    document.getElementById('6').checked = false;
    document.getElementById('7').checked = false;
    document.getElementById('8').checked = false;
    document.getElementById('9').checked = false;
    document.getElementById('10').checked = false;
    document.getElementById('11').checked = false;
    document.getElementById('12').checked = false;
    document.getElementById('13').checked = false;
    document.getElementById('14').checked = false;
    document.getElementById('15').checked = false;
    document.getElementById('16').checked = false;
    $('#multisort1').val('');
	$('#multisort2').val('');
	$('#multisort3').val('');
    $(".searchBtn").click();
}


function searchWithIndustry(selectfield_code){
    $("[name='boardSearchForm']").find("[name='selectfield_code']").val(selectfield_code);
   $(".searchBtn").click();
}


function searchWithSort(sort){

	$('#multisort1').val('');
	$('#multisort2').val('');
	$('#multisort3').val('');
	
	$("[name='boardSearchForm']").find("[name='sort']").val(sort);
    $(".searchBtn").click();

}

function gocompanyListDetailForm(c_no){
      $("[name='companyListDetailForm']").find("[name='c_no']").val(c_no);
   
       document.companyListDetailForm.submit();
   
}


function pageNoClick(clickPageNo){
//	alert(clickPageNo);
//---------------------------------------------
// name='selectPageNo' 를 가진 태그의 value 값에 
// 매개변수로 들어오는 [클릭한 페이지 번호]를 저장하기
// 즉 <input type="hidden" name="selectPageNo" value="1"> 태그에
// value 값에 [클릭한 페이지 번호]를 저장하기
//---------------------------------------------
$("[name='boardSearchForm']").find(".selectPageNo").val(clickPageNo);
search();
}

function searchWithMultiSort(){
	$("[name='boardSearchForm']").find("[name='sort']").val('');
	search();

}



</script>

</head>
<body>

      <%@ include file="header.jsp"%>


			<h1 style="text-align: center;">기업 정보</h1>


         <form name="boardSearchForm" onsubmit="return false">
            <div style="text-align: center; margin-bottom: 20px;">
                <select name="sido" id="sido" class="sido"></select>
                    <select name="gugun" id="gugun" class="gugun"></select>  
               <input type="text" name="keyword" class="keyword"> 
               <input type="button" value="검색" class="searchBtn" onclick="search()"></input>
                <input type="button" value="초기화" class="resetBtn" onclick="searchReset()">
                   <select name="rowCntPerPage" class="rowCntPerPage" onChange="search()" >
					<option value="10">10</option>
					<option value="20">20</option>
					<option value="30">30</option>
			    </select>행보기 &nbsp;&nbsp;&nbsp;

				<br>
            <div align="center" style="margin-top:5px;">
               업종<select name="selectfield_code" class="selectedIndustry"
                  onChange="search()">
                  
                  				<option value="0">업종 선택</option>
                  				<option value="1">경영·사무</option>
								<option value="2">영업·고객상담</option>
								<option value="3">IT·인터넷</option>
								<option value="4">디자인</option>
								<option value="5">미디어</option>
								<option value="6">건설</option>
								<option value="7">교육</option>
								<option value="8">의료</option>
								<option value="9">생산</option>
								<option value="10">금융</option>
								<option value="11">법률</option>
								<option value="12">마케팅</option>
								<option value="13">공공서비스</option>
								<option value="14">연구·개발</option>
								<option value="15">물류·운송</option>
								<option value="16">예술·문화</option>
								<option value="17">환경</option>
								<option value="18">자원·에너지</option>
								<option value="19">숙박·요식업</option>
								<option value="20">스포츠·레저</option>
								<option value="21">제조·생산</option>
								<option value="22">농업·수산업</option>
								<option value="23">해양·항공</option>
               </select>
            </div>
            <br>

            <div class="container">
		        <b>사내 복지</b><br>
		        <div class="welfare-box" style="width:1000px; text-align:left; padding-left:100px;" >
		        <div class="welfare-options">
		            <label><input type="checkbox" name="welfare" value="4대보험가입" id="1"> 4대보험가입</label>
		            <label><input type="checkbox" name="welfare" value="연금가입" id="2"> 연금가입</label>
		            <label><input type="checkbox" name="welfare" value="보너스 및 인센티브" id="3"> 보너스 및 인센티브</label>
		            <label><input type="checkbox" name="welfare" value="수당제도" id="4"> 수당제도</label>
		            <label><input type="checkbox" name="welfare" value="사내동호회 운영" id="5"> 사내동호회 운영</label>
		            <label><input type="checkbox" name="welfare" value="경조사 지원" id="6"> 경조사 지원</label>
		            <label><input type="checkbox" name="welfare" value="출산/육아 지원제도" id="7"> 출산/육아 지원제도</label>
		            <label><input type="checkbox" name="welfare" value="사무용품 지원" id="8"> 사무용품 지원</label>
		            <label><input type="checkbox" name="welfare" value="자유복장" id="9"> 자유복장</label>
		            <label><input type="checkbox" name="welfare" value="식대제공" id="10"> 식대제공</label>
		            <label><input type="checkbox" name="welfare" value="기숙사 및 사택 제공" id="11"> 기숙사 및 사택 제공</label>
		            <label><input type="checkbox" name="welfare" value="차량유류비 지급" id="12"> 차량유류비 지급</label>
		            <label><input type="checkbox" name="welfare" value="통근버스 운행" id="13"> 통근버스 운행</label>
		            <label><input type="checkbox" name="welfare" value="교통비 지급" id="14"> 교통비 지급</label>
		            <label><input type="checkbox" name="welfare" value="유연근무제" id="15"> 유연근무제</label>
		            <label><input type="checkbox" name="welfare" value="각종 행사" id="16"> 각종 행사</label>
		        </div>
		       </div>  
		    </div>
             <div>
             <br>
             	
        <select id="multisort1"  name="multisort1"  >
                  <option value=''> 정렬 조건  </option>
                  <option value="sal_avg desc" >평균 연봉▼
                  <option value="sales desc"  >     매출▼
                  <option value="7 desc"> 별점▼
        </select> >>
 
        <!-- 두 번째 셀렉트 박스 -->
        <select id="multisort2" name="multisort2" >
				 <option value=''> 정렬 조건</option>		
                  <option value=",sal_avg desc">평균 연봉▼
                  <option value=",sales desc">매출▼
                  <option value=",7 desc"> 별점▼        </select> >>
 
        <!-- 세 번째 셀렉트 박스 -->
        <select id="multisort3" name="multisort3" >
                  <option value=''> 정렬 조건 </option>
                  <option value=",sal_avg desc">평균 연봉▼
                  <option value=",sales desc">     매출▼
                  <option value=",7 desc"> 별점▼        </select>
    </div>
            <input type="hidden" name="selectPageNo" class="selectPageNo" value="1">
	        <input type="hidden" name="rowCntPerPage" class="rowCntPerPage">
            <input type="hidden" name="sort" class="sort" value="">
<!--             <input type="hidden" name="multisort1" class="multisort1" value=""> -->
<!--             <input type="hidden" name="multisort2" class="multisort2" value=""> -->
<!--             <input type="hidden" name="multisort3" class="multisort3" value=""> -->
            
         
            	    </div>
         	</form>
         	
         <br>
                  <div class="boardListDiv" id="container">

				
					<table  id="rwd-table" 
						style="border: 1px solid black; margin-left: auto; margin-right: auto;">



				<tr>
					<th>번 호</th>
					<th>기업 정보</th>
						<c:if  test="${param.sort!='sal_avg asc' and param.sort!='sal_avg desc'}">
				            <th style="cursor: pointer" onClick="searchWithSort('sal_avg desc')">연봉</th>
				         </c:if>
				         <c:if test="${param.sort=='sal_avg desc'}">
				            <th style="cursor: pointer" onClick="searchWithSort('sal_avg asc')">연봉▼</th>
				         </c:if>
				         <c:if test="${param.sort=='sal_avg asc'}">
				            <th style="cursor: pointer" onClick="searchWithSort('')">연봉▲</th>
				         </c:if>
				         <c:if test="${param.sort!='sales asc' and param.sort!='sales desc'}">
				            <th style="cursor: pointer" onClick="searchWithSort('sales desc')">매출</th>
				         </c:if>
				         <c:if test="${param.sort=='sales desc'}">
				            <th style="cursor: pointer" onClick="searchWithSort('sales asc')">매출▼</th>
				         </c:if>
				         <c:if test="${param.sort=='sales asc'}">
				            <th style="cursor: pointer" onClick="searchWithSort('')">매출▲</th>
				         </c:if>
						<c:if test="${param.sort!='7 asc' and param.sort!='7 desc'}">
            				<th style="cursor: pointer font-weight: bold;"onClick="searchWithSort('7 desc')">별점</th>
         				</c:if>
         				<c:if test="${param.sort=='7 desc'}">
            				<th style="cursor: pointer"onClick="searchWithSort('7 asc')">별점▼</th>
         				</c:if>
         				<c:if test="${param.sort=='7 asc'}">
            				<th style="cursor: pointer" onClick="searchWithSort('')">별점▲</th>
         				</c:if> 
						 <c:if test="${param.sort!='ci.rec_count asc' and param.sort!='ci.rec_count desc'}">
            				<th style="cursor: pointer"onClick="searchWithSort('ci.rec_count desc')">관심수</th>
         				</c:if>
         				<c:if test="${param.sort=='ci.rec_count desc'}">
            				<th style="cursor: pointer"onClick="searchWithSort('ci.rec_count asc')">관심수▼</th>
         				</c:if>
         				<c:if test="${param.sort=='ci.rec_count asc'}">
            				<th style="cursor: pointer" onClick="searchWithSort('')">관심수▲</th>
         				</c:if> 
				</tr>
                  <c:forEach var="board" items="${requestScope.companyList }"
                     varStatus="status">

                     					           
                     
                     <tr style="cursor: pointer"
                        onClick="gocompanyListDetailForm(${board.c_no});">
                        <td>    ${requestScope.boardMap.begin_serialNo_desc - status.index}</td>
                        <td>
                           <div style="display: flex; align-items: center;">
                              <img width="80" src="images/photo-1.jpg" style="margin-right: 10px;">
                              <input type="hidden" value="	${requestScope.boardMap.begin_serialNo_desc - status.index}">
                        	  &nbsp;&nbsp;&nbsp;&lt기업명&gt	&nbsp;${board.name}<br>
                              &nbsp;&nbsp;&nbsp; &lt업종&gt &nbsp;&nbsp;&nbsp;${board.indus}<br>
                              &nbsp;&nbsp;&nbsp; &lt주소&gt &nbsp;&nbsp;&nbsp;${board.addr}<br>
                           </div>
                          </td>
						<td>${board.sal_avg} 만원</td>
						<td>${board.sales} 천만원</td>
			            <td align="center">
			                <div class="star-container">
			                    <div class="star" id="star-rating">&#9733;&#9733;&#9733;&#9733;&#9733;</div>
			                    <span class="star-grade" id="star-grade">${board.star_avg}</span>
			                </div>
			            </td>
						<td><c:choose>
								<c:when test="${likeNoList.contains(board.c_no)}">
									<i class="fas fa-heart"></i>
								</c:when>
								<c:otherwise>
									<i class="far fa-heart"></i>
								</c:otherwise>
							</c:choose> ${board.rec_count}</td>
				</tr>

			</c:forEach>


               </table>

		<c:if test="${empty requestScope.companyList}">
                  <center>
                     <b> 조회할 데이터가 없습니다. </b>
                  </center>
               </c:if>
                              </div>
  <span class="pagingNos">
             		<center>
             
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
		[${requestScope.companyListCnt}/${requestScope.companyListAllCnt}]개 	
		
		<!--------------------------------------------->
		&nbsp;&nbsp;
               </center>
       
         
         <form name="companyListDetailForm" action="/companyListDetail.do"  method="post">
            <!-- 클릭한 행의 게시판 고유번호가 저장될 히든태그 선언 -->
            <input type="hidden" name="c_no" value="${board.c_no}">
         </form>
         	</span>

</body>
<%@ include file="footer.jsp"%>
</html>