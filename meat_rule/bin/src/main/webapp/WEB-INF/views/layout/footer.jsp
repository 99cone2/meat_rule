<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <!-- 추가할부분 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ page session="false" %>
<html>
<head>
	<meta charset="UTF-8"> <!-- 추가할부분 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- 추가할부분 -->
	<meta http-equiv="X-UA-Compatible" content="ie=edge"> <!-- 추가할부분 -->
<title>Insert title here</title>
<style>
.container{width: 100%;margin:0 ; padding: 10px; padding-left: 100px; padding-right: 100px; display: flex;
  justify-content: space-between;
  align-items: center;
  font-family: 'Noto Sans KR', sans-serif;
  background: #1D1D1D;
  }
.rightInfo{
	color:white;
	display: flex; justify-content: flex-end;text-align: right;
	flex-grow: 1;font-family: 'Noto Sans KR', sans-serif;
}
.leftInfo{
color:white;
}
p{margin:0;}
</style>
</head>
<body>

    
    	<div class="container" > 
    	<div class="leftInfo">
    		<img src="${contextPath}/resources/images/logo/logo2.png" width="80px"><br><br>
		    <p>(주)육룰 | 주소: 서울 성동구 마장로33길 53<br>
			개인정보관리책임자: 오동림(privacy@meatrule.com)</p>
	         <span><a href="${contextPath}/admin/notice/listNotice.do" class="text-reset">공지사항 | </a></span>
	         <span><a href="${contextPath}/board/qna/listQna.do" class="text-reset">고객센터</a></span>	         
	         <h6 class="text-uppercase fw-bold mb-4"><p>Copyright 2023. 육룰 All rights reserved.</h6>
		</div>
		
		
		<div class="rightInfo">			
	        <div class="col-md-4 col-lg-3 col-xl-3 ml-auto mb-md-0 mb-4">
	          <h6 class="text-uppercase fw-bold mb-4">고객센터</h6>		       
		        </B><h3><p>1800-0202</p></h3>
				<p>월-토요일 : 08:30 - 17:30</p>
				<p>점심 : 12:30 - 13:30</p>
				<p>(일요일 및 공휴일 휴무)</p>
				<p>카카오톡: @육룰</p>
				<p>이메일: help@meatrule.com</p>
	        </div>    
	   	 </div>
    </div>



</body>
</html>