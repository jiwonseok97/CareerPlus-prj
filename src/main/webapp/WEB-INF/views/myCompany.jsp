<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@include file="/WEB-INF/views/common.jsp"%>  

<!DOCTYPE html>
<html>

<head>
   <!-- 버튼만 오른쪽으로 보내기 CSS  -->
   <style>
        .button-right {
            float: right;
        }
     
    .hidden-row {
        display: none;
        }
   </style>
    
    <script>
    
    function goGongMoDetailForm(comp_pk){
      //       name='boardDetailForm' 을 간 form 태그 후손 중에
      //       name='b_no' 가진 태그에 매개변수로 들어온 게시판의 고유번호를 삽입하기
      //      location.replace("/boardDetailForm.do?b_no="+b_no);      >> get 방식.
          $("[name='gongMoDetailForm']").find("[name='comp_pk']").val(comp_pk);
          //----------------------------------
          // name='boardDetailForm' 을 가진 
          // form 태그의 action 에 설정된 URL 주소로 WAS 접속해서 
          // 얻은 새 HTML 를 웹브라우저 열기.
          // 즉 화면 이동하기.
          //----------------------------------
          document.gongMoDetailForm.submit();
      }
    
    function goGongGoDetailForm(g_no){

      //       name='boardDetailForm' 을 간 form 태그 후손 중에
      //       name='b_no' 가진 태그에 매개변수로 들어온 게시판의 고유번호를 삽입하기
      //      location.replace("/boardDetailForm.do?b_no="+b_no);      >> get 방식.
          $("[name='gongGoDetailForm']").find("[name='g_no']").val(g_no);
          //----------------------------------
          // name='boardDetailForm' 을 가진 
          // form 태그의 action 에 설정된 URL 주소로 WAS 접속해서 
          // 얻은 새 HTML 를 웹브라우저 열기.
          // 즉 화면 이동하기.
          //----------------------------------
          document.gongGoDetailForm.submit();
      }
    
    function goresumeListDetailForm(p_no,resume_no){
       $("[name='resumeListDetailForm']").find("[name='p_no']").val(p_no);
       $("[name='resumeListDetailForm']").find("[name='resume_no']").val(resume_no);

       document.resumeListDetailForm.submit();

    }
    
    function goresumeListDetailForm(p_no,resume_no){
    	$("[name='resumeListDetailForm']").find("[name='p_no']").val(p_no);
    	$("[name='resumeListDetailForm']").find("[name='resume_no']").val(resume_no);

    	document.resumeListDetailForm.submit();

    }
    
    </script>
  
</head>
<body>
    <div id="container">    
  <%@ include file="header.jsp" %>


 <div class="container">
       <br>
        <h1 style="text-align: center; font-size:2em;">기업 마이페이지</h1>
        <table style="margin:auto;">
            <thead>
            <div class="right-align">
   </div>
            <br>
                <tr>
                    <th colspan="4">기업 정보
                    <input type="button"  value=" 정보 수정 "  class="button-right"  onClick="document.MyCompanyInfo.submit()">
                    </th>
                </tr>
            </thead>
            <tbody>
            <c:forEach var="MyComInfo" items="${requestScope.myCompanyInfo}"  varStatus="status">
                <tr>
                    <th style="width: 20%;">기업명</th>
                    <td>${MyComInfo.name}</td>
                    <th style="width: 20%;">대표자명</th>
                    <td>${MyComInfo.ceo_name}</td>
                </tr>
                <tr>
                    <th style="width: 20%;">업종</th>
                    <td>${MyComInfo.business_industry}</td>
                    <th style="width: 20%;">관심수</th>
                    <td>${MyComInfo.rec_count}</td>
                </tr>
                </c:forEach>
            </tbody>
        </table>

<br>

        <table style="margin:auto;">
           <div class="right-align">
         </div>
            <thead>
                <tr>
                    <th colspan="4">입사 지원한 이력서
                    <input type="button" value=" 전체 이력서 " class="button-right"  onClick="location.replace('/resumeList.do')">
                    </th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <th style="width: 20%;">지원받은 공고내용</th>
                    <th style="width: 20%;">지원자명</th>
                    <th style="width: 20%;">나이(만)</th>
                    <th style="width: 20%;">성별</th>
                 </tr>
                 <c:forEach var="comPertocom" items="${requestScope.gonggoPertocom}"  varStatus="status">

               <tr style="cursor:pointer" onClick="goresumeListDetailForm(${comPertocom.p_no},${comPertocom.resume_no});"
                    class="<c:if test="${status.index >= 5}">hidden-row</c:if>">
                       <td align="center"> ${comPertocom.content}</td>
                       <td align="center"> ${comPertocom.name}</td>
                       <td align="center"> ${comPertocom.age}세</td>
                       <td align="center"> ${comPertocom.sex}</td>
                      <input type="hidden" name="resume_no" value="${comPertocom.resume_no}">
                      <input type="hidden" name="p_no" value="${comPertocom.p_no}">
                      
                       
                    </tr>
                 </c:forEach>
            </tbody>
        </table>

<br>

        <table style="margin:auto;">
           <div class="right-align">
         </div>
            <thead>
                <tr>
                    <th  colspan="4">등록한 공고
                    <input type="button" value=" 전체공고 "  class="button-right" onClick="location.replace('/gongGoList.do')">
                    </th>
                </tr>
            </thead>
            <tbody>
                <tr>
                   <th style="width: 5%;">번호</th>
                    <th style="width: 20%;">내용</th>
                  <th style="width: 10%;">작성일</th>
                    <th style="width: 15%;">공고 기간</th>
                </tr>
                <c:forEach var="gongGo" items="${requestScope.gongGoList}"  varStatus="status">

                    <tr style="cursor:pointer" onClick= "goGongGoDetailForm(${gongGo.g_no})"
                    class="<c:if test="${status.index >= 5}">hidden-row</c:if>">
                       <td align="center"> ${status.index+1}</td>
                       <td align="center"> ${gongGo.content}</td>
                       <td align="center"> ${gongGo.gonggoreg_date}</td>
                       <td align="center"> ${gongGo.opendate} ~ ${gongGo.closedate}</td>
                             <input type="hidden" name="g_no" value="${gongGo.g_no}">
                       
                    </tr>
              </c:forEach>
               <tr id="showMoreBtn" <c:if test="${requestScope.gongMoList.size() <= 5}">style="display: none;"</c:if>>
                <td colspan="4" style="text-align: center;" onclick="showMoreComments()">
                    더보기
                </td>
            </tr> 
            </tbody>
        </table>

<br>


        <table style="margin:auto;">
           <div class="right-align">
         </div>
            <thead>
                <tr>
                <th colspan="4">
                    등록한 공모전
                    <input type="button" value=" 전체공모전 "  class="button-right"  onClick="location.replace('/gongMo.do')">
                </th>
            </tr>
            </thead>
            <tbody>
               <tr>
                  <th style="width: 5%;">번호</th>
                  <th style="width: 20%;">공모전 제목</th>
                  <th style="width: 10%;">작성일</th>
                  <th style="width: 15%;">공모전 기간</th>
               </tr>
               <c:forEach var="gongMo" items="${requestScope.gongMoList}"  varStatus="status">
                    <tr style="cursor:pointer" onClick= "goGongMoDetailForm(${gongMo.comp_pk})"
                    class="<c:if test="${status.index >= 5}">hidden-row</c:if>">
                       <td align="center"> ${status.index+1}</td>
                       <td align="center"> ${gongMo.subject}</td>
                       <td align="center"> ${gongMo.reg_date}</td>
                       <td align="center"> ${gongMo.start_time} ~ ${gongMo.end_time}</td>
                    </tr>
              </c:forEach>
              <tr id="showMoreBtn" <c:if test="${requestScope.gongMoList.size() <= 5}">style="display: none;"</c:if>>
                <td colspan="4" style="text-align: center;" onclick="showMoreComments()">
                    더보기
                </td>
            </tr>
            </tbody>
        </table>

      
      
</form>       
      <form name="MyCompanyInfo"  action="/companySujungForm.do"  method="post">
            <input type="hidden" name="c_no"  value='${sessionScope.c_no}'>
      </form>


      <form name="gongMoDetailForm" action="/gongMoDetailForm.do" method="post">
      <input type="hidden" name="comp_pk">
      <input type="hidden" name="g_no">
      </form>
      
      <form name="gongGoDetailForm" action="/gonggoDetailForm.do" method="post">
      <input type="hidden" name="g_no" >
      </form>
            <form name="resumeListDetailForm" action="/resumeListDetail.do" method="post">
      <input type="hidden" name="resume_no" >
      <input type="hidden" name="p_no" >
      </form>
      
<br>
    </div>
      
</body>
<%@ include file="footer.jsp" %> 
</html>