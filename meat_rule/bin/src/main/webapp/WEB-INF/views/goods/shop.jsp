<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>		
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<link href="${contextPath}/resources/css/main.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.2/css/bootstrap.min.css" integrity="sha512-/Dmo1NVtQ05uS0vOI5qEZZn7mWaswFJzDa4RRRF29phxNQqkUkRk5xpyRUpekzoiO7CbdWXFbMHaapzVnNP2ZQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- 폰트:나눔산스 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700;800&family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.main{width: 1400px; margin:0 auto; padding: 10px;}
.category img {margin-right: 15px; margin-bottom: 50px;}
.slidewrap img{width:100%;margin:0 auto;position:relative; margin-bottom: 60px;}
.category {display: flex;justify-content: center; }
.category a:hover img {opacity: 0.8; /* 투명도 조절 */transition: all 0.5s ease-in-out; /* 변경 효과 적용 */ transform: translateY(-10px);}

.image-background {
    background-color: #f1f1f1; /* 배경색 설정 */
    display: flex;
    justify-content: center;
    align-items: center;
    width:300px; height:300px;
  }
.image-background img {
  	background-color: transparent;
    width:230px;
    object-fit: contain; /* 이미지를 가운데로 정렬 */
  }
.card-title{
  	font-family: 'Noto Sans KR', sans-serif;
  	font-size: 19px;
  	font-weight: 700;  	
  	padding-bottom: 1px;
}
  	
.card-text{
	margin-top:2px;
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 14px;
	font-weight: 400;   
	margin-bottom: 50px; 
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
</head>
<body>

	<div class="slidewrap">
  		<img id="bannerImage" src="${contextPath}/resources/images/shop/banner_pig.png">
	</div>

	<div class="main title-div" id="new">	
		<div class="category">
			<a href="${contextPath}/goods/shop.do?category=pig" data-category="pig"><img src="${contextPath}/resources/images/shop/1.png" class="card-img-top" alt="..."></a>
			<a href="${contextPath}/goods/shop.do?category=cow" data-category="cow"><img src="${contextPath}/resources/images/shop/2.png" class="card-img-top" alt="..."></a>
			<a href="${contextPath}/goods/shop.do?category=chicken" data-category="chicken"><img src="${contextPath}/resources/images/shop/3.png" class="card-img-top" alt="..."></a>
			<a href="${contextPath}/goods/shop.do?category=mealkit" data-category="mealkit"><img src="${contextPath}/resources/images/shop/4.png" class="card-img-top" alt="..."></a>
		</div>

		<div id="productsContainer" class="main-best_div row row-cols-1 row-cols-md-4 row-cols-lg-4 text-center mb-4">
			<!-- goods_sort에 따라 상품 목록 출력 -->
			
			
				<c:forEach var="pig" items="${goodsMap.pig}">
				<c:if test="${pig.goods_sort eq 'PIG'}"> 
					<div class="card h-100 border-light shadow p-3 bg-body rounded-0 col-md-4 d-flex justify-content-center align-items-center mb-4">
						<div class="image-background">
						<a href="${contextPath}/goods/goodsDetail.do?goods_id=${pig.goods_id}&amp;fileName=${pig.file_name}">
							<img src="${contextPath}/thumbnails.do?goods_id=${pig.goods_id}&amp;fileName=${pig.file_name}"  alt="...">
						</a>
						</div>
						<div class="card-body text-left">
							<h5 class="card-title">${pig.goods_name}</h5>
							<fmt:formatNumber value="${pig.goods_price}" type="number" var="goods_price" />
							<fmt:formatNumber value="${pig.goods_weight}" type="number" var="goods_weight" />	
			                <p class="card-text pt-2 text-decoration-line-through">기준가 ${goods_price}원/${goods_weight}g</p>
						</div>
					</div>
				</c:if>
			</c:forEach>
				
			
			<!-- goodsMap.cow에 대한 카테고리 상품 목록 -->
			<c:forEach var="cow" items="${goodsMap.cow}">
				<c:if test="${cow.goods_sort eq 'COW'}"> 
					<div class="card h-100 border-light shadow p-3 bg-body rounded-0 col-md-4 d-flex justify-content-center align-items-center mb-4">
						<div class="image-background">
						<a href="${contextPath}/goods/goodsDetail.do?goods_id=${cow.goods_id}">
							<img src="${contextPath}/thumbnails.do?goods_id=${cow.goods_id}&amp;fileName=${cow.file_name}" class="card-img-top" alt="...">
						</a>
						</div>
						<div class="card-body text-left">
							<h5 class="card-title">${cow.goods_name}</h5>
							<fmt:formatNumber value="${cow.goods_price}" type="number" var="goods_price" />
							<fmt:formatNumber value="${cow.goods_weight}" type="number" var="goods_weight" />	
			                <p class="card-text pt-2 text-decoration-line-through">기준가 ${goods_price}원/${goods_weight}g</p>
						</div>
					</div>
				</c:if>
			</c:forEach>
			
			<!-- goodsMap.chicken에 대한 카테고리 상품 목록 -->
			<c:forEach var="chicken" items="${goodsMap.chicken}">
				<c:if test="${chicken.goods_sort eq 'CHICKEN'}"> 
					<div class="card h-100 border-light shadow p-3 bg-body rounded-0 col-md-4 d-flex justify-content-center align-items-center mb-4">
						<div class="image-background">
						<a href="${contextPath}/goods/goodsDetail.do?goods_id=${chicken.goods_id}">
							<img src="${contextPath}/thumbnails.do?goods_id=${chicken.goods_id}&amp;fileName=${chicken.file_name}" class="card-img-top" alt="...">
						</a>
						</div>
						<div class="card-body text-left">
							<h5 class="card-title">${chicken.goods_name}</h5>
							<fmt:formatNumber value="${chicken.goods_price}" type="number" var="goods_price" />
							 <fmt:formatNumber value="${chicken.goods_weight}" type="number" var="goods_weight" />	
			                <p class="card-text pt-2 text-decoration-line-through">기준가 ${goods_price}원/${goods_weight}g</p>
						</div>
					</div>
				</c:if>
			</c:forEach>
			
			<!-- goodsMap.mealkit에 대한 카테고리 상품 목록 -->
			<c:forEach var="mealkit" items="${goodsMap.mealkit}">
				<c:if test="${mealkit.goods_sort eq 'MEALKIT'}"> <!-- 카테고리 4의 상품 -->
					<div class="card h-100 border-light shadow p-3 bg-body rounded-0 col-md-4 d-flex justify-content-center align-items-center mb-4">
						<div class="image-background">
						<a href="${contextPath}/goods/goodsDetail.do?goods_id=${mealkit.goods_id}">
							<img src="${contextPath}/thumbnails.do?goods_id=${mealkit.goods_id}&amp;fileName=${mealkit.file_name}" class="card-img-top" alt="...">
						</a>
						</div>
						<div class="card-body text-left">
							<h5 class="card-title">${mealkit.goods_name}</h5>
							<fmt:formatNumber value="${mealkit.goods_price}" type="number" var="goods_price" />
							<fmt:formatNumber value="${mealkit.goods_weight}" type="number" var="goods_weight" />	
			                <p class="card-text pt-2 text-decoration-line-through">기준가 ${goods_price}원/${goods_weight}g</p>
						</div>
					</div>
				</c:if>
			</c:forEach>
		</div>
</div>


<script>
$(document).ready(function() {
	  $(".category a").click(function(e) {
	    e.preventDefault();
	    var category = $(this).attr("data-category");
	    loadProducts(category);

	    // 슬라이드 배너 이미지 업데이트
	    var imageUrl;
	    switch (category) {
	      case "pig":
	        imageUrl = "${contextPath}/resources/images/shop/banner_pig.png";
	        break;
	      case "cow":
	        imageUrl = "${contextPath}/resources/images/shop/banner_cow.png";
	        break;
	      case "chicken":
	        imageUrl = "${contextPath}/resources/images/shop/banner_chicken.png";
	        break;
	      case "mealkit":
	        imageUrl = "${contextPath}/resources/images/shop/banner_mealkit.png";
	        break;
	      default:
	    	  imageUrl = "${contextPath}/resources/images/shop/banner_pig.png";
	        break;
	    }
	    $("#bannerImage").attr("src", imageUrl);
	  });

  function loadProducts(category) {
    $.ajax({
      url: "${contextPath}/goods/shop.do",
      data: { category: category },
      success: function(response) {
        // JSP 파일의 내용 중 #productsContainer 부분만 추출하여 업데이트합니다.
        var html = $(response).find("#productsContainer").html();
        $("#productsContainer").html(html);
      },
      error: function(xhr, status, error) {
        console.log("An error occurred: " + error);
      }
    });
  }
});
</script>
</body>
</html>