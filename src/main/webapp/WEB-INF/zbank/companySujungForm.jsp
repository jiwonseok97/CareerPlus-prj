<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
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
						alert('result')
						
						if(result==1){
							alert("정보등록 성공입니다!");
							location.replace("/loginForm.do")
						}
						else {
							alert(result)
						
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
						<td>기업명</td>
						<td></td>
					</tr>
					<tr>
						<td>기업 로고 등록</td>
						<td></td>
					</tr>
					<tr>
						<td>홈페이지</td>
						<td><input type="text" id="url" class="url" name="url"
							required></td>
					</tr>
					<tr>
						<td>기업 이메일</td>
						<td></td>
					</tr>
					<tr>
						<td>복리후생</td>
						<td><input type="checkbox" id="welfare_code"	name="welfare_code" value="1">
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
						<td><select id="business_industry" name="business_industry"
							required>
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
									<!-- 필요한 업종 옵션을 추가하세요 -->
						</select></td>
					</tr>
					<tr>
						<td>설립일</td>
						<td><input type="date" id="birth" name="birth" required></td>
					</tr>
					<tr>

						<td>대표자명</td>
						<td></td>
					</tr>
					<tr>
						<td>회사 번호</td>
						<td></td>
					</tr>
					<tr>
						<td>사업자번호</td>
						<td></td>
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
 --%>