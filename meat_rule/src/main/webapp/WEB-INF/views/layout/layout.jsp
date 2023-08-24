<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
  body {padding-top: 143px; /* 헤더 높이 만큼 바디에 패딩 추가 */}
</style>
<title>육룰 - 고기의 기준</title>
</head>
<body>
	<!-- header -->
	<tiles:insertAttribute name="header"/>
	<hr style="color=gray; margin: 0;" />
	
	<!-- 계속 바뀌는 내용부 -->
	<tiles:insertAttribute name="body"/>
	<hr style="color=gray; margin: 0;"/>
	
	<!-- foot -->
	<tiles:insertAttribute name="footer"/>
</body>
</html>