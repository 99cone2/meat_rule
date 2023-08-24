<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<style>
.form{
margin: 0;
width:100%;
}
.frm_mod_member{
  width: 1300px;

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
}
 .admin_member_title{
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

</head>
<body>
	<div class="frm_mod_member">
	<div class="title">
		<h3 class="admin_member_title"><b>회원 관리</b></h3>
	</div>
	
	<table class="table table-hover" style="width:1300px">
			<tbody align=center >
				<tr align=center bgcolor="#1D1D1D" style="color:white;height: 35px;">
					<td><span><b>회원아이디</b></span></td>
					<td><span><b>회원이름</b></span></td>
					<td><span><b>휴대폰번호</b></span></td>
					<td><span><b>주소</b></span></td>
					<td><span><b>가입일</b></span></td>
					<td><span><b>탈퇴여부</b></span></td>
					<td><span><b>비고</b></span></td>
					<td><span><b></b></span></td>
				</tr>
	   <c:choose>
	     <c:when test="${empty listMember}">			
				<tr>
			       <td colspan=5 class="fixed">
					  <strong>조회된 회원이 없습니다.</strong>
				   </td>
			     </tr>
		 </c:when>
		 <c:otherwise>
		     <c:forEach var="item" items="${listMember}" varStatus="item_num">
		            <tr>       
						<td width=10%>
						  <a href="${pageContext.request.contextPath}/admin/member/memberDetail.do?mem_id=${item.mem_id}">
						     <span>${item.mem_id}</span>
						  </a>
						</td>
						<td width=10%>
						  <span>${item.mem_name}</span><br>
						</td>
						<td width=17% >
						  <span>${item.mem_tel1}-${item.mem_tel2}-${item.mem_tel3}</span><br>
						</td>
						<td width=30% style="text-align: left;">
						  <span>${item.roadAddress}</span><br>
						  <span>${item.jibunAddress}</span>
						  <span>${item.namujiAddress}</span><br>
						</td>
						<td width=10%>
						   <c:set var="join_date" value="${item.mem_reg_date}" />
						   <c:set var="arr" value="${fn:split(join_date,' ')}" />
						   <span><c:out value="${arr[0]}" /></span>
					    </td>
					    <td width=10%>
					       <select name="status">
	                <option value="N" <c:if test="${item.mem_del_yn == 'N'}">selected</c:if>>활동중</option>
	                <option value="B" <c:if test="${item.mem_del_yn == 'B'}">selected</c:if>>비활성화</option>
	                <option value="Y" <c:if test="${item.mem_del_yn == 'Y'}">selected</c:if>>탈퇴</option>
	            </select>
	            
					    </td>
					    <td>
					    <span><textarea name="del_note">${item.del_note }</textarea></span>
					    </td>
					    <td width=10%>
					    <button onclick="updateStatus('${item.mem_id}', document.getElementsByName('status')[${item_num.index}].value, document.getElementsByName('del_note')[${item_num.index}].value)">변경</button>
					    </td>
					</tr>
			</c:forEach>
		</c:otherwise>
	  </c:choose>	
         <tr>
             <td colspan=8 class="fixed">
                <c:choose>
				 <c:when test="${not empty listMember }">	
				    	<c:set var="nextSection" value="${section}" />
				        <c:set var="nextSectionPage" value="${(section-1)*10 + 11}" />
				        <c:forEach var="page" begin="1" end="10" step="1">
				            <c:choose>
				                <c:when test="${(section-1)*10 + page <= totalPageCount}">
				                    <c:if test="${page == 1 && section > 1}">
				                    	<a href="${contextPath}/admin/member/adminMemberMain.do?chapter=${section-1}&pageNum=${section-1}" class="page-link">&nbsp; &nbsp;</a>                       
				                    </c:if>
				                    <a href="${contextPath}/admin/member/adminMemberMain.do?chapter=${section}&pageNum=${(section-1)*10 + page}" class="page-link">${(section-1)*10 +page } </a>                  
				                </c:when>
				                <c:otherwise>
				                    <c:if test="${nextSectionPage <= totalPageCount}">
				                    	<a href="${contextPath}/admin/member/adminMemberMain.do?chapter=${nextSection}&pageNum=${nextSectionPage}" class="page-link">&nbsp; next</a> 
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
  	


<script>

function search_member(search_period){	
	temp=calcPeriod(search_period);
	var date=temp.split(",");
	beginDate=date[0];
	endDate=date[1];
	//alert("beginDate:"+beginDate+",endDate:"+endDate);
	//return ;
	var formObj=document.createElement("form");
	var formObj=document.createElement("form");
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
    formObj.action="/gogi/admin/member/adminMemberMain.do";
    formObj.submit();
}

function fn_member_detail(mem_id){
    var frm_delivery_list = document.frm_delivery_list;

    var formObj = document.createElement("form");
    var i_mem_id = document.createElement("input");
    
    i_mem_id.name = "mem_id";
    i_mem_id.value = mem_id;
    
    formObj.appendChild(i_mem_id);
    document.body.appendChild(formObj); 
    formObj.method = "post";
    formObj.action = "/gogi/admin/member/memberDetail.do";
    formObj.submit();
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
    formObj.action="/${contextPath}/admin/member/memberDetail.do";
    formObj.submit();
	
}
function updateStatus(memberId, status, delNote) {
    // AJAX를 사용하여 서버로 상태 변경 요청과 메모를 전달
    $.ajax({
        type: 'POST', // POST 방식으로 전송
        url: '${pageContext.request.contextPath}/admin/member/updateStatus.do', // 요청할 URL (상황에 맞게 수정 필요)
        data: {
            memberId: memberId,
            status: status,
            delNote: delNote
        },
        success: function (response) {
            // 서버로부터 응답을 받은 후 실행되는 함수
            alert("변경하였습니다.");
            // 이후 필요한 처리를 수행하면 됩니다.
        },
        error: function (xhr, status, error) {
            // 서버 요청이 실패한 경우 실행되는 함수
            console.error("AJAX 오류 발생: " + error);
            // 이후 실패에 대한 처리를 수행하면 됩니다.
        }
    });
}
</script>
</body>
</html>

