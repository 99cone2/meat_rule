<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="imageFileList"  value="${servMap.imageFileList}"  />
<c:set var="servRead"  value="${servMap.servVO}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 조회</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link href="${contextPath}/resources/css/noticeRead.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
   .board_coment {
      width: 1100px;
      font-size: 1.1em;
	font-family: 'Noto Sans KR', sans-serif;
   }
   .cmt_btn {
      width: 60px;
       height: 40px;
       font-size: 15px;
       font-weight: bold;
       background: #D24826;
       border-radius: 5px;
       border: 0px;
       color: #fff;
   }
   .cmt_date {

      font-weight: normal;
      font-size: 0.8em;
   }
   .nonono {
      width: 900px;
      text-align: center;
      font-size: 15px;
      margin: 10px 0px;
   }
   
       /* 기본적으로 폼을 숨김 */
    .replyFormContainer {
        display: none;
    }
    /* .showing 클래스를 가지면 폼을 보이도록 변경 */
    .replyFormContainer.showing {
        display: block;
    }
    .reply-form{
    margin-left: 28px;
    margin-top: 5px;
    }
</style>
</head>
<body>

	<h1>상세보기</h1>
	<div role="main" class="container2">
		<div class="row row1">
			<table class="table" style="margin-bottom: 0px;">
				<tr>
					<th width=15% class="text-center fg lb fw">작성자</th>
					<td width=35% class="fgl" style="text-align: center;">${servRead.mem_id}</td>
					<th width=15% class="text-center lb fg fw">조회수</th>
					<td width=35% class="fgl bbu" style="text-align: center;">${servRead.cust_serv_hits}</td>
				</tr>
				<tr>
					<th width=15% class="text-center lb fg fw">제목</th>
					<td colspan="2" class="fgl">${servRead.cust_serv_title}</td>
					 
				</tr>
				<tr>
					<th width=15% class="text-center lb fg fw" style="vertical-align: middle;">문의 내역</th>
					<td colspan="4" class="text-left fg" valign="top" height="200">
					<pre class="fgl" style="white-space: pre-wrap; border: none; background-color: white;"> ${servRead.cust_serv_content}</pre>
					</td>
				</tr>
				<c:if test="${not empty imageFileList && imageFileList!='null' }">
					<c:forEach var="item" items="${imageFileList}">
						<tr>
						<th width=15% class="text-center lb fg fw" style="vertical-align: middle;">첨부 파일</th>
						<td colspan="4" class="result-images">						
							<img width=300 src="${contextPath}/thumbnails2.do?img_name=${item.img_name}&cust_serv_no=${item.cust_serv_no}" >						
						</td>
						</tr>
					</c:forEach>
				</c:if>
			
				
				<!-- 수정, 삭제, 목록 버튼 -->
				<tr>
					<td colspan="4" class="text-right">
						<div class="button-container" style="margin-top: 20px; margin-bottom: 20px;">
							<c:if test="${servRead.mem_id eq mem_id}">
							<a class="atw" href="${contextPath}/serv/modify.do?cust_serv_no=${servRead.cust_serv_no}">					
								<button type="submit" class="bbtn btn-sm btn-primary greylist">수정</button>
							</a>
							</c:if>
							<c:if test="${servRead.mem_id eq mem_id || mem_id eq 'admin'}">
							<a class="atw" href="${contextPath}/serv/delete.do?cust_serv_no=${servRead.cust_serv_no}">
								<button type="submit" class="btn btn-sm btn-primary greylist" style="height: 40px;">삭제</button>
							</a>
							</c:if>
							<a class="atw" href="${contextPath}/serv/list.do">
								<button type="button" class="btn btn-sm btn-primary greylist" style="height: 40px;">목록</button>
							</a>
						</div>
					</td>
				</tr>
			</table>
			
		<!-- 댓글 목록과 대댓글 작성 폼 영역 -->
        <div class="board_coment">  
            <!-- 댓글 등록 폼 -->
            <form id="commentForm" name="commentForm" method="post" ">
                <br><br>
                <div>
                    <div style="margin-bottom: 10px;">
                       <img src="${contextPath}/resources/images/serv/reply.png" width="20px" alt="new" style="margin-right: 5px;"/><span style="font-size: 15px;"><strong>댓글 </strong></span><span id="cCnt"></span>
                    </div>
                    <div>
                        <table class="table">                    
                            <tr>
                                <td>
                                    <input type="text" style="width: 1015px; height: 40px;margin-top: 10px;margin-right: 3px;"  id="cmt_content" name="cmt_content" placeholder="댓글을 입력하세요">
                                    <a href='#' onClick="fn_comment('${servRead.cust_serv_no }')"><input type="button" value="등록" class="cmt_btn"></a>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div> 
                <input type="hidden" id="cust_serv_no" name="cust_serv_no" value="${servRead.cust_serv_no}" />        
            </form> 

            <!-- 댓글 목록 표시 -->
			<div id="CommentList">
			    <c:if test="data.length > 0">
				    <c:forEach var="item" items="data">
				        <div>
				            <div class="cmt">
				                <table id="mem_id">
				                 <tr>
				                 <td>
				                 <h2 style="margin-bottom: 10px;"><strong>${item.mem_id}<span class="cmt_date">${item.cmt_date}</span></strong></h2>
				                 <div>${item.cmt_content}</div>			                   
				                 </td>
				                 </tr>
				                <tr>
				                  <td> 
				                    <%-- <a href="#" class="reply-button" data-cmtid="${item.cmt_number}" data-memid="${item.mem_id}">답글 달기</a>  --%>
				                    <!-- 여기에서 대댓글 작성 폼을 추가하기 위해 replyFormContainer를 클래스로 변경 -->
				                    <div class="replyFormContainer"></div>
				                  </td>
				                 <tr>
				                </table>
				            </div>
				        </div>
				    </c:forEach>
				</c:if>
			</div>
			
        </div>
    </div>
  </div>
<script>  
    function fn_comment(cust_serv_no) {
        var cmt_content = $("#cmt_content").val();
        if (cmt_content === null || cmt_content.trim() === "") {
            alert("댓글 내용을 입력해주세요.");
        } else {
        	var userLoggedIn = "<c:out value='${sessionScope.memberInfo != null}' />";
        	if (userLoggedIn === "true") {
            $.ajax({
                type: 'POST',
                url: "<c:url value='/serv/addComment.do'/>",
                data: $("#commentForm").serialize(),
                success: function (data) {
                    if (data !== "failure") {
                        alert("댓글을 등록했습니다.");

                        // 서버로부터 받아온 댓글의 글번호를 사용하여 대댓글 작성 폼 호출
                        var commentId = parseInt(data);
                        alert("댓글 글번호"+commentId);
                        showReplyForm(commentId, '', null); // 댓글의 글번호를 인자로 전달

                        getCommentList(); // 댓글 등록 후 댓글 리스트 갱신
                        $("#cmt_content").val(""); // 댓글 작성 폼 초기화
                    } else {
                        alert("댓글 등록에 실패했습니다.");
                    }
                },
                error: function (request, status, error) {
                    alert("댓글 등록에 실패했습니다.");
                }
            });
        	}else{
        		alert("댓글을 등록하려면 로그인이 필요합니다.")
        		window.location.href = "${contextPath}/member/loginForm.do"; // 로그인 페이지로 이동
        	}
        }
    }

    // 초기 페이지 로딩시 댓글 불러오기
    $(function () {
        getCommentList();
    });

 // 댓글 목록 표시 함수
	function showCommentList(data) {
	    var html = "";
	    var cCnt = data.length; 
	
	    if (data.length > 0) {
	        for (i = 0; i < data.length; i++) {
	            var indent = data[i].lvl * 40; // 들여쓰기 간격 40px씩 증가	            
	            html += "<div class='comment' style='margin-left: " + indent + "px;'>";
	            
	            // lvl이 1이 아닌 경우에만 댓글 화살표 이미지 태그 추가ㄹ
	            if (data[i].lvl !== 1) {
	                html += "<img src='${contextPath}/resources/images/serv/reply3.png' style='margin-right:5px;width:20px;' />";
	            }
	            
	            html += "<img src='${contextPath}/resources/images/serv/writer.png' style='margin-right:5px;width:20px;' /><strong style='font-size:18px;'>" + data[i].mem_id + "</strong><div class='cmt' style='margin-bottom: 5px;'><table id='mem_id'>";
	            html += "<strong><span class='cmt_date' style='float:right;' align='right'>" + formatDate(data[i].cmt_date) + "</span></strong>";
	            html += "<div style='padding-left:25px;margin-top:7px;'>"+data[i].cmt_content+"</div>";
	            html += "<div style='margin-top:10px;padding-left:25px;'><img src='${contextPath}/resources/images/serv/reply2.png' style='margin-right:2px;width:20px;' /><a href='#' class='reply-button' data-cmtid='" + data[i].cmt_number + "' data-memid='" + data[i].mem_id + "'><span style='font-size:14px;color:#9A9A9A;'>댓글달기</span></a></div>";
	            html += "<div class='replyFormContainer'></div><hr>";
	            html += "</table></div>";
	            html += "</div>";
	        }
	    } else {
	        html += "<div>";
	        html += "<div class='nonono'><table><div style='padding-right:140px; margin-bottom:30px;'><strong>등록된 댓글이 없습니다.</strong></div>";
	        html += "</table></div>";
	        html += "</div>";
	    }
	
	    $("#cCnt").html(cCnt);
	    $("#CommentList").html(html);
	}
 

 // 날짜를 연월일 형식(yyyy-mm-dd)으로 변환하는 함수
    function formatDate(dateString) {
      var months = {
        Jan: '01', Feb: '02', Mar: '03', Apr: '04', May: '05', Jun: '06',
        Jul: '07', Aug: '08', Sep: '09', Oct: '10', Nov: '11', Dec: '12'
      };

      var dateParts = dateString.split(' ');
      if (dateParts.length !== 6) {
        return "Invalid Date";
      }

      var year = dateParts[5];
      var month = months[dateParts[1]];
      var day = dateParts[2];

      return year + '-' + month + '-' + day;
    }
      

    // 초기 페이지 로딩시 댓글 불러오기
    $(function () {
        getCommentList();
    });

    // 댓글 불러오기(AJAX)
    function getCommentList() {
        $.ajax({
            type: 'GET',
            url: "${contextPath}/serv/commentList.do",
            dataType: "json",
            data: { cust_serv_no: ${servRead.cust_serv_no}}, // 현재 게시물의 cust_serv_no를 파라미터로 전달
            success: function (data) {
                showCommentList(data); // 댓글 목록을 표시하는 함수 호출
            },
            error: function (request, status, error) {
                alert("댓글 불러오기에 실패했습니다.");
            }
        });
    }
    
    
    $(document).on("click", ".reply-button", function (event) {
        event.preventDefault(); // 기본 동작 막기

        // 클릭된 "답글 달기" 버튼이 속한 댓글에 대한 정보 가져오기
        var parentCommentId = $(this).attr("data-cmtid");
        
        alert("parentCommentId:"+parentCommentId);
        var parentCommentAuthor = $(this).attr("data-memid");
        alert("parentCommentAuthor 글쓴이:"+parentCommentAuthor);
        // 대댓글 작성 폼 토글
        showReplyForm(parentCommentId, parentCommentAuthor, this);
    });

    function showReplyForm(parentCommentId, parentCommentAuthor, button) {
        var replyFormHtml = '<div class="reply-form">' +
            '<table style="width:100%;">' +
            '<tr>' +
            '<td>' +
            '<input type="text" style="width: 92%; height: 40px;margin-right:3px;"  id="reply_content" name="cmt_content" placeholder="대댓글을 입력하세요">' +
            '<input type="hidden" id="parent_comment_id" name="cmt_parent_num" value="' + parentCommentId + '">' +
            '<input type="hidden" id="parent_comment_author" name="mem_id" value="' + parentCommentAuthor + '">' +
            '<input type="button" value="등록" class="cmt_btn" onClick="submitReplyForm(this, ' + parentCommentId + ', \'' + parentCommentAuthor + '\')">' +
            '</td>' +
            '</tr>' +
            '</table>' +
            '</div>';

        var replyFormContainer = $(button).closest('.cmt').find('.replyFormContainer');
        var isReplyFormVisible = replyFormContainer.hasClass('showing');
        if (isReplyFormVisible) {
            replyFormContainer.removeClass('showing').empty();
        } else {
            replyFormContainer.addClass('showing').html(replyFormHtml);
        }
    }

	
    function submitReplyForm(button) {
        var replyContent = $(button).closest('.reply-form').find("#reply_content").val();
        var parentCommentId = $(button).closest('.reply-form').find("#parent_comment_id").val();
        var parentCommentAuthor = $(button).closest('.reply-form').find("#parent_comment_author").val();
        //console.log("replyContent:"+replyContent);
        //console.log("parentCommentId:"+parentCommentId);
        //console.log("parentCommentAuthor:"+parentCommentAuthor);

        if (replyContent === null || replyContent.trim() === "") {
            alert("대댓글 내용을 입력해주세요.");
        } else {
        	var userLoggedIn = "<c:out value='${sessionScope.memberInfo != null}' />";
        	if (userLoggedIn === "true") {
            $.ajax({
                type: 'POST',
                url: "<c:url value='/serv/addReply.do'/>", // 대댓글 추가에 대한 실제 URL로 변경
                data: {
                    cust_serv_no: ${servRead.cust_serv_no},
                    cmt_parent_num: parentCommentId,
                    mem_id: parentCommentAuthor,
                    cmt_content: replyContent
                },
                success: function (data) {
                    if (data === "success") {
                        alert("대댓글을 등록했습니다.");
                        getCommentList(); // 대댓글 등록 후 댓글 목록을 새로고침하여 표시
                        $("#reply_content").val(""); // 대댓글 작성 폼 텍스트 영역을 초기화
                    }
                },
                error: function (request, status, error) {
                    alert("대댓글 등록에 실패했습니다.");
                }
            });
        	}else{
        		alert("댓글을 등록하려면 로그인이 필요합니다.")
        		window.location.href = "${contextPath}/member/loginForm.do"; // 로그인 페이지로 이동
        	}
        }
    }

		$(document).ready(function() {
			var userRole = '<c:out value="${sessionScope.memberInfo.mem_id}" />';
		    var isAdmin = userRole === 'admin';
		    
	        function toggleForm() {
	            if (isAdmin) {
	                $('.cmt-in, .cmt-out').addClass('hidden');
	            } else if (userRole) {
	                $('.cmt-in').removeClass('hidden');
	                $('.admin-comment-in').addClass('hidden');
	            } else {
	                $('.cmt-in, .cmt-out, .admin-comment-in').addClass('hidden');
	            }
	        }
	        toggleForm();
	    });
		
		$(document).on("click", ".editComment", function () {

		    const comment_id = $(this).siblings('mem_id').val();
		    const comment_text = $(this).siblings('.').children('h5').text();
		    const comment_writer = $(this).siblings('b').text();

		    $("#comment_id").val(comment_id);
		    $("#comment_text").val(comment_text);
		    $("#comment_writer").val(comment_writer);

		});
		</script>
	</body>
</html>