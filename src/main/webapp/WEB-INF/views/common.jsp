<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="/js/jquery-1.11.0.min.js"></script>
<script src="/js/common.js"></script>
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css"> -->
<link href="/style/style.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.0.1/dist/chart.umd.min.js"></script>
 <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-3d/dist/chartjs-plugin-3d.min.js"></script>
 <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>
//해당 주소로 들어갈 때 파라미터값 입력하는 함수
function pushboardname(boardname,boardurl){
      
      $("form[name='freedome']").attr({"name":boardurl,"action":"/"+boardurl+".do"});
      
      $("[name='"+boardurl+"']").find("[name='boardname']").val(boardname);
      
      document.forms[boardurl].submit();
   }

//주소 
$('document').ready(function() {
    var area0 = ["시/도 선택","서울특별시","인천광역시","부산광역시","경기도","강원도"];
    var area1 = ["구/군 선택","강남구","강동구","강북구","강서구","관악구","광진구","구로구","금천구","노원구","도봉구","동대문구","동작구","마포구","서대문구","서초구","성동구","성북구","송파구","양천구","영등포구","용산구","은평구","종로구","중구","중랑구"];
    var area2 = ["구/군 선택","계양구","남구","남동구","동구","부평구","서구","연수구","중구","강화군","옹진군"];
    var area3 = ["구/군 선택","강서구","금정구","남구","동구","동래구","부산진구","북구","사상구","사하구","서구","수영구","연제구","영도구","중구","해운대구","기장군"];
    var area4 = ["구/군 선택","고양시","과천시","광명시","광주시","구리시","군포시","김포시","남양주시","동두천시","부천시","성남시","수원시","시흥시","안산시","안성시","안양시","양주시","오산시","용인시","의왕시","의정부시","이천시","파주시","평택시","포천시","하남시","화성시","가평군","양평군","여주군","연천군"];
    var area5 = ["구/군 선택","강릉시","동해시","삼척시","속초시","원주시","춘천시","태백시","고성군","양구군","양양군","영월군","인제군","정선군","철원군","평창군","홍천군","화천군","횡성군"];
    
    $("select[id^=sido]").each(function() {
      $selsido = $(this);
      $.each(eval(area0), function() {
       $selsido.append("<option value='"+this+"'>"+this+"</option>");
      });
      $selsido.next().append("<option value=''>구/군 선택</option>");
     });
    
     
    
     // 시/도 선택시 구/군 설정
    
     $("select[id^=sido]").change(function() {
      var area = "area"+$("option",$(this)).index($("option:selected",$(this))); // 선택지역의 구군 Array
      var $gugun = $(this).next(); // 선택영역 군구 객체
      $("option",$gugun).remove(); // 구군 초기화
    
      if(area == "area0")
       $gugun.append("<option value=''>구/군 선택</option>");
      else {
       $.each(eval(area), function() {
        $gugun.append("<option value='"+this+"'>"+this+"</option>");
       });
      }
     });
    });
    



//행추가
function addRow() {
    var td = event.target.parentNode; // 클릭된 버튼의 부모 노드인 td 요소를 가져옵니다.
    var input = document.createElement("input"); // 새로운 input 요소를 생성합니다.
    input.type = "text"; // 입력 타입을 텍스트로 설정합니다.
    input.name = "new_item"; // 입력 필드의 이름을 설정합니다.
    
    td.appendChild(input); // td 요소에 새로운 입력 필드를 추가합니다.  
}





//직군
const subFields = {
    management: ["전략기획", "경영지원", "인사", "마케팅·MD"],
    sales: ["영업", "고객상담"],
    it: ["HTML·웹퍼블리셔", "시스템·네트워크", "데이터베이스", "게임·웹툰", "모바일·APP", "QA·테스터", "시스템분석·설계"],
    design: ["그래픽디자인", "광고·시각디자인", "제품디자인", "인테리어디자인", "패션디자인"],
    media: ["영상·사진·편집", "동영상제작"],
    construction: ["건축", "감리·공무", "시공", "안전·품질", "기타"],
    education: ["유치원·보육·교사", "초등학교", "중·고등학교", "특수교육"],
    medical: ["간호조무사", "원무·코디네이터", "의사·의료진", "보건·의료관리"],
    production: ["생산·제조", "조립·가공·포장", "설비·검사·품질", "공정·생산관리", "창고·물류·유통"]
};

const fieldSelect = document.getElementById('field');
const subFieldSelect = document.getElementById('subField');

// 직군 선택이 변경될 때 중분류 선택 항목을 업데이트합니다.
fieldSelect.addEventListener('change', function() {
    const selectedField = this.value;
    const subFieldsOptions = subFields[selectedField];

    // 중분류 선택 항목을 비웁니다.
    subFieldSelect.innerHTML = '<option value="">희망직무 선택</option>';

    if (selectedField) {
        // 선택한 직군이 있으면 중분류 선택 항목을 활성화합니다.
        subFieldSelect.disabled = false;

        // 선택한 직군에 해당하는 중분류 옵션들을 추가합니다.
        subFieldsOptions.forEach(option => {
            const optionElement = document.createElement('option');
            optionElement.textContent = option;
            subFieldSelect.appendChild(optionElement);
        });
    } else {
        // 선택한 직군이 없으면 중분류 선택 항목을 비활성화하고 초기화합니다.
        subFieldSelect.disabled = true;
    }
});

//리뷰작성 (기업정보 상세페이지)
let ratingValue = 0;

function rate(stars) {
    ratingValue = stars;
    let allStars = document.querySelectorAll('.star');
    allStars.forEach((star, index) => {
        if (index < stars) {
            star.classList.add('active');
        } else {
            star.classList.remove('active');
        }
    });
}

function submitReview() {
    let reviewText = document.getElementById('review').value;
    if (ratingValue === 0) {
        alert("평점을 선택해주세요.");
        return;
    }
    if (!reviewText.trim()) {
        alert("리뷰를 작성해주세요.");
        return;
    }
    // 여기서 리뷰와 평점을 서버로 전송하는 코드를 추가할 수 있습니다.
    alert("리뷰가 제출되었습니다.\n평점: " + ratingValue + "\n리뷰 내용: " + reviewText);
    // 리뷰 제출 후 평점 초기화
    ratingValue = 0;
    document.getElementById('review').value = "";
    let allStars = document.querySelectorAll('.star');
    allStars.forEach(star => star.classList.remove('active'));
}
// 좋아요 별점
let isLiked = false;
let likeCount = 0;

function toggleLike(button, comment_no) {
   if(${empty sessionScope.p_no} && ${empty sessionScope.c_no}){
      alert("로그인을 하고 이용해주세요");
      return;
   }
   
    var likeButton = $(button);
    var likeIcon = likeButton.find('i');
    var isLiked = likeButton.find('i').hasClass('far');
    if (isLiked) {
       
       likeButton.addClass('clicked');
       likeIcon.removeClass('far').addClass('fas');
       likeButton.css('color', 'red');  // 버튼 색상 변경
        likeButton.css('color', 'red !important');
        upCount(comment_no);
    } else {
       
       likeButton.removeClass('clicked');
        likeIcon.removeClass('fas').addClass('far');
        downCount(comment_no);
    }
}


//추천수 up
function upCount(comment_no){
   
   var commentObj = $("form[name='commentRegForm']");
   commentObj.find("[name='comment_no']").val(comment_no);
   
   $.ajax(
         {
            url: "/recUpProc.do"
            ,type: "post"
            ,data: commentObj.serialize()
            ,success: function(json) {
              
               var result = json["result"];
               if (result == 1) {
                   alert("개추요~");
                   location.reload();
               }
               else if(result==-2){
                  alert("이미 추천한 댓글입니다.")
               }
               else {
                   alert("추천실패");
               }
           }
            ,error: function(){
               alert("개추 실패! 관리자에게 문의 바람");
            }
         }      
      );
}

//추천수 down
function downCount(comment_no){
   var commentObj = $("form[name='commentRegForm']");
   commentObj.find("[name='comment_no']").val(comment_no);
   
   $.ajax(
         {
            url: "/recDownProc.do"
            ,type: "post"
            ,data: commentObj.serialize()
            ,success: function(json) {
              
               var result = json["result"];
               if (result == 1) {
                   alert("비추요~");
                   location.reload();
               } else {
                   alert("추천해제실패");
               }
           }
            ,error: function(){
               alert("검색 실패! 관리자에게 문의 바람");
            }
         }      
      );
}




//게시판 비동기 검색 공용함수
   function search(community){
      var boardSearchFormObj = $("[name='boardSearchForm']");
      
      var keywordObj = boardSearchFormObj.find(".keyword");

      var keyword = keywordObj.val();
      
      if(typeof(keyword)!='string'){ keyword=""; }
      
      keyword = $.trim(keyword);
      keywordObj.val(keyword);

      boardSearchFormObj.find(".rowCntPerPage").val($("select").filter(".rowCntPerPage").val());
      
      if(community=="joongGo"){
          var tradeType = $("input[name='tradetype']:checked").val();
              boardSearchFormObj.find(".tradetype").val(tradeType);   
              }
   
      $.ajax(
         {
            url: "/"+community+".do"
            ,type: "post"
            ,data: boardSearchFormObj.serialize()
            ,success: function(responseHtml){
               var obj = $(responseHtml);
               $("."+community+"ListDiv").html(
                     obj.find("."+community+"ListDiv").html()
               );
               $(".pagingNos").html(
                     obj.find(".pagingNos").html()
               );
            }
            ,error: function(){
               alert(1123)
               alert("검색 실패! 관리자에게 문의 바람");
            }
         }      
      );


      }

//--------------------------------------------------------------------------
//게시판 상세글 들어가기
//--------------------------------------------------------------------------
   function goBoardDetailForm(b_no,boardurl,boardname,comment,sort){
   
      //boardSideCategori 에 있는 <form name="freedomeDetailForm"> 의 name과 action값을 매개변수로 들어온 boarurl과 boardname을 사용하여 변경
      $("form[name='freedomeDetailForm']").attr({"name":boardurl+"DetailForm","action":"/"+boardurl+"DetailForm.do"});
   
      //name이 b_no인 히든태그에 b_no값을 value로 저장
      $("[name='"+boardurl+"DetailForm']").find("[name='Detail_b_no']").val(b_no);
      
      //name이 table인 히든태그에 table을 value로 저장
       $("[name='"+boardurl+"DetailForm']").find("[name='Detail_board']").val(boardname);

      //댓글테이블명 입력하기
      $("[name='"+boardurl+"DetailForm']").find("[name='Comment_board']").val("comment_"+comment);
      //댓글 sort
      $("[name='"+boardurl+"DetailForm']").find("[name='comment_sort']").val(sort);
      
      if(${sessionScope.member=='person'}){         
         $("[name='"+boardurl+"DetailForm']").find("[name='p_no']").val(${sessionScope.p_no});
      }
      if(${sessionScope.member=='company'}){
         $("[name='"+boardurl+"DetailForm']").find("[name='c_no']").val(${sessionScope.c_no});         
      }
       
      //히든태그에 저장된 값을 파라미터값으로 가지고 form 네임값이 board+"DetailForm"을 가진 태그에 action에 지정된 주소로 이동
       document.forms[boardurl+"DetailForm"].submit();
}

//--------------------------------------------------------------------------
//게시판 수정,삭제 들어가기
//--------------------------------------------------------------------------
   function goUpDelForm(b_no, boardurl, boardname){
      //boardSideCategori 에 있는 <form name="freedomeDetailForm"> 의 name과 action값을 매개변수로 들어온 boarurl과 boardname을 사용하여 변경
      $("form[name='freedomeUpDelForm']").attr({"name":boardurl+"UpDelForm","action":"/"+boardurl+"UpDelForm.do"});
   
      //name이 b_no인 히든태그에 b_no값을 value로 저장
      $("[name='"+boardurl+"UpDelForm']").find("[name='UpDel_b_no']").val(b_no);
      
      //name이 table인 히든태그에 table을 value로 저장
       $("[name='"+boardurl+"UpDelForm']").find("[name='UpDel_board']").val(boardname);
       
      //히든태그에 저장된 값을 파라미터값으로 가지고 form 네임값이 board+"DetailForm"을 가진 태그에 action에 지정된 주소로 이동
       document.forms[boardurl+"UpDelForm"].submit();
}

   //--------------------------------------------------------------------------
   //게시판 수정하기
   //--------------------------------------------------------------------------
   function checkboardUpForm(boardname,boardurl){

   var formObj  = $("[name='boardUpDelForm']");
   var pwdObj   = formObj.find(".pwd");
   
   if( pwdObj.val().trim().length==0 ){
      alert("암호를 입력하십시요");
      pwdObj.val("");
      return;
   }
   
   if( confirm("정말 수정하시겠습니까?")==false ){ return; }

   $.ajax(
      { 
         url    : "/boardUpProc.do"
         ,type  : "post"
         ,data  : formObj.serialize( )
         ,success : function(json){
            var result = json["result"];
            if(result==-1){
               alert("암호가 틀립니다.");
               pwdObj.val("");
            }
            
            else if(result==-2){
               alert("삭제된 게시글 입니다.");
               pushboardname(boardname,boardurl);
            }
            else if(result==0){
               alert("수정 실패입니다.");
            }
            else{
               alert("게시글 수정 성공입니다.");
               pushboardname(boardname,boardurl);
            }
            
         }
         ,error : function(){
            alert("수정 실패! 관리자에게 문의 바람니다.");
         }
      }
   );
}

   //--------------------------------------------------------------------------
   //게시판 삭제하기
   //--------------------------------------------------------------------------
   function checkboardDelForm(boardname,boardurl){
   //----------------------------------------------
   var formObj    = $("[name='boardUpDelForm']");
   var pwdObj     = formObj.find(".pwd");
   //----------------------------------------------
   if( pwdObj.val().trim().length==0 ){
      alert("암호를 입력하십시요");
      pwdObj.val("");
      return;
   }
   if( confirm("정말 삭제 하시겠습니까?")==false ){ return; }

   $.ajax(
      { 
         url    : "/boardDelProc.do"
         ,type  : "post"
         ,data  : formObj.serialize( )
         ,success : function(json){
            var result = json["result"];
            if(result==-1){
               alert("암호가 틀립니다.");
            }
            else if(result==0){
               alert("삭제된 글 입니다.")
               pushboardname(boardname,boardurl);
            }
            else{
               alert("게시글 삭제 성공입니다.")
               pushboardname(boardname,boardurl);
            }
         }
         ,error : function(){
            alert("삭제 실패! 관리자에게 문의 바람니다.");
         }
      }
   );
}

   //--------------------------------------------------------------------------
   //게시판 등록하기
   //--------------------------------------------------------------------------
function checkboardRegForm(boardname,boardurl) {
      
       var formObj = $("[name='boardRegForm']");
       
       alert( formObj.serialize());
       
       $.ajax({
          
           url: "/boardRegProc.do",
           
           type: "post",
           
           data: formObj.serialize(),
           
           success: function(json) {
              
               var result = json["result"];
               if (result == 1) {
                   alert("게시판 작성 성공입니다.");
                   pushboardname(boardname,boardurl);
               } else {
                   alert("게시판 작성 실패입니다. 관리자에게 문의 바람!");
               }
           }
           ,error: function() {
               alert("작성 실패! 관리자에게 문의 바람니다.");
           }
       });
   }
   
   
   //---------------------------------------------------------
   //커뮤니티 게시판 댓글 입력하기
   //---------------------------------------------------------
   function checkCommentReg(){
       var commentObj = $("form[name='commentRegForm']");
       
       
    
       if( 
             commentObj.find(".content").val().trim().length==0 
             ||
             commentObj.find(".content").val().trim().length>20 
       ){
          alert("댓글은 임의 문자 1~20자 입력해야합니다.");
          return;
       }
       if( confirm("댓글을 입력하시겠습니까?")==false ){ return; }
      $.ajax(
            { 
               url    : "/commentRegProc.do"
               ,type  : "post"
               ,data  : commentObj.serialize( )
               ,success : function(json){
                  var result = json["result"];
                  if(result==1){
                     alert("댓글 입력 성공입니다.");
                     location.reload(); 
                  }
                  
                  else{
                     alert("댓글 입력 실패입니다. 관리자에게 문의 바람!");
                  }
               }
               ,error : function(){
                  alert("입력 실패! 관리자에게 문의 바람니다.");
               }
            }
         );
   }
   
   
   function showMoreComments() {
      //hidden-row를 가지는 모든 태그의 디스플레이 스타일을 table-row로 설정한다. 즉 화면에 표시
       $(".hidden-row").css("display", "table-row");
      //showMoreBtn을 id로 가지는 요소를 숨긴다.
       $("#showMoreBtn").hide();
   }
   
   
   //댓글 삭제
   function del_comment(comment_no){
          var commentObj = $("form[name='commentRegForm']");
          
          commentObj.find("[name='comment_no']").val(comment_no);
          
          if( confirm("정말 삭제할것임까~?")==false ){ return; }
          
         $.ajax(
               { 
                  url    : "/delCommentProc.do"
                  ,type  : "post"
                  ,data  : commentObj.serialize( )
                  ,success : function(json){
                     var result = json["result"];
                     if(result==1){
                        alert("댓글 삭제 성공입니다.");
                        location.reload(); 
                     }
                     
                     else{
                        alert(result)
                        alert("댓글 삭제 실패입니다. 관리자에게 문의 바람!");
                     }
                  }
                  ,error : function(){
                     alert("입력 실패! 관리자에게 문의 바람니다.");
                  }
               }
            );
      }
   
   
   //댓글 수정
   function up_comment(comment_no){
          var commentObj = $("form[name='commentRegForm']");
          var updatecomment = $("textarea[name='updateContent']").val();
          
          commentObj.find("[name='updateComment']").val(updatecomment);
          commentObj.find("[name='comment_no']").val(comment_no);
          
          
//           if( 
//                 updatecomment.val().trim().length==0 
//                 ||
//                 updatecomment.val().trim().length>20 
//           ){
//              alert("댓글은 임의 문자 1~20자 입력해야합니다.");
//              return;
//           }
          if( confirm("정말 수정할것임까~?")==false ){ return; }
         $.ajax(
               { 
                  url    : "/upCommentProc.do"
                  ,type  : "post"
                  ,data  : commentObj.serialize( )
                  ,success : function(json){
                     var result = json["result"];
                     if(result==1){
                        alert("댓글 수정 성공입니다.");
                        location.reload(); 
                     }
                     
                     else{
                        alert("댓글 수정 실패입니다. 관리자에게 문의 바람!");
                     }
                  }
                  ,error : function(){
                     alert("입력 실패! 관리자에게 문의 바람니다.");
                  }
               }
            );
      }
   
   //댓글 수정 시 textarea 추가
   function updateForm(comment_no,content){
         $("#comment"+comment_no).html(
               "<textarea  style='width:100%; height:50%;' rows='3'  name='updateContent' class='content'>"
               +content+
               "</textarea><input type='button' value='수정' onClick='up_comment("+comment_no+")'>"+
               "<input type='button' value='삭제' onClick='del_comment("+comment_no+")'>")
      }
   // 관리자 게시판 게시글 다중 삭제
   function deleteSelectedPosts(boardname) {
    var checkboxes = $('input[type="checkbox"]');
    var selectedPosts = [];
    checkboxes.each(function() {
        if ($(this).prop('checked')) {
            selectedPosts.push($(this).val());
        }
    });
    if (selectedPosts.length > 0) {
//         var b_noList = selectedPosts.join(",");
  
        $.ajax({
            type: "POST",
            url: "/deleteSelectPost.do",
            data: JSON.stringify({ b_noList: selectedPosts, boardname:boardname }), // selectedPosts는 배열
            contentType: "application/json", // JSON 데이터를 전송할 때는 content type을 명시
            success: function(response) {
               alert ('게시글이 삭제되었습니다.')
                // 성공적으로 삭제되었으므로 페이지를 새로고침합니다.
                location.reload();
            },
            error: function(xhr, status, error) {
                console.error(xhr.responseText);
            }
        });
    } else {
        alert("선택된 게시글이 없습니다.");
    }
}
   
   
   
   
</script>