<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<html>
<head>
<meta  charset="utf-8">

<style>
.form{
margin: 0;
width:100%;
}
.frm_mod_order{
  width: 1300px;
  margin: 0 auto; 
  font-family: 'Noto Sans KR', sans-serif;
  margin-top: 40px;
  margin-bottom: 40px;  
}

.table{
  width:100%;
  align-items: center;
  flex-direction: column;
  margin-top:20px;
  font-family: 'Noto Sans KR', sans-serif;
  border-collapse: separate; 


}
.admin_ordermain_title{
  font-family: 'Noto Sans KR', sans-serif;
  text-align: center;
  font-size: 30px;
  font-weight: 700;
  margin-bottom: 40px;
 }
 
tr{
  vertical-align: center;
}

element.style {
    margin-top: auto;
    margin-bottom: auto;
}
 
.td {
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

 .page-link {
    margin: 0 10px;
    text-decoration: none;
    color: black; /* 페이지 번호 링크의 색상을 변경하고 싶다면 원하는 색상으로 설정하세요 */
  }

  .page-link:hover {
    text-decoration: underline; /* 마우스를 올리면 밑줄이 나타나도록 설정 */
  }

  /* 다음 페이지 링크 스타일 */
  .next-page-link {
    margin: 0 5px;
    text-decoration: none;
    color: green; /* 다음 페이지 링크의 색상을 변경하고 싶다면 원하는 색상으로 설정하세요 */
  }

  .next-page-link:hover {
    text-decoration: underline; /* 마우스를 올리면 밑줄이 나타나도록 설정 */
  }
  .btn-primary {
    color: #fff;
    width: 50px;
    background-color: #D24826;
    border-color: #D24826;
    }
</style>
</head>
<body>
	<div class="frm_mod_order">	
	<div class="title">
		<h3 class="admin_ordermain_title"><b>주문 관리</b></h3>
	</div>
	
	<table class="table" style="width:1200px;">
			<tbody align=center >
				<tr style="background:#1D1D1D;color: #FFFFFF;font-size: 17px; height: 35px; padding:5px;" >
					<td><span><b>주문번호</b></span></td>
					<td><span><b>주문일자</b></span></td>
					<td><span><b>주문내역</b></span></td>
					<td><span><b>배송상태</b></span></td>
					<td><span><b></b></span></td>
				</tr>
	   <c:choose>
	     <c:when test="${empty newOrderList}">			
				<tr>
			       <td colspan=5 class="fixed">
					  <strong>주문한 상품이 없습니다.</strong>
				   </td>
			     </tr>
		 </c:when>
		 
		 <c:otherwise>
		 
		 <!-- 주문 상품 목록을 리스트로 표시합니다. -->
	     <c:forEach var="item" items="${newOrderList}" varStatus="i">

	        <c:choose>
	          <c:when test="${item.order_id != pre_order_id }">  
	          	<!-- 각 주문 상품에 대한 셀렉트 박스에 현재 주문 상태를 초기 값으로 설정합니다. -->
	            <c:choose>
	              <c:when test="${item.order_delivery_status=='delivery_prepared' }" >
	                <tr>    
	              </c:when>
	              <c:when test="${item.order_delivery_status=='finished_delivering' }">
	                <tr>    
	              </c:when>
	              <c:otherwise>
	                <tr>   
	              </c:otherwise>
	            </c:choose>   
					 <td width=10% style="vertical-align: middle;">
					     <span>${item.order_id}</span>
					</td>
					<td width=20% style="vertical-align: middle;">
					 	<fmt:formatDate value="${item.order_time}" pattern="yy년 MM월 dd일 HH:mm" var="orderTime"/>
					 	${orderTime}
					</td>
					<td width=50% align=left >
					  <span><b>[주문자]</b> ${item.mem_name}&nbsp;&nbsp;</span><br>
					  <span><b>[주문자 전화번호]</b> ${item.pay_orderer_hp_num}</span><br>
					  <span><b>[수령자]</b> ${item.order_rec_name}&nbsp;&nbsp;</span><br>
					  <span><b>[수령자 전화번호]</b> ${item.order_rec_hp1}-${item.order_rec_hp2}-${item.order_rec_hp3}</span><br>
					  <span><b>[주문상품명]</b> ${item.goods_name}&nbsp;&nbsp;<b>[수량]</b> ${item.order_quantity}</span><br>					    
					</td>
					<td width=10% >
					 <select name="s_delivery_state${i.index }"  id="s_delivery_state${i.index }" style="height:35px">
					 <c:choose>
					   <c:when test="${item.order_delivery_status=='delivery_prepared' }">
					     <option  value="delivery_prepared" selected>배송준비중</option>
					     <option  value="delivering">배송중</option>
					     <option  value="finished_delivering">배송완료</option>
					     <option  value="cancel_order">주문취소</option>
					     <option  value="returning_goods">반품</option>
					   </c:when>
					    <c:when test="${item.order_delivery_status=='delivering' }">
					    <option  value="delivery_prepared" >배송준비중</option>
					     <option  value="delivering" selected >배송중</option>
					     <option  value="finished_delivering">배송완료</option>
					     <option  value="cancel_order">주문취소</option>
					     <option  value="returning_goods">반품</option>
					   </c:when>
					   <c:when test="${item.order_delivery_status=='finished_delivering' }">
					    <option  value="delivery_prepared" >배송준비중</option>
					     <option  value="delivering"  >배송중</option>
					     <option  value="finished_delivering" selected>배송완료</option>
					     <option  value="cancel_order">주문취소</option>
					     <option  value="returning_goods">반품</option>
					   </c:when>
					   <c:when test="${item.order_delivery_status=='cancel_order' }">
					    <option  value="delivery_prepared" >배송준비중</option>
					     <option  value="delivering"  >배송중</option>
					     <option  value="finished_delivering" >배송완료</option>
					     <option  value="cancel_order" selected>주문취소</option>
					     <option  value="returning_goods">반품</option>
					   </c:when>
					   <c:when test="${item.order_delivery_status=='returning_goods' }">
					    <option  value="delivery_prepared" >배송준비중</option>
					     <option  value="delivering"  >배송중</option>
					     <option  value="finished_delivering" >배송완료</option>
					     <option  value="cancel_order" >주문취소</option>
					     <option  value="returning_goods" selected>반품</option>
					   </c:when>
					   </c:choose>
					 </select> 
					</td>
					<td width=10%  style="margin-top: auto; margin-bottom: auto;">
															<!-- '배송 수정'을 클릭하면 선택한 셀렉트 박스의 id를 함수로 전달합니다. -->
				     <input type="button" class="btn btn-primary" value="수정"  
				     	onClick="fn_modify_order_state('${item.order_id}','s_delivery_state${i.index}')"/>
				    </td>
			</c:when>
			</c:choose>	
			<c:set  var="pre_order_id" value="${item.order_id }" />
		</c:forEach>
		</c:otherwise>
	  </c:choose>
	
         <tr>
             <td colspan=8 class="fixed" style="height: 40px;">
             <c:choose>
				 <c:when test="${not empty newOrderList }">	
				    	<c:set var="nextSection" value="${section}" />
				        <c:set var="nextSectionPage" value="${(section-1)*10 + 11}" />
				        <c:forEach var="page" begin="1" end="10" step="1">
				            <c:choose>
				                <c:when test="${(section-1)*10 + page <= totalPageCount}">
				                    <c:if test="${page == 1 && section > 1}">
				                     <a href="${contextPath}/admin/order/adminOrderMain.do?chapter=${section-1}&pageNum=${section-1}" class="page-link">&nbsp;&nbsp;</a>				                    	                      
				                    </c:if>
				                     <a href="${contextPath}/admin/order/adminOrderMain.do?chapter=${section}&pageNum=${(section-1)*10 + page}" class="page-link">${(section-1)*10 +page } </a>			                                  
				                </c:when>
				                <c:otherwise>
				                    <c:if test="${nextSectionPage <= totalPageCount}">
				                    <a href="${contextPath}/admin/order/adminOrderMain.do?chapter=${nextSection}&pageNum=${nextSectionPage}" class="page-link">&nbsp; next</a>
				                    </c:if>
				                    <c:set var="nextSection" value="${nextSection + 1}" />
				                    <c:set var="nextSectionPage" value="${nextSectionPage + 10}" />
				                </c:otherwise>
				            </c:choose>
				        </c:forEach>		 					
				 </c:when>
				</c:choose>             
           </td>
        </tr>  		   
		</tbody>
	</table>
	</div> 
	
	
	
	
	
<c:choose>
<c:when test='${not empty order_goods_list}'>
<script  type="text/javascript">
window.onload=function()
{
	init();
}

//화면이 표시되면서  각각의 주문건에 대한 배송 상태를 표시한다.
function init(){
	var frm_delivery_list=document.frm_delivery_list;
	var h_delivery_state=frm_delivery_list.h_delivery_state;
	var s_delivery_state=frm_delivery_list.s_delivery_state;
	
	if(h_delivery_state.length==undefined){
		s_delivery_state.value=h_delivery_state.value; //조회된 주문 정보가 1건인 경우
	}else{
		for(var i=0; s_delivery_state.length;i++){
			s_delivery_state[i].value=h_delivery_state[i].value;//조회된 주문 정보가 여러건인 경우
		}
	}
}
</script>
</c:when>
</c:choose>
<script>
function search_order_history(search_period){	
	temp=calcPeriod(search_period);
	var date=temp.split(",");
	beginDate=date[0];
	endDate=date[1];
    
	var formObj=document.createElement("form");
	var i_command = document.createElement("input");
	var i_beginDate = document.createElement("input"); 
	var i_endDate = document.createElement("input");
    
	i_beginDate.name="beginDate";
	i_beginDate.value=beginDate;
	i_endDate.name="endDate";
	i_endDate.value=endDate;
	
    formObj.appendChild(i_beginDate);
    formObj.appendChild(i_endDate);
    document.body.appendChild(formObj); 
    formObj.method="get";
    formObj.action="${contextPath}/admin/order/adminOrderMain.do";
    formObj.submit();
}

function fn_modify_order_state(order_id,select_id){
						 // 주문 상태를 나타내는 셀렉트 박스에 접근합니다.
	var s_delivery_state=document.getElementById(select_id);
	
	// 함수로 전달받은 셀렉트 박스에서 선택한 옵션의 인덱스로 배송 상태 값을 가져옵니다.
    var index = s_delivery_state.selectedIndex;
    var value = s_delivery_state[index].value;
    
    console.log("value: "+value );
	 
	$.ajax({
		type : "post",
		async : false,
		url : "${contextPath}/admin/order/modifyDeliveryState.do",
			   // 주문 번호와 배송 상태 값을 컨트롤러로 전송합니다.
		data : {order_id:order_id, "order_delivery_status":value},
		success : function(data, textStatus) {
			if(data.trim()=='mod_success'){
				alert("주문 정보를 수정했습니다.");
				location.href="${contextPath}/admin/order/adminOrderMain.do";
			}else if(data.trim()=='failed'){
				alert("다시 시도해 주세요.");	
			}
			
		},
		error : function(data, textStatus) {
			alert("에러가 발생했습니다."+data);
		},
		complete : function(data, textStatus) {
			//alert("작업을완료 했습니다");
			
		}
	}); //end ajax		
}

//상세조회 버튼 클릭 시 수행
function fn_detail_search(){
	var frm_delivery_list=document.frm_delivery_list;
	
	beginYear=frm_delivery_list.beginYear.value;
	beginMonth=frm_delivery_list.beginMonth.value;
	beginDay=frm_delivery_list.beginDay.value;
	endYear=frm_delivery_list.endYear.value;
	endMonth=frm_delivery_list.endMonth.value;
	endDay=frm_delivery_list.endDay.value;
	search_type=frm_delivery_list.s_search_type.value;
	search_word=frm_delivery_list.t_search_word.value;

	var formObj=document.createElement("form");
	var i_command = document.createElement("input");
	var i_beginDate = document.createElement("input"); 
	var i_endDate = document.createElement("input");
	var i_search_type = document.createElement("input");
	var i_search_word = document.createElement("input");
	
    i_command.name="command";
    i_beginDate.name="beginDate";
    i_endDate.name="endDate";
    i_search_type.name="search_type";
    i_search_word.name="search_word";
    
    i_command.value="list_detail_order_goods";
	i_beginDate.value=beginYear+"-"+beginMonth+"-"+beginDay;
    i_endDate.value=endYear+"-"+endMonth+"-"+endDay;
    i_search_type.value=search_type;
    i_search_word.value=search_word;
	
    formObj.appendChild(i_command);
    formObj.appendChild(i_beginDate);
    formObj.appendChild(i_endDate);
    formObj.appendChild(i_search_type);
    formObj.appendChild(i_search_word);
    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/admin/order/detailOrder.do";
    formObj.submit();
}

</script>  	
</body>
</html>

