<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Date"%>

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

.infoheaderarea {
	display: grid;
	grid-template-columns: 10% 10% 10% 10% 20% 20%;
}

.infolist {
	display: grid;
	grid-template-columns: 10% 10% 10% 10% 20% 20%;
}

.content {
	
}

/* 테이블 css 시작  */
@import 'https://fonts.googleapis.com/css?family=Open+Sans:600,700';

* {
	font-family: 'Open Sans', sans-serif;
}

.rwd-table {
	margin: auto;
	min-width: 300px;
	max-width: 100%;
	border-collapse: collapse;
}

.rwd-table tr:first-child {
	border-top: none;
	background: #428bca;
	color: #fff;
}

.rwd-table tr {
	border-top: 1px solid #ddd;
	border-bottom: 1px solid #ddd;
	background-color: #f5f9fc;
}

.rwd-table tr:nth-child(odd):not(:first-child) {
	background-color: #ebf3f9;
}

.rwd-table th {
	display: none;
}

.rwd-table td {
	display: block;
}

.rwd-table td:first-child {
	margin-top: .5em;
}

.rwd-table td:last-child {
	margin-bottom: .5em;
}

.rwd-table td:before {
	content: attr(data-th) ": ";
	font-weight: bold;
	width: 120px;
	display: inline-block;
	color: #000;
}

.rwd-table th, .rwd-table td {
	text-align: left;
}

.rwd-table {
	color: #333;
	border-radius: .4em;
	overflow: hidden;
}

.rwd-table tr {
	border-color: #bfbfbf;
}

.rwd-table th, .rwd-table td {
	padding: .5em 1em;
}

@media screen and (max-width: 601px) {
	.rwd-table tr:nth-child(2) {
		border-top: none;
	}
}

@media screen and (min-width: 600px) {
	.rwd-table tr:hover:not(:first-child) {
		background-color: #d8e7f3;
	}
	.rwd-table td:before {
		display: none;
	}
	.rwd-table th, .rwd-table td {
		display: table-cell;
		padding: .25em .5em;
	}
	.rwd-table th:first-child, .rwd-table td:first-child {
		padding-left: 0;
	}
	.rwd-table th:last-child, .rwd-table td:last-child {
		padding-right: 0;
	}
	.rwd-table th, .rwd-table td {
		padding: 1em !important;
	}
}

/* THE END OF THE IMPORTANT STUFF */

/* Basic Styling */
body {
	background: #4B79A1;
	background: -webkit-linear-gradient(to left, #4B79A1, #283E51);
	background: linear-gradient(to left, #4B79A1, #283E51);
}

h1 {
	text-align: center;
	font-size: 2.4em;
	color: #f2f2f2;
}

.container {
	display: block;
	text-align: center;
}

h3 {
	display: inline-block;
	position: relative;
	text-align: center;
	font-size: 1.5em;
	color: #cecece;
}

h3:before {
	content: "\25C0";
	position: absolute;
	left: -50px;
	-webkit-animation: leftRight 2s linear infinite;
	animation: leftRight 2s linear infinite;
}

h3:after {
	content: "\25b6";
	position: absolute;
	right: -50px;
	-webkit-animation: leftRight 2s linear infinite reverse;
	animation: leftRight 2s linear infinite reverse;
}

@
-webkit-keyframes leftRight { 0% {
	-webkit-transform: translateX(0)
}

25%
{
-webkit-transform
:translateX
(-10px)
}
75%
{
-webkit-transform
:translateX
(10px)
}
100%
{-webkit-transform:translateX(0)}
}
@
keyframes leftRight { 0% {
	transform: translateX(0)
}
25%
{
transform:translateX(-10px)}
75
%
{
transform
:
translateX
(
10px
)
}
100
%
{
transform
:
translateX
(0)
}
}
.notfoudinfolist{
color:red;
}


</style>
<script>

var startDate;
var endDate;
var reservename;
var payment;
const regex=/\d{4}-\d{2}/;
var check=false;

//(\d는 숫자를 의미하고, {} 안의 숫자는 갯수를 의미한다.) 



window.onload=()=>{
	

$("#pay").val();	


	
$(".detailbetweendate").on("click",()=>{
	
	startDate=$(".startDate").val();
	endDate=$(".endDate").val();
	reservename=$(".reservename").val();
	payment=$("#pay").val();	
	
	if(regex.test(startDate) && regex.test(endDate)){
		check=true
		//return;
	}// 따로국밥 if문 종료
	
	console.log("검색 시작일->"+startDate+ "정규식 일치?->"+regex.test(startDate)+"  검색 종료일->> "+endDate+" 예약자명-->"+reservename +"입급여부->>"+payment+"정규식은 일치??"+regex.test(endDate));
	
 if(check){
	
	window.location.href="detailbetweendate.do?startDate="+startDate+"&endDate="+endDate+"&startpage=0"+"&endpage=10"+"&reservename="+reservename+"&payment="+payment
	
	
}else{
	check=false;
alert("검색 시작일 종료일 모두 입력해주세요")	
}

	
})	}

</script>
<body>
	<div class="root">
		<div class="leftwrapper">
			<div class="sidebar">
				<span class="justlog">관리자모드</span>
				<ul>
					<li><a class="sidebarmenu" href="adminhome.jsp"> <span>Home</span></a></li>
					<li><a class="sidebarmenu" href="resoveinfolist.do"> <span>예약현황</span></a></li>
					<li><a class="sidebarmenu" href="admindetailreserveinfo.jsp"> <span>예약상세조회</span></a></li>
					<li><a class="sidebarmenu" href="adminproductlist22.do"> <span>고객노출 상품관리</span></a></li>
					<li><a class="sidebarmenu"> <span>주문형황</span></a></li>
				</ul>
			</div>
			<div class="sidebarbottom"></div>

		</div>
		<div class="rigthwrapper">
			<div class="header">
				<h3>예약리스트</h3>
			</div>
			<div class="mainbody">
				<div class="sectionarea">
					<!-- 
						items
Collection 객체(List, Map) "필수사항 없으면 에러"
var	사용할 변수명  "필수사항 없으면 에러"
varStatus	반복 상태를 알 수 있는 변수 "옵션"
						 -->

					<div class="container">
						<h1 style="color: #428bca" >상세조회 검색</h1>
						<table class="rwd-table">
							<tbody>
								<tr>
									<td data-th="Due Date">검색기간</td>
									<td data-th="Net Amount">시작일:<input class="startDate"></td>
									<td data-th="Net Amount">종료일:<input class="endDate"></td>
									<td data-th="Net Amount">예약자명:<input class="reservename"></td>
									<td data-th="Net Amount">입금상태:						
										<label for="pay">
									<select id="pay">
									<option class="payment" value="pay">입금완료</option>
									<option  class="payment" value="cancel">환불완료</option>
									</select> 
									</label>
						<!--<input class="payment">  -->
								
								
									</td>									
									<td data-th="Net Amount" class="detailbetweendate">상세조회하기</td>
								</tr>

							</tbody>
						</table>
					</div>

					<div class="container">
						<h1 style="color: #428bca">상세 조회 예약 리스트</h1>
						<table class="rwd-table">
							<tbody>
								<tr>
									<th>예약번호</th>
									<th>클래스명 번호</th>
									<th>예약자 신청일</th>
									<th>예약자명</th>
									<th>예약자 연락처</th>
									<th>예약 입금 현황</th>
								</tr>
								 
								
								 <c:choose>
							
								 <c:when test="${ detailinfolist eq  null}">
								 <h1 class="notfoudinfolist" style="color: #428bca" >상세 조회 결과가 없습니다.</h1>
								 </c:when>
								 
								 <c:otherwise>
								<c:forEach var="p" items="${detailinfolist}" varStatus="i">
									<tr>
										<td data-th="Supplier Code">${p.reserveinfo_num}</td>
										<td data-th="Supplier Name">${p.onedayclass_num}</td>
										<td data-th="Invoice Number">${p.application_day}</td>
										<td data-th="Invoice Date">${p.userEntity.user_name}</td>
										<td data-th="Due Date">${p.userEntity.user_tell}</td>
										<td data-th="Net Amount">
										
										<c:choose> 
										<c:when test="${p.reservestatus eq 'payment' }">입금완료</c:when>
										<c:otherwise >예약취소및환불</c:otherwise> 	 	
										</c:choose>																			
								
										</td>
									</tr>
								</c:forEach>
								</c:otherwise>
								</c:choose>
						 
							</tbody>
						</table> 		
									
					</div>

				</div>
			</div>
		</div>
		<!--오른쪽 레퍼  종료  -->
	</div>
	<!--최상위 root 종료  -->
</body>
</html>