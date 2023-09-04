<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
.form{
margin: 0;
width:1000px;
}
.btn-group-sm>.btn, .btn-sm {
    padding: 5px 10px;
    font-size: 14px;
    line-height: 1.5;
    border-radius: 3px;
    background: black;
    width:70px;
}
.frm_mod_mem_detail{
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
  border: 1px solid #E8E8E8;
  margin-top: 40px;
  margin-bottom: 40px;  
}

.tab_content{
  width: 1000px;
  padding:30px;

  margin: 0 auto; 
  font-family: 'Noto Sans KR', sans-serif;
  border: 1px solid #E8E8E8;
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
  border: 1px solid #E8E8E8;
  margin-bottom: 40px;  
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
 
</style>
</head>

<body>
	<div class="title_underline" style="margin-top: 50px; margin-left: 780px">
			<h3><b>내 상세정보</b></h3>
	</div>
	
	<form name="frm_mod_member" style="align: center; margin-left: 500px; margin-bottom: 40px;">	
	<div id="frm_mod_tab">
		<table>
			<tbody>
				<tr class="dot_line">
					<td class="fixed_join">아이디</td>
					<td>
						<input name="mem_id" type="text" size="20" value="${member_info.mem_id}"  disabled/>
					</td>
					 <td>
					  <input type="button" value="수정" class="btn btn-secondary btn-sm" disabled onClick="fn_modify_member_info('${member_info.mem_id }','mem_id')" />
					</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">비밀번호</td>
					<td>
					  <input name="mem_pw" type="password" size="20" value="${member_info.mem_pw}" />
					</td>
					<td>
					  <input type="button" value="수정" class="btn btn-secondary btn-sm" onClick="fn_modify_member_info('${member_info.mem_pw }','mem_pw')" />
					</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">이름</td>
					<td>
					  <input name="mem_name" type="text" size="20" value="${member_info.mem_name}"  disabled />
					 </td>
					 <td>
					  <input type="button" value="수정" class="btn btn-secondary btn-sm" disabled onClick="fn_modify_member_info('${member_info.mem_name }','mem_name')" />
					</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">법정생년월일</td>
					<td>
					   <select name="mem_birth_y">
					     <c:forEach var="i" begin="1" end="100">
					       <c:choose>
					         <c:when test="${member_info.mem_birth_y==1920+i }">
							   <option value="${ 1920+i}" selected>${ 1920+i} </option>
							</c:when>
							<c:otherwise>
							  <option value="${ 1920+i}" >${ 1920+i} </option>
							</c:otherwise>
							</c:choose>
					   	</c:forEach>
					</select>년 
					<select name="mem_birth_m" >
						<c:forEach var="i" begin="1" end="12">
					       <c:choose>
					         <c:when test="${member_info.mem_birth_m==i }">
							   <option value="${i }" selected>${i }</option>
							</c:when>
							<c:otherwise>
							  <option value="${i }">${i }</option>
							</c:otherwise>
							</c:choose>
					   	</c:forEach>
					</select>월 
					
					<select name="mem_birth_d">
							<c:forEach var="i" begin="1" end="31">
					       <c:choose>
					         <c:when test="${member_info.mem_birth_d==i }">
							   <option value="${i }" selected>${i }</option>
							</c:when>
							<c:otherwise>
							  <option value="${i }">${i }</option>
							</c:otherwise>
							</c:choose>
					   	</c:forEach>
					</select>일 
					</td>
					<td>
					  <input type="button" value="수정" class="btn btn-secondary btn-sm" onClick="fn_modify_member_info('${member_info.mem_id }','mem_birth')" />
					</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join" >전화번호</td>
					<td>
						  <input type="text" size=4  name="mem_tel1" value="${member_info.mem_tel1 }">	
					    - <input type="text" size=4  name="mem_tel2" value="${member_info.mem_tel2 }"> 
					    - <input type="text" size=4  name="mem_tel3" value="${member_info.mem_tel3 }">
					</td>
					<td>
					  <input type="button" value="수정" class="btn btn-secondary btn-sm" 
					  onClick="fn_modify_member_info('${member_info.mem_tel1 }','mem_tel1','${member_info.mem_tel2 }','mem_tel2','${member_info.mem_tel3 }','mem_tel3')" />
					</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">이메일(e-mail)</td>
					<td>
					   <input type="text" name="mem_email" size=20
					   	value="${member_info.mem_email}" />
					</td>
					<td>
					  <input type="button" value="수정" class="btn btn-secondary btn-sm" onClick="fn_modify_member_info('${member_info.mem_email}','mem_email')" />
					</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">주소</td>
					<td>
					   <input type="text" id="zipcode" name="zipcode" size=5 value="${member_info.zipcode }" > <a href="javascript:execDaumPostcode()">우편번호검색</a>
					  <br>
					  <p> 
					   지번 주소: <input type="text" id="roadAddress"  name="roadAddress" size="50" value="${member_info.roadAddress }" style="margin-left: 13px;"><br><br>
					  도로명 주소: <input type="text" id="jibunAddress" name="jibunAddress" size="50" value="${member_info.jibunAddress }"><br><br>
					  나머지 주소: <input type="text"  name="namujiAddress" size="50" value="${member_info.namujiAddress }" />
					   <span id="guide" style="color:#999"></span>
					   </p>
					</td>
					<td>
					  <input type="button" value="수정" class="btn btn-secondary btn-sm" onClick="fn_modify_member_info('${member_info.zipcode }','zipcode')" />
					</td>
				</tr>
				<tr style="text-align: right;">
					<td colspan="3">
						<input type="hidden" name="command" value="modify_my_info" /> 
						 <c:choose>
						  <c:when test="${member_info.mem_del_yn=='Y' }">
						    <input  type="button"  value="회원복원" onClick="fn_delete_member('${member_info.mem_del_yn }','N')">
						  </c:when>
						  <c:when test="${member_info.mem_del_yn=='N' }">
						    <input type="button" style="background:#D24826;" value="회원탈퇴" class="btn btn-secondary btn-sm" onClick="fn_delete_member('${member_info.mem_del_yn }','Y')">
						  </c:when>	  
						</c:choose>
						<input  type="button"  value="회원삭제" class="btn btn-secondary btn-sm" onClick="fn_delete_member('${member_info.mem_del_yn }'), backToList(this.form)">
					</td>
				</tr>
			</tbody>
		</table>
		</div>
</form>	

<c:choose>
<c:when test='${modified_personal_info==true }'>
<script>
window.onload=function()
{
  test();
}

function test(){
	init();
	alert("회원 정보가 수정되었습니다.");
}
function init(){
	var frm_mod_member=document.frm_mod_member;
	var mem_tel1=frm_mod_member.mem_tel1;
	var mem_tel1=mem_tel1.value;
	var mem_tel2=frm_mod_member.mem_tel2;
	var mem_tel2=mem_tel2.value;
	var mem_tel3=frm_mod_member.mem_tel3;
	var mem_tel3=mem_tel3.value;
	
	var select_tel1=frm_mod_member.mem_tel1;
	select_tel1.value=mem_tel1;
	var select_tel2=frm_mod_member.mem_tel2;
	select_tel2.value=mem_tel2;
	var select_tel3=frm_mod_member.mem_tel3;
	select_tel3.value=mem_tel3;
}

</script>
</c:when>
<c:otherwise>
<script>
window.onload=function()
{
  test();
}

function test(){
	init();
	//alert("회원 정보가 수정되었습니다.");
//	init();
}
function init(){
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
/*     var mem_del_yn = frm_mod_member.mem_del_yn.value; */
}

</script>
</c:otherwise>
</c:choose>
<script>
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
                    document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

                } else {
                    document.getElementById('guide').innerHTML = '';
                }
            }
        }).open();
    }
</script>
<script>
    function fn_modify_member_info(mem_id, mod_type) {
        var value;

        if (mod_type === 'mem_pw') {
            value = frm_mod_member.mem_pw.value;

        } else if (mod_type === 'mem_birth') {
            var mem_birth_y = frm_mod_member.mem_birth_y.value;
            var mem_birth_m = frm_mod_member.mem_birth_m.value;
            var mem_birth_d = frm_mod_member.mem_birth_d.value;
            value = mem_birth_y + "," + mem_birth_m + "," + mem_birth_d;

        } else if (mod_type === 'mem_tel') {
            var mem_tel1 = frm_mod_member.mem_tel1.value;
            var mem_tel2 = frm_mod_member.mem_tel2.value;
            var mem_tel3 = frm_mod_member.mem_tel3.value;
            value = mem_tel1 + "," + mem_tel2 + "," + mem_tel3;

        } else if (mod_type === 'mem_email') {
            value = frm_mod_member.mem_email.value;

        } else if (mod_type === 'address') {
            var zipcode = frm_mod_member.zipcode.value;
            var roadAddress = frm_mod_member.roadAddress.value;
            var jibunAddress = frm_mod_member.jibunAddress.value;
            var namujiAddress = frm_mod_member.namujiAddress.value;
            value = zipcode + "," + roadAddress + "," + jibunAddress + "," + namujiAddress;
        }
	 
	    $.ajax({
	        type : "post",
	        async : false,
	        url : "${contextPath}/admin/member/modifyMemberInfo.do", // 수정된 URL로 변경
	        data : {
	            mem_id: mem_id,
	            mod_type: mod_type,
	            value: value
	        },
	        success : function(data, textStatus) {
	            if (data.trim() == 'mod_success') {
	                alert("회원 정보를 수정했습니다.");
	            } else if (data.trim() == 'failed') {
	                alert("다시 시도해 주세요.");
	            }
	        },
	        error : function(data, textStatus) {
	            alert("에러가 발생했습니다." + data);
	        },
	        complete : function(data, textStatus) {
	            // 작업을 완료 했습니다
	        }
	    }); // end ajax
}

//멤버 삭제
function fn_delete_member(mem_id){
  	$.ajax({
		type : "post",
		async : true, //false인 경우 동기식으로 처리한다.
		url : "${contextPath}/admin/member/deleteMember.do",
		data: {mem_id:mem_id},
		success : function(data, textStatus) {
			alert("회원 삭제가 완료되었습니다");
            tr.style.display = 'none';
		},
		error : function(data, textStatus) {
			alert("에러가 발생했습니다."+textStatus);
		},
		complete : function(data, textStatus) {
			alert("작업을완료 했습니다");
		}
	}); //end ajax	
}

function backToList(obj) {
	obj.action = "${contextPath}/admin/member/adminMemberMain.do";
	obj.submit();
}

</script>
</body>
</html>