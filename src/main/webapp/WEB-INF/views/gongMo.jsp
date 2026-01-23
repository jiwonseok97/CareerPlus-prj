<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@include file="/WEB-INF/views/common.jsp"%>  

<!DOCTYPE html>
<html>

<head>
<style>
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

    /* Select box */
    select {
        padding: 8px;
        border-radius: 5px;
        border: 1px solid #ccc;
        margin-right: 10px;
    }
    
    /* 버튼 스타일링 */
form[name="gongMoSearchForm"] input[type="button"] {
    padding: 5px 10px;
    border-radius: 5px;
    border: none;
    background-color: #007bff;
    color: #fff;
    cursor: pointer;
}

/* 버튼 호버 효과 */
form[name="gongMoSearchForm"] input[type="button"]:hover {
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
	
	       $("[name='gongMoSearchForm']").find("[name='ing']").val(ingValue); 
	       $(".searchBtn").click();
	      }

		
		
		function searchWithSort(sort){
			
			$("[name='gongMoSearchForm']").find("[name=sort]").val(sort);
			
			$(".searchBtn").click();
			
		}
		
		function goBoardDetailForm(comp_pk){
			// 		name='boardDetailForm' 을 간 form 태그 후손 중에
			// 		name='b_no' 가진 태그에 매개변수로 들어온 게시판의 고유번호를 삽입하기
			//		location.replace("/boardDetailForm.do?b_no="+b_no);		>> get 방식.
		 		$("[name='gongMoDetailForm']").find("[name='prj_no']").val(comp_pk);
		 		//----------------------------------
		 		// name='boardDetailForm' 을 가진 
		 		// form 태그의 action 에 설정된 URL 주소로 WAS 접속해서 
		 		// 얻은 새 HTML 를 웹브라우저 열기.
		 		// 즉 화면 이동하기.
		 		//----------------------------------
		 		document.gongMoDetailForm.submit();
			}
		
		function search(){
			
			var gongMoSearchFormObj = $("[name=gongMoSearchForm]");
			
			var keywordObj = gongMoSearchFormObj.find(".keyword");
			
			var keyword = keywordObj.val();
			if(typeof(keyword)!='string'){keyword = "";}
			keyword = $.trim(keyword);
			keywordObj.val(keyword)
			
			gongMoSearchFormObj.find(".rowCntPerPage").val( 
					$("select").filter(".rowCntPerPage").val()
			)
			
			$.ajax(
					{
					// WAS 로 접속할 주소 설정
					url : "/gongMo.do"
					// WAS 로 접속하는 방법 설정. get 또는 post
					, type : "post"
					// WAS 에 보낼 파명과 파값을 설정하기. "파명=파값&파명=값~"
					, data : gongMoSearchFormObj.serialize()
					// WAS 의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
					// 이때 익명함수의 매개변수로 WAS 의 응답물이 들어 온다.
					// "/boardList.do" 주소의 응답물은 boardList.jsp 페이지의
					// 실행결과인 HTML 문서 문자열이다.
					, success : function(responseHtml){
						// 매개변수로 들어오는 HTML 문자열을 관리하는 JQuery 객체 생성하여
						// 변수 obj 에 저장하기
						var obj = $(responseHtml);
						// 매개변수로 받은 HTML 문자열 중에
						// <div class='boardListDiv'> 태그 안에 html 문자열을
						// 현 화면의 <div class='boardListDiv'>태그 안에 덮어 쓰기
						$(".gongMoListDiv").html(
								obj.find(".gongMoListDiv").html()		
						);
						$(".pagingNos").html(
								obj.find(".pagingNos").html()		
						);
						
					}
					,error : function(){
						alert("검색 실패! 관리자에게 문의 바랍니다.")
					}
				}
			)
		}
		
		function pageNoClick( clickPageNo ){
			//---------------------------------------------
			// name='selectPageNo' 를 가진 태그의 value 값에 
			// 매개변수로 들어오는 [클릭한 페이지 번호]를 저장하기
			// 즉 <input type="hidden" name="selectPageNo" value="1"> 태그에
			// value 값에 [클릭한 페이지 번호]를 저장하기
			//---------------------------------------------
			$("[name='gongMoSearchForm']").find(".selectPageNo").val(clickPageNo);
			search();
		}
		
		function goGongMoDetailForm(comp_pk){
			// 		name='boardDetailForm' 을 간 form 태그 후손 중에
			// 		name='b_no' 가진 태그에 매개변수로 들어온 게시판의 고유번호를 삽입하기
			//		location.replace("/boardDetailForm.do?b_no="+b_no);		>> get 방식.
		 		$("[name='gongMoDetailForm']").find("[name='comp_pk']").val(comp_pk);
		 		//----------------------------------
		 		// name='boardDetailForm' 을 가진 
		 		// form 태그의 action 에 설정된 URL 주소로 WAS 접속해서 
		 		// 얻은 새 HTML 를 웹브라우저 열기.
		 		// 즉 화면 이동하기.
		 		//----------------------------------
		 		document.gongMoDetailForm.submit();
			}
		
		
		function searchReset() {
		    var gongMoSearchFormObj = $("[name='gongMoSearchForm']");
		    gongMoSearchFormObj.find(".keyword").val("");
		    gongMoSearchFormObj.find("[name='sort']").val("");
		    gongMoSearchFormObj.find("[name='field_name']").val("");
		    gongMoSearchFormObj.find("[name='ing']").val("");
		    gongMoSearchFormObj.find("[name='rowCntPerPage']").val("10");
		    search(); // 초기화 후 다시 검색
		}
		
		</script>
	
  
</head>
<body>
	<div id="container">    
	 <%@ include file="header.jsp" %>

  </header>




    <br>
     <div id="wrap" class="container">
     <h1 style="text-align: center;">공모전</h1>
     <form name="gongMoSearchForm" onsubmit="return false">
        <div style="text-align: center; margin-bottom: 20px;">
        	<select name="field_name" class="field_name">
        		<option value="">모두</option>
        		<option value="IT·인터넷">IT·인터넷</option>
                <option value="디자인">디자인</option>
                <option value="미디어">미디어</option>
                <option value="교육">교육</option>
                <option value="의료">의료</option>
        	</select>
            <input type="text"   name="keyword" class="keyword">
            <input type="button" value="검색"   class="searchBtn" onclick="search()">
              <input type="button" value="초기화" class="resetBtn" onclick="searchReset()">	  
            <br>
            <span onclick="timeShareing();" >[진행중인 공모전만 보기]</span>
<select name="rowCntPerPage" class="rowCntPerPage" onChange="search()">
	<option value="10">10
	<option value="15">15
	<option value="20">20
</select> 행보기 &nbsp;&nbsp;&nbsp;
            <input type="hidden" name="field_code" class="field_code">
            <!-- nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn -->
            <input type="hidden" name="ing" class="ing">
        	<!-- nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn -->
			<input type="hidden" name="sort" class="sort">
			<!-- nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn -->
			<input type="hidden" name="selectPageNo" class="selectPageNo" value="1" >
			<!-- nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn -->
			<input type="hidden" name="rowCntPerPage" class="rowCntPerPage">
			<!-- nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn -->
        </div>
     </form>
     
     <div class="gongMoListDiv">
     <form action="submit.php" method="POST">
     		
          <table id="rwd-table" style="border:1px solid black;margin-left:auto;margin-right:auto;" >
              
              <tr>
                  <th>번호</th>
                  <th>제목</th>
                  <th>분야</th>
                  <th>기간</th>
                  <c:if test="${param.sort!='reg_date asc' and param.sort!='reg_date desc'}">
						<th style="cursor:pointer" onClick="searchWithSort('reg_date desc')">등록일</th>
					</c:if>
                  <c:if test="${param.sort=='reg_date desc'}">
						<th style="cursor:pointer" onClick="searchWithSort('reg_date asc')">등록일▼</th>
					</c:if>
					<c:if test="${param.sort=='reg_date asc'}">
						<th style="cursor:pointer" onClick="searchWithSort('')">등록일▲</th>
					</c:if>
                <c:if test="${param.sort!='read_count asc' and param.sort!='read_count desc'}">
					<th width="100" style="cursor:pointer" onClick="searchWithSort('read_count desc')"><center>조회수</center></th>
				</c:if>
					
				<c:if test="${param.sort=='read_count desc'}">
					<th width="100" style="cursor:pointer" onClick="searchWithSort('read_count asc')">조회수▼</th>
				</c:if>
			
				<c:if test="${param.sort=='read_count asc'}">
					<th width="100" style="cursor:pointer" onClick="searchWithSort('')">조회수▲</th>
				</c:if>
                  
                
              </tr >
              
              <c:forEach var="gongMo" items="${requestScope.gongMoList}"  varStatus="status">
              <tr  class="KOTRA-fontsize-80" style="cursor:pointer" onCLick= "goGongMoDetailForm(${gongMo.comp_pk})">
              	<td align="center"> ${requestScope.boardMap.begin_serialNo_desc-status.index}</td>
              	<td align="center"> ${gongMo.subject}</td>
              	<td align="center"> ${gongMo.field_name}</td>
              	<td align="center"> ${gongMo.start_time} ~ ${gongMo.end_time}</td>
              	<td align="center"> ${gongMo.reg_date}</td>
              	<td align="center"> ${gongMo.read_count}</td>
              </tr>
              </c:forEach>
            
            </form>
            
          </table>
          <c:if test="${empty gongMoList}">
          	<center>
          		조회할 데이터가 없습니다.
          	</center>
          </c:if>
          </div>
          <br>
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
		[${requestScope.gongMoListCnt}/${requestScope.gongMoListAllCnt}] 개 	
		<!--------------------------------------------->
		&nbsp;&nbsp;
</span>
<!--nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn-->
<!--- 게시판 페이징 번호 출력하기.  끝   -->
<!--nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn-->

</center>
          
      <c:if test="${sessionScope.member=='company'}">    
          <br>
     <center>
          <input type="button" value="등록" onCLick= "location.replace('/gongMoRegForm.do')">
     </center>
     </c:if>
  </div>
  
      <form name="gongMoDetailForm" action="/gongMoDetailForm.do" method="post">
		<input type="hidden" name="comp_pk">
		</form>
		
		</div>
</body>
<%@ include file="footer.jsp" %>
</html>
