//-------------------------------------------------------------------------------
// 슬라이드쇼 초기화 - 요소가 존재하는 페이지에서만 실행
var slides = document.querySelectorAll("#slides > img");
var prev = document.getElementById("prev");
var next = document.getElementById("next");
var current = 0;

// slides가 존재하고 길이가 있을 때만 실행
if (slides && slides.length > 0) {
  showSlides(current);
  if (prev) prev.onclick = prevSlide;
  if (next) next.onclick = nextSlide;
}

function showSlides(n) {
  if (!slides || slides.length === 0) return;
  for (let i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";
  }
  if (slides[n]) {
    slides[n].style.display = "block";
  }
}

function prevSlide() {
  if (!slides || slides.length === 0) return;
  if (current > 0) current -= 1;
  else current = slides.length - 1;
  showSlides(current);
}

function nextSlide() {
  if (!slides || slides.length === 0) return;
  if (current < slides.length - 1) current += 1;
  else current = 0;
  showSlides(current);
}

//---------------------------------------------------------------------------




function isEmpty(str){
	if(typeof(str)!="string"){
		str="";
	}
	str=str.trim();
	
	return str=="";
	
	}
	
	
//	-----------------------------------------------------------------------------
function checkDateRange(minYear,minMonth,maxYear,maxMonth,title){
	try{
		if(minYear==null){
			alert("checkDateRange 함수 호출시 들어오는 1번째 인자에 대응하는 태그가 없습니다."); return;
		}
		if(minMonth==null){
			alert("checkDateRange 함수 호출시 들어오는 2번째 인자에 대응하는 태그가 없습니다."); return;
		}
		if(maxYear==null){
			alert("checkDateRange 함수 호출시 들어오는 3번째 인자에 대응하는 태그가 없습니다."); return;
		}
		if(maxMonth==null){
			alert("checkDateRange 함수 호출시 들어오는 4번째 인자에 대응하는 태그가 없습니다."); return;
		}
		if(title==undefined){
			alert("checkDateRange 함수 호출시 들어오는 5번째 인자에 대응하는 태그가 없습니다."); return;
		}
		var minYObj = $("."+minYear);
		var minMObj = $("."+minMonth);
		var maxYObj = $("."+maxYear);
		var maxMObj = $("."+maxMonth);
		var minY = minYObj.val();
		var minM = minMObj.val();
		var maxY = maxYObj.val();
		var maxM = maxMObj.val();
		
		if(minY!=""&&minM==""){
			minMObj.val("01");
			minM="01";
		}
		if(maxY!=""&&maxM==""){
			maxMObj.val("12");
			maxM="12";
		}
		
		//max년도는 있는데 min년도가 없을때
		if(maxY!=""&&minY==""){
			alert(title+"년도를 모두 설정하시오.")
		}
		
		if(minY!=""&&minM!=""&&maxY!=""&&maxM!=""){
			//max년도가 더 작으면 비우기
			if(minY>maxY){
				alert(title+"년도 설정이 잘못되었습니다.");
				maxYObj.val("");
				maxMObj.val("");
			}
			//년도가 같을때 월 비교하기
			if(minY==maxY){
				if(minM>maxM){
					alert(title+"월 설정이 잘못되었습니다.");
				}
			}
			
			//강사님 코드
	//	if( minYear!="" & minMonth!="" & maxYear!="" & maxMonth!=""  ){
	//			if( minYear+minMonth>maxYear+maxMonth ){
	//				alert("미니멈 년월이 맥시멈 년월보다 크면 안됩니다.")	
	//				maxYearObj.val(""); maxMonthObj.val("");
	//				return;
	//			}
	//		}
	//		if( minYear=="" & minMonth!=""  ){
	//			alert("미니멈 년도를 먼저 선택하세요.")	
	//			minMonthObj.val(""); return;
	//		}
	//		if( maxYear=="" & maxMonth!=""  ){
	//			alert("맥시멈 년도를 먼저 선택하세요.")	
	//			maxMonthObj.val(""); 
	//		}
			
			
		}
	}catch(ex){
		alert("checkDateRange 함수에서 예외 발생!"+ex.message);
	}
}

//	-------------------------------------------------------------------------
function getOptionWithYear(minYear,maxYear){
	if(minYear>maxYear){
		var tmp = minYear;
		minYear = maxYear;
		maxYear = tmp;
	}
	var arr = [];
	for(var i=maxYear ; i>=minYear ; i--){
		arr.push( "<option>" + i + "</option>" );
	}
	return arr.join("");
}
//	-------------------------------------------------------------------------
function thisYear(){
	return new Date().getFullYear();
}


//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
// 매개변수로 들어온 JQuery 객체가 관리하는 
// 태그에 입력된 문자의 앞뒤 공백을 제거하고 다시 넣어 주기 
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
function inputAfterBlankDel( obj ) {
	try{
		if( obj.length==0 ){
			alert("inputAfterBlankDel 함수 호출 시 "
					+"1번째 매개변수로 들어오는 JQuery 객체가 관리하는 태그가 없습니다.");
			return;
		}
		if( obj.is(":checkbox") || obj.is(":radio") ){
			alert("inputAfterBlankDel 함수 호출 시 "
					+"1번째 매개변수로 들어오는 JQuery 객체가 관리하는 태그는 "
					+"[체크박스] 도 아니고 [라디오버튼]도 아닙니다.");
			return;
		}
		var val = obj.val( );
		if( typeof(val)=='string' ){
			obj.val( val.trim()  );
		}
	}
	catch(e){
		alert( "inputAfterBlankDel함수 호출 시 예외 발생! " + e.message )
	}
	
}


