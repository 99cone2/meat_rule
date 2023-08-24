<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* Style the buttons that are used to open the tab content */
	.tab button {
		background-color: inherit;
		border: none;
		outline: none;
		cursor: pointer;
		padding: 14px 16px;
		transition: 0.3s;
	}
	
	/* Change background color of buttons on hover */
	.tab button:hover {
		text-decoration: underline;
	}
	
	/* Create an active/current tablink class */
	.tab button.active {
		color: black;
		text-decoration: underline;
	}
	
	/* Style the tab content */
	.tabcontent {
		display: none;
		padding: 6px 12px;
		text-align: center;
	}
	.tab{
	    display: flex;
	    justify-content: flex-start;
	    text-align: center;
	    height: 100px;
	   
	}
	.tab .tablinks{
	height: 100px;
	font-weight: 700;
	font-size: 20px;
	color: #909090;
	}
	.tab-menu{
	font-family: 'Noto Sans KR', sans-serif;
	}
	h1 {
	text-align: center;
	margin-top: 50px;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 700;
	font-size: 30px;
	margin-bottom: 20px;
}
.container2{
    width: 1200px;
    margin: 0 auto; /* Added margin to center the form */
   
  }
  .title{
  font-family: 'Noto Sans KR', sans-serif;
  text-align: center;
  margin-top: 30px;
  font-size: 30px;
  font-weight: 700;
  }
  table{  
   border-collapse: separate;
   margin:0 auto;
   width: 100%;
   margin-bottom: 40px;
   }
   
   th{border-bottom:1px solid #1D1D1D ;
   border-top: 1px solid #1D1D1D;
   align-content: center;
  }
  tr{
   height: 40px;
  
  }
</style>
</head>
<body>


		
<div class="container2">
	<div class="title">내가 남긴 글</div>

		<!--내가 남긴 글 탭 메뉴  -->
		<div class="tab-menu">
			<!-- Tab 이름 -->
			<div class="tab">
				<button class="tablinks" onclick="deliveryOpen(event, 'myReview')">상품 리뷰</button>
				<button class="tablinks" onclick="deliveryOpen(event, 'myInquiry')">1:1 문의</button>
			</div>
					
				<!-- 내가 쓴 리뷰  -->
				<div id="myReview" class="tabcontent">
				    <table style="width:100%;">
				        <tr style="font-size: 15px; background: #FAFBFC; color:black; ">
				            <th style="width: 5%;text-align: center;">번호</th>
				            <th style="width: 20%;text-align: center;">구매한 상품</th>
				            <th style="width: 40%;text-align: center;">리뷰 내용</th>
				            <th style="width: 15%;text-align: center;">리뷰 작성일</th>
				            <th style="width: 10%;text-align: center;">삭제</th>
				        </tr>
				        <c:choose>
				            <c:when test="${empty reviewVO }">
				                <tr>
				                    <td colspan="5" class="fixed"><strong style="margin-top: 5px;">작성한 리뷰가 없습니다.</strong></td>
				                </tr>
				            </c:when>
				
				            <c:otherwise>
				                <c:forEach var="item" items="${reviewVO}" varStatus="cnt">
				                    <tr>
				                        <td>${cnt.index + 1}</td>
				                        <td class="goodsName" style="text-align: center; ">
				                            <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}" style="font-weight: 500; color: black;">해당 상품으로 이동</a>
				                        </td>
				                        <td style="text-align: left;">${item.rev_content}</td>
				                        <fmt:formatDate value="${item.rev_date}" pattern="yy/MM/dd HH:mm" var="rev_date" />
				                        <td>${rev_date}</td>
				                        <td><button onclick="reviewDelete(${item.rev_no});">삭제</button></td>
				                    </tr>
				                </c:forEach>
				            </c:otherwise>
				        </c:choose>
				    </table>
				</div>
				
				
				<!-- 내가 쓴 1:1 문의  -->
				<div id="myInquiry" class="tabcontent">
				
				  <table style="width:100%;">
				        <tr style="font-size: 15px; background: #FAFBFC; color:black; ">
				            <th style="width: 20%;text-align: center;">번호</th>				
				            <th style="width: 50%"text-align: center;">문의 내역</th>
				            <th style="text-align: center;">작성일</th>
				        </tr>
				        <c:choose>
				            <c:when test="${empty servVO }">
				                <tr>
				                    <td colspan="3" class="fixed"><strong style="margin-top: 5px;">작성한 문의글이 없습니다.</strong></td>
				                </tr>
				            </c:when>
				
				            <c:otherwise>
				                <c:forEach var="item" items="${servVO}" varStatus="cnt">
				                    <tr>
				                        <td>${cnt.index + 1}</td>
				                        <td class="goodsName" style="text-align: left; ">				                 
				                            <a href="${contextPath}/serv/read.do?cust_serv_no=${item.cust_serv_no}" style="font-weight: 500; color: black;">${item.cust_serv_title}</a>
				                        </td>
				                        <fmt:formatDate value="${item.cust_serv_date}" pattern="yy/MM/dd HH:mm" var="serv_date" />
				                        <td>${serv_date}</td>
				                      
				                    </tr>
				                </c:forEach>
				            </c:otherwise>
				        </c:choose>
				    </table>
				</div>
		</div>
	
</div>	


<!--Tab 관련  -->
		<script type="text/javascript">
			// 페이지 로드 시 상품설명 탭이 기본으로 선택되도록 설정
			  document.addEventListener("DOMContentLoaded", function() {
			    // "상품설명" 탭 버튼을 선택
			    var defaultTabButton = document.querySelector(".tablinks");
			    defaultTabButton.click(); // 프로그래밍 방식으로 클릭 이벤트 발생
			  });
	
			function deliveryOpen(evt, deliveryName) {
				var i, tabcontent, tablinks;
	
				// Get all elements with class="tabcontent" and hide them
				tabcontent = document.getElementsByClassName("tabcontent");
				for (i = 0; i < tabcontent.length; i++) {
					tabcontent[i].style.display = "none";
				}
	
				// Get all elements with class="tablinks" and remove the class "active"
				tablinks = document.getElementsByClassName("tablinks");
				for (i = 0; i < tablinks.length; i++) {
					tablinks[i].className = tablinks[i].className.replace(
							" active", "");
				}
	
				// Show the current tab, and add an "active" class to the button that opened the tab
				document.getElementById(deliveryName).style.display = "block";
				evt.currentTarget.className += " active";
			}
			
			 function reviewDelete(rev_no) {
			        // 작성한 리뷰를 삭제할 것인지 확인하는 알림창
			        var result = confirm("작성한 리뷰를 삭제하시겠습니까?");
			        
			        // 확인을 눌렀을 경우 리뷰를 삭제하는 로직 수행
			        if (result) {
			            var contextPath = "${contextPath}";
			            var deleteURL = contextPath + "/mypage/myReivewDelete.do?rev_no=" + rev_no;
			            
			            // 해당 URL로 이동하여 리뷰 삭제
			            window.location.href = deleteURL;
			        }
			    }
		</script>
</body>
</html>