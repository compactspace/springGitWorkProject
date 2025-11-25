<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<sec:csrfMetaTags />
<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

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
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.08);
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
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
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

/* 우측 메인 영역 시작  */
.grid-2x2 {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	grid-gap: 20px;
}

/* 카드 기본 스타일 */
.summary-card {
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
	cursor: pointer;
	transition: all 0.2s ease-in-out;
	text-align: center;
}

/* 카드 hover 효과 */
.summary-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

/* 숫자 강조 */
.summary-number {
	font-size: 2em;
	font-weight: bold;
	margin-top: 10px;
}

.summary-row {
	display: flex;
	justify-content: space-between;
	margin: 10px 0;
}

/* 우측 메인 영역 종료  */
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


}


</script>

</head>
<body>
	<div id="pageWrapper">
		<!-- 좌측 수직 메뉴 -->
		<div id="sidebar">
			<%@ include file="../compoents/adminVerticalBar/adminVerticalBar.jsp"%>
		</div>
		<!-- 우측 메인 콘텐츠 -->
		<div id="mainContent">
			<div id="contentHeader">
				<h1>대시보드</h1>
				<div class="header-subtitle">주요 요약 정보</div>
			</div>

			<!--  우측 시작  -->


			<div id="contentBody" class="grid-2x2">



				<!-- 오늘 주문 건 -->
				<div class="summary-card">
					<h2>주문 요약</h2>
					<div class="summary-row" onclick="goTodayOrders()">
						<span>오늘 주문:</span> <span class="summary-number">${ordersSummary.todayOrders}</span>
					</div>
					<div class="summary-row" onclick="goWeekOrders()">
						<span>이번주 주문:</span> <span class="summary-number">${ordersSummary.weekOrders}</span>
					</div>
				</div>
				<script>

var url = contextPath + "/admin/order-list-by-postmapping";

// 오늘 00:00:00
function getTodayDate() {
    var d = new Date();
    var y = d.getFullYear();
    var m = ("0" + (d.getMonth() + 1)).slice(-2);
    var day = ("0" + d.getDate()).slice(-2);
    return y + "-" + m + "-" + day; // yyyy-MM-dd
}

function getTomorrowDate() {
    var d = new Date();
    d.setDate(d.getDate() + 1); // 다음날
    var y = d.getFullYear();
    var m = ("0" + (d.getMonth() + 1)).slice(-2);
    var day = ("0" + d.getDate()).slice(-2);
    return y + "-" + m + "-" + day; // yyyy-MM-dd
}




function goTodayOrders() {
    var start = getTodayDate();
    var end = getTomorrowDate();

    var form = document.createElement("form");
    form.method = "POST";
    form.action = url;

    var token = $("meta[name='_csrf']").attr("content");

    form.innerHTML =
        "<input type='hidden' name='startDate' value='" + start + "'>" +
        "<input type='hidden' name='endDate' value='" + end + "'>" +
        "<input type='hidden' name='status' value='Pending'>" +
        "<input type='hidden' name='_csrf' value='" + token + "'>";

    document.body.appendChild(form);
    form.submit();
}

// 이번주 주문 (startDate, endDate = null → 전체 검색)
function goWeekOrders() {
    var form = document.createElement("form");
    form.method = "POST";
    form.action = url;

    var token = $("meta[name='_csrf']").attr("content");

    form.innerHTML =
        "<input type='hidden' name='status' value='Pending'>" +
        "<input type='hidden' name='_csrf' value='" + token + "'>";

    document.body.appendChild(form);
    form.submit();
}
</script>


				<!-- 추가 카드 예시: 반품 신청 -->
				<div class="summary-card">
					<h2>환불 요약</h2>
					<div class="summary-row" onclick="goTodayRefunds()">
						<span>오늘 환불:</span> <span class="summary-number">${productSummary.todayProductRefund}</span>
					</div>
					<div class="summary-row" onclick="goWeekRefunds()">
						<span>이번주 환불:</span> <span class="summary-number">${productSummary.weekProductRefund}</span>
					</div>
				</div>
<script>

var url = contextPath + "/admin/unread-document-list-by-postmapping";

// 오늘 00:00:00
function getTodayDate() {
    var d = new Date();
    var y = d.getFullYear();
    var m = ("0" + (d.getMonth() + 1)).slice(-2);
    var day = ("0" + d.getDate()).slice(-2);
    return y + "-" + m + "-" + day; // yyyy-MM-dd
}

function getTomorrowDate() {
    var d = new Date();
    d.setDate(d.getDate() + 1); // 다음날
    var y = d.getFullYear();
    var m = ("0" + (d.getMonth() + 1)).slice(-2);
    var day = ("0" + d.getDate()).slice(-2);
    return y + "-" + m + "-" + day; // yyyy-MM-dd
}



function goTodayRefunds() {
    var start = getTodayDate();
    var end = getTomorrowDate();

    var form = document.createElement("form");
    form.method = "POST";
    form.action = url;

    var token = $("meta[name='_csrf']").attr("content");

    form.innerHTML =
        "<input type='hidden' name='startDate' value='" + start + "'>" +
        "<input type='hidden' name='endDate' value='" + end + "'>" +
 
        "<input type='hidden' name='_csrf' value='" + token + "'>";

    document.body.appendChild(form);
    form.submit();
}

// 이번주 주문 (startDate, endDate = null → 전체 검색)
function goWeekRefunds() {
    var form = document.createElement("form");
    form.method = "POST";
    form.action = url;

    var token = $("meta[name='_csrf']").attr("content");

    form.innerHTML =
        "<input type='hidden' name='_csrf' value='" + token + "'>";

    document.body.appendChild(form);
    form.submit();
}
</script>


				<div class="summary-card"
					onclick="location.href='${contextPath}/admin/returns'">
					<h2>신청서류 요약</h2>
					<div class="summary-row">
						<span>오늘 신청건:</span> <span class="summary-number">${applicantSummary.todayApplicantDocuments}</span>
					</div>
					<div class="summary-row">
						<span>이번주 신청건:</span> <span class="summary-number">${applicantSummary.weekApplicantDocuments}</span>
					</div>
				</div>


				<div class="summary-card"
					onclick="location.href='${contextPath}/admin/returns'">
					<h2>게시물 등록 요약</h2>
					<div class="summary-row">
						<span>오늘 등록건:</span> <span class="summary-number">${artWorkSummary.todayArtWork}</span>
					</div>
					<div class="summary-row">
						<span>이번주 등록건:</span> <span class="summary-number">${artWorkSummary.weekArtWork}</span>
					</div>
				</div>

				<!-- 추가 카드 예시: 에러 로그 -->
				<%--  <div class="summary-card" onclick="location.href='${contextPath}/admin/errorLogs'">
            <h2>최근 에러 로그</h2>
            <p class="summary-number">5하드코딩값임</p>
        </div> --%>

			</div>
		</div>


	</div>
</body>
</html>