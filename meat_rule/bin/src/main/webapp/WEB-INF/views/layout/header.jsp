<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<style>
.container-fluid{
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 700;
}
.navbar.navbar-inverse {
	padding: 10px;
	padding-left: 100px;
	padding-right: 100px;
	background: white;
	border: none;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 500;
	font-size: 20px;
}

.nav.navbar-nav {
	margin-top: 60px;
	margin-left: 40px;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 500;
	display: block;
	font-size: 20px;
	
}
.nav.navbar-nav.navbar-right{
font-size: 16px;
font-family: 'Noto Sans KR', sans-serif;
font-weight: 500;
display: block;
margin-top: 37px;
}

ul.nav.navbar-nav li a{
	color:black;
	padding:10px;
}

 .nav.navbar-nav li a {
    color: black;
    font-weight: 700;
}


 ul.nav.navbar-nav li a:hover {
 	color:#D24826;
    border-color: #D24826;
    border-bottom: 4px solid #D24826; /* 밑줄 색상과 두께 조절 */
}

.hidden {
	display: none;
}

.navbar.navbar-inverse.navbar-fixed {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	z-index: 1;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 700;
	box-shadow: 0px 10px 6px rgba(0, 0, 0, 0.1);
}

.navbar .dropdown-menu .dropdown-toggle {
    z-index: 99;
 }
 .logged-out{ /* 0802 21:57분 오동림 추가 */
 	margin-top: 25px;
 }
 .btn{
 font-family: 'Noto Sans KR', sans-serif;
 font-size:17px;
 font-weight:700;
 background-color:#D24826;
 color:white;
 width:50px;
 height: 32px;
 margin-left: 3px;
 }

#suggest {
 font-family: 'Noto Sans KR', sans-serif;
 font-weight:500;
 font-size:15px;
  position: absolute;
  width: 235px;
  display:none;
  background-color: #fff; /* 배경색 설정 */
  box-shadow: 0px 3px 5px rgba(0, 0, 0, 0.1); /* 그림자 효과 추가 */
  padding: 10px; /* 내부 여백 설정 */
  z-index: 999; /* 다른 요소 위에 표시되도록 설정 */
  color:black;
}

.form-control {
  /* 기존 스타일 유지 */
  position: relative; /* 부모 위치를 기준으로 연관검색어 위치 조정 */
}

.d-flex{
	width:300px;
}
.container-mt-5{
	margin-left: 690px;
}

</style>

<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- 폰트:나눔산스 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700;800&family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
</head>

<body>
	<nav class="navbar navbar-inverse navbar-fixed" >
	
		<div class="container-fluid">
			<div class="navbar-header">
				<a href="${contextPath}/main/main.do"><img src="${contextPath}/resources/images/logo/logo.png" width="100px"></a>
			</div>
			<ul class="nav navbar-nav" style="color:black; font-weight: 700;">
				<li><a href="${contextPath}/goods/shop.do">쇼핑하기</a></li>
				<li><a href="${contextPath}/main/delivery.do">배송안내</a></li>
				<li><a href="${contextPath}/notice/list.do">공지사항</a></li>
				<li><a href="${contextPath}/serv/list.do">고객센터</a></li>
				<div class="nav-item search-box no-hover" style="padding: 10px;">
			        <!-- 검색 -->
					   <div class="container-mt-5">
						    <form class="d-flex" role="search" action="${contextPath}/goods/searchResult.do" name="frmSearch" style="display:flex;">
						        <input class="form-control me-2" type="text" placeholder="원하시는 상품을 검색하세요" aria-label="Search" name="searchWord" onKeyUp="keywordSearch()">
						        <button class="btn btn-outline-secondary" type="submit">검색</button>
						    </form>					    
							    <div id="suggest">
							        <div id="suggestList" class="col-4"></div>
							    </div>						
						</div>
    			</div>
			</ul>
				
		<ul class="nav navbar-nav navbar-right" style="vertical-align: middle;margin">		
			 <c:choose>
		           <c:when test="${isLogon == true and not empty memberInfo }">
		             <div style="margin-top: 1.5px;font-size: 14px;text-align: right;margin-right: 13px;">${memberInfo.mem_name} 님 / <img width=20 src="${contextPath}/resources/images/nav/point.png">적립금 ${memberInfo.mem_point}원</div>
		          </c:when>
		       </c:choose>
		    <li class="logged-out"><a href="${contextPath}/member/memberForm.do"><img width=20 src="${contextPath}/resources/images/nav/join.png"> 회원가입</a></li>
		    <li class="logged-out"><a href="${contextPath}/member/loginForm.do" id="loginBtn"><img width=20 src="${contextPath}/resources/images/nav/login.png"> 로그인</a></li>
		    <li class="user-logged-in hidden" ><a href="${contextPath}/cart/myCartList.do"><img width=20 src="${contextPath}/resources/images/nav/cart.png"> 장바구니</a></li>		    
		    <li class="dropdown user-logged-in hidden" >
            <a class="dropdown-toggle" data-toggle="dropdown" href="#" >
                <img width=20 src="${contextPath}/resources/images/nav/mypage.png"> 마이페이지<span class="caret"></span>
            </a>
	            <ul class="dropdown-menu" style="min-width: 105px;">
	                <li style="width:130px;"><a href="${contextPath}/mypage/modifyMemForm.do">개인정보수정</a></li>
	                <li><a href="${contextPath}/mypage/myWriteList.do">내가 남긴 글</a></li>
	                <li><a href="${contextPath}/mypage/listMyOrderHistory.do">주문 내역</a></li>
	                <li><a href="${contextPath}/mypage/deleteMemForm.do">회원 탈퇴</a></li>
	            </ul>
            </li>
            <li class="dropdown kakao-user-logged-in hidden" >
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                <span class="glyphicon glyphicon-user"></span> 마이페이지 <span class="caret"></span>
            </a>
	            <ul class="dropdown-menu">
	                <li><a href="${contextPath}/mypage/modifyMemForm.do">카카오-개인정보수정</a></li>
	                <li><a href="#">문의 내역</a></li>
	                <li><a href="${contextPath}/mypage/listMyOrderHistory.do">카카오-주문 내역</a></li>
	                <li><a href="#">리뷰 확인</a></li>
	                <li><a href="${contextPath}/mypage/deleteMemForm.do">카카오-회원 탈퇴</a></li>
	            </ul>
            </li>
            <li class="user-logged-in hidden"><a href="${contextPath}/member/logout.do" id="logoutBtn"><img width=20 src="${contextPath}/resources/images/nav/logout.png"> 로그아웃</a></li>
		    <li class="kakao-user-logged-in hidden"><a href="${contextPath}/social/kakao_logout.do" id="logoutBtn"><img width=20 src="${contextPath}/resources/images/nav/logout.png"> 로그아웃</a></li>
		    
            
            <li class="dropdown admin-logged-in hidden" >
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                <span class="glyphicon glyphicon-user"></span> 관리자 페이지 <span class="caret"></span>
            </a>
	            <ul class="dropdown-menu">
	                <li><a href="${contextPath}/admin/goods/adminGoodsMain.do">상품 관리</a></li>
	                <li><a href="${contextPath}/admin/member/adminMemberMain.do">회원 관리</a></li>
	                <li><a href="${contextPath}/admin/order/adminOrderMain.do">주문 관리</a></li>	       
	            </ul>
            </li>
		    <li class="admin-logged-in hidden"><a href="${contextPath}/member/logout.do" id="logoutBtn"> 로그아웃</a></li>
		    
		</ul>
	</div>
</nav>

<!-- 헤더 스크립트 -->
<script type="text/javascript">
	$(document).ready(function() {
	    var isLogOn = false;
	    var isAdmin = false;
	    var isKakao = false;
	    
	    function toggleForm() {
	        if (isAdmin) {
	            $('.admin-logged-in').removeClass('hidden');
	            $('.user-logged-in, .logged-out').addClass('hidden');
	        } else if (isLogOn) {
	            $('.user-logged-in').removeClass('hidden');
	            $('.admin-logged-in, .logged-out').addClass('hidden');
	        } else if (isKakao) {
	            $('.kakao-user-logged-in').removeClass('hidden');
	            $('.admin-logged-in, .logged-out').addClass('hidden');
	        } else {
	            $('.logged-out').removeClass('hidden');
	            $('.user-logged-in, .admin-logged-in').addClass('hidden');
	        }
	    }
	
	    // 로그인 상태 변경 시 폼 변경
	    toggleForm();
	
	    var isLogonValue = '<c:out value="${sessionScope.isLogon}" />';
	    if (isLogonValue === 'true') {
	        isLogOn = true;
	    }
	    toggleForm();
	    
	    var isAdminValue = '<c:out value="${sessionScope.isAdmin}" />';
	    if (isAdminValue === 'true') {
	        isAdmin = true;
	    }
	    toggleForm();
	    
        var kakaoTokenValue = '<c:out value="${sessionScope.kakaoToken}" />';
        if (kakaoTokenValue === 'true') {
            isKakao = true; // kakaoToken이 존재하면 카카오 로그인으로 판별
        }
        toggleForm();
	
	    $('#loginBtn').click(function() {
	        isLogOn = true;
	        isAdmin = true;
	        isKakao = true;
	        toggleForm();
	    });
	
	    $('#logoutBtn').click(function() {
	        isLogOn = false;
	        isAdmin = false;
	        isKakao = false;
	        toggleForm();
	    	});
		});
	
		//카카오로그아웃  
		function kakaoLogout() {
		    if (Kakao.Auth.getAccessToken()) {
		      Kakao.API.request({
		        url: '/v1/user/unlink',
		        success: function (response) {
		        	console.log(response)
		        },
		        fail: function (error) {
		          console.log(error)
		        },
		      })
		      Kakao.Auth.setAccessToken(undefined)
		    }
		  }  

		function keywordSearch() {
		    var value = document.frmSearch.searchWord.value;
		    if (value.trim() === "") {
		        loopSearch = false;
		        hide('suggest'); // 검색어 입력이 비어 있으면 suggest div를 숨김
		        return;
		    }

		    loopSearch = true; // 검색어가 있는 경우 loopSearch 값을 true로 설정
		    $.ajax({
		        type: "get",
		        async: true,
		        url: "${contextPath}/goods/keywordSearch.do",
		        data: { keyword: value },
		        success: function (data, textStatus) {
		            if (data != null && data != "")
		                var jsonInfo = JSON.parse(data);
		            hide('suggest'); // 검색 결과를 받기 전에 suggest div를 숨김
		            displayResult(jsonInfo);
		        },
		        error: function (data, textStatus) {
		            alert("에러가 발생했습니다." + data);
		        },
		        complete: function (data, textStatus) {
		            // 작업을 완료했을 때의 동작
		        }
		    }); // end ajax
		}


		function displayResult(jsonInfo){
			if(jsonInfo !=null && jsonInfo != "")
			var count = jsonInfo.keyword.length;
			if(count > 0) {
			    var html = '';
			    for(var i in jsonInfo.keyword){
				   html += "<a id='aaa' href=\"javascript:select('"+jsonInfo.keyword[i]+"')\">"+jsonInfo.keyword[i]+"</a><br/>";
			    }
			    var listView = document.getElementById("suggestList");
			    listView.innerHTML = html;
			    show('suggest');
			}else{
			    hide('suggest');
			} 
		}


			function select(selectedKeyword) {
				 document.frmSearch.searchWord.value=selectedKeyword;
				 loopSearch = false;
				 hide('suggest');
			}
				
			function show(elementId) {
				 var element = document.getElementById(elementId);
				 if(element) {
				  element.style.display = 'block';
				 }
				}
			
			function hide(elementId){
			   var element = document.getElementById(elementId);
			   if(element){
				  element.style.display = 'none';
			   }
			}

	</script>
</body>
</html>
