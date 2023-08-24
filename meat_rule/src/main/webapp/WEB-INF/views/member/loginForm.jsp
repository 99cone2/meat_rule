<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>		
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<c:if test='${not empty message }'>
<script src="your-javascript-file.js"></script>
<script>
window.onload=function()
{
  result();
}

function result(){
   alert("${message}");
   window.location.href = "${contextPath}/member/loginForm.do";
}
</script>
</c:if>

<!DOCTYPE html>
<html lang="ko">
<head>
<style>



ul.nav.navbar-nav li a:hover {
	color: #000000;
}

@import url(https://fonts.googleapis.com/css?family=Roboto:300);
</style>

<link href="${contextPath}/resources/css/member/login.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.2/css/bootstrap.min.css" integrity="sha512-/Dmo1NVtQ05uS0vOI5qEZZn7mWaswFJzDa4RRRF29phxNQqkUkRk5xpyRUpekzoiO7CbdWXFbMHaapzVnNP2ZQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>로그인</title>
</head>
<body>
	<div class="login-page">
		<div class="login-text">
			<a href="${contextPath}/main/main.do"><img src="${contextPath}/resources/images/logo/logo3.png" alt="logo3" width="130px"></a>
		</div>
		<div class="form">
			<form id="loginform" class="login-form" action="${contextPath}/member/loginForm.do" method="post">
				<input type="text" placeholder="아이디" id="mem_id" name="mem_id" /> 
				<input type="password" placeholder="비밀번호" id="mem_pw" name="mem_pw" />
				<button type="submit">로그인</button>
				
				<p class="message">
					<a href="${contextPath}/member/memberForm.do">회원가입</a>
				</p>
				
				<div class="login-icon">
					<a href="${contextPath}/social/kakao_login.do">
					<img src="${contextPath}/resources/images/login/kakao-icon.png" alt="kakao-icon"></a> 
				</div>
			</form>
		</div>
	</div>
</body>
</html>
