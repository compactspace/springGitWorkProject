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
* {
	margin: 0;
	padding: 0;
}

body {
	margin: 0 0 0 0px;
	box-shadow: 0 0 17px 3px rgb(171 171 171/ 50%);
	background-color: #FFF !important;
}

p {
	background-color: rgb(119, 193, 61) font-family: 'Sunflower', sans-serif;
}

#wrappers {
	max-width: 560px;
	margin: 0 auto;
	box-shadow: 0 0 17px 3px rgb(171 171 171/ 50%);
}

#carousel {
	margin: 0 auto;
	/* 메인사진 주석처리 해가며 어느게 가장 이쁜지 비교해보자*/
	/* 	background-image: url(./img/main.jpg); */
	background-image: url(./img/main2.jpg);
	background-repeat: no-repeat;
	background-size: 100% 400px;
	height: 300px;
	vertical-align: middle;
}

/* 배치도 생각으로 전체 wrapper 감싼후 마진 오토 */
#wrapper {
	position: relative;
	max-width: 560px;
	    max-height: 688px;
	
	margin: 0 auto;
	display: grid;
	grid-template-rows: 10% 80%;
	box-shadow: 0 0 17px 3px rgb(171 171 171/ 50%);
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


#header1 {
	width: 100%;
	color: #333333;
	padding: 20px 0px;
	font-weight: 600;
}



/* Section 2 */
img {
	display: block;
}
#content1{
    border-bottom: 1px solid rgba(230, 230, 230, 0.5);
    }
#content2 {
border-bottom: 4px solid rgba(230, 230, 230, 0.5);
    height: 480px;
	display: grid;
	grid-template-columns: 50% 50%;
}

.sameinfo {
    color: #252525;
	background: #fff;
	margin: 0px auto 0;
	padding: 20px 0 40px;
}

.sameinfo>h2{
margin-left: 5px;

}

.sameinfo>p {
	display: block;
	width: 80%;
	margin: 5px 0px 0px 5px;
	font-weight: 300;
}




#Section2_2 {
	width: 100%;
	height: 100%;
}

}
#info2 {
	width: 90%;
	float: left;
	margin: 0px 0px 30px 50px;
	color: #333333;
}

#Section2_3 {
	/* display: grid;
	grid-template-rows: 40% 40%; */
	max-width: 490px;
}

#iconrow {
	height: 480px;
	width: 100%;
	display: flex;
	flex-direction: column;
}

.detail{
display: flex;
padding-bottom: 10px;
}


.infoicon {
	height: 20px;
	width: 20px;
}



.reserve_img {
	width: 250px;
	height: 250px
}

}
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



.sinchung{
max-width: 560px;
	margin: 0 auto;
    background-color: #FF5862;
    color: #fff;
        width: 100%;
}

.sinchung>h3{
width: 50%;
    margin: 0 auto;
    text-align: center;
        padding-top: 15px;
}


.allwarpper{

    position: absolute;
    /*컨텐츠의 위쪽 기준 으로 50% 수직임  */
    top: 50%;
       /*따라서 높의 절반만큼 올려준다. */
    margin-top:-339.5px;
    
     /*컨텐츠의 왼쪽 기준 으로 50% 이동임  */
        left: 50%;
         /*따라서 컨텐츠의 널비 절반만큼 올려준다. */
        margin-left: -280px;
}



 #ui-datepicker-div {
    
	/* display: grid !important;
	height: 480px;
	left: 0px !important;
	position: relative !important;
	max-width: 1020px !important;
	margin: 0 auto !important;
	top: -730px !important;
	width: 80%;
	grid-gap: 20px;
	grid-template-rows: 0px 40px 430px 0px; */
	
	
	/*    margin-top: -243.75px;
    top: 50%;
    position: absolute;
   
    z-index: 1;
    display: grid;
    height: 480px;
    max-width: 1020px;

    width: 80%;
    gap: 20px;
    grid-template-rows: 0px 40px 430px 0px; 
	 */
	
	
	
}
 
.ui-datepicker-title {
	display: flex !important;
}

.ui-datepicker select.ui-datepicker-year {
	width: 30% !important;
}

.ui-widget-header{

    background-color: #FF5862;
 
}
.ui-datepicker-calendar tr{
font-size: 14px;
}
.ui-datepicker-week-end>span{

color: #FF5862;
}

.ui-state-default{
text-align: center !important;

}

.ui-datepicker-trigger{
  
    width: 120px;
    height: 35px;
    font-weight: 600;
    color: white;
    background-color: #FF5862;
    border-radius: 5px;
    border: none;
}

.restcount{
width: 120px;
    height: 35px;
    font-weight: 600;
    color: white;
    background-color: #FF5862;
    border-radius: 5px;
    border: none;

}

.restcountarea{
padding: 10px 0px;
}


</style>
</head>