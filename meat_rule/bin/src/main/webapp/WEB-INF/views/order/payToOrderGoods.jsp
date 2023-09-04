<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="delivery_fee" value="3500"/>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="preconnect" href="httpps://fonts.googleapis.com">
<link href="${contextPath}/resources/css/order/payToOrderGoods.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>Insert title here</title>

</head>
<body>
<div class="order-container">
	 <div class="title">주문이 완료되었습니다.</div>
	<H1>주문 내역</H1>
	<hr>
	<table class="list_view">
		<tbody align=center>
			<tr style="font-size: 17px;font-weight:500; text-align: center;background: #1D1D1D; color:white;">
			    <td>주문번호</td>
				<td colspan=2 class="fixed">주문상품</td>
				<td>수량</td>
				<td>주문금액</td>
				<td>배송비</td>
				<td>적립금</td>
				<td>주문금액합계</td>
			</tr>			
			<c:forEach var="item" items="${myOrderList }">
				<tr>
				    <td> ${item.order_id }</td>
					<td class="goods_image">
					  <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
					    <img width="75" alt="" src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.file_name}">
					  </a>
					</td>
					<td style="text-align: left; width:30%">					
					     <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">${item.goods_name }</a>				
					</td>
					<td>${item.order_quantity }개</td>
					<fmt:formatNumber value="${item.order_quantity *item.goods_sales_price}" type="number" var="final_price" />
					<td>${final_price}원</td>
					<td><fmt:formatNumber value="${delivery_fee}" type="number" var="delivery_fee2" />${delivery_fee2 }원</td>					
					<td>${1500 *item.order_quantity }원</td>
					<td>${item.order_quantity *item.goods_sales_price+delivery_fee}원</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="clear"></div>
	 <H1>주문고객</H1>
	 <hr>
		 <table style="margin-left: 30px;">
		   <tbody>
			 <tr class="dot_line" >
				<td style="color:#A6A6A6">이름</td>
				<td style="vertical-align: middle;">
				 <input type="text" value="${orderer.mem_name}" size="15" disabled />
				</td>
			  </tr>
			  <tr class="dot_line">
				<td style="color:#A6A6A6">연락처</td>
				<td style="vertical-align: middle;">
				 <input  type="text" value="${orderer.mem_tel1}-${orderer.mem_tel2}-${orderer.mem_tel3}" size="15" disabled />
				</td>
			  </tr>
			  <tr class="dot_line">
				<td style="color:#A6A6A6">이메일</td>
				<td style="vertical-align: middle;">
				   <input  type="text" value="${orderer.mem_email}" size="15" disabled />
				</td>
			  </tr>
		   </tbody>
		</table>
			
		<form name="form_order">
			<br>
			<br>
			<H1>배송지 정보</H1>
			<hr>
			<div class="detail_table">			
				<table>
					<tbody>
						<tr class="dot_line" style="text-align: left;">
							<td class="fixed_join">희망 배송일</td>
							<td>
							   ${myOrderInfo.order_deli_hope_date }
						    </td>
						</tr>
						<tr class="dot_line">
							<td class="fixed_join">받으실 분</td>
							<td>
							${myOrderInfo.order_rec_name }
							</td>
						</tr>
						<tr class="dot_line">
							<td class="fixed_join">연락처</td>
							<td>${myOrderInfo.order_rec_hp1}-${myOrderInfo.order_rec_hp2}-${myOrderInfo.order_rec_hp3}</td>
						  </tr>
						<tr class="dot_line">
							<td class="fixed_join">주소</td>
							<td>
							   ${myOrderInfo.order_delivery_address}
							</td>
						</tr>
						<tr class="dot_line">
							<td class="fixed_join">배송 메시지</td>
							<td>${myOrderInfo.order_delivery_message}</td>
						</tr>
					</tbody>
				</table>		
			</div>
		
			<br>
		
			<H1>결제정보</H1>
			<hr>
			<div class="detail_table">
				<table>
					<tbody>
						<tr class="dot_line">
							<td class="fixed_join">결제방법</td>
							<td>${myOrderInfo.order_pay_method }</td>
						</tr>
						<tr class="dot_line">
							<td class="fixed_join">결제카드</td>
							<td>${myOrderInfo.card_company_name}</td>
						</tr>
						<tr class="dot_line">
							<td class="fixed_join">할부기간</td>
							<td>${myOrderInfo.card_pay_month }</td>
						</tr>
						<tr class="dot_line">
							<td class="fixed_join">결제금액</td>
							<td>${myOrderInfo.final_total_price }</td>
						</tr>					
					</tbody>
				</table>
			</div>
		</form>

		<br>
		<br> 
		<div style="text-align: right;">
		<a href="${contextPath}/main/main.do"> 
		<input type="button" class="btn btn-secondary" value="메인페이지 이동" style="background:#E8E8E8; color:black;width:150px; height: 40px;font-weight: 700;margin-bottom: 50px;"/>
		</a>
		</div>
	</div>

	
</body>
</html>