<%@ page import="java.util.*,java.io.*"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<sec:csrfMetaTags />
<title>Mobile Navigation</title>

<style>
/* ✅ 기본 세팅 */
body {
	margin: 0;
	padding: 0;
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #fff;
	color: #333;
}

a {
	text-decoration: none;
	color: inherit;
}

/* ✅ 전체 래퍼 */
#header_wrapper {
	width: 100%;
	border-bottom: 1px solid #eee;
	background-color: #fff;
}

/* ✅ 상단 로그인/로그아웃 영역 */
.header_top {
	display: flex;
	justify-content: flex-end;
	align-items: center;
	padding: 8px 12px;
	font-size: 13px;
	color: #666;
	background-color: #fafafa;
}

.header_top a, 
.header_top button {
	color: #555;
	font-size: 13px;
}

.header_top button {
	background: none;
	border: none;
	cursor: pointer;
	padding: 0;
	font-family: inherit;
}

/* ✅ 하단 메뉴 영역 */
.header_bottom {
	display: flex;
	justify-content: space-around;
	align-items: center;
	padding: 10px 0;
	background-color: #fff;
	border-top: 1px solid #eee;
}

.header_bottom a {
	font-size: 15px;
	font-weight: 600;
	color: #333;
	text-align: center;
	flex: 1;
}

/* ✅ 글쓰기 버튼 */
.write-btn {
	background-color: #ff7a00;
	color: #fff;
	border: none;
	padding: 8px 14px;
	font-size: 14px;
	font-weight: 600;
	border-radius: 18px;
	cursor: pointer;
	transition: 0.2s;
}

.write-btn:hover {
	background-color: #e56c00;
}

/* ✅ 반응형 (작은 화면에 맞춤) */
@media screen and (max-width: 480px) {
	.header_top {
		font-size: 12px;
		padding: 6px 10px;
	}
	.header_bottom a {
		font-size: 14px;
	}
	.write-btn {
		padding: 6px 12px;
		font-size: 13px;
	}
}
</style>

<script>
$(document).ready(function() {
	const token = $("meta[name='_csrf']").attr("content");
	const header = $("meta[name='_csrf_header']").attr("content");

	$.ajaxSetup({
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		}
	});
});
</script>

</head>
<body>

<div id="header_wrapper">

	<!-- ✅ 로그인/로그아웃 -->
	<div class="header_top">
		<sec:authorize access="hasAuthority('user')">
			<a href="${pageContext.request.contextPath}/users/mypage">나의정보</a>&nbsp;|&nbsp;
			<a href="${pageContext.request.contextPath}/users/generalcartlist">장바구니</a>&nbsp;|&nbsp;
			<a href="${pageContext.request.contextPath}/users/payinfo">결제현황</a>&nbsp;|&nbsp;
			<a href="${pageContext.request.contextPath}/users/get-my-reserve-page">예약현황</a>&nbsp;|&nbsp;
			<form id="logoutForm" action="${pageContext.request.contextPath}/users/logout" method="POST" style="display:inline;">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<button type="submit">로그아웃</button>
			</form>
		</sec:authorize>

		<sec:authorize access="hasRole('ROLE_TEACHER')">
			<a href="${pageContext.request.contextPath}/teacher/teacher-my-info">나의정보</a>&nbsp;|&nbsp;
			<form id="logoutForm" action="${pageContext.request.contextPath}/users/logout" method="POST" style="display:inline;">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<button type="submit">로그아웃</button>
			</form>
		</sec:authorize>

		<sec:authorize access="!isAuthenticated()">
			<a href="${pageContext.request.contextPath}/guest/login">로그인/가입</a>
		</sec:authorize>
	</div>

	<!-- ✅ 메뉴 + 글쓰기 버튼 -->
	<div class="header_bottom">
		<a href="${pageContext.request.contextPath}/guest/productlist">미술용품</a>
		<a href="${pageContext.request.contextPath}/guest/get-onedayclass-detail-one-page">미술수업</a>
		<a href="${pageContext.request.contextPath}/guest/communityPage">커뮤니티</a>

		<sec:authorize access="!isAuthenticated()">
			<button class="write-btn" onclick="window.location.href='${pageContext.request.contextPath}/guest/login'">글쓰기</button>
		</sec:authorize>

		<sec:authorize access="isAuthenticated()">
			<button class="write-btn" onclick="window.location.href='${pageContext.request.contextPath}/users/get-free-write-gasigle'">글쓰기</button>
		</sec:authorize>
	</div>
</div>

</body>
</html>
