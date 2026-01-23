<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common.jsp"%>

<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%> 
<%@ page import="com.wa.erp.BoardDTO" %>
<!DOCTYPE html>
<html>

<head>
 <style>
        .wide-column {
            width: 120px; /* 원하는 너비로 설정 */
        }
    </style>
<script>
function checkAndDelete() {
    var selectedMembers = []; // 선택된 회원들의 정보를 담을 배열
    var requests = []; // 모든 AJAX 요청을 담을 배열

    // 체크된 체크박스를 모두 가져옵니다.
    $('.memberCheckbox:checked').each(function() {
        var values = $(this).val().split(","); // 체크박스의 값에서 c_no와 p_no를 가져옵니다.
        var c_no = parseInt(values[0]);
        var p_no = parseInt(values[1]);

        // 객체에 c_no와 p_no를 저장하여 배열에 추가합니다.
        selectedMembers.push({ c_no: c_no, p_no: p_no });
    });

    // 선택된 회원들의 정보가 존재하는지 확인합니다.
    if (selectedMembers.length > 0) {
        // 선택된 회원들의 정보를 이용하여 삭제 작업을 수행합니다.
        selectedMembers.forEach(function(member) {
            if (member.c_no === 0) {
                var request = deletePersonMember(member.p_no);
                requests.push(request);
            } else if (member.p_no === 0) {
                var request = deleteCompanyMember(member.c_no);
                requests.push(request);
            }
        });

        // 모든 요청이 완료된 후 알림 표시
        $.when.apply($, requests).done(function() {
            alert("선택된 모든 회원이 삭제되었습니다.");
            location.reload();
            // 모든 요청이 완료된 후 필요한 작업 수행
        }).fail(function() {
            alert("일부 회원 삭제에 실패하였습니다.");
            // 실패 시 필요한 작업 수행
        });

    } else {
        // 선택된 회원이 없는 경우 알림창을 표시합니다.
        alert("선택된 회원이 없습니다.");
    }
}

function deletePersonMember(p_no) {
    return $.ajax({
        type: "POST",
        url: "/deletePersonMemberProc.do", // 회원을 삭제하는 서버의 URL
        data: { p_no: p_no }, // URL 쿼리 문자열 전송
        success: function(response) {
            console.log("개인 회원이 삭제되었습니다.");
            // 삭제 후 필요한 작업 수행
        },
        error: function(xhr, status, error) {
            console.error("개인 회원 삭제 실패");
            // 실패 시 필요한 작업 수행
        }
    });
}

function deleteCompanyMember(c_no) {
    return $.ajax({
        type: "POST",
        url: "/deleteCompanyMemberProc.do", // 회사 회원을 삭제하는 서버의 URL
        data: { c_no: c_no }, // URL 쿼리 문자열 전송
        success: function(response) {
            console.log("기업 회원이 삭제되었습니다.");
            // 삭제 후 필요한 작업 수행
        },
        error: function(xhr, status, error) {
            console.error("기업 회원 삭제 실패");
            // 실패 시 필요한 작업 수행
        }
    });
}







function blockMem() {
	
	  var checkboxes = $('input.blockMemberCheckbox[type="checkbox"]');
	    var selectedPosts = [];
	    checkboxes.each(function() {
	        if ($(this).prop('checked')) {
	            selectedPosts.push($(this).val());
	        }
	    });
	    if (selectedPosts.length > 0) {
//	         var b_noList = selectedPosts.join(",");
	  
	        $.ajax({
	            type: "POST",
	            url: "/blockMemberProc.do",
	            data: JSON.stringify({ b_noList: selectedPosts }), // selectedPosts는 배열
	            contentType: "application/json", // JSON 데이터를 전송할 때는 content type을 명시
	            success: function(response) {
	            	alert ('회원이 차단되었습니다.')
	                // 성공적으로 삭제되었으므로 페이지를 새로고침합니다.
	                location.reload();
	            },
	            error: function(xhr, status, error) {
	                console.error(xhr.responseText);
	            }
	        });
	    } else {
	        alert("선택된 회원이 없습니다.");
	    }
	}

</script>

   <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        .container {
            text-align: center;
        }
        .welfare-options {
            display: inline-block;
            text-align: left;
            margin: 0 auto;
            columns: 4; /* 두 개의 열로 나누어 정렬 */
            column-gap: 20px; /* 열 간격 */
        }
        .welfare-options label {
            display: block;
            margin: 5px 0;
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
</style>
<style>
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
    </style>
<script>

function search(member_type){
	//---------------------------------------------
	// 변수 boardSearchFormObj 선언하고 
	// name='boardSearchForm' 를 가진 form 태그 관리 JQuery 객체를 생성하고 저장하기
	//---------------------------------------------
	var boardSearchFormObj = $("[name='boardSearchForm']");
	boardSearchFormObj.find(".rowCntPerPage").val($("select").filter(".rowCntPerPage").val());
	 var tradeType = $("input[name='member_type']:checked").val();
     boardSearchFormObj.find(".member_type").val(member_type);	
	$.ajax(
		{
			//-------------------------------
			// WAS 로 접속할 주소 설정
			//-------------------------------
			url      : "/memberList.do"
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
         

            
            
//             $("body").append(
//                "<textarea class=xxx cols=100 rows=100>"
//                + obj.filter(".boardListDiv").html()
//                +"</textarea>"
            //)
            
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
    $("[name='boardSearchForm']").find("[name='selectedIndustry']").val("");
    $("[name='boardSearchForm']").find("[name='sido']").val("시/도 선택");
    $("[name='boardSearchForm']").find("[name='gugun']").val("구/군 선택");

 
    $(".searchBtn").click();
}


function searchWithSort(sort){

	$('#multisort1').val('');
	$('#multisort2').val('');
	$('#multisort3').val('');
	
	$("[name='boardSearchForm']").find("[name='sort']").val(sort);
    $(".searchBtn").click();

}




function pageNoClick(clickPageNo){


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


			<h1 style="text-align: center;">회원 정보</h1>

         <form name="boardSearchForm" onsubmit="return false">
            <div style="text-align: center; margin-bottom: 20px;">
    			<input type="radio" value="" name="member_type" onclick="search()">전체
       		<input type="radio" value="기업" name="member_type"   onclick="search('기업')">기업 
    		<input type="radio" value="개인" name="member_type"  onclick="search('개인')">개인
              <select name="rowCntPerPage" class="rowCntPerPage" onChange="search()" >
		<option value="10">10</option>
		<option value="20">20</option>
		<option value="30">30</option>
    </select>행보기 &nbsp;&nbsp;&nbsp;

         <center>총 ${requestScope.memberListAllCnt} 명 의 회원분들과 함께하고 있습니다.</center>
        

		
             
	
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
         
       




				
	<table 	style="border: 1px solid black; margin-left: auto; margin-right: auto;">
				<tr>
					<th>개인/기업</th>
            		<th style="cursor: pointer font-weight: bold;">이름/상호명</th>	   
         			<th class="wide-column"  style="cursor: pointer">가입일</th>
         			<th style="cursor: pointer">아이디</th>
         			<th style="cursor: pointer">비밀번호</th>
         			<th style="cursor: pointer">주소</th>
         			<th style="cursor: pointer">e-mail</th>
         			<th style="cursor: pointer">연락처</th>
					<th style="cursor: pointer"> 탈퇴 회원 선택</th>         			
         			<th style="cursor: pointer"> 제한 회원 선택</th>         			
         			         			
				</tr>
                  <c:forEach var="board" items="${requestScope.memberList }"   varStatus="status">


					<tr>
			
					<td>
				    ${board.member_type }
					</td>	
					
			     	<td>
					${board.name}
					</td>
					
					<td>
							${board.reg_date}
					</td>
					
					<td>
							${board.id}
					</td>
					
					<td>
							${board.pwd}
					</td>
					
					<td>
							${board.addr}
					</td>
					
					<td>
							${board.email}
					</td>
					
					<td>
							${board.phone}
							<input type="hidden" class="c_no" value="${board.c_no }">
							<input type="hidden" class="p_no" value="${board.p_no }">
							<input type="hidden" class="is_block" value="${board.is_block}">
 					</td>
					<td>
					<center>
					
					<input type="checkbox" value="${board.c_no},${board.p_no}" class="memberCheckbox" >
					
					</center>
					</td>
					<td>
								
								<center><c:if test = "${board.p_no >0}"  >
								<input type="checkbox" value="${board.p_no}" class="blockMemberCheckbox"  	<c:if test="${board.is_block == 'block'}">checked</c:if>></c:if></center>						
					</td>
			     	</tr>
			</c:forEach>
		
               </table>

                              </div>
  <span style="margin:auto;" class="pagingNos">
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
			[${requestScope.memberListCnt} / ${requestScope.memberListAllCnt}]개		
		<!--------------------------------------------->
		&nbsp;&nbsp;
		 </center>
		 <br>
<center>
				 <input type="button" value="회원 탈퇴"  onclick="checkAndDelete();">
				 <input type="button" value="회원 제한"  onclick="blockMem();">
</center>	


         	</span>

</body>
<%@ include file="footer.jsp"%>
</html>