<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
.delete-page{
 width: 800px;
  padding:30px;
   margin: 0 auto; 
  font-family: 'Noto Sans KR', sans-serif;
  border: 1px solid #E8E8E8;
  margin-top: 40px;
  margin-bottom: 40px;  
  text-align: center;
}
.sub_title {
  font-family: 'Noto Sans KR', sans-serif;
  text-align: center;
  font-size: 30px;
  font-weight: 700;
  margin-bottom: 40px;
}

.sub_text1 {
	-swiper-theme-color: #007aff;
	-swiper-navigation-size: 44px;
	 font-family: 'Noto Sans KR', sans-serif;
	outline: 0;
	margin: 0;
	padding: 0;
	margin-top: 25px;
	width: 400px;
	margin-left: auto;
	margin-right: auto;
	font-size: 20px;
	font-weight:500;
	line-height: 28px;
	color: #212121;
}

.sub_text2 {
	-swiper-theme-color: #007aff;
	-swiper-navigation-size: 44px;
	font-family: Spoqa Han Sans, "Sans-serif";
	outline: 0;
	margin: 0;
	padding: 0;
	margin-top: 8px;
	width: 328px;
	margin-left: auto;
	margin-right: auto;
	font-size: 13px;
	color: #9e9e9e;
	letter-spacing: -0.1px;
	text-align: center;
}

.reason {

	margin:0 auto; 
	line-height: 2em;
	text-align: left !important;
	width:400px;  
	align-items: center;
	padding-left: 50px;
	margin-top: 20px;
	margin-bottom: 20px;
}
.reason input[type=text]{
	width: 300px;
	height: 30px;
	padding: 10px;
}
.info {
	margin-top: 10px;
	background: #E8E8E8;
}
.deleteInfo {
	margin-top: 10px;
	margin-left: 30px;
	font-size: 0.9em;
	padding: 20px 0px;
	text-align: left;
}
.deleteInfo li{
margin-bottom: 5px;
}
.reason input[type=button]:disabled{
	float: right;
	width:100px;  
   	height:40px;
   	background: rgb(230,230,230);
   	border: none;
   	border-radius: 5px;
   	font-family: 'TheJamsil';
   	color: #ccc;
   	font-size: 1.1em;
   	font-weight: bold;
   	text-align:center;
}
.reason input[type=radio]{
	margin-left:20px;
	margin-right:5px;
   	background: rgb(230,230,230);
   	border: none;
   	border-radius: 5px;
   	color: #000;
   	text-align:center;
}



</style>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>회원탈퇴</title>
<script>

	function agreeCheck(checkbox) {
	  let deleteBtn = document.getElementsByName('checkButton')[0];

	  if (checkbox.checked) {
	    deleteBtn.removeAttribute('disabled');
	  } else {
	    deleteBtn.setAttribute('disabled', true);
	  }
	}

	//탈퇴 기타사유 텍스트박스 활성화
	$(function(){
	    $("input:radio[name=reason]").attr("checked", false);
	    $("#etc_view").css("display", "none");
	
	    // 기타 사유 라디오 버튼 클릭 이벤트 추가
	    $("#etc").click(function(){
	        if ($("#etc_view").css("display") === "none") {
	            $("#etc_view").css("display", "block");
	        } else {
	            $("#etc_view").css("display", "none");
	        }
	    });
	});

	$(document).ready(function () {
		  $('#deleteButton').on('click', function () {
		    // 수행할 작업을 이곳에 위치시키세요.
		    console.log('클릭 이벤트가 실행되었습니다.');
		    var mem_id = '${mem_id}';
		    deletemember(mem_id);
		});
	});
	
	function deletemember(mem_id){
		if(confirm("회원 정보는 30일간 저장 됩니다. 정말로 탈퇴 하시겠습니까?")){

		var formObj = document.createElement("form");
		var i_login_id = document.createElement("input");
		i_login_id.name = "mem_id";
		i_login_id.value = mem_id;
		
		formObj.appendChild(i_login_id);
		document.body.appendChild(formObj);
		formObj.method="post";
		formObj.action="${contextPath}/mypage/deleteMember.do";
		formObj.submit();
		} else {
			alert("취소합니다.");
		}	
	}
</script>
</head>
<body>
	<div class="delete-page">
		<div class="form">
			<form id="memberDeleteForm" class="deleteform" action="${contextPath}/mypage/deleteMember.do" method="post">
			<p class="sub_title">회원 탈퇴</p>
			<h6 class="sub_text1">그동안 육룰을 이용해주셔서 감사합니다</h6>
			<p class="sub_text2">
				탈퇴 이유를 말씀해주시면 <br> 참고하여 더 나은 서비스를 만들어 나가겠습니다.
			</p>

			<div class="reason">
				<input type="radio" class="non_etc" name="reason"
					value="상품 종류 부족">상품 종류 부족
					
				<input type="radio" class="non_etc" name="reason"
					value="교환/환불/반품 불만">교환/환불/반품 불만<br>
					 
				<input type="radio" class="non_etc" name="reason" 
					value="잦은 알림/문자">잦은 알림/문자
					
				<input type="radio" class="non_etc" name="reason"
					value="배송 불만">배송 불만<br>
					
				<input type="radio" class="non_etc" name="reason" 
					value="높은 상품 가격">높은 상품 가격
				
				<input type="radio" class="non_etc"name="reason" 
					value="서비스 이용 불편">서비스 이용 불편<br>
					
				<input type="radio" id="etc" name="reason" value="기타">기타
									
				<div id="etc_view" >
				    <input type="text" style="width: 400px;margin-left: 20px;border: 1px solid #E8E8E8;" placeholder="기타 사유를 입력해주세요">
				</div>
			</div>
			
			<div class="info">
				<ul class="deleteInfo">
					<li>현재 사용중인 계정 정보는 회원 탈퇴 후 복구가 불가능합니다.</li>
					<li>진행 중인 거래건이 있거나 페널티 조치 중인 경우 탈퇴 신청이 불가합니다.</li>
					<li>탈퇴 후 회원님의 정보는 전자상거래 소비자보호법에 의거한 육룰 개인정보처리방침에 따라 관리됩니다.</li>
					<li>무상으로 지급된 포인트는 탈퇴와 함께 자동 소멸됩니다. 탈퇴 후 재가입하더라도 이미 소멸되었기 때문에
						양도되지 않습니다.</li>
					<li>구매후기 및 답글은 탈퇴 시 자동 삭제되지 않습니다. 탈퇴 후에는 계정 정보가 삭제되어 본인 확인이
						불가하므로, <br>탈퇴 신청 전에 게시글 삭제를 요청해 주시기 바랍니다.
					</li>
					<li>환불 받지 못한 금액이 있을 경우, 환불 정산이 완료된 이후 탈퇴를 신청하셔야 합니다.</li>
					<li>탈퇴 완료 30일 경과 후 개인정보가 모두 삭제됩니다.</li>
				</ul>
			</div>

			<div class="reason2" style="margin-bottom: 10px;">
				<input type="checkbox" name="agree" onClick="agreeCheck(this)" style="margin-right: 5px;"><strong>주의 사항을 모두 확인하였습니다.</strong>
			</div>
				<button type="button" id="deleteButton" name="checkButton" value="회원 탈퇴" >회원 탈퇴</button>
			</form>
		</div>
	</div>
</body>
</html>
