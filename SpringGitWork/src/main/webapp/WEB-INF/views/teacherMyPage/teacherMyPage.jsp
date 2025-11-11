<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<sec:csrfMetaTags />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<meta charset="UTF-8">
<title>내 정보 확인</title>

<style>
 html, body {
    height: 100%;
    margin: 0;
    font-family: 'Roboto', sans-serif;
}

#pageWrapper {
    display: flex;
    height: 100vh;
}

#sidebar {
    width: 240px;
    border-right: 1px solid #e0e0e0;
    overflow-y: auto;
}

#mainContent {
    flex: 1;
    padding: 24px;
    overflow-y: auto;
}

#contentHeader {
    padding: 20px 24px;
    background-color: #f5f7fa;
    border-left: 6px solid #4a90e2;
    border-radius: 4px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.08);
    margin-bottom: 20px;
}

#contentHeader h1 {
    margin: 0;
    font-size: 1.8em;
    font-weight: 700;
    color: #333;
}

#contentHeader .header-subtitle {
    margin: 6px 0 0 0;
    font-size: 0.95em;
    color: #666;
}


#contentBody {
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    min-height: 400px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.05);
}


/* 내정보 시작 */
.info-container {
	display: flex;
	flex-direction: column;
	width: 400px;
	margin: 40px auto;
	font-family: 'Arial', sans-serif;
	padding: 20px 30px;
}

.info-container h2 {
	margin-bottom: 20px;
	font-size: 1.5em;
	color: #333;
	border-bottom: 1px solid #eee;
	padding-bottom: 10px;
}

.info-row {
	display: flex;
	margin-bottom: 12px;
}

.info-row div:first-child {
	flex: 1;
	font-weight: bold;
	color: #555;
}

.info-row div:last-child {
	flex: 2;
	color: #333;
}
/* 내정보 종료 */
</style>

<script>
const contextPath="${pageContext.request.contextPath}";

window.onload = function(){	
	const token = $("meta[name='_csrf']").attr("content");
	const header = $("meta[name='_csrf_header']").attr("content");

	$.ajaxSetup({
	    beforeSend: function(xhr) {
	        xhr.setRequestHeader(header, token);
	    }
	});  

	getCurrentMyInfo();  
}

function getCurrentMyInfo(){
	$.ajax({
		url: contextPath + "/api/teacher/teacher-current-myinfo",
		type: "GET",
		success: function(res){
			// 받은 데이터 동적으로 채우기
			$('#userId').text(res.userId || '-');
			$('#name').text(res.name || '-');
			$('#email').text(res.email || '-');
			$('#phone').text(res.phone || '-');
			$('#approved').text(res.approved ? '승인' : '미승인');
			$('#created_at').text(res.created_at || '-');

			$('#company_name').text(res.company_name || '-');
			$('#registration_number').text(res.registration_number || '-');
			$('#representative_name').text(res.representative_name || '-');
			$('#company_phone').text(res.company_phone || '-');
			$('#company_email').text(res.email || '-');
		},
		error: function(err){
			console.error(err);
			alert("내정보를 불러오는 중 오류가 발생했습니다.");
		}
	});
}
</script>

</head>
<body>
	<div id="pageWrapper">
		<!-- 좌측 수직 메뉴 -->
		<div id="sidebar">
			<%@ include file="../compoents/teacherVerticalBar/teacherVerticalBar.jsp"%>
		</div>


		<!-- 우측 메인 콘텐츠 -->
		<div id="mainContent">
			<div id="contentHeader">
				<h1>정보 확인</h1>
				<p class="header-subtitle">등록된 회사 그리고 나의 정보를 확인</p>
			</div>
			<div id="contentBody">
				<div class="info-container">
					<h2>개인 정보</h2>
					<div class="info-row"><div>아이디</div><div id="userId"></div></div>
					<div class="info-row"><div>이름</div><div id="name"></div></div>
					<div class="info-row"><div>이메일</div><div id="email"></div></div>
					<div class="info-row"><div>전화번호</div><div id="phone"></div></div>
					<div class="info-row"><div>승인 상태</div><div id="approved"></div></div>
					<div class="info-row"><div>가입일</div><div id="created_at"></div></div>

					<h2 style="margin-top:30px;">사업자 정보</h2>
					<div class="info-row"><div>회사명</div><div id="company_name"></div></div>
					<div class="info-row"><div>사업자등록번호</div><div id="registration_number"></div></div>
					<div class="info-row"><div>대표자명</div><div id="representative_name"></div></div>
					<div class="info-row"><div>회사 전화</div><div id="company_phone"></div></div>
					<div class="info-row"><div>회사 이메일</div><div id="company_email"></div></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>