<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="euc-kr" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="goods" value="${goodsMap.goods}" />
<c:set var="imageFileList" value="${goodsMap.imageFileList}" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
.form{
margin: 0 auto;
width:1000px;
}

.btn-group-sm>.btn, .btn-sm {
    padding: 5px 10px;
    font-size: 14px;
    font-weight:500;
    line-height: 1.5;
    width: 60px;
    background:black;
    border-radius: 3px;
}
.frm_mod_goods{
  width: 1000px;
  padding:30px;
  margin: 0 auto; 
  font-family: 'Noto Sans KR', sans-serif;
  border: 1px solid #E8E8E8;
  margin-top: 40px;
  margin-bottom: 40px;  
}

.frm_mod_tab{
  width: 1000px;
  padding:30px;
  margin: 0 auto; 
  font-family: 'Noto Sans KR', sans-serif;
  margin-top: 40px;
  margin-bottom: 40px;  
}

.category {display: flex;justify-content: center; }
.category a:hover img {opacity: 0.8; /* 투명도 조절 */transition: all 0.5s ease-in-out; /* 변경 효과 적용 */ transform: translateY(-10px);}

.table{
  width:100%;
  align-items: center;
  flex-direction: column;
  margin-top:20px;
  font-family: 'Noto Sans KR', sans-serif;
  border-collapse: separate; 

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
 
 .hh2{
 text-align: center;
   margin-top: 50px;
   font-family: 'Noto Sans KR', sans-serif;
   font-weight: 700;
   font-size: 35px;
   margin-bottom: 20px;
 }

</style>

</HEAD>
<html>
<BODY>
   <div class="title" style="margin-top: 50px">
      <h3 class="hh2">상품 수정</h3>
   </div>

   <form name="frm_mod_goods" method=post>
      <DIV class="clear"></DIV>

      <DIV class="frm_mod_tab" id="tab1">
         <table class="table">
            <tr>
               <td width=20% >상품분류</td>
               <td width=65%><select name="goods_sort">
                     <c:choose>
                        <c:when test="${goods.goods_sort=='COW'}">
                           <option value="COW" selected>소</option>
                           <option value="PIG">돼지</option>
                           <option value="CHICKEN">닭</option>
                           <option value="MEALKIT">밀키트/양념육</option>
                        </c:when>
                        <c:when test="${goods.goods_sort=='PIG'}">
                           <option value="COW" >소</option>
                           <option value="PIG" selected>돼지</option>
                           <option value="CHICKEN">닭</option>
                           <option value="MEALKIT">밀키트/양념육</option>
                        </c:when>
                        <c:when test="${goods.goods_sort=='CHICKEN'}">
                           <option value="COW" >소</option>
                           <option value="PIG" >돼지</option>
                           <option value="CHICKEN" selected>닭</option>
                           <option value="MEALKIT">밀키트/양념육</option>
                        </c:when>
                        <c:when test="${goods.goods_sort=='MEALKIT'}">
                           <option value="COW" >소</option>
                           <option value="PIG" >돼지</option>
                           <option value="CHICKEN" >닭</option>
                           <option value="MEALKIT" selected>밀키트/양념육</option>
                        </c:when>
                     </c:choose>
               </select></td>
               <td width=15% ><input type="button" value="수정"
                  class="btn btn-secondary btn-sm"
                  onClick="fn_modify_goods('${goods.goods_id}','goods_sort')" /></td>
            </tr>
            <tr>
               <td>상품이름</td>
               <td><input name="goods_name" type="text" size="40"
                  value="${goods.goods_name}" /></td>
               <td><input type="button" value="수정"
                  class="btn btn-secondary btn-sm"
                  onClick="fn_modify_goods('${goods.goods_id}','goods_name')" /></td>
            </tr>

            <tr>
               <td>제품회사</td>
               <td><input name="goods_seller" type="text" size="40"
                  value="${goods.goods_seller}" /></td>
               <td><input type="button" value="수정"
                  class="btn btn-secondary btn-sm"
                  onClick="fn_modify_goods('${goods.goods_id}','goods_seller')" />
               </td>
            </tr>
            <tr>

               <td>상품판매가격</td>
               <td><input name="goods_price" type="text" size="40"
                  value="${goods.goods_price}" /></td>
               <td><input type="button" value="수정"
                  class="btn btn-secondary btn-sm"
                  onClick="fn_modify_goods('${goods.goods_id}','goods_price')" /></td>
            </tr>

            <tr>
               <td>상품 구매 포인트</td>
               <td><input name="goods_point" type="text" size="40"
                  value="${goods.goods_point}" /></td>
               <td><input type="button" value="수정"
                  class="btn btn-secondary btn-sm"
                  onClick="fn_modify_goods('${goods.goods_id}','goods_point')" /></td>
            </tr>

            <tr>
               <td>상품등록일</td>
               <td><input name="goods_delivery_date" type="date"
                  value="${goods.goods_delivery_date}" /></td>
               <td><input type="button" value="수정"
                  class="btn btn-secondary btn-sm"
                  onClick="fn_modify_goods('${goods.goods_id}','goods_delivery_date')" />
               </td>
            </tr>

            <tr>
               <td>상품종류</td>
               <td><select name="goods_status">
                     <option value="bestgoods">인기상품</option>
                     <option value="newgoods">신상품</option>
                     <option value="on_sale" selected>판매중</option>
                     <option value="buy_out">품절</option>
               </select> <input type="hidden" name="goods_status"
                  value="${goods.goods_status}" /></td>
               <td><input type="button" value="수정"
                  class="btn btn-secondary btn-sm"
                  onClick="fn_modify_goods('${goods.goods_id}','goods_status')" />
               </td>
            </tr>
               <tr>
               <td>상품중량</td>
               <td><input name="goods_weight" type="text"
                  value="${goods.goods_weight}" /></td>
               <td><input type="button" value="수정" class="btn btn-secondary btn-sm" onClick="fn_modify_goods('${goods.goods_id}','goods_weight')" />
               </td>
            </tr>
            <tr>
               <td>상품소개</td>
               <td><textarea rows="8" cols="70" name="goods_intro">${goods.goods_intro }</textarea></td>
               <td>
               <input type="button" value="수정" onClick="fn_modify_goods('${goods.goods_id }','goods_intro')"
                   class="btn btn-secondary btn-sm" />
               </td>
            </tr>
                 
				<tr>
				  <form id="FILE_FORM" method="post" enctype="multipart/form-data">		            
		             <c:forEach var="item" items="${imageFileList }" varStatus="itemNum">		                 
		                        <c:if test="${item.file_type=='main_image' }">
		                           <tr>
		                              <td>메인 이미지</td>
		                             
		                              <td><img id="preview${itemNum.count }" width=200 height=200 src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.file_name}" />
					                    <input type="file" id="main_image" name="main_image" onchange="readURL(this,'preview${itemNum.count}');" /> 
					                    <input type="hidden" name="image_id" value="${item.image_id}" />            
		                              </td>		                            
		                              <td><input type="button" value="수정"
		                                 onClick="modifyImageFile('main_image','${item.goods_id}','${item.image_id}','${item.file_type}')"
		                                 class="btn btn-secondary btn-sm" /></td>
		                           </tr>
		                                  
		                    </c:if>
		             </c:forEach>  
		           </form>
                </tr>
                <tr style="text-align: right;s">
                  <td colspan="3">      
	                  <c:forEach var="item" items="${imageFileList }" varStatus="itemNum" begin="0" end="0">
			            <input type="button" value="삭제" class="btn btn-secondary btn-sm" onClick="deleteGoods('${goods.goods_id}'), backToList(this.form)">
			          </c:forEach>
		          </td>
                </tr>
         </table>
      </DIV>
   		
      <DIV class="tab_content" id="tab7">
        
      </DIV>
      <DIV class="clear"></DIV>

   </form>
   
   <c:choose>
   <c:when test='${not empty goods.goods_status}'>
      <script>
         window.onload = function() {
            init();
         }
         function init() {
            var frm_mod_goods = document.frm_mod_goods;
            var h_goods_status = frm_mod_goods.h_goods_status;
            var goods_status = h_goods_status.value;
            var select_goods_status = frm_mod_goods.goods_status;
            select_goods_status.value = goods_status;
         }
      </script>
   </c:when>
</c:choose>
<script type="text/javascript">
   // 수정된 상품 정보의 속성과 수정 값을 컨트롤러로 전송합니다.
   function fn_modify_goods(goods_id, attribute) {
      var frm_mod_goods = document.frm_mod_goods;
      var value = "";
      if (attribute == 'goods_sort') {
         value = frm_mod_goods.goods_sort.value;
      } else if (attribute == 'goods_name') {
         value = frm_mod_goods.goods_name.value;
      } else if (attribute == 'goods_seller') {
         value = frm_mod_goods.goods_seller.value;
      } else if (attribute == 'goods_price') {
         value = frm_mod_goods.goods_price.value;
      } else if (attribute == 'goods_point') {
         value = frm_mod_goods.goods_point.value;
      } else if (attribute == 'goods_delivery_date') {
         value = frm_mod_goods.goods_delivery_date.value;
      } else if (attribute == 'goods_status') {
         value = frm_mod_goods.goods_status.value;
      } else if (attribute == 'goods_intro') {
         value = frm_mod_goods.goods_intro.value;
      } else if (attribute == 'goods_weight') {
         value = frm_mod_goods.goods_weight.value;
      }

      $.ajax({
         type : "post",
         async : false, //false인 경우 동기식으로 처리한다.
         url : "${contextPath}/admin/goods/modifyGoodsInfo.do",
         data : {
            goods_id : goods_id,
            // 상품 속성과 수정 값을 Ajax로 전송합니다.
            attribute : attribute,
            value : value
         },
         success : function(data, textStatus) {
            if (data.trim() == 'mod_success') {
               alert("상품 정보를 수정했습니다.");
            } else if (data.trim() == 'failed') {
               alert("다시 시도해 주세요.");
            }

         },
         error : function(data, textStatus) {
            alert("에러가 발생했습니다." + data);
         },
         complete : function(data, textStatus) {
            //alert("작업을완료 했습니다");

         }
      }); //end ajax   
   }

   function readURL(input, preview) {
      //  alert(preview);
      if (input.files && input.files[0]) {
         var reader = new FileReader();
         reader.onload = function(e) {
            $('#' + preview).attr('src', e.target.result);
         }
         reader.readAsDataURL(input.files[0]);
      }
   }

   // '이미지 추가' 클릭 시 상세 이미지 파일 업로드를 추가합니다.
   var cnt = 1;
   function fn_addFile() {
      $("#d_file").append(
            "<br>" + "<input  type='file' name='detail_image" + cnt
                  + "' id='detail_image" + cnt
                  + "'  onchange=readURL(this,'previewImage" + cnt
                  + "') />");
      $("#d_file").append(
            "<img  id='previewImage"+cnt+"'   width=200 height=200  />");
      $("#d_file")
            .append(
                  "<input  type='button' value='추가'  onClick=addNewImageFile('detail_image"
                        + cnt
                        + "','${imageFileList[0].goods_id}','detail_image')  />");
      cnt++;
   }

   // 기존 이미지를 다른 이미지로 변경한 후 FormData를 이용해 Ajax로 수정합니다.
   function modifyImageFile(fileId, goods_id, image_id, fileType) {
      // alert(fileId);
      var form = $('#FILE_FORM')[0];
      var formData = new FormData(form);

      // formData에 수정할 이미지와 이미지 정보를 name/value로 저장합니다.
      formData.append("fileName", $('#' + fileId)[0].files[0]);
      formData.append("goods_id", goods_id);
      formData.append("image_id", image_id);
      formData.append("fileType", fileType);

      $.ajax({
         url : '${contextPath}/admin/goods/modifyGoodsImageInfo.do',
         processData : false,
         contentType : false,
         // formData를 Ajax로 전송합니다.
         data : formData,
         type : 'POST',
         success : function(result) {
            alert("이미지를 수정했습니다!");
         }
      });
   }

   // 새 이미지 추가 후 FormData를 이용해 Ajax로 수정합니다.
   function addNewImageFile(fileId, goods_id, fileType) {
      //  alert(fileId);
      var form = $('#FILE_FORM')[0];
      var formData = new FormData(form);
      formData.append("uploadFile", $('#' + fileId)[0].files[0]);
      formData.append("goods_id", goods_id);
      formData.append("fileType", fileType);

      $.ajax({
         url : '${contextPath}/admin/goods/addNewGoodsImage.do',
         processData : false,
         contentType : false,
         data : formData,
         type : 'post',
         success : function(result) {
            alert("이미지를 수정했습니다!");
         }
      });
   }

   // 이미지를 삭제합니다.
   function deleteImageFile(goods_id, image_id, imageFileName, trId) {
      var tr = document.getElementById(trId);

      $.ajax({
         type : "post",
         async : true, //false인 경우 동기식으로 처리한다.
         url : "${contextPath}/admin/goods/removeGoodsImage.do",
         data : {
            goods_id : goods_id,
            image_id : image_id,
            imageFileName : imageFileName
         },
         success : function(data, textStatus) {
            alert("이미지를 삭제했습니다.");
            tr.style.display = 'none';
         },
         error : function(data, textStatus) {
            alert("에러가 발생했습니다." + textStatus);
         },
         complete : function(data, textStatus) {
            //alert("작업을완료 했습니다");

         }
      }); //end ajax   
   }

   /* 상품삭제 */
   function deleteGoods(goods_id) {
      $.ajax({
         type : "post",
         async : true,
         url : "${contextPath}/admin/goods/removeGoods.do",
         data : {
            goods_id : goods_id
         },
         success : function(data, textStatus) {
            alert("상품을 삭제했습니다.");
            location.href = "${contextPath}/admin/goods/adminGoodsMain.do";
         },
         error : function(data, textStatus) {
            alert("에러가 발생했습니다." + textStatus);
         },
         complete : function(data, textStatus) {
            //alert("작업을완료 했습니다");
         }
      }); //end ajax
   }

   function backToList(obj) {
      obj.action = "${contextPath}/admin/goods/adminGoodsMain.do";
      obj.submit();
   }
</script>
   
 </BODY>
 </html>