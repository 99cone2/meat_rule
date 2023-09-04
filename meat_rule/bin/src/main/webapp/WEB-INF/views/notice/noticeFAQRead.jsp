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
<h1 style="font-size: 30px;margin-bottom: 80px;">FAQ</h1>

<div role="main" class="container1" style="height:850px">
		<div class="row row1">
			<table class="table">
				<tr>
					<th width=15% class="text-center fg lb fw">작성자</th>
					<td width=35% class="fgl" style="text-align: center;"> ${noticeFAQRead.mem_id}</td>
					<th width=15% class="text-center lb fg fw">조회수</th>
					<td width=35% class="fgl bbu" style="text-align: center;">${noticeFAQRead.notice_hits_faq}</td>
				</tr>
				<tr>
					<th width=15% class="text-center lb fg fw">제목</th>
					<td colspan="2" class="fgl">${noticeFAQRead.notice_title_faq}</td>
				</tr>
				<tr>
					<th width=15% class="text-center lb fg fw" style="vertical-align: middle;">내용</th>
					<td colspan="4" class="text-left fg" valign="top" height="200">
					<pre class="fgl" style="white-space: pre-wrap; border: none; background-color: white;">${noticeFAQRead.notice_content_faq}</pre>
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
					      <a class="atw" href="${contextPath}/notice/faqmodify.do?notice_no_faq=${noticeFAQRead.notice_no_faq}">
					        <button type="submit" class="bbtn btn-sm btn-primary greylist">수정</button>
					      </a>
					      <a class="atw" href="${contextPath}/notice/faqdelete.do?notice_no_faq=${noticeFAQRead.notice_no_faq}">
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
 
 
 
 
 
 
 <!-- 목록 이동시 faq페이지로 오게 하기 기능x 일단 보류 -->
 <script>
function showFaqTab() {
  // "FAQ" 탭 버튼 요소를 가져옵니다.
  var faqTabButton = document.getElementById("faqTabButton");

  // "FAQ" 탭 버튼의 클릭 이벤트를 트리거합니다.
  faqTabButton.click();
}
</script>
 
 

</body>
</html>