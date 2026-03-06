<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>커뮤니티 페이지</title>

<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>


<style>
body {
	font-family: Arial, sans-serif;
	padding: 20px;
	max-width: 1200px !important;
    margin: 0 auto !important;
}


.page-label {
       font-size: 25px;
    font-weight: 700;
    color: #333;
}




.banner-wrapper {
    max-width: 1200px;
    margin: 5px auto;
    display: flex;
    gap: 30px;
    padding: 0 20px;
}

.banner-left {
    flex: 2;
}

.banner-right {
    flex: 1;
}

/* 공통 배너 박스 */
.banner-left,
.banner-right {
    position: relative;
    border-radius: 20px;
    overflow: hidden;
    background: linear-gradient(135deg, #f3f4f6, #e5e7eb);
    box-shadow: 0 8px 25px rgba(0,0,0,0.08);
    transition: all 0.3s ease;
}

/* hover 효과 */
.banner-left:hover,
.banner-right:hover {
    transform: translateY(-5px);
    box-shadow: 0 12px 35px rgba(0,0,0,0.15);
}

/* 이미지 비율 설정 */
.banner-left img {
    width: 100%;
    height: 100%;
    object-fit: contain;   /* 🔥 이미지 전체 표시 */
    aspect-ratio: 16 / 9;  /* 왼쪽 배너 비율 */
}

.banner-right img {
    width: 100%;
    height: 100%;
    object-fit: contain;   /* 🔥 이미지 전체 표시 */
    aspect-ratio: 4 / 5;   /* 오른쪽 배너 비율 */
}


.container-wrapper {
	max-width: 1200px; /* 최대 너비 설정 */
	margin: 0 auto; /* 중앙 정렬 */
	padding: 0 20px; /* 양 옆 여백 추가 */
}


.container {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	justify-content: center;
}



.card {
	background-color: white;
	border-radius: 10px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	width: 300px;
	overflow: hidden;
	text-align: center;
	transition: transform 0.3s ease;
}

.card:hover {
	transform: scale(1.05);
}

.card img {
	width: 100%;
	height: 200px;
	object-fit: cover;
}

.card-content {
	padding: 15px;
}

.card-title {
	font-size: 18px;
	font-weight: bold;
	margin-bottom: 10px;
}

.card-date {
	font-size: 14px;
	color: #666;
}

.load-more {
	text-align: center;
	margin-top: 30px;
}

.load-more button {
	padding: 10px 20px;
	font-size: 16px;
	background-color: #007BFF;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.load-more button:hover {
	background-color: #0056b3;
}



#mobileNave{

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



</head>
<script >

let hasNext="${hasNext}"||false;
let offset=hasNext? 10: 0;



$(document).ready(function() {
    // .container에 클릭 이벤트를 위임
    
    // 왼쪽 배너 자동 슬라이드
let bannerIndex = 1;
const totalBanners = 4; // 1~4
const contextPath = "${pageContext.request.contextPath}";

setInterval(function() {
    bannerIndex++;
    if (bannerIndex > totalBanners) {
        bannerIndex = 1;
    }

    $("#leftBanner").fadeOut(800, function() {
        $(this).attr("src",
            contextPath +
            "/resources/img_community_banner/communityPage_left_banner" +
            bannerIndex +
            ".jpeg"
        ).fadeIn(800);
    });

}, 4000); // 4초마다 변경




    
$(document).ready(function() {
        // .container에 클릭 이벤트를 위임
        $(".container").on("click", ".card", function() {
            // 클릭된 .card 요소에 대해 처리할 코드
            console.log("클릭된 카드: ", $(this).data("artworkid"));
            
            // 클릭된 카드의 artWorkID 가져오기
            let artWorkID = $(this).data("artworkid");
            
            // contextPath를 JSP에서 동적으로 전달
            let contextPath = "${pageContext.request.contextPath}";
            
            // URL 변경
            window.location.href = contextPath + "/guest/get-artwork-detail?artWorkID=" + artWorkID;
        });
    });
    
    
    
    
    
    $(".more-artwort").on("click", ".card", function() {     
        
        window.location.href="${pageContext.request.contextPath}/guest/communityPage?offset="+offset;
        
    });	
    		
    
    
});






</script>
<body>
		<div id="pcNave">
 <%@ include file="../pcNave.jsp"%>
</div>
<div id="mobileNave">
 <%@ include file="../mobileNave.jsp"%>
</div>



<div class="banner-wrapper">
    <div class="banner-left">
        <img id="leftBanner"
             src="${pageContext.request.contextPath}/resources/img_community_banner/communityPage_left_banner1.jpeg"
             alt="Left Banner">
    </div>
    <div class="banner-right">
        <img src="${pageContext.request.contextPath}/resources/img_community_banner/community_right_banner.jpeg"
             alt="Right Banner">
    </div>
</div>


<div class="container-wrapper">
<h2 class="page-label">미술작업실</h2>
	<div class="container">
		<c:forEach var="artwork" items="${artWorkList}">
			<div class="card" data-artworkid="${artwork.artwork_id}">
				<img
					src="${pageContext.request.contextPath}/api/guest/get-artwork-image?folder=${artwork.file_url}&&name=${artwork.file_name}">
				<div class="card-content">
					<div class="card-title">${artwork.title}</div>
					<div class="card-date">${artwork.created_at}</div>
				</div>
			</div>
		</c:forEach>
	</div>

<div class="insert-hasNext-artWorklistFragment"></div>


</div>

	<!-- 더보기 버튼 -->
	<c:if test="${hasNext}">
		<div class="load-more">
			
				<button class="more-artwort">더 보기</button>
		
		</div>
	</c:if>

</body>
</html>
