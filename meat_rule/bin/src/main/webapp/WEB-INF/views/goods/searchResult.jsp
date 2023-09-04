<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>		
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<style>
.searchContainer{
width: 1400px; 
height:100%;
margin:0 auto; padding: 10px;
margin-top: 50px;
}
.searchword{
font-size: 20px;
margin-bottom: 20px;
font-weight: 700;
}
.fs-3{
font-size: 20px;
height:300px;
font-weight: 700;
margin-top: 150px;
}
</style>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${contextPath}/resources/css/main.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- 폰트:나눔산스 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700;800&family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<title>Insert title here</title>
</head>
<body>
<div class="searchContainer"> 	
        <p class="searchword">"${searchWord}" <span>검색결과</span></p>

        <!-- 검색 결과 표시 -->
        <c:choose>
            <c:when test="${empty goodsList}">
                <div class="result mb-5 mt-5">
                    <p class="fs-3 mb-5 mt-5 text-center">존재하지 않는 상품입니다.</p>	
                </div>
            </c:when>
            <c:otherwise>
             <c:forEach var="item" items="${goodsList }" >
             
               <div class="card h-100 border-light shadow p-3 bg-body rounded-0 col-md-4 d-flex justify-content-center align-items-center mb-4">
						<div class="image-background">
						<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}&amp;fileName=${item.file_name}">
							<img src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&amp;fileName=${item.file_name}"  alt="...">
						</a>
						</div>
						<div class="card-body text-left">
							<h5 class="card-title">${item.goods_name}</h5>
							<fmt:formatNumber value="${item.goods_price}" type="number" var="goods_price" />
							<fmt:formatNumber value="${item.goods_weight}" type="number" var="goods_weight" />	
			                <p class="card-text pt-2 text-decoration-line-through">기준가 ${goods_price}원/${goods_weight}g</p>
						</div>
					</div>
			 </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>