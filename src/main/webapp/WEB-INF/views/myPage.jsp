<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common.jsp"%>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<style>
    .button-right {
        float: right;
    }
    .hidden-row {
        display: none;
    }
</style>

</head>

<body>
<script>
 
 
    function gotimeShareDetail(b_no){
    	$("[name='timeShareDetail']").find("[name='b_no']").val(b_no);
    	  document.timeShareDetail.submit();
    	}
    
    function gorResumDetail(resume_no){
    	$("[name='ResumDetail']").find("[name='resume_no']").val(resume_no);
    	  document.ResumDetail.submit();
    	}
    
    function goApplyCompanyDetail(g_no){
    	$("[name='ApplyCompanyDetail']").find("[name='g_no']").val(g_no);
    	  document.ApplyCompanyDetail.submit();
    	}
    
    function goScoutCompanyDetail(c_no){
    	$("[name='ScoutCompanyDetail']").find("[name='c_no']").val(c_no);
    	  document.ScoutCompanyDetail.submit();
    	}
    
    function goMywriteDetail(Detail_b_no){
    	$("[name='MywriteDetail']").find("[name='Detail_b_no']").val(Detail_b_no);
    	  document.MywriteDetail.submit();
    	}

</script>


<div id="container">
    <%@ include file="header.jsp" %>
    
    
<div class="container"  id="wrap"> 
    <center>
 <form action="submit.php" method="POST">  
 
      
	
<!-- 개인정보  -->
        <table>
            <th colspan="7">개인정보
                <input type="button" class="button-right" value="정보수정"  onclick="document.personalUpDelForm.submit();" >
            </th>
            
            <c:forEach var="MyPrivacy" items="${requestScope.MyPrivacy}" varStatus="status"> 
                <tr style="cursor:pointer">
                    <tr>
                        <td>이름</td>
                        <td align="center">${MyPrivacy.name}</td>
                    </tr>
                    
                    <tr>
                        <td>성별</td>
                        <td align="center">${MyPrivacy.sex}</td>
                    </tr>
                    
                    <tr>
                        <td>아이디</td>
                        <td align="center">${MyPrivacy.pid}</td>
                    </tr>
                    <tr>
                        <td>번호</td>
                        <td align="center">${MyPrivacy.phone}</td>
                    </tr>
                    
<!--                     <tr> -->
<!--                         <td>비밀번호</td> -->
<%--                         <td align="center">${MyPrivacy.pwd}</td> --%>
<!--                     </tr> -->

                    <tr>
                        <td>취업여부</td>
                        <td align="center">${MyPrivacy.is_job}</td>
                    </tr>
                    
                    <tr>
                        <td>이메일</td>
                        <td align="center">${MyPrivacy.email}</td>
                    </tr>
                    
                    <tr>
                        <td>관심분야</td>
                        <td align="center">${MyPrivacy.field_name}</td>
                    </tr>
                    
<!--                        <tr> -->
<!--                         <td>주민번호</td> -->
<%--                         <td align="center">${MyPrivacy.jumin_num}</td> --%>
<!--                     </tr> -->
                    
                </tr> 
            </c:forEach>
      
        </table>

    

        <br><br>


<!-- 등록 타임쉐어  -->
        <table>
            <tr>
                <th colspan="3">등록한 타임쉐어
                    <input type="button" class="button-right" value="타임쉐어 등록" onClick="location.replace('/timeShareRegForm.do')">
                     
                </th>
            </tr>
            
            <tr>
                <th>제목</th>
                <th>내용</th>
                <th>작성일</th>
            </tr> 
           
            
            <c:forEach var="MytimshareList" items="${requestScope.MytimshareList}" varStatus="status">
                <tr style="cursor:pointer" onClick="gotimeShareDetail(${MytimshareList.b_no});">          
                    <td align="center">${MytimshareList.subject}</td>
                    <td align="center">${MytimshareList.content}</td>
                    <td align="center">${MytimshareList.reg_date}</td>
                </tr>
            </c:forEach>
            
                 <c:if test="${empty requestScope.MytimshareList}">
                     <td colspan="4" align="center"><b>프리랜서 등록 글이 없습니다.</b></td>    
                </c:if>
        </table>

     
		 <form name="resumRegForm" action="/resumRegForm.do" method="post">
		      <input type="hidden" name="p_no" >
		</form>

<br><br>

<!-- 이력서관리 -->
		<table>
		    <tr>
		        <th colspan="3">이력서 관리
		            <input type="button" class="button-right" value="더보기"> 
		       
		        </th>                                                                    
		    </tr>

            <tr>
                <th>이력서 번호</th>
                <th>자기소개</th>
                <th>등록일</th>         
            </tr> 
            
            <c:forEach var="ResumeList" items="${requestScope.ResumeList}" varStatus="status">
                <tr style="cursor:pointer" onClick="gorResumDetail(${ResumeList.resume_no})">                 
                    <td align="center">${ResumeList.resume_no}</td> 
                    <td align="center">${ResumeList.introduce}</td>  
                    <td align="center">${ResumeList.reg_date}</td>
                </tr>
            </c:forEach>
            
            	<c:if test="${empty requestScope.ResumeList}">
                     <td colspan="4" align="center"><b>등록한 이력서가 없습니다.</b></td>    
                </c:if>
        </table>
        
               

        <br><br>

<!-- 지원한 기업  -->
        <table>
            <tr>
                <th colspan="4">내가 지원한 공고
                    <input type="button" class="button-right" value="더보기">
                </th>
            </tr>
            <tr>
                <th>기업명</th>
                <th>대표업종</th>
                <th>주소</th>	                 
            </tr>           
            <c:if test="${not empty requestScope.ApplycompanyList}">
                <c:forEach var="ApplycompanyList" items="${requestScope.ApplycompanyList}" varStatus="status">
                    <tr style="cursor:pointer" onClick="goApplyCompanyDetail(${ApplycompanyList.g_no})"> 
                        <td align="center">${ApplycompanyList.name}</td>
                        <td align="center">${ApplycompanyList.business_industry}</td>
                        <td align="center">${ApplycompanyList.addr}</td>
                    </tr>     
                </c:forEach>
            </c:if>
            
            <c:if test="${empty requestScope.ApplycompanyList}">
                     <td colspan="4" align="center"><b>지원한 기업이 없습니다.</b></td>    
                </c:if>
            
        </table>


        <br><br>
        
<!--  스카우트 제안한 기업 -->
        <table>
            <tr>
                <th colspan="4">스카우트 제안한 기업
                    <input type="button" class="button-right" value="더보기">
                </th>
            </tr>
            <tr>             
                <th>기업명</th>
                <th>대표업종</th>
                <th>주소</th>	                 
            </tr>           
            <c:forEach var="ScoutcompanyList" items="${requestScope.ScoutcompanyList}" varStatus="status">
                <tr style="cursor:pointer" onClick="goScoutCompanyDetail(${ScoutcompanyList.c_no})"> 
                    <td align="center">${ScoutcompanyList.name}</td>
                    <td align="center">${ScoutcompanyList.business_industry}</td>
                    <td align="center">${ScoutcompanyList.addr}</td>
                </tr>         
            </c:forEach>
            
            <c:if test="${empty requestScope.ScoutcompanyList}">
                <td colspan="4" align="center"><b>스카우트 제안한 기업이 없습니다.</b></td>    
              </c:if>    
            

       
  </table>
  
        <br><br>

<!--         <table>   -->
<!--             <tr> -->
<!--                 <th colspan="3">내가 작성한 글 -->
<!--                     <input type="button" class="button-right" value="더보기"> -->
<!--                 </th> -->
<!--             </tr> -->
<!--             <tr> -->
<!--                 <th>제목</th> -->
<!--                 <th>내용</th> -->
<!--                 <th>등록일</th>                      -->
<!--             </tr>  -->
            
<%--             <c:forEach var="WriteList" items="${requestScope.WriteList}" varStatus="status"> --%>
<%--                 <tr style="cursor:pointer" onClick="goMywriteDetail(${WriteList.b_no})">                  --%>
<%--                     <td align="center">${WriteList.subject}</td>  --%>
<%--                     <td align="center">${WriteList.content}</td>   --%>
<%--                     <td align="center">${WriteList.reg_date}</td> --%>
<!--                 </tr> -->
<%--             </c:forEach> --%>
            
<%--                <c:if test="${empty requestScope.WriteList}"> --%>
<!--                      <td colspan="4" align="center"><b>작성한 글이 없습니다.</b></td>     -->
<%--                 </c:if> --%>
                
<!--         </table> -->

        <br><br>

    </form>
    </center>         
     
       <input type="hidden" name="p_no" value="${sessionScope.p_no}">  

	 <form name="personalUpDelForm" action="/personalUpDelForm.do" method="post">		
		    	<input type="hidden" name="p_no"  value="${sessionScope.p_no}">
	</form>
	
	
	 <form name="timeShareDetail" action="/timeShareDetailForm.do" method="post">
	     <input type="hidden" name="b_no" class="b_no">
    </form>
    
    <form name="ResumDetail" action="/resumeListDetail.do" method="post">
         <input type="hidden" name="p_no" value="${sessionScope.p_no}">  
	     <input type="hidden" name="resume_no"   value="${requestScope.boardDTO.resume_no}">
    </form>

    <form name="ApplyCompanyDetail" action="/gonggoDetailForm.do" method="post">
	     <input type="hidden" name="g_no" class="g_no">
    </form>
    
    <form name="ScoutCompanyDetail" action="/companyListDetail.do" method="post">
	     <input type="hidden" name="c_no" class="c_no" >
    </form>
    
    <form name="MywriteDetail"  action="/freedomeDetailForm.do" method="post">
	     <input type="hidden" name="Detail_b_no" class="Detail_b_no">
	     
    </form>
	
          <input type="hidden" name="p_no" value="${sessionScope.p_no}">
</div>
</div>
<%@ include file="footer.jsp" %>

</body>
</html>
