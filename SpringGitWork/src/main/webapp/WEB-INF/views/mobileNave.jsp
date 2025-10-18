<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
/* 모바일 전용..후 */	
@media screen and (max-width: 701px) {


* {
	margin: 0;
	padding: 0;
}

body {
	margin: 0 0 0 0px;
	box-shadow: 0 0 17px 3px rgb(171 171 171/ 50%);
	background-color: #FFF !important;
}







.menudiv a {
	text-decoration: none;
	color: #333333 !important;
}

.menudiv li {
	display: inline-block !important;
	width: 30% !important;
	text-align: center;
	color: #333333 !important;
	letter-spacing: .01em !important;
	font-style: normal;
	font-weight: 300 !important;
}



	.mobileheader {
		flex-direction: column;
		display: flex;
		height: 80px !important;
		justify-content: center;
	}
	.homeicon {
		background-image: url('./img_icon/homeicon.png');
		background-position: center;
		background-repeat: no-repeat;
		background-attachment: scroll;
		background-size: cover;
		width: 40px !important;
		height: 39.5px !important;
	}
	.navebar {
		display: flex;
		justify-content: space-between;
		margin-right: auto;
		margin-left: auto;
		max-width: 1050px;
		color: black;
		/*   background: #1a73e8; */
		font-size: 13px !important;
		font-weight: 600;
	}
	.navebar div {
		line-height: 3em !important;
	}
	
	.navebar div ul{
	
	display: flex;
	list-style-type: none;

	}
	
	
	.menudiv {
		width: 300px;
		padding-left: 10px;
	}
}
</style>
</head>
<body>

	<!-- ..모바일 디자인 후... -->
	<div class="mobileheader">
		<div class="navebar">
			<a href="${pageContext.request.contextPath}/">
				<div class="homeicon"></div>
			</a>
			<div class="menudiv">
				<ul>
					<c:choose>
						<c:when test="${userId ne null || user_where=='finalluser'}">
							<li><c:if test="${user_where=='finalluser'}">
									<a class="nav-link" href="mypersonalinfo.do?id=${userId}">정보수정</a>
								</c:if></li>
							<li class="nav-item active"><a class="nav-link"
								href="generalcartlist.do?id=${userId}">장바구니</a></li>
							<li><a href="myreserveinfo.do?user_code=${user_code}">예약현황</a></li>
							<li class="nav-item active"><a class="nav-link"
								href="mypayinfo.do?user_code=${user_code}&id=${userId}">결제현황</a></li>
							<li><a href="logout.do">로그아웃</a></li>							
							<!-- <li><a href="getreserve.do?nextpage=0">테스트예약페이지</a></li>	 -->											
						</c:when>
												
						<c:otherwise>
						
							<li class="nav-item active"><a class="nav-link" href="${pageContext.request.contextPath}/users/login">로그인</a></li>
							<!-- <li class="nav-item active"><a class="nav-link" href="phonesms.jsp">가입</a></li> -->
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>