<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${contextPath}/resources/css/noticeList.css"
	rel="stylesheet" type="text/css">
<!-- 폰트:나눔산스 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700;800&family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">
<title>Insert title here</title>
<style>
.serv_title {
	font-family: 'Noto Sans KR', sans-serif;
	cursor: pointer;
	font-size: 30px;
	font-weight: 700;
	margin-bottom: 50px;
	text-align: center;/* 0802 오동림 수정 */
	margin-top: 35px;/* 0802 오동림 수정 */
}
</style>
</head>
<body>

	<div id="Notice" class="tabcontent container1"style="display: block; margin-top: 30px;height:850px;">
		<h3 class="serv_title">고객센터</h3>
		<div id="Cust_serv_page">
			<div class="table-responsive">
				<table class="table table-striped table-sm" >
					<colgroup>
						<col style="width: 10%;" />
						<col style="width: auto;" />
						<col style="width: 15%;" />
						<col style="width: 10%;" />
						<col style="width: 10%;" />
					</colgroup>
					<thead>
						<tr style="height: 45px;">
							<th class="center tw fg" style="vertical-align: middle;">번호</th>
							<th class="center tw fg" style="vertical-align: middle;">제목</th>
							<th class="center tw fg" style="vertical-align: middle;">작성일</th>
							<th class="center tw fg" style="vertical-align: middle;">작성자</th>
							<th class="center tw fg" style="vertical-align: middle;">조회수</th>
						</tr>
					</thead>

					<tbody>
						<c:choose>
							<c:when test="${empty servList }">
								<tr style="height: 50px;">
									<td colspan="5" class="fixed" style="align-content: center"><strong
										style="margin-top: 5px;">작성된 글이 없습니다.</strong></td>
								</tr>
							</c:when>
							<c:otherwise>

								<c:forEach var="servList" items="${servList}" varStatus="status">
									<tr style="text-align: center;">
										<td class="center fgl" style="font-weight: 500; font-size: 16px;">
											<c:choose>
												<c:when test="${servList.cust_serv_notice eq 1}">
		                                    		<img src="${contextPath}/resources/images/serv/green-megaphone.png" width="30px" alt="new" />		                                    		
		                                       </c:when>
		                                       <c:otherwise> 
		                                       		<c:out value="${servList.cust_serv_no}" />
		                                       </c:otherwise>
	                                       </c:choose>
                                       </td>
										<td class="left fgl">
										<fmt:formatDate value="<%= new java.util.Date() %>" pattern="d" var="today" />
										<fmt:formatDate value="${servList.cust_serv_date}" pattern="d" var="regDate" />
										 
										<c:if test="${servList.cust_serv_secret eq '1'}">
												<img src="${pageContext.request.contextPath}/resources/images/serv/icn_security.png"  width="25px" alt="비밀글" />
												<c:choose>
												<c:when test="${isLogOn == true && (mem_id=='admin' || servList.mem_id eq mem_id)}">
														  <a href="${contextPath}/serv/read.do?cust_serv_no=${servList.cust_serv_no}">
														  <c:out value="${servList.cust_serv_title}"/></a>
													</c:when>
													<c:otherwise>비밀글은 작성자와 관리자만 볼 수 있습니다.</c:otherwise>
												</c:choose>
											</c:if>
											<c:if test="${servList.cust_serv_notice eq 1}">
											<a href="${contextPath}/serv/read.do?cust_serv_no=${servList.cust_serv_no}">
												  	<b><c:out value="${servList.cust_serv_title}"/></b></a>
											</c:if>
											 <c:if test="${servList.cust_serv_secret eq '0' && servList.cust_serv_notice eq 0}">
												  <a href="${contextPath}/serv/read.do?cust_serv_no=${servList.cust_serv_no}">
												  	<c:out value="${servList.cust_serv_title}"/>
												  	<c:if test="${today - regDate <= 3}">
					                        		<img src="${contextPath}/resources/images/serv/new.png" width="35px" />
					                    			</c:if>
												  </a>
											</c:if>
											
										</td>
										<td class="center fgl"> 
											<fmt:formatDate value="${servList.cust_serv_date}"/></td>
										<td class="center fgl"><c:out value="${servList.mem_id}" /></td>
										<td  class="center fgl"><c:out value="${servList.cust_serv_hits}" /></td>

									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>

				<!-- 8.1 구태선 추가 -->
				<!-- 로그인 상태에만 글쓰기 뜨기 -->
				<!-- 로그인 상태 -->
				<c:if test="${isLogOn == true }">
					<div class="writeButton">
						<button type="button" class="btn btn-sm btn-primary greylist  " id="btnWriteForm">
							<a class="atw" href="${contextPath}/serv/write.do">글쓰기</a>
						</button>
					</div>
				</c:if>

			</div>

			<!-- 페이징 -->
			<div class="pageHTML">
				<ul class="pagingul">
					<c:if test="${pageMaker.prev}">
						<li><div class="pagingbtncolor">
								<a class="pagea fg " href="${contextPath}/serv/list.do?page=${pageMaker.startPage - 1}">이전</a>
							</div>
						</li>
					</c:if>

					<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
						<li>
							<div class="pagingbtncolor">
								<a class="pagea fg" href="${contextPath}/serv/list.do?page=${idx}">${idx}</a>
							</div>
						</li>
					</c:forEach>

					<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
						<li><div class="pagingbtncolor">
								<a class="pagea fg "
									href="${contextPath}/serv/list.do?page=${pageMaker.endPage + 1}">다음</a>
							</div></li>
					</c:if>
				</ul>
			</div>

		</div>
	</div>







</body>
</html>