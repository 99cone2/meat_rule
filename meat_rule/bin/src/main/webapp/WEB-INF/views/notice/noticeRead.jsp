<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> 
<link href="${contextPath}/resources/css/noticeRead.css" rel="stylesheet" type="text/css">
<title>게시물 조회</title>
</head>
<body>

	<h1 style="font-size: 30px;margin-bottom: 80px;">공지사항</h1>
<div role="main" class="container2" style="height:850px">
		<div class="row row1">
			<table class="table">
				<tr>
					<th width=15% class="text-center fg lb fw">작성자</th>
					<td width=35% class="fgl" style="text-align: center;"> ${noticeRead.mem_id}</td>
					<th width=15% class="text-center lb fg fw">조회수</th>
					<td width=35% class="fgl bbu" style="text-align: center;">${noticeRead.notice_hits}</td>
				</tr>
				<tr>
					<th width=15% class="text-center lb fg fw">제목</th>
					<td colspan="2" class="fgl">${noticeRead.notice_title}</td>
					 
				</tr>
				<tr>
					<th width=15% class="text-center lb fg fw" style="vertical-align: middle;">내용</th>
					<td colspan="4" class="text-left fg" valign="top" height="200">
					<pre class="fgl" style="white-space: pre-wrap; border: none; background-color: white;">${noticeRead.notice_content}</pre>
					</td>
				</tr>
				<c:forEach var="imageFileName" items="${servMap.fileList}">
					<tr>
					<th width=15% class="text-center lb fg fw" style="vertical-align: middle;">첨부 파일</th>
						<td class="result-images">						
							<img alt="" src="${contextPath}/download?imageFileName=${imageFileName}" >							
						</td>
					</tr>
				</c:forEach>
				<tr>
				  <td colspan="4" class="text-right">
				 
				    <div class="button-container">
				     <c:if test="${isLogOn == true && mem_id=='admin' }">
					      <a class="atw" href="${contextPath}/notice/modify.do?notice_no=${noticeRead.notice_no}">
					        <button type="submit" class="bbtn btn-sm btn-primary greylist">수정</button>
					      </a>
					      <a class="atw" href="${contextPath}/notice/delete.do?notice_no=${noticeRead.notice_no}">
					        <button type="submit" class="btn btn-sm btn-primary greylist" style="height: 40px;">삭제</button>
					      </a>
				 	 </c:if>
					      <a class="atw" href="${contextPath}/notice/list.do">
					        <button type="button" class="btn btn-sm btn-primary greylist" style="height: 40px;">목록</button>
					      </a>
				    </div>
				  </td>
				</tr>
			</table>
		</div>
	</div>
 
 
 
</body>
</html>