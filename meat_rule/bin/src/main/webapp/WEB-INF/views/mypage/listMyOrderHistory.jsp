<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<script>
// 리뷰 작성 파일추가
var cnt = 1;
function fn_addFile(orderId) {
    var fileInput = document.createElement("input");
    fileInput.type = "file";
    fileInput.name = "file" + cnt;
    var fileDiv = document.getElementById("d_file_" + orderId);
    fileDiv.appendChild(fileInput);
    cnt++;
}



</script>
<style>

.btn_review{
color:white;
background: #1D1D1D;
font-weight: 500;
border: 1px solid #ccc;
height:40px;
}
.form{
margin: 0;
width:100%;
}
.frm_mod_member{
  width: 1300px;
  padding:30px;

  margin: 0 auto; 
  font-family: 'Noto Sans KR', sans-serif;

  margin-top: 40px;
  margin-bottom: 40px;  
}

table{
  width:100%;
  align-items: center;
  flex-direction: column;
  margin-top:20px;
  font-family: 'Noto Sans KR', sans-serif;
  border-collapse: separate; 
   border: 1px solid #E8E8E8;
}
 .title{
  font-family: 'Noto Sans KR', sans-serif;
  text-align: center;
  font-size: 30px;
  font-weight: 700;
  margin-bottom: 40px;
 }
 
  td {
  border-top: 1px solid #ddd; /* 위쪽에 border 추가 */
  padding: 15px;
  vertical-align: middle;
}
.required {
    color: #DB0000; /* 원하는 색상으로 변경하세요 */
  }
.cancel-order-btn{
border:none;
height: 30px;
}  
.modal {
 display: none;
 position: fixed;
 top: 50%;
 left: 50%;
 transform: translate(-50%, -50%);
 font-family: 'Noto Sans KR', sans-serif;
 height:580px;
}
.modal a.close-modal {
top:5px;
right:6px;
}

.modal a {
text-decoration: none;
cursor: pointer;
  }
  
/* 체크박스를 보여주기 위한 스타일 */
.goodstitle_modal {
   display: inline;
   display: flex;
   align-items: center;
   margin-bottom: 10px;
   margin-right:10px;
   font-size: 16px;	
}
    
   .goods_checkbox {
       font-size: 16px;
       font-family: 'Noto Sans KR', sans-serif;
       margin-right: 5px;
    }

    .goodsCheckbox {
        margin-right: 5px; /* 체크박스와 상품 이름 사이의 간격을 주기 위해 margin 추가 */
    }
    /* .goodsCheckbox + label {
        margin: 0; /* 체크박스와 상품 이름 사이의 간격을 없애기 위해 margin 제거 */
    } */
.required {
    color: #DB0000; /* 원하는 색상으로 변경하세요 */
}
  
.modal-table {
   border-collapse: separate;
   border: 1px solid #E8E8E8;
   margin-bottom: 15px;
}
  
.modal-table input[type="text"] {
   	width:315px;
    border: 1px solid #E8E8E8;
}
  
  .modal-table td:nth-child(1){
  background: #1D1D1D;
  text-align: center;
  color:white;
  width:20%;
 
  }
  button{
  border:1px solid;
  }
  
  .modal-buttons {
        display: flex;
        width: 100%;
        margin-top: 20px;
text-align: right;
    }

.modal-buttons button {
        margin: 5px;
    }
    
#modal${item.order_id}.modal {
  max-height: 90%; /* 필요에 따라 이 값을 조정하세요 */
  overflow-y: auto;
}

#d_file_${item.order_id}.input{
	font-size: 15px;
}
.bordered-input{
font-size: 15px;
background: transparent;
border: none;
}
</style>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>주문내역</title>

</head>
<body>
	<div class="frm_mod_member">		
		
	<div class="title">
		주문 내역
	</div> 
	
	<table class="form">
		<tbody align=center >
		<tr style="background:#1D1D1D;color: #FFFFFF;font-size: 17px; height: 35px; padding:5px;" >
            <td>주문번호</td>
            <td>주문일자</td>
            <td>주문내역</td>
            <td>주문금액/수량</td>
            <td>주문상태</td>
            <td>주문자</td>
            <td>수령자</td>
            <td>주문취소</td>
            <td>리뷰</td>
         </tr>
   <c:choose>
     <c:when test="${empty myOrderHistList }">			
			<tr>
		       <td colspan=8 class="fixed">
				  주문한 상품이 없습니다.
			   </td>
		     </tr>
	 </c:when>
	 <c:otherwise> 
	
	 <c:set var="review_goods_id" value="" /> <!-- review_goods_id 빈값으로 초기화 -->
     <c:forEach var="item" items="${myOrderHistList }" varStatus="i">
        <c:choose>
          <c:when test="${item.order_id != pre_order_id }">   
            <tr style="font-size: 15px; padding:10px ; border-top: 1px solid #ddd; /* 위쪽에 border 추가 */">       
				<td style="font-weight: 500;">
				  ${item.order_id }
				</td>
				
				<td>
				<fmt:formatDate value="${item.order_time}" pattern="yy/MM/dd HH:mm" var="orderTime"/>
				 ${orderTime}
				</td>
				<td style="text-align: left;"> 				
				   <c:forEach var="item2" items="${myOrderHistList}" varStatus="j">
			          <c:if  test="${item.order_id == item2.order_id}" >
			           	<c:set var="review_goods_id" value="${item.goods_id }"/>		
			            <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item2.goods_id }">${item2.goods_name }</a><br>			            
			         </c:if>   
				  </c:forEach>			
				</td>
				<td>
				
			  <c:forEach var="item2" items="${myOrderHistList}" varStatus="j">
                   <c:if  test="${item.order_id == item2.order_id}">
                         <fmt:formatNumber value="${item2.goods_sales_price*item2.order_quantity }" type="number" var="price" />
                         ${price }원/${item2.order_quantity }개<br>
                   </c:if>   
               </c:forEach>
			
				</td>
				<td>
				  <strong>
				    <c:choose>
					    <c:when test="${item.order_delivery_status=='delivery_prepared' }">
					       	배송준비중
					    </c:when>
					    <c:when test="${item.order_delivery_status=='delivering' }">
					       	배송중
					    </c:when>
					    <c:when test="${item.order_delivery_status=='finished_delivering' }">
					       	배송완료
					    </c:when>
					    <c:when test="${item.order_delivery_status=='cancel_order' }">
					       	<span class="required" >주문취소</span>
					    </c:when>
					    <c:when test="${item.order_delivery_status=='returning_goods' }">
					       	반품
					    </c:when>
				  </c:choose>
				  </strong>
				</td>
				<td>
				 ${item.mem_name } 
				</td>
				<td>
					${item.order_rec_name }
				</td>
				<td>
				   <c:if test="${item.order_delivery_status =='delivery_prepared'}">
				       <input type="button" class="cancel-order-btn" value="주문취소" data-order-id="${item.order_id}" />
				     </c:if>
				</td>
			<!-- 리뷰작성 모달창 내용  -->
				<td>
				<c:if test="${item.order_delivery_status=='finished_delivering' }">
				    <a href="#modal${item.order_id}" rel="modal:open" class="open-review-modal" data-order-id="${item.order_id}">리뷰작성</a>
				    <div id="modal${item.order_id}" class="modal">
				        <p style="text-align: center;margin-top: 20px;margin-bottom:20px;font-size: 30px;font-weight: 700;">리뷰 등록</p>
				        <p style="text-align: left;margin-bottom: 10px;font-size: 13px;font-weight: 700;"><span class="required" >*</span>상품명</p>
				        <form name="myform" id="myform${item.order_id}" method="post" action="${contextPath}/goods/addReview.do" enctype="multipart/form-data">
				          <div class="goodstitle_modal">
				            <div id="selectedGoodsList${item.order_id}" class="goods_checkbox">
				                <!-- 체크박스에 선택된 상품들의 goods_id를 보관하기 위한 영역 -->    
				            </div>
					           <c:forEach var="reviewItem" items="${myOrderHistList}" varStatus="j">
					               <c:if test="${item.order_id == reviewItem.order_id}">	               
					                   <input type="checkbox" class="goodsCheckbox" name="selected_goods" value="${reviewItem.goods_id}" data-order-id="${item.order_id}" style="display:none;">${reviewItem.goods_name}<br>	               
					               </c:if>   
						        </c:forEach>
					      </div>
				            <input type="hidden" name="goods_id" id="review_goods_id${item.order_id}" value="${review_goods_id}">
				            <input type="hidden" name="mem_id" value="${mem_id}">
				            <div class="middle">
				            	<table class="modal-table">
				            		<tr>
					            		<td>제목</td>
						                <td><input type="text" name="rev_title" placeholder="제목을 입력해주세요."></td>
					                </tr>
					                <tr>
					                	<td>내용</td>
					                	<td><textarea style="border: 1px solid #E8E8E8;"cols="40" rows="7" type="text" id="reviewContents" name="rev_content" placeholder="리뷰를 작성해주세요."></textarea></td>					                
					                </tr>
					                 <tr>
					                	<td>첨부파일</td>
					                	<td>
						                	<input type="button" value="+파일첨부" onclick="fn_addFile(${item.order_id})" class="bordered-input" >
                							<div id="d_file_${item.order_id}" style="font-size: 15px;"></div>
										</td>					                
					                </tr>
				                </table>
				                 <div class="modal-buttons"  style="margin-left: 370px;">
				                    <input type="submit" value="등록하기" class="btn_review">
				                </div>
				            </div>
				        </form>	
				        <a href="#" class="close-modal"></a>			
				    </div>
				    </c:if>
				</td>
			</tr>
			<c:if test="${review_goods_id == ''}">
                <c:set var="review_goods_id" value="${item.goods_id }"/>		
            </c:if>		 
			<c:set  var="pre_order_id" value="${item.order_id }" />
		   </c:when>	
	  </c:choose>		
	</c:forEach>
	</c:otherwise>
  </c:choose>			   
		</tbody>
	</table>
     	
	<div class="clear"></div>
	</div>
	
	<script>
	
	$(document).ready(function() {
	    // 리뷰작성 모달이 열릴 때 실행되는 함수
	    $('.open-review-modal').on('click', function() {
	        var orderId = $(this).data('order-id');
	        var selectedGoodsList = $('#selectedGoodsList' + orderId);
	        var reviewGoodsId = $('#review_goods_id' + orderId).val();
	        selectedGoodsList.empty(); // 기존에 선택된 상품 목록을 비움

	        $('.goodsCheckbox').each(function() {
	            // 해당 주문의 상품만 선택된 상태로 보여줌
	            if ($(this).data('order-id') == orderId) {
	                var checkbox = $(this).clone();
	                checkbox.css('display', 'block'); // 상품 이름 왼쪽에 체크박스가 위치하도록 block으로 변경
	                selectedGoodsList.append(checkbox);

	                // 리뷰 등록시 미리 체크된 상태로 설정
	                var checkedGoodsIds = $('#review_goods_id' + orderId).val().split(',');
	                if (checkedGoodsIds.includes($(this).val())) {
	                    checkbox.prop('checked', true);
	                }
	            }
	        });
	    });

	    // 리뷰 작성 폼을 제출할 때 체크된 상품의 goods_id를 넘김
	    $('.open-review-modal').on('click', function() {
	        var orderId = $(this).data('order-id');
	        $('#myform' + orderId).on('submit', function(e) {
	            e.preventDefault();
	            var checkedGoodsIds = [];
	            $('#selectedGoodsList' + orderId + ' .goodsCheckbox:checked').each(function() {
	                checkedGoodsIds.push($(this).val());
	            });
	            $('#review_goods_id' + orderId).val(checkedGoodsIds.join(','));
	            $(this).off('submit').submit();
	        });
	    });
	});
	 
	 
	 
	function search_order_history(fixedSearchPeriod){
		var formObj=document.createElement("form");
		var i_fixedSearch_period = document.createElement("input");
		i_fixedSearch_period.name="fixedSearchPeriod";
		i_fixedSearch_period.value=fixedSearchPeriod;
	    formObj.appendChild(i_fixedSearch_period);
	    document.body.appendChild(formObj); 
	    formObj.method="get";
	    formObj.action="${contextPath}/mypage/listMyOrderHistory.do";
	    formObj.submit();
	}
	
	$(document).ready(function() {
	    $('.cancel-order-btn').on('click', function() {
	        var orderId = $(this).data('order-id');
	        fn_cancel_order(orderId);
	    });
	});
	
	function fn_cancel_order(order_id){
		var answer=confirm("주문을 취소하시겠습니까?");
		if(answer==true){
			var formObj=document.createElement("form");
			var i_order_id = document.createElement("input"); 
		    
		    i_order_id.name="order_id";
		    i_order_id.value=order_id;
			
		    formObj.appendChild(i_order_id);
		    document.body.appendChild(formObj); 
		    formObj.method="post";
		    formObj.action="${contextPath}/mypage/cancelMyOrder.do";
		    formObj.submit();	
		}
	}
	

</script>
</body>
</html>
