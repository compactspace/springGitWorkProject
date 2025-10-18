<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
 <link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<style>
p {
	background-color: rgb(119, 193, 61) font-family: 'Sunflower', sans-serif;
}

#carousel {
	margin: 0 auto;
	background-image: url(./img/main.jpg);
	background-repeat: no-repeat;
	background-size: 1200px 500px;
	height: 500px;
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

#carousel {
    margin-top: 80px;
	height: 230px;
	/* background-color: #BABABA; */
	vertical-align: middle;
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

ul {
	display: flex;
	list-style-type: none;
}

li {
	display: inline-block;
	width: 30%;
	text-align: center;
	color: #333333;
	letter-spacing: .01em;
	font-style: normal;
	font-weight: 300;
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

table{border-top:1px solid black;
    width: 100%;
    }

    img{ height: 70px;       
    
    }

.imgs{
padding-top:20px;
padding-bottom:20px ;
}
.col1{
    width: 20px;
}
.col2{
    width: 10%;
}
    
    input{
    border: none;
    }
    
    #finallsum{
     height: 90px;
    border-top:1px solid black;
        border-bottom:1px solid black;
        background-color: rgb(216, 219, 219);
    
    }
    .isorder{
        margin-top: 8px;
    }
    .isorder_1{
        display: inline-block;
        width: 120px;
        text-align: center;
        color:white;
        background-color: #ed1c24;
        padding-top: 10px;
        padding-bottom: 10px;


    }
    .isorder_2{
        display: inline-block;
        width: 120px;
        text-align: center;
        color:white;
        background-color: #232a32;
        padding-top: 10px;
        padding-bottom: 10px;


    }


 
</style>
</head>
