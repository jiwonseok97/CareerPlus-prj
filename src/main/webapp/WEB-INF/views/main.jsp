<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@include file="/WEB-INF/views/common.jsp" %>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>12Wa~</title>
  <script>
function gonoticeDetailForm(n_no){
    $("[name='noticeDetailForm']").find("[name='n_no']").val(n_no);

     document.noticeDetailForm.submit();
 
}
function gocompanyListDetailForm(c_no){
    $("[name='companyListDetailForm']").find("[name='c_no']").val(c_no);
 
     document.companyListDetailForm.submit();
 
}
</script>
<script type="text/javascript">
  google.charts.load('current', {
    'packages':['geochart'],
  });

  google.charts.setOnLoadCallback(drawRecordsStatisticsRegionRatioChart);

  function drawRecordsStatisticsRegionRatioChart() {
	  var data = google.visualization.arrayToDataTable([
	        ['Region', 'Popularity'],
	        <c:choose>
	            <c:when test="${sessionScope.member == 'company'}">
	                <c:forEach var="regionRatio" items="${requestScope.getPer_RegionCnt}" varStatus="status">
	                    ['?œìš¸', ${regionRatio.count_seoul}],
	                    ['ê²½ê¸°??, ${regionRatio.count_gyeonggi}],
	                    ['KR-28', ${regionRatio.count_incheon}],
	                    ['ê°•ì›??, ${regionRatio.count_gangwon}],
	                    ['KR-26', ${regionRatio.count_busan}]
	                    <c:if test="${!status.last}">,</c:if>
	                </c:forEach>
	            </c:when>
	            <c:otherwise>
	                <c:forEach var="regionRatio" items="${requestScope.RegionCount}" varStatus="status">
	                    ['?œìš¸', ${regionRatio.count_seoul}],
	                    ['ê²½ê¸°??, ${regionRatio.count_gyeonggi}],
	                    ['KR-28', ${regionRatio.count_incheon}],
	                    ['ê°•ì›??, ${regionRatio.count_gangwon}],
	                    ['KR-26', ${regionRatio.count_busan}]
	                    <c:if test="${!status.last}">,</c:if>
	                </c:forEach>
	            </c:otherwise>
	        </c:choose>
	    ]);

      var options = {
              region: 'KR',
              displayMode: 'regions',
              resolution: 'provinces',
              colorAxis: { minValue: 0 },
              title: 'ì§€??³„ ?´ìš©????
          };

          var chart = new google.visualization.GeoChart(document.getElementById('recordsStatisticsRegionRatio'));

          chart.draw(data, options);

  }
</script>
</head>


<style>

	.promote {
    overflow: hidden;
    position: relative;
    width: 100%;
    height: 350px;
}

	.promote .bx-wrapper {
    height: 100%;
}

.promote_a {
	padding: 75px 0 0 150px;
	position: absolute;
	width: 100%;
	height: 100%;
	background-size: cover;
	background-position: right bottom;
}

.promote_a {
	background: url('/static/images/promote_a.png') no-repeat right bottom;
}

.promote_b {
	background: url('/static/images/promote_b.png') no-repeat right bottom;
	padding: 75px 0 0 750px;
	position: absolute;
	width: 100%;
	height: 100%;
	background-size: cover;
	background-position: right bottom;
}

.promote_a_title, .promote_b_title {
	font-size: 40px;
	font-weight: 200;
	color: #111;
	text-align: justify;
	line-height: 48px;
}

.promote_a_title b, .promote_b_title b {
	font-weight: 700 !important;
}

.promote_a_sub, .promote_b_sub {
	margin-top: 5px;
	font-size: 20px;
	font-weight: 200;
	color: #111;
	letter-spacing: -1px;
	line-height: 28px;
}

	.promote_a_btn {
    display: inline-block;
    margin-top: 13px;
    padding: 11px 20px;
    color: #111;
    border: 1px solid #111;
    border-radius: 5px;
}

.prev, .next {
	cursor: pointer;
	position: absolute;
	top: 50%;
	width: auto;
	padding: 16px;
	margin-top: -22px;
	color: white;
	font-weight: bold;
	font-size: 18px;
	transition: 0.6s ease;
	user-select: none;
	z-index: 99;
}

.next {
	right: 0;
}

.prev:hover, .next:hover {
	background-color: rgba(0, 0, 0, 0.8);
}

.text_center {
	font-size: 32px;
	font-weight: 700;
	color: #111;
}

.sub_title {
	margin-top: 11px;
	font-size: 1.2rem;
	color: #767676;
	text-align: center;
	line-height: 26px;
}
</style>

<body>
	<div id="container">
	<div id="wrap">
		<%@ include file="header.jsp"%>

	<div id="slideShow" class="promote">
			<div id="slides">
			<img src="images/promote_b.png" alt="">
<!-- 					<div class="slide promote_a active" aria-hidden="false" style="background-image: url('/static/images/promote_a.png');"> -->
				<div class="slide promote_a active" aria-hidden="false" style="display: block;">
					<div class="size_set">
						<p class="promote_a_title">
							ë§ì¶¤??<b>ì·¨ì—…</b><br> <b>ê¸°ì—…?•ë³´?€ ì±„ìš©</b>ê¹Œì?
						</p>
						<p class="promote_a_sub">
							???˜ì? ?¼ìë¦¬ë? êµ¬í•˜?„ë¡ ?œê³µ?©ë‹ˆ??<br>12wa~?ì„œ ?´ë£¨?¸ìš”.
						</p>
					</div>
				</div>
				
				<img src="images/promote_a.png" alt="">
<!-- 				  	 <div class="slide promote_b" aria-hidden="true" style="background-image: url('/static/images/promote_b.png');"> -->
				<div class="slide promote_b" aria-hidden="true" style="display: none;">
					<div class="size_set">
						<p class="promote_b_title">
							<b>?¹ì‹ ??ì·¨ì—…?´ë£¸</b>??br> ?‘ì›?©ë‹ˆ??
						</p>
						<p class="promote_b_sub">
							???˜ì? ?¼ìë¦¬ë? êµ¬í•˜?„ë¡ ?œê³µ?©ë‹ˆ??<br>12wa~?ì„œ ?´ë£¨?¸ìš”.
						</p>
					</div>
				</div>
				
				<button id="prev">&lang;</button>
				<button id="next">&rang;</button>
			</div>
		</div>

		<script type="text/javascript">
			$(document).ready(function() {
				$(".slide").not(".active").hide(); // ?”ë©´ ë¡œë”© ??ì²«ë²ˆì§?divë¥??œì™¸???˜ë¨¸ì§€ ?¨ê?
			
// 				setInterval(nextSlide, 3000); // 3ì´ˆë§ˆ???¤ìŒ ?¬ë¼?´ë“œë¡??˜ì–´ê°?);
			});
			

			// ?´ì „ ?¬ë¼?´ë“œ
			function prevSlide() {
				 var allSlides = $(".slide");
				 var currentIndex = allSlides.index($(".active"));

				allSlides.hide().removeClass("active");

				var newIndex = (currentIndex <= 0) ? allSlides.length - 1
						: currentIndex - 1;

				allSlides.eq(newIndex).show().addClass("active");
				return newIndex; // ?¬ë¼?´ë“œ ?¸ë±?¤ë? ë°˜í™˜
				
			}
			
			// ?¤ìŒ ?¬ë¼?´ë“œ
			function nextSlide() {
				var allSlides = $(".slide");
				var currentIndex = allSlides.index($(".active"));

				allSlides.hide().removeClass("active");

				var newIndex = (currentIndex >= allSlides.length - 1) ? 0
						: currentIndex + 1;

				allSlides.eq(newIndex).show().addClass("active");
				return newIndex; // ?¬ë¼?´ë“œ ?¸ë±?¤ë? ë°˜í™˜
			}
			
            // ?¤ìŒ ?¬ë¼?´ë“œë¡??´ë™?˜ê³  ?ìŠ¤???…ë°?´íŠ¸
            function nextSlideAndUpdateText() {
                var newIndex = nextSlide();
                updateText(newIndex); // ?¬ë¼?´ë“œê°€ ë³€ê²½ë  ?Œë§ˆ???ìŠ¤???…ë°?´íŠ¸ ?¨ìˆ˜ ?¸ì¶œ
            }
			
            // ?´ì „ ?¬ë¼?´ë“œë¡??´ë™?˜ê³  ?ìŠ¤???…ë°?´íŠ¸
            function prevSlideAndUpdateText() {
                var newIndex = prevSlide();
                updateText(newIndex); // ?¬ë¼?´ë“œê°€ ë³€ê²½ë  ?Œë§ˆ???ìŠ¤???…ë°?´íŠ¸ ?¨ìˆ˜ ?¸ì¶œ
            }
			

			function updateText(slideIndex) {

			    // ?¬ë¼?´ë“œ ?´ë?ì§€?€ ?ìŠ¤?¸ë? ë§¤í•‘?˜ëŠ” ë°°ì—´??ë§Œë“­?ˆë‹¤.
			    const slideTextArray = [{
			    	 title: "ë§ì¶¤??<b>ì·¨ì—…</b><br> <b>ê¸°ì—…?•ë³´?€ ì±„ìš©</b>ê¹Œì?",
                     sub: "???˜ì? ?¼ìë¦¬ë? êµ¬í•˜?„ë¡ ?œê³µ?©ë‹ˆ??<br>12wa~?ì„œ ?´ë£¨?¸ìš”."
			    }, {
			    	 title: "<b>?¹ì‹ ??ì·¨ì—…?´ë£¸</b>??br> ?‘ì›?©ë‹ˆ??",
                     sub: "???˜ì? ?¼ìë¦¬ë? êµ¬í•˜?„ë¡ ?œê³µ?©ë‹ˆ??<br>12wa~?ì„œ ?´ë£¨?¸ìš”."
			    }];

			    // ?„ì¬ ?¬ë¼?´ë“œ ?¸ë±?¤ì— ?´ë‹¹?˜ëŠ” ?ìŠ¤??ê°€?¸ì˜¤ê¸?
			    const slideText = slideTextArray[slideIndex];
				
			    // ê°€?¸ì˜¨ ?ìŠ¤?¸ë? ?´ë‹¹?˜ëŠ” ?”ì†Œ???…ë°?´íŠ¸?©ë‹ˆ??
			    const titleElement = $(".slide.active .promote_title");
			    const subElement = $(".slide.active .promote_sub");

			    titleElement.textContent = slideText.title; // textContentë¡??ìŠ¤???…ë°?´íŠ¸
			    subElement.textContent = slideText.sub; // textContentë¡??ìŠ¤???…ë°?´íŠ¸
			}

			// ?´ì „ ë²„íŠ¼ê³??¤ìŒ ë²„íŠ¼???´ë¦­????ë§ˆë‹¤ ?…ë°?´íŠ¸ ?¨ìˆ˜ ?¸ì¶œ
			$('#prev').on('click', prevSlide)
			$('#next').on('click', nextSlide)


		</script>
		
				<center>
			<h3 class="text_center">êµ¬ì¸êµ¬ì§ ?¬ì´??12wa~ ?¬ì—…?Œê°œ</h3>
		</center>
		<p class="sub_title">2024??5??31???Œêµ¬ì§ì ì·¨ì—…ì´‰ì§„ ë°?ì±„ìš©ê³µê³ ?â€?2wa~?™ê?
			?œí–‰?˜ì—ˆ?µë‹ˆ??</p>

    <div id="contents">
    
      <div id="tabMenu">
        <input type="radio" id="tab1" name="tabs" checked>
        <label for="tab1">ê³µì??¬í•­</label>
        <input type="radio" id="tab2" name="tabs" onclick="getNaverNews()">
        <label for="tab2">IT/?´ìŠ¤</label>
        <input type="radio" id="tab3" name="tabs" onclick="getYouTube()">
        <label for="tab3">YouTube</label>
              
        <div id="notice" class="tabContent">
          <h2>ê³µì??¬í•­ ?´ìš©?…ë‹ˆ??</h2>     
          <ul>        
         <c:set var="mainCount" value="0" />
         <c:forEach var="board" items="${requestScope.noticeList}" varStatus="status">
             <c:if test="${mainCount < 5}">
                 <c:if test="${board.category eq 'main'}">
                     <c:set var="mainCount" value="${mainCount + 1}" />
                     <li style="cursor:pointer" onClick="gonoticeDetailForm(${board.n_no})">
                         ${board.subject}
                     </li>
                 </c:if>
             </c:if>
         </c:forEach>
          </ul>

        </div>
               <form name="noticeDetailForm" action="/noticeDetail.do"   method="post">
                  <!-- ?´ë¦­???‰ì˜ ê²Œì‹œ??ê³ ìœ ë²ˆí˜¸ê°€ ?€?¥ë  ?ˆë“ ?œê·¸ ? ì–¸ -->
                  <input type="hidden" name="n_no"  value="${board.n_no}">
                                    
             </form>  
               
        <div id="gallery" class="tabContent">
          <h2>IT/?´ìŠ¤ ?´ìš©?…ë‹ˆ??</h2>
          <ul id="headLine">
          </ul>
        </div> 
        
        <div id="youTube" class="tabContent">
          <h2>ì±„ìš©ê´€??/h2>
          <ul id="youtubeList">
          </ul>
        </div>   
            
      </div>
      
      <div id="links">
        <ul>
          <li>
          	<c:choose>
          		<c:when test="${sessionScope.member=='company'}">
          			<b>?…ì¢…ë³??¬ë§?¸ì›, ì§€????/b>
          		</c:when>
          		<c:when test="${sessionScope.member=='admin'}">
          			<b>?”ë³„ ê°€?…ì ??ì¶”ì´</b>
          		</c:when>
          		<c:otherwise>
          			<b>?…ì¢…ë³?ê³µê³ ,ê¸°ì—… ??/b>
          		</c:otherwise>
          	</c:choose>
          	<c:if test="${sessionScope.member!='admin'}">
              <canvas id="gonggoChart" width="800px" height="262px"></canvas>
             </c:if>
          	<c:if test="${sessionScope.member=='admin'}">             
              <canvas id="MemberIn" width="800px" height="262px"></canvas>
            </c:if>
          </li> 
        </ul>
      </div>
          		 
	  <div id="links2">
	    <ul>
	    	<li>
	    		<div id="popular" style="font-family: Arial, sans-serif; font-size: 16px; line-height: 1.6; border: 1px solid #ccc; padding: 30px; border-radius: 30px; width: 350px; text-align:left; padding-left:70px;">
				    <div style="margin-bottom:30px"><b style="font-size: 20px; color: #007bff; font-weight: bold;">?„ì¬ ?¸ê¸° ë§ì? TOP5 ê¸°ì—…</b></div>
				    <c:forEach var="board" items="${requestScope.popularCom}" varStatus="status">
				        <div style="margin-bottom: 10px;">
				            <a style="color: #007bff; font-weight: bold; cursor:pointer;" onClick="gocompanyListDetailForm(${board.c_no});">${board.rnum}??/a> - <span style="cursor:pointer;"onClick="gocompanyListDetailForm(${board.c_no});">${board.name}</span> 
				        </div>
				    </c:forEach>
				    <div style=" margin-top: 30px; text-align:center;">
					    <input type="button" value="+?”ë³´ê¸? onClick="location.replace('/companyList.do')" style="cursor:pointer;  background-color: #007bff; color:#fff ; border-radius:5px; opacity:0.7;">
					</div>
				</div>
	    	</li>
	        <li>
	            <canvas id="SalaryChart" width="400px" height="262px"></canvas>
	        </li>
	        <li>
	        	 <div class="recordsStatisticsRegionRatioContainer">
	        	 <c:if test="${sessionScope.member!='admin' }">
			        <div class="recordsStatisticsRegionRatioTitle" ><br>
			       </c:if>
			          		<c:if test="${sessionScope.member=='company'}">
			          			<b>ì§€??³„ ?¸ì› ??/b>
			          		</c:if>
			          		<c:if test="${sessionScope.member!='company' and sessionScope.member!='admin'} ">
			          			<b>ì§€??³„ ê¸°ì—… ??/b>
			          		</c:if>
			        	</div>
			         <c:if test="${sessionScope.member!='admin'}">	
			        	<div id="recordsStatisticsRegionRatio" style="width: 100%; height: 340px; margin: 0 auto;"></div>
			        </c:if>
			        <c:if test="${sessionScope.member=='admin'}">
			        	<canvas id="MemberRatio" width="400px" height="262px"></canvas>
			        </c:if>	
			        
			    </div>
	        </li>
	    </ul>
	</div>
<!--       ê¸°ì—… ?‰ê· ?°ë´‰ ë¶„í¬???¨ìœ„ : ë§Œì›) -->
<!-- 	            <canvas id="SalaryChart" width="400px" height="262px"></canvas> -->
    </div>  
    </div>
  </div> 
  <form name="companyListDetailForm" action="/companyListDetail.do"  method="post">
            <!-- ?´ë¦­???‰ì˜ ê²Œì‹œ??ê³ ìœ ë²ˆí˜¸ê°€ ?€?¥ë  ?ˆë“ ?œê·¸ ? ì–¸ -->
            <input type="hidden" name="c_no" value="${board.c_no}">
         </form>
  
  
  <script>
  const memberValue = '${sessionScope.member}';
	let labels1, data1,text1,label1;
	if (memberValue === 'company') {
	    labels1 = ${empty Salary_Range ? 0 : Salary_Range};
	    data1 = ${empty Hope_Cnt?0:Hope_Cnt};
	    text1 = "?¬ë§ ?°ë´‰ ë¶„í¬(?¨ìœ„: ë§?";
	    label1 = "?¬ë§ ?¸ì›";
	} 
	else if(memberValue==='admin'){
		labels1 = ${empty getSexRatio ? 0 : '["??, "??]'};
		data1= ${empty getSexRatio ? 0 : [getSexRatio.male, getSexRatio.female]};
		text1= "???€ ë¹„ìœ¨";
		label1="?¸ì› ??;
	}
	else {
	    labels1 = ${Range};
	    data1 = ${SalaryData};
	    text1 = "ê¸°ì—… ?°ë´‰ ë¶„í¬(?¨ìœ„: ë§?";
	    label1 = "ê¸°ì—… ??
	}
  
  const ctx1 = document.getElementById('SalaryChart').getContext('2d');

  console.log("12"+labels1);
  
  const SalaryChart = new Chart(ctx1, {
	    type: 'doughnut',
	    data: {
	      labels: labels1,
	      datasets: [
	    	 {
	        label: label1,
	        data: data1,
	        backgroundColor: [
	          'rgba(54, 162, 235, 0.6)',
	          'rgba(255, 99, 132, 0.6)',
	          'rgba(255, 206, 86, 0.6)',
	          'rgba(75, 192, 192, 0.6)',
	          'rgba(153, 102, 255, 0.6)',
	          'rgba(255, 159, 64, 0.6)',
	          'rgba(128, 0, 128, 0.6)',
	          'rgba(0, 0, 255, 0.6)',
	          'rgba(0, 128, 0, 0.6)'
	          
	        ],
	        borderColor: [
	          'rgba(54, 162, 235, 1)',
	          'rgba(255, 99, 132, 1)',
	          'rgba(255, 206, 86, 1)',
	          'rgba(75, 192, 192, 1)',
	          'rgba(153, 102, 255, 1)',
	          'rgba(255, 159, 64, 1)',
	          'rgba(128, 0, 128, 1)',
	          'rgba(0, 0, 255, 1)',
	          'rgba(0, 128, 0, 1)'
	        ],
	        borderWidth: 1,
	        hoverOffset: 50
	      }]
	    },
	    options: {
	      plugins: {
	    	  title: {
	    	        display: true,
	    	        text: text1,
	    	        color: 'black',
	    	        font: {
	    	          size: 18
	    	        },
	    	        padding: {
	    	          top: 10,
	    	          bottom: 10
	    	        }
	    	      },
	        legend: {
	          display: true,
	          position: 'bottom',
	          labels: {
	            color: 'black',
	            font: {
	              size: 14
	            },
	            boxWidth:10
	          }
	        },
	        tooltip: {
	          enabled: true,
	          backgroundColor: 'rgba(0, 0, 0, 0.7)',
	          titleColor: 'white',
	          bodyColor: 'white',
	          borderColor: 'white',
	          borderWidth: 1
	        }
	      },
	      animation: {
	        animateScale: true,
	        animateRotate: true
	      },
	      layout: {
	        padding: {
	          left: 20,
	          right: 20,
	          top: 20,
	          bottom: 20
	        }
	      }
	    }
	  });
  
if(memberValue!='admin'){
  const ctx2 = document.getElementById('gonggoChart').getContext('2d');
  let labels2, data2, data2_1, text2, label2, label2_1;
  
	if (memberValue == 'company') {
	    labels2 = ${empty Hope_Field ? 0 : Hope_Field};
	    data2 = ${empty Hope_PerCnt ? 0 : Hope_PerCnt};
	    data2_1 = ${empty Apply_Cnt ? 0 : Apply_Cnt};
		text2 = "?…ì¢…ë³??¬ë§?¸ì›, ì§€????;
	    label2 = "?¬ë§ ?¸ì›"
	    label2_1 = "ì§€????
	} else {
	    labels2 = ${Field};
	    data2 = ${gonggoCnt};
	    data2_1 = ${companyCnt};
	    text2 = "?…ì¢…ë³?ê³µê³ , ê¸°ì—… ??;
	    label2 = "ê³µê³  ??
	    label2_1 = "ê¸°ì—… ??
	}
  
  const gonggoChart = new Chart(ctx2, {
	    type: 'bar',
	    data: {
	        labels: labels2,
	        datasets: [
	            {
	                label: label2,
	                data: data2,
	                backgroundColor: '#00C7E2'
	            },
	            {
	                label: label2_1,
	                data: data2_1,
	                backgroundColor: '#FF7DA8'
	            }
	        ]
	    },
	    options: {
	        plugins: {
	            legend: {
	                labels: {
	                    boxWidth: 10 // ?¬ê¸°?ì„œ ë²”ë? ??ª©???ˆë¹„ë¥??¤ì •?©ë‹ˆ??
	                }
	            }
	        }
	    }
	});
}
else{
	const ctx3 = document.getElementById('MemberIn').getContext('2d');
  
	const MemberIn = new Chart(ctx3, {
	    type: 'line',
	    data: {
	        labels: ${month},
	        datasets: [
	            {
	                label: 'ê°œì¸ ê°€???¸ì›',
	                data: ${person_count},
	                backgroundColor: 'rgb(255, 99, 132)',
	                borderWidth: 1,
	                fill: false
	            },
	            {
	                label: 'ê¸°ì—… ê°€???¸ì›',
	                data: ${company_count},
	                backgroundColor: 'rgb(75, 192, 192)',
	                borderWidth: 1,
	                fill: false
	            }
	            ]
	    	},
	            options:{
	            	scales:{
	            		x: {
	            			beginAtZero : true
	            		},
	            		y:{
	            			beginAtZero : true
	            		}
	            	}
	            }
			});
}
const ctx4 = document.getElementById('MemberRatio').getContext('2d');
  
  const MemberRatio = new Chart(ctx4, {
	    type: 'doughnut',
	    data: {
	      labels: ${empty getMemberRatio ? 0 :'["ê°œì¸","ê¸°ì—…"]'},
	      datasets: [
	    	 {
	        label: "??,
	        data: [${getMemberRatio.person}, ${getMemberRatio.company}],
	        backgroundColor: [
	          'rgba(255, 206, 86, 0.6)',
	          'rgba(75, 192, 192, 0.6)',
	          'rgba(153, 102, 255, 0.6)',
	          'rgba(255, 159, 64, 0.6)',
	          'rgba(128, 0, 128, 0.6)',
	          'rgba(0, 0, 255, 0.6)',
	          'rgba(0, 128, 0, 0.6)'
	          
	        ],
	        borderColor: [
	          'rgba(255, 206, 86, 1)',
	          'rgba(75, 192, 192, 1)',
	          'rgba(153, 102, 255, 1)',
	          'rgba(255, 159, 64, 1)',
	          'rgba(128, 0, 128, 1)',
	          'rgba(0, 0, 255, 1)',
	          'rgba(0, 128, 0, 1)'
	        ],
	        borderWidth: 1,
	        hoverOffset: 50
	      }]
	    },
	    options: {
	      plugins: {
	    	  title: {
	    	        display: true,
	    	        text: "?Œì› ë¹„ìœ¨",
	    	        color: 'black',
	    	        font: {
	    	          size: 18
	    	        },
	    	        padding: {
	    	          top: 10,
	    	          bottom: 10
	    	        }
	    	      },
	        legend: {
	          display: true,
	          position: 'bottom',
	          labels: {
	            color: 'black',
	            font: {
	              size: 14
	            },
	            boxWidth:10
	          }
	        },
	        tooltip: {
	          enabled: true,
	          backgroundColor: 'rgba(0, 0, 0, 0.7)',
	          titleColor: 'white',
	          bodyColor: 'white',
	          borderColor: 'white',
	          borderWidth: 1
	        }
	      },
	      animation: {
	        animateScale: true,
	        animateRotate: true
	      },
	      layout: {
	        padding: {
	          left: 20,
	          right: 20,
	          top: 20,
	          bottom: 20
	        }
	      }
	    }
	  });
  //======================================================//
// 	    type: 'bar',
// 	    data: {
// 	      labels: ${Field},
// 	      datasets: [{
// 	        label: 'ê³µê³  ??,
// 	        data: ${gonggoCnt},
// 	        backgroundColor: [
// 	          'rgba(255, 99, 132, 0.6)',
// 	          'rgba(54, 162, 235, 0.6)',
// 	          'rgba(255, 206, 86, 0.6)',
// 	          'rgba(75, 192, 192, 0.6)',
// 	          'rgba(153, 102, 255, 0.6)',
// 	          'rgba(255, 159, 64, 0.6)',
// 	          'rgba(128, 0, 128, 0.6)',
// 	          'rgba(0, 0, 255, 0.6)'
// 	        ],
// 	        borderColor: [
// 	          'rgba(255, 99, 132, 1)',
// 	          'rgba(54, 162, 235, 1)',
// 	          'rgba(255, 206, 86, 1)',
// 	          'rgba(75, 192, 192, 1)',
// 	          'rgba(153, 102, 255, 1)',
// 	          'rgba(255, 159, 64, 1)',
// 	          'rgba(128, 0, 128, 1)',
// 	          'rgba(0, 0, 255, 1)'
// 	        ],
// 	        borderWidth: 1,
// 	        hoverOffset: 50
// 	      }]
// 	    },
// 	    options: {
// 	      plugins: {
// 	        legend: {
// 	          display: true,
// 	          position: 'top',
// 	          labels: {
// 	            color: 'black',
// 	            font: {
// 	              size: 14
// 	            },
// 	    		boxWidth:10
// 	          }
// 	        },
// 	        tooltip: {
// 	          enabled: true,
// 	          backgroundColor: 'rgba(0, 0, 0, 0.7)',
// 	          titleColor: 'white',
// 	          bodyColor: 'white',
// 	          borderColor: 'white',
// 	          borderWidth: 1
// 	        }
// 	      },
// 	      animation: {
// 	        animateScale: true,
// 	        animateRotate: true
// 	      },
// 	      layout: {
// 	        padding: {
// 	          left: 20,
// 	          right: 20,
// 	          top: 20,
// 	          bottom: 20
// 	        }
// 	      }
// 	    }
// 	  });


</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	function renderFallbackNews(){
	var fallback = [
		{ title: "2026 »ó¹İ±â °øÃ¤ ´ëºñ: Ã¤¿ë Æ®·»µå¿Í Á÷¹«º° ÇÙ½É ¿ª·® Á¤¸®", href: "#", img: "/images/photo-1.jpg" },
		{ title: "AI¡¤µ¥ÀÌÅÍ Á÷¹« Æ÷Æ®Æú¸®¿À ±¸¼º °¡ÀÌµå: ÇÁ·ÎÁ§Æ® ½ºÅä¸®ÅÚ¸µ 5´Ü°è", href: "#", img: "/images/photo-1.jpg" },
		{ title: "½ÅÀÔ °³¹ßÀÚ ÀÌ·Â¼­¿¡¼­ ²À ÇÇÇØ¾ß ÇÒ Ç¥Çö 10°¡Áö", href: "#", img: "/images/photo-1.jpg" },
		{ title: "Å¬¶ó¿ìµå ÀÔ¹®ÀÚ¸¦ À§ÇÑ ÀÚ°İÁõ ·Îµå¸Ê (AWS/Azure/GCP)", href: "#", img: "/images/photo-1.jpg" },
		{ title: "¸éÁ¢¿¡¼­ ¸¹ÀÌ ¹¯´Â ½Ã½ºÅÛ ¼³°è Áú¹® TOP 7", href: "#", img: "/images/photo-1.jpg" },
		{ title: "¼­ºñ½º Àå¾Ö »ç·Ê·Î º¸´Â ¸ğ´ÏÅÍ¸µ¡¤¾Ë¶÷ ¼³°è ¿øÄ¢", href: "#", img: "/images/photo-1.jpg" },
		{ title: "¹é¿£µå °³¹ßÀÚ ±â¼ú ½ºÅÃ ¼±ÅÃ ±âÁØ: ¼º´É¡¤È®Àå¼º¡¤À¯Áöº¸¼ö", href: "#", img: "/images/photo-1.jpg" },
		{ title: "ÇÁ·ĞÆ®¿£µå ¼º´É ÃÖÀûÈ­ Ã¼Å©¸®½ºÆ® (Core Web Vitals)", href: "#", img: "/images/photo-1.jpg" },
		{ title: "DevOps ÀüÈ¯ »ç·Ê: CI/CD ÆÄÀÌÇÁ¶óÀÎ ±¸Ãà ÇÁ·Î¼¼½º", href: "#", img: "/images/photo-1.jpg" },
		{ title: "µ¥ÀÌÅÍº£ÀÌ½º ÀÎµ¦½º ¼³°è ½ÇÀü ÆÁ 8°¡Áö", href: "#", img: "/images/photo-1.jpg" },
		{ title: "º¸¾È Ãë¾àÁ¡ Á¡°Ë: OWASP Top 10 ÇÙ½É ¿ä¾à", href: "#", img: "/images/photo-1.jpg" },
		{ title: "Çù¾÷À» ³ôÀÌ´Â ÄÚµå¸®ºä ¹®È­ ¸¸µé±â", href: "#", img: "/images/photo-1.jpg" },
		{ title: "¹é¿£µå ¸éÁ¢ ´ëºñ: DB Æ®·£Àè¼Ç¡¤¶ô °³³ä Á¤¸®", href: "#", img: "/images/photo-1.jpg" },
		{ title: "´ë¿ë·® Æ®·¡ÇÈ ´ëÀÀ Àü·«: Ä³½Ã¡¤Å¥¡¤»şµù", href: "#", img: "/images/photo-1.jpg" },
		{ title: "ÁÖ´Ï¾î °³¹ßÀÚ Ä¿¸®¾î ·Îµå¸Ê: 0~3³â ¼ºÀå Àü·«", href: "#", img: "/images/photo-1.jpg" },
		{ title: "±â¼ú ºí·Î±×°¡ Æ÷Æ®Æú¸®¿À¿¡ µµ¿òÀÌ µÇ´Â ÀÌÀ¯", href: "#", img: "/images/photo-1.jpg" },
		{ title: "Kubernetes ¿î¿µ ±âº»: ¸®¼Ò½º ¼³Á¤°ú ¹èÆ÷ Àü·«", href: "#", img: "/images/photo-1.jpg" },
		{ title: "SQL Æ©´× ½ÇÀü: ½ÇÇà°èÈ¹ ºĞ¼® ¹æ¹ı", href: "#", img: "/images/photo-1.jpg" },
		{ title: "½ÅÀÔ °³¹ßÀÚ ¿¬ºÀ Çù»ó °¡ÀÌµå", href: "#", img: "/images/photo-1.jpg" },
		{ title: "¹é¿£µå Å×½ºÆ® Àü·«: ´ÜÀ§/ÅëÇÕ Å×½ºÆ® ¼³°è", href: "#", img: "/images/photo-1.jpg" }
	];
	var innerHtml = '';
	for(var i = 0; i < fallback.length; i++) {
		innerHtml += '<li>';
		innerHtml +=     '<a href="' + fallback[i].href + '">';
		innerHtml +=         '<div class="news-item">';
		innerHtml +=             '<div class="news-thumbnail">';
		innerHtml +=                 '<img src="' + fallback[i].img + '" alt="' + fallback[i].title + '">';
		innerHtml +=             '</div>';
		innerHtml +=             '<div class="news-text">';
		innerHtml +=                 '<strong>' + fallback[i].title + '</strong>';
		innerHtml +=             '</div>';
		innerHtml +=         '</div>';
		innerHtml +=     '</a>';
		innerHtml += '</li>';
	}
	$('#headLine').html(innerHtml);
}
function getNaverNews(){
		// naver ??— ?€??AJAX ?”ì²­
		if(!$('#headLine').text().trim()){
			$.ajax({
			    type: "GET",
			    url: "/naver",
			    dataType: "json",
			    success: function (data) {
			      console.log(data);
			      if (!data.errorMessage && data.reulst && data.reulst.textList && data.reulst.textList.length > 0) {
			        var textList = data.reulst.textList; 
			        var imgList = data.reulst.imgList; 
			        var hrefList = data.reulst.hrefList; 
			        var innerHtml = '';
			        for(var i = 0; i < textList.length; i++) {
			          innerHtml += '<li>';
			          innerHtml +=     '<a href="' + hrefList[i] + '" data-clk="clart">';
			          innerHtml +=         '<div class="news-item">';
			          innerHtml +=             '<div class="news-thumbnail">';
			          innerHtml +=                 '<img src="' + imgList[i] + '" alt="' + textList[i] + '">';
			          innerHtml +=             '</div>';
			          innerHtml +=             '<div class="news-text">';
			          innerHtml +=                 '<strong>' + textList[i] + '</strong>';
			          innerHtml +=             '</div>';
			          innerHtml +=         '</div>';
			          innerHtml +=     '</a>';
			          innerHtml += '</li>';      
			        }
			        $('#headLine').html(innerHtml);
			      } else {
			        renderFallbackNews();
			      }
			    },
			    error: function (error) {
			      console.log(error);\n\t\t\t  renderFallbackNews();
			    }
		  	});
		}
		
	}
	
	function getYouTube(){
		
		console.log($('#youtubeList').html())
		
		if(!$('#youtubeList').text().trim()){
		
		// YouTube ??— ?€??AJAX ?”ì²­
		$.ajax({
		    type: "GET",
		    url: "/YouTube", // ?¤ì œ YouTube ?¬ë¡¤ë§?URL???…ë ¥?´ì£¼?¸ìš”
		    dataType: "json",
		    success: function (data) {
		      console.log(data);
		      if (!data.errorMessage && data.reulst && data.reulst.textList && data.reulst.textList.length > 0) {
		        var videoList = data.reulst.videoList; 
		        var innerHtml = '';
		        for(var i = 0; i < videoList.length; i++) {
		          innerHtml += '<li>';
		          innerHtml +=     '<a href="' + videoList[i].url + '" data-clk="clart">';
		          innerHtml +=         '<div class="video-item">';
		          innerHtml +=             '<div class="video-thumbnail">';
		          innerHtml +=                 '<img src="' + videoList[i].thumbnail + '" alt="' + videoList[i].title + '">';
		          innerHtml +=             '</div>';
		          innerHtml +=             '<div class="video-text">';
		          innerHtml +=                 '<strong>' + videoList[i].title + '</strong>';
		          innerHtml +=             '</div>';
		          innerHtml +=         '</div>';
		          innerHtml +=     '</a>';
		          innerHtml += '</li>';      
		        }
		        $('#youtubeList').html(innerHtml);
		      } else {
		        renderFallbackNews();
		      }
		    },
		    error: function (error) {
		      console.log(error);\n\t\t\t  renderFallbackNews();
		    }
		  });
		}
	}

</script>

  <style>
.news-item {
  display: flex;
  align-items: center;
  margin-bottom: 10px;
}

.news-thumbnail {
  flex: 0 0 auto;
  margin-right: 10px;
}

.news-thumbnail img {
  width: 100px;
  height: 65px;
}

.news-text strong {
  font-weight: bold;
  font-size: 16px;
}

.video-item {
  display: flex;
  align-items: center;
  margin-bottom: 10px;
}

.video-thumbnail {
  flex: 0 0 auto;
  margin-right: 10px;
}

.video-thumbnail img {
  width: 100px;
  height: 65px;
}

.video-text strong {
  font-weight: bold;
  font-size: 16px;
}
</style>
 <%@include file="/WEB-INF/views/common.jsp" %>
  <%@ include file="footer.jsp" %>
</body>

</html>

