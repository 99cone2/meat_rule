<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>		
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link href="${contextPath}/resources/css/main.css" rel="stylesheet" type="text/css">
<!-- 폰트:나눔산스 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700;800&family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<style>
.section .slide-control .left {left:5px;background:url('${contextPath}/resources/images/main/left.png') center center / 100% no-repeat;}
.section .slide-control .right {right:5px;background:url('${contextPath}/resources/images/main/right.png') center center / 100% no-repeat;}
   .section .slidewrap {
        width: 100%;
        margin: 0 auto;
        position: relative;
        overflow: hidden;
    }

    .section .slidelist {
        display: flex;
        width: 400%;
        animation: slideAnimation 15s linear infinite;
    }

    .section .slidelist li {
        flex: 1;
        list-style: none;
    }

    .section .slidelist li a img {
        width: 100%;
        height: 530px;
        display: block;
        object-fit: cover;
    }
    
    @keyframes slideAnimation {
        0% {
            transform: translateX(0);
        }
        25% {
            transform: translateX(0);
        }
        30% {
            transform: translateX(-25%);
        }
        55% {
            transform: translateX(-25%);
        }
        60% {
            transform: translateX(-50%);
        }
        85% {
            transform: translateX(-50%);
        }
        90% {
            transform: translateX(-75%);
        }
        100% {
            transform: translateX(-75%);
        }
    }
   @media (min-width: 1400px) {
   	.main-best_div.row-cols-lg-4 > .col-md-4 {
       	max-width: 300px;
   	}    
}
.main-best_div .col-md-4 {
    margin: 0px 25px; /* 이미지 박스 간격 조절을 위한 margin 설정 */
}
.main-best_div {
    width: 1400px;
    text-align: center; /* 내부 컨텐츠 가운데 정렬 */
}
</style>
<title>Insert title here</title>
</head>
<body>

		<!-- 메인페이지 배너 -->
		<div class="section">
		    <div class="slidewrap">
		        <ul class="slidelist">
		            <li><a href="#"><img src="${contextPath}/resources/images/main/banner5.png"></a></li>
		            <li><a href="#"><img src="${contextPath}/resources/images/main/banner1.png"></a></li>
		            <li><a href="#"><img src="${contextPath}/resources/images/main/banner2.png"></a></li>
		            <li><a href="#"><img src="${contextPath}/resources/images/main/banner3.png"></a></li>
		        </ul>
		    </div>
		</div>


		<!-- 메인페이지 베스트상품 -->
		
		<div class="main title-div" id="new">
		      <div class="main-sort">[육룰 BEST]</div>         
    			<div class="main-best_div row row-cols-1 row-cols-md-4 row-cols-lg-4 text-center mb-4" >
		        <c:forEach var="best" items="${goodsMap.best}">
		            <div class="col-md-4 mb-4"> <!-- 변경된 부분: col-md-4 추가 -->
		                <div class="card h-100 border-light shadow p-3 bg-body rounded-0 d-flex justify-content-center align-items-center">
		                    <div class="image-background">
		                        <a href="${contextPath}/goods/goodsDetail.do?goods_id=${best.goods_id}">
		                            <img src="${contextPath}/thumbnails.do?goods_id=${best.goods_id}&amp;fileName=${best.file_name}" class="card-img-top" alt="...">
		                        </a> 
		                    </div>
		                    <div class="card-body text-left">
		                        <h5 class="card-title">${best.goods_name}</h5>
		                        <fmt:formatNumber value="${best.goods_price}" type="number" var="goods_price" />
		                        <fmt:formatNumber value="${best.goods_weight}" type="number" var="goods_weight" />    
		                        <p class="card-text pt-2 text-decoration-line-through">기준가 ${goods_price}원/${goods_weight}g</p>
		                    </div>
		                </div>
		            </div>
		        </c:forEach>
		    </div>
		
	
		
		<!-- 메인페이지 할인상품 -->
		
			<div class="main-sort">[할인상품]</div>
				<div class="main-best_div row row-cols-1 row-cols-md-4 row-cols-lg-4 text-center mb-4">
				    <c:forEach var="sale" items="${goodsMap.sale}">
				        <div class="col-md-4 mb-4"> <!-- 변경된 부분: col-md-4 추가 -->
				            <div class="card h-100 border-light shadow p-3 bg-body rounded-0 d-flex justify-content-center align-items-center">
				                <div class="image-background">
				                    <a href="${contextPath}/goods/goodsDetail.do?goods_id=${sale.goods_id}">
				                        <img src="${contextPath}/thumbnails.do?goods_id=${sale.goods_id}&amp;fileName=${sale.file_name}" class="card-img-top" alt="...">
				                    </a> 
				                </div>
				                <div class="card-body text-left">
				                    <h5 class="card-title">${sale.goods_name}</h5>
				                    <fmt:formatNumber value="${sale.goods_price}" type="number" var="goods_price" />
				                    <fmt:formatNumber value="${sale.goods_weight}" type="number" var="goods_weight" />    
				                    <p class="card-text pt-2 text-decoration-line-through">기준가 ${goods_price}원/${goods_weight}g</p>
				                </div>
				            </div>
				        </div>
				    </c:forEach>
				</div>
				<div style="padding-bottom: 50px;">
  					<a href="${contextPath}/goods/shop.do"><img src="${contextPath}/resources/images/main/banner4.png" width="100%"></a>
				</div>
		</div>


<script>
//슬라이드 쇼 시작
	function startSlideShow() {
	    var slideshow = document.querySelector('.slidewrap');
	    var slideList = document.querySelector('.slidelist');
	
	    if (slideshow.classList.contains('paused')) {
	        slideshow.classList.remove('paused');
	        slideList.style.animationPlayState = 'running';
	    }
	}
	
	window.onload = function() {
	    startSlideShow();
	};
</script>
</body>
</html>