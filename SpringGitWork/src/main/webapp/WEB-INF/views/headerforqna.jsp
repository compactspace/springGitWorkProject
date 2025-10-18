<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>

<head>
<meta charset="UTF-8">
<title>index페이지</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Orbit&family=Sunflower:wght@300&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<style>
p {
	background-color: rgb(119, 193, 61) font-family: 'Sunflower', sans-serif;
}

#carousel {
	height: 220px;
	vertical-align: middle;
	border-bottom: 1px solid black;
}

* {
	margin: 0;
	padding: 0;
}

body {
	margin: 0 0 0 0px;
}

/* 배치도 생각으로 전체 wrapper 감싼후 마진 오토 */
#wrapper {
	max-width: 1020px;
	margin: 0 auto;
	padding: 0px;
}

header {
	position: relative;
	height: 70px;
	background: #fff;
	margin: 0;
}

#carouselimg {
	text-align: center;
}

h2 {
	font-weight: 500;
	color: #333333;
	font-style: normal;
}

nav {
	position: absolute;
	top: 20px;
	width: 100%;
}

#qnali:after {
	content: "";
	display: block;
	width: 100%;
	border-bottom: 2px solid #bcbcbc;
}

.menue_ul {
	display: flex;
	list-style-type: none;
}

.navul {
	display: flex;
	list-style-type: none;
}

.navul>li {
	display: inline-block;
	width: 30%;
	text-align: center;
	color: #333333;
	letter-spacing: .01em;
	font-style: normal;
	font-weight: 300;
}

.menue_ul {
	margin-right: auto;
	margin-left: auto;
	width: 20%;
	display: flex;
	list-style-type: none;
	justify-content: space-around;
}

}
.menue_li {
	display: inline-block;
	width: 20%;
	text-align: center;
	color: #333333;
	letter-spacing: .01em;
	font-style: normal;
	font-weight: 400px;
}

a {
	text-decoration: none;
	color: #333333;
}

.article1 {
	background: #fff;
	height: 100%;
	margin: 0 auto;
	padding: 40px 0 40px;
}

#header1 {
	width: 100%;
	float: left;
	margin: 0px 0px 30px 50px;
	color: #333333;
}

p {
	display: block;
	width: 80%;
	margin: 0px 0px 0px 50px;
	font-weight: 300;
}

/* Section 2 */
img {
	display: block;
}

#content2 {
	margin: 20px auto;
}

.sameinfo {
	background: #fff;
	height: 100%;
	margin: 0px auto 0;
	padding: 20px 0 40px;
}

#Section2_2 {
	float: left;
	margin: 0;
	width: 500px;
	overflow: hidden;
}

#info2 {
	width: 90%;
	float: left;
	margin: 0px 0px 30px 50px;
	color: #333333;
}

#Section2_3 {
	float: right;
	margin: 0;
	width: 500px;
	overflow: hidden;
}

#info3 {
	width: 90%;
	float: left;
	margin: 0px 0px 30px 50px;
}

.clearfix:after {
	content: ".";
	display: block;
	height: 0;
	clear: both;
}

/* 미구현 footer영역 */
footer {
	text-align: center;
	display: block;
	height: 40px;
	background: #424141;
	margin: 20px 0 0 0;
}

table {
	border-collapse: collapse;
	border-top: 2px solid black;
	width: 100%;
	height: 400px;
}

tr {
	border-bottom: 1px solid #707070;
	height: 35px;
}

.th1 {
	text-align: left
}

.th2 {
	width: 700px;
}

.th2 .th3 .th4 .th5 {
	text-align: center
}

.title {
	text-align: left;
	height: 35px;
}

.seq, .writer, .regdate, .cnt {
	text-align: center;
}

.table {
	display: table;
	width: 100%;
}

.table-row-group {
	display: table-row-group;
}

.table-row {
	display: table-row;
	height: 40px;
}

.table-cell {
	display: table-cell;
	border-bottom: 1px solid #000;
	text-align: center;
	vertical-align: middle;
}

.thead {
	display: table-header-group;
	vertical-align: middle;
	border-color: inherit;
}

.tbody {
	display: table-row-group;
	vertical-align: middle;
	border-color: inherit;
}

.content {
	font-weight: bold;
}

/*  #modalContainer{
display:none
}  */
#modalContent {
	display: none
}

#modalContent {
	
}

.imgs {
	position: absolute;
	right: 0px;
	top: 25px;
	height: 200px;
	width: 200px;
}

.alldivwrapper {
	width: 1200px;
	position: relative;
}

.imgdiv {
	padding-top: 150px;
}

#loginformwrapper {
	background-color: white;
	height: 1300px;
	width: 1200px;
	border: 1px solid #ddd;
}

.loginform {
	height: 900px;
}

.container {
	display: flex;
	flex-direction: column;
}

ul {
	list-style: none;
}

#q1 {
	display: inline-block;
}

.a1 {
	display: inline-block;
}

.qusetionli {
	line-height: 2.3;
	padding: 10px 10px 0px 10px;
	margin-top:3px;
margin-bottom:3px;
}

.qnali {
    margin-top: 20px;
margin-bottom:3px;
    border-bottom: 1px solid #ebebeb;
	height: 60px
}

.qusetionli>span {
	padding: 10px 10px;
}

.answerli {
	padding: 10px 10px 0px 10px;
	height: 50px;
	background-color: #f7f7f7;
	line-height: 2.5;
}

.answerli>.a1 {
	padding-left: 10px;
}
</style>
<script>
	window.onload = function() {
		
		$("#gasipanli").on("click",function(){
		
			location.href="firstgetboad.do?page=0";
			
			
		})
		
		
		
		$("div[class='answerli']").hide();
		$("div[class='qusetionli']").on('click', function() {

			console.log($(this));
			console.log($(this).children().next());
			console.log($(this).children().next().next().css('display'));

			
			
			let q = $(this).children().next().next().css('display');
	
			if (q == 'none') {
				$(this).children().next().next().show();
				$(this).parent().css({"border-bottom":"1px solid #ebebeb","height":"80px"})
				$(this).children().next().next().css({"color":"red"});
			} else {
				$(this).children().next().next().hide();
				$(this).parent().css({"border-bottom":"1px solid #ebebeb","height":"60px"})

			}
		})

	}
</script>
</head>