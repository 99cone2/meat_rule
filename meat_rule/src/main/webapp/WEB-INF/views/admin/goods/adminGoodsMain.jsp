<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="utf-8">
</head>
<style>
.form{
margin: 0;
width:100%;
}
.frm_mod_main{
  width: 1300px;
  padding:30px;
 font-size:17px;
  margin: 0 auto; 
  font-family: 'Noto Sans KR', sans-serif;
  margin-top: 20px;
  margin-bottom: 40px;  
}

.table{
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
  margin-top: 40px;
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
</style>
<body>
	<div class="title">
		<h3 class="title"><b>상품 관리</b></h3>
	</div>
	<form class="add-goods-form" action="${contextPath}/admin/goods/addNewGoodsForm.do" style="margin-left: 1400px;">
				<input type="submit" value="상품 등록" class="btn btn-secondary btn-sm" style="width:80px;height: 35px; background: #D24826; color: white; font-family: 'Noto Sans KR', sans-serif; font-weight: 500;font-size: 15px;">
	</form>
	<TABLE class="frm_mod_main">
		<TBODY align=center >
			<tr style="background:#1D1D1D;color: #FFFFFF;font-size: 17px; height: 35px; padding:5px;" >
				<td><span><b>상품번호</b></span></td>
				<td><span><b>상품이름</b></span></td>
				<td><span><b>회사</b></span></td>
				<td><span><b>상품가격</b></span></td>
				<td><span><b>입고일</b></span></td>
			</tr>
   <c:choose>
     <c:when test="${empty newGoodsList }">			
			<TR>
		       <TD colspan=8 class="fixed">
				  <strong>조회된 상품이 없습니다.</strong>
			   </TD>
		     </TR>
	 </c:when>
	 <c:otherwise>
     <c:forEach var="item" items="${newGoodsList }">
			 <TR>       
				<TD>
			      
				  <span>${item.goods_id }</span>
				 
				</TD>
				<TD style="text-align: left;">
				 <a href="${pageContext.request.contextPath}/admin/goods/modifyGoodsForm.do?goods_id=${item.goods_id}">
				    <span>${item.goods_name } </span>
				 </a> 
				</TD>
				<TD>
				   <span>${item.goods_seller }</span> 
				</TD>
				<td>
				  <span>${item.goods_price }원</span>
				</td>
				<td>
					<fmt:formatDate value="${item.goods_delivery_date }" pattern="yyyy-MM-dd" />
				</td>
			</TR>
	</c:forEach>
	</c:otherwise>
  </c:choose>
           <tr>
    <td colspan=8 class="fixed" style="padding-left: 105px;">
        <c:set var="nextSection" value="${section}" />
        <c:set var="nextSectionPage" value="${(section-1)*10 + 11}" />
        <c:forEach var="page" begin="1" end="10" step="1">
            <c:choose>
                <c:when test="${(section-1)*10 + page <= totalPageCount}">
                    <c:if test="${page == 1 && section > 1}">
                        <a href="${contextPath}/admin/goods/adminGoodsMain.do?chapter=${section-1}&pageNum=${section-1}" class="page-link">&nbsp; &nbsp;</a>
                    </c:if>
                    <a href="${contextPath}/admin/goods/adminGoodsMain.do?chapter=${section}&pageNum=${(section-1)*10 + page}" class="page-link">${(section-1)*10 + page}</a>
                </c:when>
                <c:otherwise>
                    <c:if test="${nextSectionPage <= totalPageCount}">
                        <a href="${contextPath}/admin/goods/adminGoodsMain.do?chapter=${nextSection}&pageNum=${nextSectionPage}" class="page-link">&nbsp; next</a>
                    </c:if>
                    <c:set var="nextSection" value="${nextSection + 1}" />
                    <c:set var="nextSectionPage" value="${nextSectionPage + 10}" />
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </td>
</tr>

		</TBODY>
	</TABLE>
		
</body>
</html>