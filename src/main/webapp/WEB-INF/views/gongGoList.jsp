<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>12Wa~</title>
</head>

   <script>
  

   
   function goGonggoDetailForm(g_no){
 	   $("[name='gonggoDetailForm']").find("[name='g_no']").val(g_no);
 	  document.gonggoDetailForm.submit();
 	   
   }

 	
 	
 	$(function(){
 		   // class=rowCntPerPage 를 가진 태그에 value 값으로 20을 넣어주기
 		   $(".rowCntPerPage").val("10"); 
 		   // search 함수 호출하기
 		  searchForm();
 		})   

  
   function searchForm() {
 		
 

 	    var gonggoSearchFormObj = $("[name='gonggoSearchForm']");
 	    var keywordObj = gonggoSearchFormObj.find(".keyword");
 	    var keyword = keywordObj.val();

 	    if (typeof(keyword) != 'string') {
 	        keyword = "";
 	    }
 	    keyword = $.trim(keyword);
 	    keywordObj.val(keyword);
 	    

                 
  gonggoSearchFormObj.find(".rowCntPerPage").val($("select")
                             .filter(".rowCntPerPage").val() )
 	    
 	 
 	    /*    alert(gonggoSearchFormObj.serialize());  */
 	
/* 	if( work_place.eq(0) == ''){
		 sessionStorage.removeItem('dataValue'); 		
	} */
 	    $.ajax(
 	    	{
 	        url: "/gongGoList.do",
 	        type: "post",
 	        data: gonggoSearchFormObj.serialize(),
 	        success: function(responseHtml) {
 	        
 	            var obj = $(responseHtml);
 	        	
 	        	
  	    //	     $("body").append("<hr>" + responseHtml );
  	    //    	return;     
 	            $(".gongGoListDiv").html(
 	            		obj.find(".gongGoListDiv").html()
 	            		);
 	            
 	             $(".pagingNos").html(
                       obj.find(".pagingNos").html()
                 );

//                $("body").append(
//                "<textarea cols=100 rows=100>" +obj.find(".gongGoListDiv").html() +   "</textarea>"   
//             )
 	        },
 	        error: function() {
 	            alert("검색 실패");
 	        }
 	    });
 	}

  	function searchWithSort(sort){
  		
 		$("[name='gonggoSearchForm']").find("[name='sort']").val(sort);
 		$(".searchBtn").click();
 		
 		
 		
 	}		  
 	 
  	 //mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
 	// [페이지 번호]를 클릭하면 호출되는 함수 pageNoClick 선언하기 
 	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
 	function pageNoClick( clickPageNo ){
 		/* alert(clickPageNo); */
 		//---------------------------------------------
 		// name='selectPageNo' 를 가진 태그의 value 값에 
 		// 매개변수로 들어오는 [클릭한 페이지 번호]를 저장하기
 		// 즉 <input type="hidden" name="selectPageNo" value="1"> 태그에
 		// value 값에 [클릭한 페이지 번호]를 저장하기
 		//---------------------------------------------
 		$("[name='gonggoSearchForm']").find(".selectPageNo").val(clickPageNo);
 		searchForm();
 	}  
 	
 			  
 			  
 		
   
   </script>
   
 </head>
   
 <body>
  <div id="container">    
   <%@ include file="header.jsp" %>
 <!--         
 <div style="text-align: left; width:145px; float: left;"><br><br>
 		<li><a onCLick= "location.replace('/gongGoLocationList.do')">지역별</a></li>
 		<li onCLick= "location.replace('/gongGoUpjongList.do')">업무별</li>
 		<li onCLick= "location.replace('/gongGoTOP100List.do')">TOP100</li>
 </div> -->
     
    
     
    
   		<br>
   		<br>
   	<center>
   	          
   	   <form name="gonggoSearchForm"  onsubmit="return false">
   	   			공고상태
   	   			 <select name="gonggoStatus" id="gonggoStatus">
                 		<option value="">공고 상태 선택
                           <option value="ing">진행중인 공고
                           <option value="end">마감된 공고
   	    		</select>
                 지역별
                 
                 <select name="work_place" id="work_place">
                 		<option value="">지역을 선택해 주세요
                           <option value="서울특별시">서울특별시
      					 <option value="인천광역시">인천광역시
      					 <option value="부산광역시">부산광역시
      					 <option value="경기도">경기도
      					 <option value="강원도">강원도
                 </select>
             
                    
                  업종별
                   
                       <select id="industry" name="industry" required>
                       	<option value="">업종을 선택해 주세요
                           <option value="화장품 및 뷰티 제품 제조업">화장품 및 뷰티 제품 제조업
      					 <option value="식품 및 음료 소매업">식품 및 음료 소매업
      					 <option value="건설/건축 서비스">건설/건축 서비스
      					 <option value="의료/보건 서비스">의료/보건 서비스
      					 <option value="여행/관광 업종">여행/관광 업종
       					<option value="환경 보호/재활용 산업">환경 보호/재활용 산업
      					 <option value="생활용품/가전제품 도매업">생활용품/가전제품 도매업
      					 <option value="금융 및 보험 서비스">금융 및 보험 서비스
       						<option value="자동차 부품 제조업">자동차 부품 제조업
       					<option value="출판/인쇄 업종">출판/인쇄 업종
       					<option value="교육 기술 서비스">교육 기술 서비스
       					<option value="농업 및 농산물 가공 산업">농업 및 농산물 가공 산업
       					<option value="전자상거래/온라인 판매">전자상거래/온라인 판매
       					<option value="음악/예술 엔터테인먼트 산업">음악/예술 엔터테인먼트 산업
       					<option value="생명 공학/의료 기기 산업">생명 공학/의료 기기 산업
       					<option value="통신/네트워크 서비스">통신/네트워크 서비스
       					<option value="스포츠/운동 기술 산업">스포츠/운동 기술 산업
       					<option value="에너지/청정 기술 산업">에너지/청정 기술 산업
       					<option value="인테리어 디자인/가구 제조업">인테리어 디자인/가구 제조업
       					<option value="컴퓨터/소프트웨어 서비스">컴퓨터/소프트웨어 서비스
       					<option value="식물/원예 관련 서비스">식물/원예 관련 서비스
       					<option value="코스메틱/미용 서비스">코스메틱/미용 서비스
       					<option value="공예품/수공예품 제조업">공예품/수공예품 제조업
       					<option value="동물 의료 서비스">동물 의료 서비스
       					<option value="부동산 개발/투자">부동산 개발/투자
       					<option value="국제 무역/물류 서비스">국제 무역/물류 서비스
       					<option value="자원 관리/환경 컨설팅">자원 관리/환경 컨설팅
       					<option value="자료/정보 서비스">자료/정보 서비스
       					<option value="패션/의류 디자인 업종">패션/의류 디자인 업종
                     </select>
           
         
          
           
 	            <input type="text" class="keyword" name="keyword" placeholder="검색어를 입력하세요">&nbsp;
 	            <input type="button"   value="검색" class="searchBtn" onClick="searchForm()"></input>
 	            
 	            
 				<input type="hidden" name="sort" class="sort">
 				<input type="hidden" name="selectPageNo" class="selectPageNo" value="1" >
 				<input type="hidden" name="rowCntPerPage" class="rowCntPerPage" >
 </form>
 				

 </center>


 <br>
 <br>
 <center>


   	<!-- 게시판 목록 출력하기. 시작 -->
 	  <div class="gongGoListDiv">
 	
 	<table  id="rwd-table" class="gongGoTable" border="0" align="center" style="border-collapse:collapse" cellpadding="10" >	
 	
 	<tr>
 	    <th>기업</th>
 	
 		</th>
 		<c:if test="${param.sort!='work_place asc' and param.sort!='work_place desc'}" >
 		<th width="220" style="cursor:pointer"onClick="searchWithSort('work_place desc')">주소</th>
 	</c:if>
 	<c:if test="${param.sort=='work_place desc'}">
 		<th width="220" style="cursor:pointer"onClick="searchWithSort('work_place asc')">주소▲</th>
 	</c:if>
 	<c:if test="${param.sort=='work_place asc'}">
 		<th width="220" style="cursor:pointer"onClick="searchWithSort('')">주소▼</th>
 	  </c:if>
 		<c:if test="${param.sort!='business_industry asc' and param.sort!='business_industry desc'}" >
 		<th width="220" style="cursor:pointer"onClick="searchWithSort('business_industry desc')">업종</th>
 	</c:if>
 	<c:if test="${param.sort=='business_industry desc'}">
 		<th width="220" style="cursor:pointer"onClick="searchWithSort('business_industry asc')">업종▲</th>
 	</c:if>
 	<c:if test="${param.sort=='business_industry asc'}">
 		<th width="220" style="cursor:pointer"onClick="searchWithSort('')">업종▼</th>
 	  </c:if>
 		<!-- <th width="100">등록일</th> -->
 	<c:if test="${param.sort!='gonggoreg_date asc' and param.sort!='gonggoreg_date desc'}" >
 		<th width="120" style="cursor:pointer"onClick="searchWithSort('gonggoreg_date desc')">등록일</th>
 	</c:if>
 	<c:if test="${param.sort=='gonggoreg_date desc'}">
 		<th width="120" style="cursor:pointer"onClick="searchWithSort('gonggoreg_date asc')">등록일▲</th>
 	</c:if>
 	<c:if test="${param.sort=='gonggoreg_date asc'}">
 		<th width="120" style="cursor:pointer"onClick="searchWithSort('')">등록일▼</th>
 	  </c:if>
 	
 			 	<c:if test="${param.sort!='13 asc' and param.sort!='13 desc'}" >
 		<th width="120" style="cursor:pointer"onClick="searchWithSort('13 desc')">남은기한</th>
 	</c:if>
 	<c:if test="${param.sort=='13 desc'}">
 		<th width="120" style="cursor:pointer"onClick="searchWithSort('13 asc')">남은기한▲</th>
 	</c:if>
 	<c:if test="${param.sort=='13 asc'}">
 		<th width="120" style="cursor:pointer"onClick="searchWithSort('')">남은기한▼</th>
 	  </c:if>
 
 	</tr>
              <c:forEach var="gonggo" items="${requestScope.gonggoList}" varStatus="status">  
              <tr style="cursor:pointer" onClick="goGonggoDetailForm(${gonggo.g_no});">     
              
     <td>
         <div style="display: flex; align-items: center;">
             <img width="80" src="images/photo-1.jpg" style="margin-right: 10px;">
             <div>
            
             <%-- ${requestScope.gonggoListCnt - status.index } --%>
                 기업: ${gonggo.name} <br>
                 학력: ${gonggo.graduation}<br>
                 경력: ${gonggo.career}<br>
                 
         <%--         ${requestScope.BoardDTO.role}
                 ${requestScope.BoardDTO.graduation} --%>
         
           </div>    
         </div>
     </td>
      <td>
            ${gonggo.work_place}	
            </td>
            <td>
            ${gonggo.business_industry}	
            </td>
             <td>${gonggo.gonggoreg_date }</td>
                <td>
                <c:if test ="${gonggo.due_date > 0 }" >
                 D -  ${gonggo.due_date }
                </c:if>
                <c:if test ="${gonggo.due_date <= 0 }" >
                 마감
                </c:if>
              
              
           
              
                </td>
             </tr>

           
            </c:forEach>
          </div>   
               

 		
 	
 	</table>

 	  
 	   <c:if test="${empty requestScope.gonggoList}">
                        <center>
                           <b>조회할 데이터가 없습니다.</b>
                        </center>
                        
                </c:if>
 	  
 		<c:if test="${sessionScope.member=='company'}">
 		<br>
 		<input type="button" value="등록" onClick="location.replace('/gongGoRegForm.do')">
 		
 		</c:if>
 		
 		<form name="gonggoDetailForm" action="/gonggoDetailForm.do" method="post">
 			<input type="hidden" name="g_no" class="g_no">
 		</form>

 	
 </center>  
   
   
     
     
     
 <!-- 게시판 페이지 번호 출력하기 -->
 <span class="pagingNos">

 <center>
  <!--------------------------------------------->
    <!-- [처음] [이전] 출력하기 -->
    <!--------------------------------------------->
    <br>
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
		[${requestScope.gonggoListCnt}/${requestScope.gonggoListAllCnt}]개 	
       <!--------------------------------------------->
    &nbsp;&nbsp;
    </span>
    <!--nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn-->
    <!--- 게시판 페이징 번호 출력하기.  끝   -->
    <!--nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn-->

  <select name="rowCntPerPage" class="rowCntPerPage" onChange="searchForm()">
       <option value="10">10
       <option value="15">15
       <option value="20">20
    </select>&nbsp;&nbsp;&nbsp;행보기 <br>
 	  </div> 
  	</div>
  		<script src="js/slideshow.js"></script>
	</body>
	<%@include file="/WEB-INF/views/common.jsp" %>
	<%@ include file="footer.jsp" %>
