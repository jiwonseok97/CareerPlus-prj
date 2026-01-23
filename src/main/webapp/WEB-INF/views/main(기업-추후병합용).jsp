<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/WEB-INF/views/common.jsp"%>  
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>12Wa~</title>

</head>


<body>
<script src="js/slideshow.js"></script>
 <div id="container">    
 <%@ include file="header.jsp" %>
    
    <div id="slideShow">
      <div id="slides">
       <img src="images/photo-1.jpg"alt="">
        <img src="images/photo-2.jpg"alt="">
        <img src="images/photo-3.jpg" alt="">  
        <button id="prev">&lang;</button>
        <button id="next">&rang;</button>
      </div>
    </div>
    
<div style="text-align: right;">
  <span href="javascript:location.replace('/loginForm.do')">로그인 ㅣ</span>
  <span href="javascript:location.replace('/myCompany.do')">기업마이페이지 ㅣ</span>
  <span href="javascript:location.replace('/myPage.do')">개인마이페이지</span>
</div>


    <div id="contents">
      <div id="tabMenu">
        <input type="radio" id="tab1" name="tabs" checked>
        <label for="tab1">공지사항</label>
        <input type="radio" id="tab2" name="tabs">
        <label for="tab2">갤러리</label>      
        <div id="notice" class="tabContent">
          <h2>공지사항 내용입니다.</h2>
          <ul>        
            <li>[사전안내] 개인회원 휴면해제 사전안내</li>     
            <li>2024년 12Wa 면접교육 소개</li>
            <li>[이벤트] 커리어 조언을 남겨주실 프로 전문가를 모집합니다✨</li>
            <li>[참가 모집] 여름 방학 기간, 오름 체험단을 모집합니다.</li>
            <li>[이벤트] 게-으른 이직러를 위한 포지션제안</li>        
          </ul>
        </div>
        
        
        <div id="gallery" class="tabContent">
          <h2>갤러리</h2>
          <ul>
            <li><img src="images/img-1.jpg"></li>
            <li><img src="images/img-2.jpg"></li>
            <li><img src="images/img-3.jpg"></li>                         
          </ul>
        </div>        
      </div>
      
      
      <div id="links">
        <ul>
          <li>
            <a href="#">
              <span id="quick-icon1"></span>
              <p>평화기행</p>
            </a>
          </li>
          
          <li>
            <a href="#">
              <span id="quick-icon2"></span>
              <p>힐링 워크샵</p>
            </a>            
          </li>
          
          <li>
            <a href="#">
              <span id="quick-icon3"></span>
              <p>문의하기</p>
            </a>            
          </li>
          
        </ul>
      </div>
    </div>  
    
     
  </div> 
</body>
<%@ include file="footer.jsp" %>
</html>