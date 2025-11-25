<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>



<meta charset="UTF-8">
<title>원데이 클래스란?</title>
<style>
.wrapper {
	max-width: 960px;
	margin: 50px auto;
	padding: 0 20px;
}

h1 {
	font-size: 2.5em;
	margin-bottom: 20px;
}

.intro {
	font-size: 1.3em;
	line-height: 1.8;
	margin-bottom: 40px;
}

.section {
	margin-bottom: 60px;
}

.section h2 {
	font-size: 1.8em;
	margin-bottom: 15px;
	color: #5a5a5a;
}

.section p {
	font-size: 1.1em;
	line-height: 1.7;
}

.img-full {
	width: 100%;
	border-radius: 12px;
	margin: 30px 0;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.highlight {
	background-color: #fff5d0;
	padding: 10px 15px;
	border-left: 5px solid #ffc107;
	margin: 20px 0;
}

.class-preview-list {
	display: flex;
	gap: 20px;
	overflow-x: auto;
	padding-top: 20px;
}

.class-card {
	flex: 0 0 auto;
	width: 200px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	text-align: center;
	padding: 15px;
}

.class-card img {
	width: 100%;
	height: 120px;
	object-fit: cover;
	border-radius: 6px;
}

.class-title {
	margin-top: 10px;
	font-weight: bold;
	font-size: 1.1em;
}

.class-link {
	display: inline-block;
	margin-top: 8px;
	text-decoration: none;
	color: #007bff;
	font-size: 0.95em;
}

.class-link:hover {
	text-decoration: underline;
}

/* 슬라이더 영역 시작*/
.class-preview-list {
	display: flex;
	gap: 20px;
	overflow-x: auto;
	padding-top: 20px;
}

.class-card {
	flex: 0 0 auto;
	width: 200px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	text-align: center;
	padding: 15px;
	transition: transform 0.2s;
}

.class-card:hover {
	transform: translateY(-4px);
}

.class-card img {
	width: 100%;
	height: 120px;
	object-fit: cover;
	border-radius: 6px;
}

.class-title {
	margin-top: 10px;
	font-weight: bold;
	font-size: 1.1em;
}

.class-link {
	display: inline-block;
	margin-top: 8px;
	text-decoration: none;
	color: #007bff;
	font-size: 0.95em;
}

.class-link:hover {
	text-decoration: underline;
}

/* 슬라이더 영역 종료*/

 #mobileNave {
        display: none;
    }
    
    
/*모바일 시작  */
@media screen and (max-width: 760px) {


    /* 네비게이션 전환 */
    #pcNave {
        display: none;
    }
    #mobileNave {
        display: block;
    }
}
/*모바일 종료  */
</style>


<script>
    
    window.onload=()=>{
    	
    	
    	
    	
    }
    
    
    
    </script>


</head>
<body>
	<div class="wrapper">
		<div id="pcNave">
 <%@ include file="../pcNave.jsp"%>
</div>
<div id="mobileNave">
 <%@ include file="../mobileNave.jsp"%>
</div>
		<h1>우리의 원데이 클래스는</h1>

		<div class="intro">
			일상의 작은 쉼표가 되어주는 예술 한 조각.<br> 누구나 그림을 그릴 수 있고, 누구나 표현할 수 있습니다.<br>
			우리 원데이 클래스는 <strong>기술보다 마음</strong>을, <strong>결과보다 경험</strong>을 소중히
			여깁니다.
		</div>


		<div class="section">
			<h2>💡 원데이 클래스란?</h2>
			<p>
				"원데이 클래스"는 단 하루, 짧은 시간 안에<br> 예술 활동을 경험해보는 소규모 참여형 수업입니다.<br>
				<br> 미술을 전공하지 않아도 괜찮습니다.<br> 그림을 잘 그리지 않아도 괜찮습니다.<br>
				중요한 건 ‘함께 그려보는 시간’입니다.
			</p>
		</div>

		<div class="section">
			<h2>🖌️ 어떤 걸 배우나요?</h2>
			<p>
				만화, 인물화, 풍경화, 정물화, 디지털 드로잉, 크로키, 애니메이션 등 다양한 테마를 선택할 수 있습니다.<br>
				각 수업은 <strong>소수 정원</strong>으로 진행되며, 모든 재료는 제공됩니다.
			</p>
		</div>

		<div class="section">
			<h2>🌿 이런 분께 추천드려요</h2>
			<ul>
				<li>그림을 한 번쯤 제대로 배워보고 싶었던 분</li>
				<li>연인 또는 친구와 특별한 하루를 보내고 싶은 분</li>
				<li>창의적인 취미를 찾고 계신 분</li>
			</ul>
		</div>

		<div class="section highlight">
			🎟️ 수업은 사전 예약제로 운영되며,<br> 참여 인원에 따라 시간과 테마가 달라질 수 있습니다.
		</div>

		<!-- <div class="section">
			<h2>📍 위치 & 안내</h2>
			<p>
				경기도 안양시 만안구에 위치한 저희 작업실은<br> 조용하고 따뜻한 분위기에서 수업이 진행됩니다.<br>
				주차 가능 / 대중교통 접근 용이
			</p>
		</div> -->			

		<div class="section">
			<h2>🎨 클래스 둘러보기</h2>
			<p>아래 클래스 중, 나와 맞는 수업을 찾아보세요.</p>

			<div class="class-preview-list">
				<c:forEach var="item" items="${onedayclassList}">
					<div class="class-card">
						<img src="${pageContext.request.contextPath}/resources/${item.reserve_img}" alt="${item.onedayclass_name}">
						<div class="class-title">${item.onedayclass_name}</div>
						<a href="${pageContext.request.contextPath}/guest/getonedayclass-info?nextpage=0&onedayclass_name=${item.onedayclass_name}" 
							class="class-link">자세히 보기 →</a>
					</div>
				</c:forEach>
			</div>
		</div>

	</div>
</body>
</html>

