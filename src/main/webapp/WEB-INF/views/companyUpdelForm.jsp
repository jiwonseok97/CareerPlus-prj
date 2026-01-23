<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>12Wa~</title>

<script>
   function comRegUpDel(){
      var formObj = $("[name='comUpDel']");
      
      
      $.ajax(
            { 
               
               url    : "/comUpDelProc.do"
               
               ,type  : "post"
               
               ,data  : formObj.serialize( )
               
               ,success : function(json){
                  var result = json["result"];
                  
                  if(result==1){
                     alert("정보등록 성공입니다!");
                     location.replace("/12Wa.do")
                  }
                  else {
                     alert("잘못됨ㅅㄱ")
                  
                  }
               }
               //----------------------------------------------------------
               // WAS 의 응답이 실패했을 실행할 익명함수 설정.
               //----------------------------------------------------------
               ,error : function(){
                  alert("정보등록 실패! 관리자에게 문의 바람니다.");
               }
            }
         );
      }
   </script>

</head>

<body>

   <div id="container">
      <%@ include file="header.jsp"%>






      <div class="container">
         <br>
         <h1 style="text-align: center;">기업 정보 등록</h1><br>
         <form action="submit.php" method="POST" name='comUpDel'>
            <table
               style="border: 1px solid black; margin-left: auto; margin-right: auto;">
               <tr>
                  <th>항목</th>
                  <th>등록 사항</th>
               </tr>
               <tr>
                  <td>기업 로고 등록</td>
                  <td><input type="file" id="competition_file" name="competition_file" accept=".pdf, .doc, .docx"  ></td>
               </tr>
               <tr>
                  <td>홈페이지</td>
                  <td><input type="text" id="url" class="url" name="url"
                     required></td>
               </tr>
               <tr>
                  <td>복리후생</td>
                  <td><input type="checkbox" id="welfare_code"   name="welfare_code" value="1">
                      <label for="benefits">4대보험가입</label>
                     <input type="checkbox" id="welfare_code" name="welfare_code" value="2">
                     <label for="benefits">연금가입</label> 
                     <input type="checkbox"  id="welfare_code" name="welfare_code" value="3">
                     <label for="benefits">보너스 및 인센티브</label>
                     <input type="checkbox" id="welfare_code" name="welfare_code" value="4">
                     <label for="benefits">수당제도</label><br>
                     <input type="checkbox" id="welfare_code" name="welfare_code" value="5">
                     <label for="benefits">사내동호회 운영</label> 
                     <input type="checkbox"  id="welfare_code" name="welfare_code" value="6">
                     <label for="benefits">경조사 지원</label>
                     <input type="checkbox" id="welfare_code" name="welfare_code" value="7">
                     <label for="benefits">사무용품 지원</label>
                     <input type="checkbox" id="welfare_code" name="welfare_code" value="8">
                     <label for="benefits">출산/육아 지원제도</label><br>
                     <input type="checkbox"  id="welfare_code" name="welfare_code" value="9">
                     <label for="benefits">자유복장</label>
                     <input type="checkbox" id="welfare_code" name="welfare_code" value="10">
                     <label for="benefits">식대제공</label> 
                     <input type="checkbox"  id="welfare_code" name="welfare_code" value="11">
                     <label for="benefits">기숙사 및 사택 제공</label>
                     <input type="checkbox" id="welfare_code" name="welfare_code" value="12">
                     <label for="benefits">차량유류비 지급</label><br>
                     <input type="checkbox" id="welfare_code" name="welfare_code" value="13">
                     <label for="benefits">통근버스 운행</label> 
                     <input type="checkbox"  id="welfare_code" name="welfare_code" value="14">
                     <label for="benefits">교통비 지급</label>
                     <input type="checkbox" id="welfare_code" name="welfare_code" value="15">
                     <label for="benefits">유연근무제</label>
                     <input type="checkbox" id="welfare_code" name="welfare_code" value="16">
                     <label for="benefits">각종 행사</label>
                     
               </td>
               </tr>
               <tr>
                  <td>기업 형태</td>
                  <td><select id="volume" name="volume" required>
                        <option value=""></option>
                        <option value="대기업">대기업</option>
                        <option value="중견기업">중견기업</option>
                        <option value="중소기업">중소기업</option>
                  </select></td>
               </tr>
               <tr>
                  <td>대표 업종</td>
                  <td><select id="field_code" name="field_code"
                     required>
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
                           <!-- 필요한 업종 옵션을 추가하세요 -->
                  </select></td>
               </tr>
               <tr>
                  <td>설립일</td>
                  <td><input type="date" id="birth" name="birth" required></td>
               </tr>
               

               <tr>
                  <td>매출 액</td>
                  <td><input type="text" id="sales" name="sales" required></td>
               </tr>
               <tr>
                  <td>회사 주소</td>
                  <td><select name="addr1" id="sido1"></select> <select
                     name="addr2" id="gugun1"></select>&nbsp; <input type="text"
                     name="addr3" id="addr" value="나머지 상세주소"
                     onfocus="if(this.value=='나머지 상세주소') this.value='';"></td>

               </tr>




               <tr>
                  <td>사원수</td>
                  <td><input type="text" id="emp_no" name="emp_no" required></td>
               </tr>
               <tr>
                  <td>평균연봉</td>
                  <td><input type="text" id="sal_avg" name="sal_avg" required></td>
               </tr>
               <input type="hidden" name="mem_c_no" value="${sessionScope.c_no}">


            </table>
            <br>
            <center>
                <input type="button" value="등록" onClick="comRegUpDel()">
            </center>
         </form>
         <br>
      </div>
      
</body>
<%@include file="/WEB-INF/views/common.jsp" %>
<%@ include file="footer.jsp"%>
</html>