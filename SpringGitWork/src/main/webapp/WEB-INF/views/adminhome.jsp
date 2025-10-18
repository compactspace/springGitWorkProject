<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Date"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
	integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
	crossorigin="anonymous"> -->
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
</head>
<style>
body {
	bottom: 0px 0px;
	margin: 0px 0px;
}

.root {
	display: flex;
}

.justlog {
	margin: 0 30px;
	display: flex;
	flex-direction: row;
	min-height: 50px;
	color: #fff;
	background-color: #262626;
	border-radius: 6px;
	border: 0;
	justify-content: center;
	align-items: center;
	column-gap: 8px;
	text-decoration: none;
	cursor: pointer;
	transition: transform .2s;
}

.leftwrapper {
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	background-color: #000;
	z-index: 11;
	flex: 0 0 240px;
	min-width: 240px;
	height: 100vh;
}

.sidebar {
	flex: 1;
	display: flex;
	gap: 20px;
	flex-direction: column;
	padding: 30px 0;
	position: fixed;
	top: 0;
	/* 	width: 240px; */
	overflow: auto;
	height: calc(100vh - 220px);
	background-color: #000;
}

ul {
	margin: 0;
	padding: 0;
	list-style: none;
}

.sidebarmenu {
	display: block;
	background: #262626;
	color: #fc6b2d;
	font-family: Pretendard, sans-serif;
	font-size: 16px;
	line-height: 27.2px;
	font-weight: 700;
	word-break: keep-all;
	height: 50px;
	padding: 0 24px 0 35px;
	text-decoration: none;
	color: #fff;
	background: #000000;
	border: none;
	outline: none;
	box-shadow: none;
	cursor: pointer;
}

/* 롸이트바 시작  */
.rigthwrapper {
	width: 100%;
}

.header {
	width: 100%;
	/* padding: 0 50px; */
	display: inline-flex;
	align-items: center;
	border-bottom: 1px solid #f5f5f5;
	background-color: #fff;
	position: sticky;
	top: 0;
	height: 40px;
	z-index: 10;
	left: 240px;
	font-family: Pretendard, sans-serif;
	font-size: 14px;
	line-height: 22.4px;
	font-weight: 700;
	word-break: keep-all;
}

.mainbody {
	padding-left: 50px;
	padding-right: 50px;
	background-color: #fbfbfb;
}

.sectionarea {
	margin-left: auto;
	margin-right: auto;
	width: 940px;
	display: flex;
	flex-direction: column;
	padding: 40px 0 140px;
	width: 1100px;
	background-color: #fbfbfb;
}

.sectionone {
	display: grid;
	grid-template-rows: 50% 50%;
	grid-template-columns: 50% 50%;
}

.infoarea {
	
}
</style>
<script>
window.onload=()=>{
	
	$(".justlog").on("click",()=>{		
		
		key=localStorage.getItem("key");
		console.log("로컬스토리지 토큰값"+key)	
		$.ajax({				
			url:"adminmode.do",
			 beforeSend: function (xhr) {
		            xhr.setRequestHeader("Content-type","application/json");
		            xhr.setRequestHeader("Authorization","Bearer "+localStorage.getItem("key"));
		            xhr.setRequestHeader("걍아무키","걍아무값");
		            },
			success:(data,status,request)=>{				
			location.replace("/finall/"+data); 
			}			
		})	
	})
}
</script>
<body>

	<div class="root">
		<div class="leftwrapper">
			<div class="sidebar">
				<span class="justlog">관리자모드</span>
				<ul>
					<li><a class="sidebarmenu" href="adminhome.jsp"> <span>Home</span></a></li>
					<li><a class="sidebarmenu" href="resoveinfolist.do"> <span>예약현황</span></a></li>
					<li><a class="sidebarmenu" href="admindetailreserveinfo.jsp">
							<span>예약상세조회</span>
					</a></li>
					<!-- <li><a class="sidebarmenu" href="adminproductlist.do"> <span>고객노출 상품관리</span></a></li> -->
					<li><a class="sidebarmenu" href="adminproductlist22.do"> <span>고객노출
								상품관리</span></a></li>
					<li><a class="sidebarmenu" href=""> <span>재고현황</span></a></li>
					<li><a class="sidebarmenu"> <span>주문형황</span></a> <sec:authorize
							access="hasRole('ROLE_ADMIN')">
							<!-- <a class="nav-link" href="/adminhome.do">관리자 모드</a> -->
							<h3 class="managermode">관리자모드</h3>
							<p>
								principal :
								<sec:authentication property="principal" />
							</p>
						</sec:authorize> <sec:authorize access="hasRole('ROLE_ADMIN')">
							<!-- <a class="nav-link" href="/adminhome.do">관리자 모드</a> -->
							<h3 class="managermode">관리자모드</h3>
							<p>
								principal :
								<sec:authentication property="principal" />
							</p>
						</sec:authorize></li>
				</ul>
			</div>
			<div class="sidebarbottom"></div>

		</div>
		<div class="rigthwrapper">
			<div class="header">
				<span> <%
 Date nowdate = new Date();
 %> <%=nowdate%>
				</span>
			</div>
			<div class="mainbody">
				<div class="sectionarea">
					<div class="sectionone">
						<div class="infoarea" id="reserveinfo">
							<h3>기간 예약조회</h3>
						</div>
						<div class="infoarea" id="cancelinfo">
							<h3>상세 예약 조회</h3>
						</div>
						<div class="infoarea" id="inventory">
							<h3>고객 홈페이지 상품관리</h3>
						</div>
						<div class="infoarea" id="orderinfo">
							<h3>주문 현황</h3>
						</div>
					</div>
					<div class="section"></div>
				</div>
			</div>
		</div>
	</div>


</body>
</html>