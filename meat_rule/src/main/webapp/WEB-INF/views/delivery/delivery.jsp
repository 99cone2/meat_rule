<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
 
<link href="${contextPath}/resources/css/delivery.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
 <!-- 폰트:나눔고딕 -->
<!-- 폰트:나눔산스 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700;800&family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
 
</head>
<title>배송 안내</title>


<body>
	<div class="delivery_container">
		<section id="delivery_banner">
			<a href="#"><img
				src="${contextPath}/resources/images/delivery/delivery_banner.png"
				alt="delivery_banner_img"></a>
		</section>

		<section id="delivery_why">
			<h3 class="d_f">왜 육룰의 초신선배송인가요?</h3>
			<div id="delivery_why_d">
			<ul id="delivery_why_u" >
				<li>
				</li>
				<li><img alt="de1" src="${contextPath}/resources/images/delivery/de1.png">
					<h6 class="dh6" >빠른 배송</h6>
					<p class="d_p">아침에 주문한 고기를 저녁에 <br>받아보실수 있도록 최대한 빠르게 배송합니다.</p></li>
				<li><img alt="de2" src="${contextPath}/resources/images/delivery/de2.png">
					<h6 class="dh6">안전하고 신선한 포장</h6>
					<p class="d_p">수차레 배송테스트를 거친 간소한 포장으로 <br>신선도를 유지하면서도 안전하게 배송합니다.</p></li>
				<li><img alt="de3" src="${contextPath}/resources/images/delivery/de3.png">
					<h6 class="dh6">캠핑장에도 배송 가능</h6>
					<p class="d_p">초신선 식품을 원하는 곳에서 <br>즐기실 수 있도록 캠핑장까지 육룰이 달려갑니다.</p></li>
			</ul>
			 </div>
		</section>
		
		<section id="delivery_where">
			<div>
				<h3 class="d_f">배달 가능한 캠핑장인지 확인해 보세요.</h3>
				<div id="delivery_search">
					<input id="member_post" type="text" placeholder="우편번호" readonly>
					<input id="member_addr" type="text" placeholder="주소" readonly>
					<input type="button" id="member_btn" value="검색"
						onclick="findAddr()">
					<div id="delivery_message" style="display: none;">
						<p id="dv_w_p">배달 가능 지역입니다.</p>
					</div>
				</div>
			</div>
		</section> 

		<section>
			<div>
				<!-- Tab 이름 -->
				<div class="tab">
					<button class="tablinks" onclick="deliveryOpen(event, 'theDay')">당일배송</button>
					<button class="tablinks" onclick="deliveryOpen(event, 'dawn')">새벽배송</button>
					<button class="tablinks" onclick="deliveryOpen(event, 'camping')">캠핑배송</button>
				</div>

				<!-- Tab 내용 -->
				<div id="theDay" class="tabcontent" style="display: block;">
					<p class="tab_c_p1">서울, 경기(일부)</p>
					<h4>당일배송</h4>
					<div id="tad">
					<b class="tab_d_b">오전에 주문하면 저녁 전에 도착!</b>&emsp;
					<p class="tab_d_p">  육룰이 직접 배송하는 초신선함</p>
					</div>
					
					<div class="div_w"></div>
					<div class="dv_c_d2">
						<div class="span_dv">
							<p   > 월~일 도착</p>
						</div>
						<ul>
							<li>
								<h6 class="dh6">주문</h6>
								<p>낮 12시까지</p>
							</li>
							<li>
								<h6 class="dh6">도착</h6>
								<p>당일 오후 7시 전</p>
							</li>
							<li>
								<h6 class="dh6">배송비</h6>
								<p>3,500원</p>
							</li>
						</ul>
					</div>
					<div class="div_w">
					<p class="de_lp">※ 교통 상황에 따라 배송이 지연될 수 있습니다.</p>
					<p class="de_lp">※ 주소지의 당일 배송 지역 해당여부는 [배송지역 검색]에서 확인 하실 수 있습니다.</p>
				</div>
				</div>

				<div id="dawn" class="tabcontent">
					<p class="tab_c_p1">수도권, 충청(일부)</p>
					<h4>새벽배송</h4>
					<b class="tab_d_b">저녁에 주문하면 다음 날 아침 전에 도착!</b>
					<div class="dv_c_d2">
						<div class="span_dv">
							<p  > 월~일 도착</p>
						</div>
						<ul>
							<li>
								<h6 class="dh6">주문</h6>
								<p>오후 8시까지</p>
							</li>
							<li>
								<h6 class="dh6">도착</h6>
								<p>당일 오후 7시 전</p>
							</li>
							<li>
								<h6 class="dh6">배송비</h6>
								<p>3,500원</p>
							</li>
						</ul>
					</div>
					<div class="div_w">
					<p class="de_lp">※ 주소지의 새벽배송 지역 해당여부는 [배송지역 검색]에서 확인 하실 수 있습니다.</p>
					</div>
				</div>

				<div id="camping" class="tabcontent">
					<h4>캠핑배송</h4>
					<b>캠핑장에서 원하는 고가를 즐길수 있도록 육룰이 달려갑니다.</b>
					<div class="dv_c_d2">
						<div class="span_dv">
							<p  c > 월~일 도착</p>
						</div>
						<ul>
							<li>
								<h6 class="dh6">주문</h6>
								<p>낮 12시까지</p>
							</li>
							<li>
								<h6 class="dh6">도착</h6>
								<p>당일 오후 7시 전</p>
							</li>
							<li>
								<h6 class="dh6">배송비</h6>
								<p>3,500원</p>
							</li>
						</ul>
					</div>
					<div class="div_w">
					<p class="de_lp">※ 교통 상황에 따라 배송이 지연될 수 있습니다.</p>
					<p class="de_lp">※ 주소지의 캠핑 배송 지역 해당여부는 [배송지역 검색]에서 확인 하실 수 있습니다.</p>
				</div>
				</div>
			</div>
		</section>
	</div>

	<!-- 캠핑 주소 검색 관련 script -->
	<script>
		function findAddr() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							console.log(data);
							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
							// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var roadAddr = data.roadAddress; // 도로명 주소 변수
							var jibunAddr = data.jibunAddress; // 지번 주소 변수
							// 우편번호와 주소 정보를 해당 필드에 넣는다
							document.getElementById('member_post').value = data.zonecode;
							if (roadAddr !== '') {
								document.getElementById("member_addr").value = roadAddr;
							} else if (jibunAddr !== '') {
								document.getElementById("member_addr").value = jibunAddr;
							}
							checkDeliveryAvailability(data);
						}
					}).open();
		}
		function checkDeliveryAvailability(data) {
			//배달 가능 여부를 확인하기 위한 로직을 추가할 때, 주소 정보에 접근하기 위해 data 객체를 사용할 수 있습니다.
			//주소가 배달 가능한 경우 true를 반환
			var deliveryAvailable = true; //배달 가능 
			displayDeliveryMessage(deliveryAvailable);
		}

		function displayDeliveryMessage(deliveryAvailable) {
			var deliveryMessage = document.getElementById("delivery_message");
			if (deliveryAvailable) {
				deliveryMessage.style.display = "block";
			} else {
				deliveryMessage.style.display = "none";
			}
		}
	</script>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js">
		
	</script>

	<!--Tab 관련  -->
	<script type="text/javascript">
		function deliveryOpen(evt, deliveryName) {
			var i, tabcontent, tablinks;

			// Get all elements with class="tabcontent" and hide them
			tabcontent = document.getElementsByClassName("tabcontent");
			for (i = 0; i < tabcontent.length; i++) {
				tabcontent[i].style.display = "none";
			}

			// Get all elements with class="tablinks" and remove the class "active"
			tablinks = document.getElementsByClassName("tablinks");
			for (i = 0; i < tablinks.length; i++) {
				tablinks[i].className = tablinks[i].className.replace(
						" active", "");
			}

			// Show the current tab, and add an "active" class to the button that opened the tab
			document.getElementById(deliveryName).style.display = "block";
			evt.currentTarget.className += " active";
		}
	</script>
</body>
</html>
