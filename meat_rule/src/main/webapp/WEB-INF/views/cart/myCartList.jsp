<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- <c:set var="contextPath"  value="${pageContext.request.contextPath}"  /> --%>
<c:set var="myCartList"  value="${cartMap.myCartList}"  />
<c:set var="myGoodsList"  value="${cartMap.myGoodsList}"  />
<c:set var="delivery_fee" value="3500"/>
<c:set var="totalGoodsNum"  value="0"  />
<c:set var="totalDeliveryPrice"  value="0"  />
<c:set var="tatalDiscountedPrice"  value="0"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${contextPath}/resources/css/myCartList.css" rel="stylesheet" type="text/css">
<!-- 폰트:나눔산스 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700;800&family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>Insert title here</title>
<style>
.frm_order_all_cart{
	text-align: center;

}
 .btn-container {
    display: flex;
    width:60%;
    margin-top: 30px;
 }

  /* 버튼 스타일 */
 .btn-container .btn {
   margin-right: 10px; /* 버튼 사이 여백 조정 (원하는 크기로 조절) */
 }
  
 .order-button {
    display: flex;
    justify-content: center; /* 버튼들을 가운데로 정렬 */+
     margin-bottom: 30px;
  }

  /* 버튼 스타일 */
  .order-button .btn {
    font-weight: 700;
    font-size: 18px;
    padding: 10px 20px;
	width:150px;
	height: 50px;
  }

  /* 버튼 사이의 간격 조절 */
  .order-button .btn:not(:last-child) {
    margin-right: 10px; /* 원하는 간격으로 버튼 사이의 간격 조정 */
  }

 .cart-total-table {
    border: 1px solid #ccc; /* 겉 테두리를 1px 두께의 검은 선으로 설정합니다. */
    border-collapse: separate; /* 테이블 셀 경계를 별도로 표시하도록 설정합니다. */
    font-weight: 400;
    height: 120px;
  }
  /* 표 안쪽의 테두리를 없애는 스타일 */
  .cart-total-table td {
    border: none; /* 테두리 없음 */  
  }
  .total_content{
   font-size: 20px;
   font-weight: 700;
   
  }
</style>
</head>
<body>
<div class="cartList">
	<form name="frm_order_all_cart" style="width:1300px;align-items: center;">
	<span style="font-size: 30px;font-weight: 700; text-align: center;margin-top: 50px;">장바구니</span><br>
		<div class="btn-container">				
		  <input value="선택삭제" type="button" class="choice" onClick="deleteCheckedGoods()"style="font-size:13px;font-weight: 700;" />
		</div>
		<table style="width:90%;">
			<tr style="font-size: 15px; background: #1D1D1D; color:white;">
				<th><input type="checkbox" id="selectAllCheckbox" onClick="goodsAllCheckboxes()"></th>
				<th>상품정보</th>
				<th></th>
				<th>수량</th>
				<th>구매금액</th>
				<th>배송비</th>
				<th>삭제</th>
			</tr>
			<tr>
			<c:choose>
				<c:when test="${empty myCartList }">
					<tr><td colspan="7" class="fixed"><strong style="margin-top: 5px;">장바구니가 비었습니다.</strong></td></tr>
				</c:when>
				
				
				<c:otherwise>																			
					<c:forEach var="item" items="${myGoodsList}" varStatus="cnt">
						<tr>	  
					  <c:set var="cart_qty" value="${myCartList[cnt.index].cart_count}"/>
					  <c:set var="cart_no" value="${myCartList[cnt.index].cart_no}"/>
					  <c:set var="delivery_option" value="${myCartList[cnt.index].delivery_option}"/>
					  	<td>
					  		<input type="checkbox" name="checked_goods" checked value="${item.goods_id}" data-cart-no="${cart_no}" data-cart-count="${cart_qty}" onClick="calculateTotal()">
					  	</td>
						<td><a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id} "><img src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.file_name}" width="110px;"/></a></td>
						<td class="goodsName" style="text-align: left; "><a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}" style="font-size: 20px; font-weight:500;color:black;">${item.goods_name}</a>
						<p>배송 옵션: <c:out value="${delivery_option}" /></p>
						<input type="hidden" value="${item.goods_id }" class="goods_id"/>	
						</td>
						<td>
							<input type="hidden" value="${item.goods_price }" class="goods_price"/>	
						 	<button type="button" class="minus" >-</button>
					        <input type="number" name="cart_count" class="numBox" min="1" max="20" value="${cart_qty}" readonly="readonly"/>
					        <button type="button" class="plus" >+</button>
					        <button type="button" class="btn btn-secondary btn-sm" onclick="modify_qty(${item.goods_id },${item.goods_price },${cnt.index })">변경</button>
						</td>						
						<td>
						 <fmt:formatNumber value="${item.goods_price*cart_qty}" type="number" var="total_price" />
		            	<span class="price">${total_price}원</span>
						</td>
						<fmt:formatNumber value="${delivery_fee}" type="number" var="delivery_fee2" />
						<td>${delivery_fee2}원</td>	
						<td>
						<a href="javascript:delete_cart_goods('${cart_no}');" style="color:black;"><button type="button" class="btn btn-secondary btn-sm">삭제</button></a>
						</td>	
						</tr>							
							<c:set  var="totalGoodsPrice" value="${item.goods_price*cart_qty }" />								
							<c:set  var="totalGoodsNum" value="${totalGoodsNum+1 }" />				
					</c:forEach>				
					</c:otherwise>					
			</c:choose>
		</table>
	
		<div class="cart-total">
				<table class="cart-total-table" >
				     <tr>
				       <td>총 상품수 </td>
				       <td>총 상품금액</td>
				       <td></td>
				       <td>총 배송비</td>
				       <td></td>
				       <td>최종 결제금액</td>
				     </tr>
					<tr class="total_content" >
						<td>
			  				<p id="p_totalGoodsNum"></p>
			  				<input id="totalGoodsNum" type="hidden" value="0" />
						</td>
				        <td>
			  				<p id="p_totalGoodsPrice"></p>
			  				<input id="totalGoodsPrice" type="hidden" value="0" />
						</td>
				       <td> 
				          <img width="20" src="${contextPath}/resources/images/cart/plus.png" style="margin-top:-13px">  
				       </td>
				       <td>
				       <fmt:formatNumber value="${delivery_fee}" type="number" var="delivery_fee2" />
				         <p>${delivery_fee2}</p>
				       <td>  
				         <img width="20" src="${contextPath}/resources/images/cart/equal.png" style="margin-top:-13px">
				       </td>
				       <td>
				       <!-- 최종 결제금액 -->     
			  				<p id="p_finalGoodsPrice"></p>
			  			</td>
					</tr>
				</table>
			    <br><br>	
			    
			    <div class="order-button">
			    	<input value="주문하기" type="button" class="btn btn-secondary btn-sm" onClick="fn_order_all_cart_goods()" style="background-color:#D24826;color:white" />
			    	<input value="쇼핑 계속하기" type="button" class="btn btn-secondary btn-sm" onClick="backToList(this.form)" style="background-color:black;color:white" />
				</div>
					
					
	
			</div>	
	</form>				
</div>
	
	
		
			
			
<!-- JavaScript 코드 -->
<script>



//체크박스 전체 선택시
function goodsAllCheckboxes() {
    const checkboxes = document.querySelectorAll('input[name="checked_goods"]');
    const selectAllCheckbox = document.getElementById('selectAllCheckbox');

    checkboxes.forEach((checkbox) => {
      checkbox.checked = selectAllCheckbox.checked;
    });

    calculateTotal();
  }
	
// + 버튼 클릭 시 이벤트 처리
document.querySelectorAll('.plus').forEach(button => {
  button.addEventListener('click', function() {
	
    var numBox = this.parentElement.querySelector('.numBox');
    var cartCount = parseInt(numBox.value, 10) + 1;
    numBox.value = cartCount;
    
    var goods_price = parseInt(event.target.parentElement.querySelector('.goods_price').value, 10); // 한 개당 가격
    var totalPrice = calcPrice(goods_price, cartCount);
    this.parentElement.nextElementSibling.querySelector('.price').textContent = totalPrice + "원";
  });
});

// - 버튼 클릭 시 이벤트 처리
document.querySelectorAll('.minus').forEach(button => {
  button.addEventListener('click', function() {
    var numBox = this.parentElement.querySelector('.numBox');
    var cartCount = parseInt(numBox.value, 10) - 1;
    if (cartCount >= 1) {
      numBox.value = cartCount;
      
      var goods_price = parseInt(event.target.parentElement.querySelector('.goods_price').value, 10); // 한 개당 가격
      var totalPrice = calcPrice(goods_price, cartCount);
      this.parentElement.nextElementSibling.querySelector('.price').textContent = totalPrice + "원";
    }else{
    	// 수량이 1보다 작은 경우에는 1로 설정
        numBox.value = 1;
        
        var goods_price = parseInt(event.target.parentElement.querySelector('.goods_price').value, 10); // 한 개당 가격
        var totalPrice = calcPrice(goods_price, 1);
        this.parentElement.nextElementSibling.querySelector('.price').textContent = totalPrice + "원";
    }
  });
});

function calcPrice(goods_price, cart_count){
  return goods_price * cart_count;
}


function modify_qty(goods_id, goods_price, index,event){
	  
	   var cart_count = 0;
	   var numBox = document.querySelectorAll('.numBox')[index];
	   cart_count = parseInt(numBox.value, 10);/* 10진수 정수로 변환 */
		
		$.ajax({
			type:"post",
			async : false,
			url :"${contextPath}/cart/modifyCount.do",
			data: {
				goods_id:goods_id,
				cart_count:cart_count
			},
			
			success: function(data, textStatus){
				location.reload();
				if(data.trim()=='modify_success'){
					alert("수량이 변경되었습니다.");
				}else{
					alert("다시 시도해주세요.");
				}
			},
			error: function(data, textStatus){
				alert("에러가 발생했습니다."+data);
			},
			complete: function(data,textStatus){
				//alert("완료");
			}			
		}); //end ajax
}

function delete_cart_goods(cart_no){
	var cart_no=Number(cart_no);
	var formObj=document.createElement("form");
	var i_cart = document.createElement("input");
	i_cart.name="cart_no";
	i_cart.value=cart_no;
	
	formObj.appendChild(i_cart);
    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/cart/deleteGoods.do";
    formObj.submit();
}


function calculateTotal() {
    let totalGoodsNum = 0;
    let totalGoodsPrice = 0;
    let finalGoodsPrice = 0; // 최종 결제금액 변수를 선언하고 초기값을 할당합니다.
    

    // 'checked_goods'라는 이름을 가진 모든 체크박스를 가져옵니다.
    const checkboxes = document.querySelectorAll('input[name="checked_goods"]:checked');

    // 각 체크된 체크박스를 순회합니다.
    checkboxes.forEach((checkbox) => {
      // 체크된 체크박스와 관련된 행을 찾습니다.
      const row = checkbox.closest('tr');

      // 행에서 필요한 값을 가져옵니다.
      const cart_count = parseInt(row.querySelector('.numBox').value, 10);
      const goods_price = parseFloat(row.querySelector('.goods_price').value);

      // 총 상품 개수와 총 상품 금액을 업데이트합니다.
      totalGoodsNum += cart_count;
      totalGoodsPrice += goods_price * cart_count;
    });

    // 배송비를 숫자로 변환하고 쉼표를 제거하여 최종 결제금액을 계산합니다.
    finalGoodsPrice = totalGoodsPrice + parseInt("${delivery_fee}".replace(",", ""), 10);

    // 총 상품 개수와 총 상품 금액을 표시하는 요소들을 업데이트합니다.
    document.getElementById('p_totalGoodsNum').textContent = totalGoodsNum + "개";
    document.getElementById('totalGoodsNum').value = totalGoodsNum;
    document.getElementById('p_totalGoodsPrice').textContent = totalGoodsPrice.toLocaleString() + "원";
    document.getElementById('totalGoodsPrice').value = totalGoodsPrice;
    // 최종 결제금액 표시하는 요소를 업데이트합니다.
    document.getElementById('p_finalGoodsPrice').textContent = finalGoodsPrice.toLocaleString() + "원";
  }

  // 페이지 로드 후 초기값을 표시하기 위해 calculateTotal() 함수를 호출합니다.
  calculateTotal();
  
  
 //선택삭제 버튼 클릭시 삭제 
  function deleteCheckedGoods() {
	    const checkboxes = document.querySelectorAll('input[name="checked_goods"]:checked');
	    const cart_no = [];

	    checkboxes.forEach((checkbox) => {
	      cart_no.push(parseInt(checkbox.getAttribute('data-cart-no'), 10));
	    });

	    if (cart_no.length > 0) {
	      if (confirm('선택한 항목을 삭제하시겠습니까?')) {
	        deleteCartGoods(cart_no); // 배열 형태로 전달
	      }
	    } else {
	      alert('삭제할 항목을 선택해주세요.');
	    }
	  }

	  // 선택한 항목 삭제 처리
	  function deleteCartGoods(cart_no) {
	    const formObj = document.createElement('form');
	    const iCart = document.createElement('input');

	    iCart.name = 'cart_no';
	    iCart.value = cart_no.join(','); // 배열을 콤마(,)로 구분한 문자열로 변환
	    formObj.appendChild(iCart);

	    document.body.appendChild(formObj);
	    formObj.method = 'post';
	    formObj.action = '${contextPath}/cart/checkDeleteGoods.do';
	    formObj.submit();
	  }
	  
	  function backToList() {
		  // 여기에 장바구니 목록을 나타내는 페이지 URL을 설정합니다.
		  const cartListUrl = "${contextPath}/goods/shop.do"; // 장바구니 목록 페이지 URL을 여기에 입력하세요.

		  // 페이지 이동
		  window.location.href = cartListUrl;
		}
	  
	  
	 
	  function fn_order_all_cart_goods() {
		  var objForm = document.frm_order_all_cart;
		  var goods_id; // 서버전송 상품아이디
		  var order_quantity; // 서버전송 수량
		  var cart_count = objForm.cart_count;
		  // var checked_goods = objForm.checked_goods;
		  const checkboxes = document.querySelectorAll('input[name="checked_goods"]:checked');
		  var cart_qty = []; // 선택된 항목들을 담을 배열 생성

		  checkboxes.forEach((checkbox) => {
		    // 체크된 체크박스와 관련된 행을 찾습니다.
		    goods_id = checkbox.value;
		    order_quantity = parseInt(checkbox.getAttribute('data-cart-count'), 10);
		    cart_qty.push(goods_id + ":" + order_quantity);
		  });

		  // 선택한 항목이 없는 경우 경고창을 띄우고 함수 종료
		  if (cart_qty.length === 0) {
		    alert("주문할 상품을 선택해주세요.");
		    return;
		  }

		  // 'cart_qty' 데이터를 전달할 숨은 입력 필드를 폼에 추가
		  var input = document.createElement("input");
		  input.type = "hidden";
		  input.name = "cart_qty"; // 컨트롤러 메소드에서 사용하는 파라미터 이름과 일치해야 합니다.
		  input.value = cart_qty.join(","); // 배열을 콤마로 구분된 문자열로 변환하여 입력 필드 값으로 설정합니다.
		  objForm.appendChild(input);

		  objForm.method = "post";
		  objForm.action = "${contextPath}/order/orderCartGoods.do";
		  objForm.submit();
		}

</script>
<script>
  var contextPath = "${pageContext.request.contextPath}";
</script>

</body>
</html>

