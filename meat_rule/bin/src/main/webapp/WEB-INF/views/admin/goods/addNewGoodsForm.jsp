<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />	
<!DOCTYPE html>
<meta charset="utf-8">
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<style>
@charset "UTF-8";

.row1 {
	margin: 0px auto;
	width: 900px;
}

#asas {
	text-align: center;
	justify-content: center;
}

.hh2 {
	text-align: center;
	margin-top: 50px;
	margin-bottom:20px;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 700;
	font-size: 35px;
	margin-bottom: 20px;
}

.bbu {
	border-bottom: 1px solid #ddd;
}

.greylist {
	width: 100px;
	height: 50px;
	font-weight: 700;
	color: white;
	text-align: center;
	background: black;
	border-radius: 5px;
	font-size: 19px;
}

.greylist:hover {
	background-color: #D24826;
	border: solid 2px white;
	color: white;
}

.greylist a {
	text-decoration-line: none;
	text-decoration: none;
	color: white;
}

.atw {
	text-decoration-line: none;
	text-decoration: none;
	color: white;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 500;
	display: block;
	font-size: 18px;
	width:130px;
	height:40px;
	margin-top: 10px;
}

.writeButton {
	float: right;
}

.fg {
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 400;
	font-size: 20px;
	font-weight: bold;
}

.fgl {
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 400;
	font-size: 16px;
	padding:5px;
	margin: 0;
}

.fw {
	color: white;
 	
}

.lb {
	background-color: #292929;
}

.rightbtn {
	float: right;
}

.bordered-input {
  border: 1px solid #ccc;
  margin-left:5px;
}

.text-center{
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 500;
	font-size: 17px;
}

::-webkit-input-placeholder { /* Chrome, Safari, Opera */
    font-size: 15px;
}
.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th {
    padding: 8px;
    line-height: 1.42857143;
    vertical-align: top;
    border-top: 1px solid #ddd;
    background: none;
    color: black;
}
</style>
   

<body>
	<h3 class="hh2">새상품 등록창</h3>
		 
		<form action="${contextPath}/admin/goods/addNewGoods.do" method="post" enctype="multipart/form-data">				
		<div class="tab_container" style="margin-top: 20px;">
			<div class="container1" style="padding-bottom: 100px" id="container">
			 
				<div class="row row1">
					<div  class="table" id="tab1">
						<table class="table">
					<tr>
						<td width=20% class="text-center fg lb fw">제품분류</td>
						<td width=80% class="text-left fgl">
						<select name="goods_sort">
								<option value="PIG" selected>돼지
								<option value="COW">소
								<option value="CHICKEN">닭
								<option value="MEALKIT">양념육/밀키트
							</select>
						</td>
					</tr>
					<tr >
						<td width="10%" class="text-center lb fg fw" >제품이름</td>
						<td colspan="2" class="fgl">
							<input name="goods_name" type="text" size="40" /></td>
					</tr>
					 
					<tr>
						<td width="10%" class="text-center lb fg fw">제품회사</td>
						<td colspan="2" class="fgl"> <input name="goods_seller" type="text" size="40" /></td>
					</tr>
					<tr>
						<td width="10%" class="text-center lb fg fw" >제품정가</td>
						<td colspan="2" class="fgl"><input name="goods_price" type="text" size="40" /></td>
					</tr>
					
					<tr>
						<td width="10%" class="text-center lb fg fw">제품판매가격</td>
						<td colspan="2" class="fgl"><input name="goods_sales_price" type="text" size="40" /></td>
					</tr>
					
			 		<tr>
						<td width="10%" class="text-center lb fg fw">제품 구매 포인트</td>
						<td colspan="2" class="fgl"><input name="goods_point" type="text" size="40" /></td>
					</tr>
					
					<tr>
						<td width="10%" class="text-center lb fg fw">제품 등록일</td>
						<td colspan="2" class="fgl"><input name="goods_delivery_date"  type="date" size="40" /></td>
					</tr>
					<tr>
						<td width="10%" class="text-center lb fg fw">제품 중량</td>
						<td colspan="2" class="fgl"><input name="goods_weight"  type="text" size="40" /></td>
					</tr>
					<tr>
						<td width="10%" class="text-center lb fg fw">제품종류</td>
						<td colspan="2" class="fgl">
						<select name="goods_status">
						  <option value="B">인기상품</option>
						  <option value="N" selected>신규상품</option>
						  <option value="S">할인상품</option>
						</select>
						</td>
					</tr>
					<tr>
								<th width="10%" class="text-center fg lb fw" style="vertical-align: middle;">제품 소개</th>
								<td colspan="4" class="text-left fg" valign="top" height="200">
									<pre class="fgl" style="white-space: pre-wrap; border: none; background-color: white;">
										<textarea cols="80" rows="8" name="goods_intro" placeholder="제품 설명을 입력해 주세요" class="bordered-input" style="width: 100%; height: 100%; padding: 0; margin: 0;"></textarea>
									</pre>
								</td>
							</tr>
							<tr>
								<th width="10%" class="text-center   fg lb fw">상품 이미지 추가</th>
								<td width="90%" class="text-left fgl">
									<input type="button" value="파일추가" onClick="fn_addFile()" class="bordered-input" style="font-size: 15px;">
									<div id="d_file"></div>
								</td>
							</tr>
							<tr>
								<td td colspan="4" class="text-right">
									<div>
										<input type="button" class="btn btn-sm btn-primary greylist atw"  style="float: right;" value="상품 등록하기" onClick="fn_add_new_goods(this.form)">
									</div>
								</td>
							</tr>
						</table>	
					</div>
				</div>
			</div>
	 
		</div>
		</form>
		
		
		 <script type="text/javascript">
		  // 상세 이미지의 첨부 순서를 나타냅니다.
		  var cnt=0;
		  function fn_addFile(){
			  if(cnt == 0){
				  												  // 첫 번째 파일 업로드는 메인 이미지를 첨부하므로 name 속성을 main_image로 설정합니다.
				  $("#d_file").append("<br>"+"<input  type='file' name='main_image' id='f_main_image' />");	  
			  }else{
				  												  // 그 외의 이미지들은 name 속성의 값을 detail_image+cnt로 설정합니다.
				  $("#d_file").append("<br>"+"<input  type='file' name='detail_image"+cnt+"' />");
			  }
		  	
		  	cnt++;
		  }
		  
		  function fn_add_new_goods(obj){
				 fileName = $('#f_main_image').val();
				 if(fileName != null && fileName != undefined){
					 obj.submit();
				 }else{
					 alert("메인 이미지는 반드시 첨부해야 합니다.");
					 return;
				 }
				 
			}
		</script> 
</body>
</html>