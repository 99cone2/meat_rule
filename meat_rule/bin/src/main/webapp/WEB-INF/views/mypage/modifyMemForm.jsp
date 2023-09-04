<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<head>
<style>
.required {
    color: #DB0000; /* 원하는 색상으로 변경하세요 */
  }
.modifybutton{
font-family: 'Noto Sans KR', sans-serif;
font-size:15px;
cursor: pointer;
border: 0;
width: 70px;
font-weight:500;
height: 35px;
margin-top: 10px;
background: #1D1D1D;
color: #FFFFFF;
}

.button{
text-align: right;
margin-right: 35px;
}

.label-group {
  width: 150px;
  text-align: left;
  margin-right: 10px;
}

.category {
	display: flex;
	justify-content: center;
}

 .title{
  font-family: 'Noto Sans KR', sans-serif;
  text-align: center;
  font-size: 30px;
  font-weight: 700;
  margin-bottom: 40px;
 }
 

 input[type="password"] {
    width: 60%; /* 원하는 길이로 설정 (예: 300px) */
    border: 1px solid #E8E8E8;
    padding-left:10px;
  }
  .frm_mod_member{
  width: 800px;
  padding:30px;
  padding-left:35px;
  padding-right:35px;
  margin: 0 auto; 
  font-family: 'Noto Sans KR', sans-serif;
  margin-top: 40px;
  margin-bottom: 40px;
  
   }
   
   table{
   width:100%;
   align-items: center;
   }
.form{
   align-items: center;
   margin-left: 27px;
   }
   
.form input {
  font-family: 'Noto Sans KR', sans-serif;
  outline: 0;
  width: 500px;
  height: 40px;
  border: 1px solid #E8E8E8;
  margin: 5px 0; 
  padding-right:5px;
  box-sizing: border-box;
  font-size: 14px;
}

#mem_birth_y, #mem_birth_m, #mem_birth_d, #mem_tel1, #mem_tel2, #mem_tel3{
	width: 160px;
	margin-right: 10px;
}
</style>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>회원 페이지</title>
</head>
<body>
	<div class="frm_mod_member">
	  <div class="title">개인정보수정</div>
        <div class="form">
            <form name="frm_mod_member" action="${contextPath}/mypage/modifyMyInfo.do" method="post">            
			<table>
			    <tr>
			        <td>
			           <label for="myp_id">아이디</label>			      
			       	</td>
			       	<td>
			           <input type="text" name="mem_id" value="${memberInfo.mem_id}" disabled />			        
			        </td>
			    </tr>
			    <tr>    
			        <td>		           
		                <div class="label-group">
		                    <label for="mem_pw"><span class="required" >*</span>비밀번호</label>
		                </div>
		            </td>			    
			       	<td>
			            <input type="password" placeholder="비밀번호" id="mem_pw" name="mem_pw" style="margin-right: 5px;">
			       
			        </td>
			    </tr>
			    <tr>
			        <td>
			        
		                <div class="label-group">
		                    <label for="mem_name">이름</label>
		                </div>
			        </td>			    
			       	<td>
		                <input type="text" name="mem_name" value="${memberInfo.mem_name}" disabled />
			            
			        </td>
			    </tr>
			      <tr>
					    <td>
					        <div class="label-group" >
					            <label for="mem_birth">생년월일</label>
					        </div>
					    </td>		    	 
					    <td>      
					        <div class="input-group" style="display:flex !important;">
					            <input type="text" id="mem_birth_y" name="mem_birth_y" placeholder="년" maxlength="4" value="${memberInfo.mem_birth_y}"  disabled>
					            <input type="text" id="mem_birth_m" name="mem_birth_m" placeholder="월" maxlength="2" value="${memberInfo.mem_birth_m}" disabled>
					            <input type="text" id="mem_birth_d" name="mem_birth_d" placeholder="일" maxlength="2" value="${memberInfo.mem_birth_d}" disabled> 
					        </div>			           
					    </td>
					</tr>
					<tr>
					    <td>
					        <div class="label-group">
					            <label for="mem_tel">연락처</label>
					        </div>
					    </td>			       
					    <td>
					        <div class="input-group" style="display:flex !important;">
					            <input type="text" id="mem_tel1" name="mem_tel1" placeholder="통신사" maxlength="3" value="${memberInfo.mem_tel1}">
					            <input type="text" id="mem_tel2" name="mem_tel2" placeholder="중간 번호" maxlength="4" value="${memberInfo.mem_tel2}">
					            <input type="text" id="mem_tel3" name="mem_tel3" placeholder="마지막 번호" maxlength="4" value="${memberInfo.mem_tel3}">
					        </div>
					    </td>
					</tr>
			        <tr>
				        <td>				       
			                <div class="label-group">
			                    <label for="mem_email">이메일</label>
			                </div>
				        </td>
				        <td>			        
			               <input type="text" placeholder="이메일" id="mem_email" name="mem_email" value="${memberInfo.mem_email}">				          
				        </td>
			    	</tr>
			    	<tr>
			        <td>			            
			                <div class="label-group">
			                    <label for="mem_addr">주소</label>
			                </div>
			        </td>
			        <td style="display:flex;">
			                <div class="input-group" style="margin-right: 5px;">
			                    <input type="text" id="zipcode" name="address_zipcode" placeholder="우편번호" value="${memberInfo.zipcode}" style="width: 100px;">
			                </div>
			                 <input type="button" value="주소 검색" onclick="execDaumPostcode()"style="width:120px;">
			        </td> 
			        <td>  
			           
			        </td>
			    </tr>
			    <tr>
			    	<td></td>
			        <td>
			            		              
			                <div class="input-group" style="margin-bottom: 3px;">
			                    <input type="text" id="roadAddress" name="radAddress" size="200" placeholder="도로명 주소" value="${memberInfo.roadAddress}" >
			                </div>
			          
			        </td>
			    </tr>
			    <tr>
			    	<td></td>
			        <td>
			           
			                <div class="input-group" style="margin-bottom: 3px;">
			                    <input type="text" id="jibunAddress" name="jibunAddress" size="200" placeholder="지번 주소" value="${memberInfo.jibunAddress}">
			                </div>
			          
			        </td>
			    </tr>
			    <tr>
			    	<td></td>
			        <td>			           
			                <div class="input-group">
			                    <input type="text" id="namujiAddress" name="namujiAddress" size="200" placeholder="나머지 주소" value="${memberInfo.namujiAddress}">
			                </div>			         
			        </td>
			    </tr>
			</table>
			<div class="button">
				<button class="modifybutton" type="button" onclick="fn_mod_member()">수정</button>
			</div>
			</form>
		</div>
	</div>
	
<script>

	function fn_mod_member(){
	    var frm_mod_member = document.frm_mod_member;
	    
	    // 각 속성의 값을 바로 가져와서 변수에 설정
	    var mem_pw = frm_mod_member.mem_pw.value;
	    var mem_tel1 = frm_mod_member.mem_tel1.value;
	    var mem_tel2 = frm_mod_member.mem_tel2.value;
	    var mem_tel3 = frm_mod_member.mem_tel3.value;
	    var mem_email = frm_mod_member.mem_email.value;
	    var zipcode = frm_mod_member.zipcode.value;
	    var roadAddress = frm_mod_member.roadAddress.value;
	    var jibunAddress = frm_mod_member.jibunAddress.value;
	    var namujiAddress = frm_mod_member.namujiAddress.value;
	 	
	    // 비밀번호 입력 칸이 비어 있는지 확인
	    if (mem_pw === '') {
	        alert('비밀번호를 입력해주세요.');
	        return;
	    }
	      
	    // value 변수에 모든 값을 하나의 문자열로 합침
	    var value = mem_pw + "," + mem_tel1 + "," + mem_tel2 + "," + mem_tel3 + "," + zipcode + "," + roadAddress + "," + jibunAddress + "," + namujiAddress + "," + mem_email;

	    console.log(value);
		
		$.ajax({
			type : "post",
			async : false, //false인 경우 동기식으로 처리한다.
			url : "${contextPath}/mypage/modifyMyInfo.do",
			data : {
				value : value
			},
			success : function(data, textStatus) {
				if (data.trim() === 'mod_success') {
					alert("회원 정보를 수정했습니다.");
				} else if (data.trim() === 'failed') {
					alert("다시 시도해 주세요.");
				}
			},
			error : function(data, textStatus) {
				console.log(data, textStatus);
				alert("에러가 발생했습니다." + data);
			},
			complete : function(data, textStatus) {
				console.log(data, textStatus);
				alert("작업을 완료 했습니다");
			}
		});
	}

	//주소 스크립트
	function execDaumPostcode() {
	  new daum.Postcode({
	    oncomplete: function(data) {
	      // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	      // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
	      // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	      var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
	      var extraRoadAddr = ''; // 도로명 조합형 주소 변수
	
	      // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	      // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	      if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	        extraRoadAddr += data.bname;
	      }
	      // 건물명이 있고, 공동주택일 경우 추가한다.
	      if(data.buildingName !== '' && data.apartment === 'Y'){
	        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	      }
	      // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	      if(extraRoadAddr !== ''){
	        extraRoadAddr = ' (' + extraRoadAddr + ')';
	      }
	      // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
	      if(fullRoadAddr !== ''){
	        fullRoadAddr += extraRoadAddr;
	      }
	
	      // 우편번호와 주소 정보를 해당 필드에 넣는다.
	      document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
	      document.getElementById('roadAddress').value = fullRoadAddr;
	      document.getElementById('jibunAddress').value = data.jibunAddress;
	
	      // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
	      if(data.autoRoadAddress) {
	        //예상되는 도로명 주소에 조합형 주소를 추가한다.
	        var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
	        document.getElementById('roadAddress').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
	
	      } else if(data.autoJibunAddress) {
	          var expJibunAddr = data.autoJibunAddress;
	          document.getElementById('jibunAddress').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
	      } 
	      window.close();
	    }
	  }).open();
	}
	

	
</script>

</body>
</html>