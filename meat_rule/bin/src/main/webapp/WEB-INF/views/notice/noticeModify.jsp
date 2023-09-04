<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 조회</title>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link href="${contextPath}/resources/css/noticeRead.css"
	rel="stylesheet" type="text/css">


<style type="text/css">
@charset "UTF-8";

.row1 {
	margin: 0px auto;
	width: 1100px;
	height: 650px;
}

#asas {
	text-align: center;
	justify-content: center;
}

.hh1 {
	text-align: center;
	margin-top: 50px;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 700;
	font-size: 35px;
	margin-bottom: 20px;
}

.bbu {
	border-bottom: 1px solid #ddd;
}

.greylist {
	width: 100px;
	height: 50px;
	font-weight: 900;
	color: white;
	text-align: center;
	background: black;
	border-radius: 5px;
}

.greylist:hover {
	background-color: #D24826;
	border: solid 2px white;
	color: white;
}

.greylist a {
	text-decoration-line: none;
	text-decoration: none;
	color: white;
}

.atw {
	text-decoration-line: none;
	text-decoration: none;
	color: white;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 500;
	display: block;
	font-size: 20px;
	width: 80px;
	height: 40px;
}

.writeButton {
	float: right;
}

.fg {
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 400;
	font-size: 20px;
	font-weight: bold;
}

.fgl {
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 400;
	font-size: 20px;
	padding: 5px;
	margin: 0;
}

.fw {
	color: white;
}

.lb {
	background-color: #292929;
}

.rightbtn {
	float: right;
}

.bordered-input {
	border: 1px solid #ccc;
	margin-left: 5px;
}

.text-center {
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 500;
	font-size: 20px;
}

::-webkit-input-placeholder { /* Chrome, Safari, Opera */
	font-size: 15px;
}
</style>

</head>
<body>
	<h1 class="hh1">공지글 수정</h1>
	<form method="post" name="form" id="form" role="form">
		<!-- POST 방식은 폼 데이터를 별도로 첨부하여 서버로 전달하는 방식 -->
		<!--주의! 입력 엘리먼트인 <input> 과 <textarea>의 이름(name) 속성의 값이 BoardVO와 동일해야함  -->
		<div role="main" class="container1" style="padding-bottom: 100px">
			<div class="row row1">
				<table class="table">
					<tr>
						<th width=15% class="text-center fg lb fw">작성자</th>
						<td width=85% class="text-left fgl"><input
							style="width: 350px;" type="text" name="mem_id"
							class="bordered-input" value="${noticeRead.mem_id}" readonly/>
					</tr>
					<tr>
						<th width=10% class="text-center fg lb fw">제목</th>
						<td width=90% class="text-left fgl"><input
							style="width: 700px;" type="text" name="notice_title"
							value="${noticeRead.notice_title}" class="bordered-input" /></td>
					</tr>
					<tr>
						<th width="10%" class="text-center fg lb fw"
							style="vertical-align: middle;">공지 수정내용</th>
						<td colspan="4" class="text-left fg" valign="top" height="200">
							<pre class="fgl"
								style="white-space: pre-wrap; border: none; background-color: white;">
								<textarea cols="80" rows="8" name="notice_content"
									class="bordered-input"
									style="width: 100%; height: 100%; padding: 0; margin: 0;">${noticeRead.notice_content}</textarea>
							</pre>
						</td>
					</tr>
					<tr>
						<td  colspan="4" class="text-right">
							<div>
								<input type="submit" class="btn btn-sm btn-primary greylist atw"
									style="float: right;" value="완료">
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</form>

</body>
</html>