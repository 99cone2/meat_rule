<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="imageFileList"  value="${servMap.imageFileList}"  />
<c:set var="servRead"  value="${servMap.servVO}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 조회</title>
<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link href="${contextPath}/resources/css/noticeRead.css"
   rel="stylesheet" type="text/css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style>
input[type="text"], input[type="password"], textarea{ 
    border: 1px solid #E8E8E8;
  }   
  
.fg {
   font-family: 'Noto Sans KR', sans-serif;
   font-weight: 400;
   font-size: 17px;
}

.fgl {
   font-family: 'Noto Sans KR', sans-serif;
   font-weight: 400;
   font-size: 17px;
   padding:5px;
   margin: 0;
}  

::-webkit-input-placeholder { /* Chrome, Safari, Opera */
    font-size: 15px;
}
</style>
</head>
<body>
   <h1>게시물 수정</h1>
	<form method="post" name="form" id="updateForm" role="form" enctype="multipart/form-data" action="${contextPath}/serv/modify.do?cust_serv_no=${servRead.cust_serv_no}">
    <div role="main" class="container2" style="padding-bottom: 100px">
        <div class="row row1">
               <table class="table">
                  <tr>
                     <th width=15% class="text-center fg lb fw">작성자</th>
                     <td width=35% class="text-center fgl">
                        <input style="width: 350px;" type="text" name="mem_id"
                     class="bordered-input" value="${servRead.mem_id}" disabled/>
                     </td>
                     <th width=15% class="text-center lb  fg fw">조회수</th>
                     <td width=35%  class="text-center  bbu fgl">
                     <input style="width: 350px;" type="text" name="cust_serv_hits"
                     class="bordered-input" value="${servRead.cust_serv_hits}" disabled/>
                     </td>
                  </tr>
                  <tr>
                     <th width=15% class="text-center lb fg fw">제목</th>
                     <td width=35% class="text-center  bbu fgl"> 
                        <input style="width:350px;" type="text" name="cust_serv_title" value="${servRead.cust_serv_title}"  class="bordered-input"/>
                     </td>
                  </tr>
                  <tr>
                  <th width="15%" class="text-center lb fg fw" style="vertical-align: middle;">문의내역</th>
                     <td colspan="4" class="text-left fg" valign="top" height="200">                     
                        <pre class="fgl" style="white-space: pre-wrap; border: none; background-color: white;">
                         <textarea cols="80" rows="8" name="cust_serv_content" class="bordered-input"style="width: 100%; height: 100%; padding: 0; margin: 0;">${servRead.cust_serv_content}</textarea>
                        </pre>
                     </td>
                  </tr>
                  
            <c:if test="${not empty imageFileList && imageFileList!='null' }">
               <c:forEach var="item" items="${imageFileList}" varStatus="status">
                  <tr>
                  <th width=15% class="text-center lb fg fw" style="vertical-align: middle;">첨부 파일${status.count }</th>
                  <td class="result-images" colspan="4">   
                     <input type="hidden" name="img_name" value="${item.img_name}" >       <!-- 이미지 수정에 대비해 원리 이미지 파일 이름은 hidden 태그에 저장 -->         
                     <input type="hidden" name="img_no" value="${item.img_no}" >       <!-- 이미지 수정에 대비해 원리 이미지 파일 이름은 hidden 태그에 저장 -->         
                     <img width=200 src="${contextPath}/thumbnails2.do?img_name=${item.img_name}&cust_serv_no=${item.cust_serv_no}" >                  
                   	<input type="file" name="imageFileName"><!-- 수정된 이미지 파일 이름을 전송합니다. -->
                  </td>
                  </tr>
                  
               </c:forEach>
            </c:if>
                  
                  <tr id="tr_btn">
                     <td td colspan="4" class="text-right  ">
                     <div> 
                           <button type="submit" class="btn btn-sm btn-primary greylist atw" style="float: right;"  >완료</button>
                     </div>
                     </td>
                  </tr>
               </table>
            </div>
         </div> 
      </form>
      




    
   
</body>
</html>