<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>12Wa~</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">


 <style>
       .table-container {
          display: flex;
          justify-content: space-between;
          margin: 0 auto; /* 가운데 정렬을 위해 추가 */
      }
      .table-container table {
          border-collapse: collapse;
          border: 1px solid gray;
          padding: 7px;
      }
      
      #links {
  float: left;
}
	    .circle {
            width: 200px;
            height: 200px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 2px solid blue;
            overflow: hidden;
        }
        img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
	
  </style>
	<script>


	
	function gonggoSupportForm() {
	
		var formObj = $("[name='getgonggoSupportForm']");
	

		$.ajax({

			url : "/gonggoSupportProc.do"

			,
			type : "post"

			,
			data : formObj.serialize()

			,
			success : function(json) {
				var result = json["result"];
				if (result == -1) {
					alert("지원한 이력서가 있습니다.");
				}else{
					alert("이력서 지원 성공입니다.");
					/* location.replace("/gonggoDetailForm.do"); */
				}
			}

			,
			error : function() {
				alert("이력서 지원실패! 관리자에게 문의 바람니다.");
			}
		});
	}
</script>
</head>
  
<body>
 <div id="container">
		<%@ include file="header.jsp"%>

		<br>
		<br> 기업 - ${requestScope.GonggoDTO.name}
		<td></td>




		<div class="table-container">
			<table align="center" bordercolor="gray" border="1" cellpadding="7"
				style="border-collapse: collapse">
				<tr>
					<td>경력 : ${requestScope.GonggoDTO.career}</td>

				</tr>
				<tr>
					<td>학력 : ${requestScope.GonggoDTO.graduation}
						${requestScope.GonggoDTO.ph_d_candidate}</td>
				</tr>
				<tr>
					
						<td>나이 : 
					<c:if test="${requestScope.GonggoDTO.seeker_age1=='나이'}">
					 	나이 무관
					 	</c:if>
					<c:if test="${requestScope.GonggoDTO.seeker_age1!='나이'}">
					 	${requestScope.GonggoDTO.seeker_age1} ~ ${requestScope.GonggoDTO.seeker_age2}
					 	</c:if>
						</td>

				

				</tr>
				<tr>
					<td>필수조건 : ${requestScope.GonggoDTO.benefit_name_essential1}
						${requestScope.GonggoDTO.benefit_name_essential2}
						${requestScope.GonggoDTO.benefit_name_essential3}<br>
						${requestScope.GonggoDTO.benefit_name_essential4}
						${requestScope.GonggoDTO.benefit_name_essential5}
					</td>
				</tr>
				<tr>
					<td>우대사항 : ${requestScope.GonggoDTO.benefit_name_preferential1}
						${requestScope.GonggoDTO.benefit_name_preferential2}
						${requestScope.GonggoDTO.benefit_name_preferential3}
						${requestScope.GonggoDTO.benefit_name_preferential4}
						${requestScope.GonggoDTO.benefit_name_preferential5}</td>
				</tr>


			</table>
			<table align="center" bordercolor="gray" border="1" cellpadding="7"
				style="border-collapse: collapse">
				</tr>
				<tr>
					<td>성 별 : ${requestScope.GonggoDTO.seeker_sex}</td>
				</tr>
				<tr>
					<td>급여 :
					<script>
					if(new RegExp(/^[0-9]{1,4}$/).test(seeker_ageObj1.val()) == false && age_irrelevantObj.is(':checked')== false ){
						alert("지원자의 나이는 2자리까지만 입력해주세요1");
						return false;
					} 
					</script>
					  ${requestScope.GonggoDTO.salary}
					<%--  <c:if test="${requestScope.GonggoDTO.salary != 0}">
                    ${requestScope.GonggoDTO.salary}
                    </c:if> --%> <%-- <c:if
							test="${not empty requestScope.GonggoDTO.other_salary }">
                    ${requestScope.GonggoDTO.other_salary}만원
                    </c:if> --%>
					</td>

				</tr>

				<tr>
					<td>기업형태 : ${requestScope.GonggoDTO.volume}</td>

					<tr>
                     <td> 시간 : 
                     		  ${requestScope.GonggoDTO.attendencetime}
                    		~  ${requestScope.GonggoDTO.leaveworktime}시 </td>
              
                    
                </tr>
                <tr>
                    <td> 근무지역 : ${requestScope.GonggoDTO.work_place}
                    </td>
                </tr>
            </table>
        </div>
        
        <br>
         채용부문
           <c:if test="${ not empty requestScope.GonggoDTO.dept_name}">
         <table align="center" bordercolor="gray" border="1"
				cellpadding="7">
           <tr>
        <th colspan="1">담당부서</th>
        <th colspan="2">상세내용</th>
    </tr>
    <tr>
        <th rowspan="4"> ${requestScope.GonggoDTO.dept_name}</th>
    </tr>
    <tr>
        <td>세부분야</td>
        <td>${requestScope.GonggoDTO.field_detail1}</td>
    </tr>
    <tr>
        <td>직급</td>
        <td>${requestScope.GonggoDTO.position_name}</td>
    </tr> 
    <tr>
        <td>업무내용</td>
        <td>${requestScope.GonggoDTO.content1}</td>
    </tr> 
            </table>
            <br>
            </c:if>
            
            <c:if test="${ not empty requestScope.GonggoDTO.dept_name2}">
         <!-- -------------------------------------------------- -->   
             <table align="center" bordercolor="gray" border="1"
				cellpadding="7">
           <tr>
        <th colspan="1">담당부서</th>
        <th colspan="2">상세내용</th>
    </tr>
    <tr>
        <th rowspan="4">${requestScope.GonggoDTO.dept_name2}</th>
    </tr>
    <tr>
        <td>세부분야</td>
        <td>
        	${requestScope.GonggoDTO.field_detail2}
        </td>
    </tr>
    <tr>
        <td>직급</td>
        <td>
        	${requestScope.GonggoDTO.position_name2}
        </td>
    </tr> 
    <tr>
        <td>업무내용</td>
        <td>${requestScope.GonggoDTO.content2}</td>
    </tr> 
            </table>
            <br>
            </c:if>
   <!-- -------------------------------------------------- -->       
             <c:if test="${ not empty requestScope.GonggoDTO.dept_name3}">
             <table align="center" bordercolor="gray" border="1"
				cellpadding="7">
           <tr>
        <th colspan="1">담당부서</th>
        <th colspan="2">상세내용</th>
    </tr>
    <tr>
        <th rowspan="4">${requestScope.GonggoDTO.dept_name3}</th>
    </tr>
    <tr>
        <td>세부분야</td>
        <td>
        	${requestScope.GonggoDTO.field_detail3}
        </td>
    </tr>
    <tr>
        <td>직급</td>
        <td>
        	${requestScope.GonggoDTO.position_name3}
        </td>
    </tr> 
    <tr>
        <td>업무내용</td>
        <td>${requestScope.GonggoDTO.content3}</td>
    </tr> 
            </table>
          </c:if>  
    <br>
    채용절차        
    <table align="center">
    
    <div class="container mx-auto px-4 py-10">
        <div class="grid grid-cols-3 gap-8">
            <div class="text-center">
            <c:if
							test="${not empty requestScope.GonggoDTO.process_name1 }">
                <div class="circle">
                    <img
									src="https://source.unsplash.com/random/200x200?sig=1"
									alt="Image 1">
                </div>
                <p class="mt-2">${requestScope.GonggoDTO.process_name1}</p>
            
					</div>
              </c:if>
            <div class="text-center">          
             <c:if
							test="${not empty requestScope.GonggoDTO.process_name2 }">
                <div class="circle">
                    <img
									src="https://source.unsplash.com/random/200x200?sig=2"
									alt="Image 2">
                </div>
                <p class="mt-2">${requestScope.GonggoDTO.process_name2}</p>
            
					</div>
              </c:if>
            <div class="text-center">           
                <c:if
							test="${not empty requestScope.GonggoDTO.process_name3 }">
                <div class="circle">
                    <img
									src="https://source.unsplash.com/random/200x200?sig=3"
									alt="Image 3">
                </div>
                <p class="mt-2">${requestScope.GonggoDTO.process_name3}</p>
            
					</div>
            </c:if>
             <div class="text-center">              
              <c:if
							test="${not empty requestScope.GonggoDTO.process_name4 }">
                <div class="circle">
                    <img
									src="https://source.unsplash.com/random/200x200?sig=4"
									alt="Image 4">
                </div>
                <p class="mt-2">${requestScope.GonggoDTO.process_name4}</p>
            
					</div>
            </c:if>
              <c:if
						test="${not empty requestScope.GonggoDTO.process_name5 }">
             <div class="text-center">           
                <div class="circle">
                    <img
									src="https://source.unsplash.com/random/200x200?sig=5"
									alt="Image 5">
                </div>
                <p class="mt-2">${requestScope.GonggoDTO.process_name5}</p>
            </div>
            </c:if>
             <c:if
						test="${not empty requestScope.GonggoDTO.process_name6 }">
             <div class="text-center">
                <div class="circle">
                    <img
									src="https://source.unsplash.com/random/200x200?sig=6"
									alt="Image 6">
                </div>
                <p class="mt-2">${requestScope.GonggoDTO.process_name6}</p>
            </div>
            </c:if>
             <c:if
						test="${not empty requestScope.GonggoDTO.process_name7 }">
             <div class="text-center">
                <div class="circle">
                    <img
									src="https://source.unsplash.com/random/200x200?sig=7"
									alt="Image 7">
                </div>
                <p class="mt-2">${requestScope.GonggoDTO.process_name7}</p>
            </div>
             </c:if>
        </div>
    </div>
                <tr>
                    <td> 사내복지 : ${requestScope.GonggoDTO.welfare_name}  </td>
                </tr>
                <tr>
                    <td> 내용 : ${requestScope.GonggoDTO.content}</td>
                </tr>
               
      
    </table>
    
    <br>
    <br>
    
    접수기간 및 담당자 이름
  	<table>
			  	 
			    <tr>
			        <td rowspan="4">남은기간 : 
			        <c:if test ="${requestScope.GonggoDTO.gonggoreg_date <= 0 }" >
			        마감
			        </c:if>
			          <c:if test ="${requestScope.GonggoDTO.gonggoreg_date > 0 }" >
			        ${requestScope.GonggoDTO.gonggoreg_date}일 
			        </c:if>
			         
			        <br>시작일	:  ${requestScope.GonggoDTO.opendate}<br>
			        마감일	:	${requestScope.GonggoDTO.closedate}
			        </td>
                	<!-- 마감날 - sysdate 추후에 추가해서 남은 시간 넣기 -->
                
                	 <td>
                	 	담당자 이름 :  ${requestScope.GonggoDTO.manager_name}
                	 
                   
            
			    </tr>
  				
  				
                
  	
  	</table>
  	<c:if test="${sessionScope.member=='person'}">
  	<center>
  		<input type="button" value="입사지원하기" onClick="gonggoSupportForm();"> 
  	</center>
  	</c:if>
  	<c:if test="${sessionScope.c_no == GonggoDTO.c_no}">
  		<input type="button" value="수정/삭제"
			onclick="document.gonggoUpDelForm.submit();">
	</c:if>     
  </div> 
  <form name="gonggoUpDelForm" action="/gonggoUpDelForm.do"
		method="post">
		<input type="hidden" name="g_no" value="${requestScope.GonggoDTO.g_no}">
	</form>
	
	<form name="getgonggoSupportForm">
		<input type="hidden" name="g_no" value="${requestScope.GonggoDTO.g_no}">
		<input type="hidden" name="c_no" value="${requestScope.GonggoDTO.c_no}">
		<input type="hidden" name="p_no" value="${sessionScope.p_no}">
	</form>
  

  <script src="js/slideshow.js"></script>
</body>

<%@ include file="footer.jsp" %>
</html>