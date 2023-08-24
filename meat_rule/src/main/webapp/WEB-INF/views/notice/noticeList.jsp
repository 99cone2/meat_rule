<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
    // 특정 아이디를 변수에 저장 (예: "admin"이 특정 아이디라고 가정)
    String admin = "admin";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${contextPath}/resources/css/noticeList.css" rel="stylesheet" type="text/css">
<!-- 폰트:나눔산스 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700;800&family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">s
<title>Insert title here</title>
</head>
<body>

	<!-- Tab links -->
	<div class="tab">
		<button class="tablinks" onclick="openNotice(event, 'Notice')">공지사항</button>
		<button id="faqTabButton" class="tablinks"
			onclick="openNotice(event, 'FAQ')">FAQ</button>
	</div>

	<!-- Tab content -->

	<div id="Notice" class="tabcontent container1" style="display: block;margin-top: 30px;">
		<!-- <h3>공지사항</h3> -->


		<div id="Notice_page">
			<div class="table-responsive">
				<table class="table table-hover table-striped table-sm ">

					<colgroup>
						<col style="width: 10%;" />
						<col style="width: auto;" />
						<col style="width: 15%;" />
						<col style="width: 10%;" />
						<col style="width: 10%;" />
					</colgroup> 
					<thead style="border-bottom:2px solid black; border-top: 2px solid black;">
						<tr>
							<th scope="col" class="center tw fg">번호</th>
							<th scope="col" class="center tw fg" >제목</th>
							<th scope="col" class="center tw fg">작성일</th>
							<th scope="col" class="center tw fg">작성자</th>
							<th scope="col" class="center tw fg">조회수</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach items="${noticeList}" var="noticeList">
							<tr>
								<td class="center fgl" style="font-weight: 500; font-size: 16px;">${noticeList.notice_no}</td>
								<td class="left fgl"><a
									href="${contextPath}/notice/read.do?notice_no=${noticeList.notice_no}">${noticeList.notice_title}</a>
								</td>
								<td class="center fgl"><fmt:formatDate value="${noticeList.notice_date}" /></td>
								<td class="center fgl">${noticeList.mem_id}</td>
								<td class="center fgl">${noticeList.notice_hits}</td>
							</tr>
						</c:forEach>
					</tbody>


				</table>
				<!--글쓰기 버튼  -->
				<c:if test="${isLogOn == true && mem_id=='admin' }">
				<div class="writeButton">
					<button type="button" class="btn btn-sm btn-primary greylist" id="btnWriteForm">
						<a class="atw" href="${contextPath}/notice/write.do">글쓰기</a>
					</button>
				</div>
				</c:if>

			</div>

			<!-- 페이징 -->
			<div class="pageHTML">
				<ul class="pagingul">
					<c:if test="${pageMaker.prev}">
						<li><div class="pagingbtncolor">
								<a class="pagea fg " href="${contextPath}/notice/list.do?page=${pageMaker.startPage - 1}">이전</a>
							</div>
						</li>
					</c:if>

					<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
						<li>
							<div class="pagingbtncolor">
								<a class="pagea fg" href="${contextPath}/notice/list.do?page=${idx}">${idx}</a>
							</div>
						</li>
					</c:forEach>

					<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
						<li><div class="pagingbtncolor">
								<a class="pagea fg "
									href="${contextPath}/notice/list.do?page=${pageMaker.endPage + 1}">다음</a>
							</div></li>
					</c:if>
				</ul>
			</div>

		</div>

	</div>

 <!-- FAQ -->

	<div id="FAQ" class="tabcontent container1">
		
		<div id="Notice_FAQ_page">
			<div class="table-responsive">
				<table class="table table-striped table-sm">

					<colgroup>
						<col style="width: 10%;" />
						<col style="width: auto;" />
						<col style="width: 15%;" />
						<col style="width: 10%;" />
						<col style="width: 10%;" />
					</colgroup>
					<thead>
						<tr>
							<th class="center tw fg">번호</th>
							<th class="center tw fg">제목</th>
							<th class="center tw fg">작성일</th>
							<th class="center tw fg">작성자</th>
							<th class="center tw fg">조회수</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach items="${noticeFAQList}" var="noticeFAQList">
							<tr>
								<td class="center fgl" style="font-weight: 500; font-size: 16px;">${noticeFAQList.notice_no_faq}</td>
								<td class="left fgl"><a
									href="${contextPath}/notice/faqread.do?notice_no_faq=${noticeFAQList.notice_no_faq}">${noticeFAQList.notice_title_faq}</a>
								</td>

								<td class="center fgl"><fmt:formatDate
										value="${noticeFAQList.notice_date_faq}" /></td>
								<td class="center fgl">${noticeFAQList.mem_id}</td>
								<td class="center fgl">${noticeFAQList.notice_hits_faq}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>


				<!--글쓰기 버튼  -->
				<c:if test="${isLogOn == true && mem_id=='admin' }">
					<div class="writeButton">
						<button type="button" class="btn btn-sm btn-primary greylist"
							id="btnWriteForm">
							<a class="atw" href="${contextPath}/notice/faqwrite.do">글쓰기</a>
						</button>
					</div>
				</c:if>   

			</div>
		</div>
	</div>

	<script>
    function openNotice(evt, noticeName) {
        // Declare all variables
        var i, tabcontent, tablinks;

        // Get all elements with class="tabcontent" and hide them
        tabcontent = document.getElementsByClassName("tabcontent");
        for (i = 0; i < tabcontent.length; i++) {
            tabcontent[i].style.display = "none";
        }

        // Get all elements with class="tablinks" and remove the class "active"
        tablinks = document.getElementsByClassName("tablinks");
        for (i = 0; i < tablinks.length; i++) {
            tablinks[i].className = tablinks[i].className.replace(" active", "");
        }

        // Show the current tab, and add an "active" class to the button that opened the tab
        document.getElementById(noticeName).style.display = "block";
        evt.currentTarget.className += " active";

        // AJAX로 데이터 가져오기
        if (noticeName === "Notice") {
            loadNoticeList();
        } else if (noticeName === "FAQ") {
            loadFaqList();
        }
    } 
    
    </script>
 
</body>
</html>