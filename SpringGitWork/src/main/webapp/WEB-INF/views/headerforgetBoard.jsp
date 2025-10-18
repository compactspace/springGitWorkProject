<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
	height: 280px;

	vertical-align: middle;
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

.menue_ul{    margin-right: auto;
    margin-left: auto;
    width: 20%;
    display: flex;
    list-style-type: none;
    justify-content: space-around;
}
	}


.menue_li{
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

table{
border-collapse: collapse;
    border-top: 2px solid black;
    width: 100%;
    height: 400px;
    }
    
    tr{
       border-bottom: 1px solid #707070;
       height: 35px;
    }
.th1{
text-align:left  
}
.th2{
width: 700px;
}
.th2 .th3 .th4 .th5 {
text-align:center
}
.title{
text-align:left;
height: 35px;
}
.seq,.writer, .regdate, .cnt{
text-align:center;

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
        border-bottom : 1px solid #000;
        text-align: center;
        vertical-align: middle;
    }
    .content {
        font-weight: bold;
    }


/*  #modalContainer{
display:none
}  */
#modalContent{
display:none
}

#modalContent{

}

.imgs{
    position: absolute;
    right: 0px;     
    top: 25px;
    height:200px;
    width: 200px;
}

.alldivwrapper{
    width: 1200px;
    position: relative;
 
}

.imgdiv{
    padding-top: 150px;
}


#loginformwrapper{
    background-color: white;
    height: 1300px;
    width: 1200px;
    border: 1px solid #ddd;

    
}

.loginform{


    height: 900px;
    
}
.container{
    display: flex;
    flex-direction: column;
}

.passwordinput,.idinput{
background-color: rgb(232, 240, 254);
    border: none;
    border-bottom: 1px solid #bdbdbd;
  
    width: 100%;

    height: 50px;
}
h3{
    color: #797979;
}


.iddiv, .passworddiv{
    margin-left: auto;
    margin-right: auto;
    width: 95%;
 

    

}
textarea{
    width: 900px;
    height: 150px;
}
.passworddiv{
text-align: center;
}

.logindiv,.membershipdiv{
padding-top: 10px;
padding-bottom: 10px;
    margin-left: auto;
    margin-right: auto;
    width: 95%;
    height: 40px;
    border: none;
    background-color:#1a70dc;
    color: aliceblue;
    line-height: 35px;
}

.loginbtn{
padding-top: 10px;
padding-bottom: 50px;
    margin-left: auto;
    margin-right: auto;
    width: 95%;
    height: 40px;
    border: none;
    background-color:#1a70dc;
    color: aliceblue;
    line-height: 35px;
}





.login_membershipdivwrapper{
    text-align: center;
}

#examplecontainer{

}

#noimgitems{
width:350px;
 float: left;
 margin-right: 160px;
    margin-left: 140px;

}

#yesimgitems{
width:350px;
 float: left;

}

.yesorno{
width:400px;
height:600px;
}



</style>
<script>
	window.onload = function() {
		$("button[class=getBoard]").on('click', function() {
	/* $(".same").next().val(""); */
			let page = parseInt($(this).text());
			

			$.ajax({
				url : "/getboad.do",
				data : {
					"page" : $(this).text()
				},
/*type=우리가보내는 타입 
*/
				type : "POST",
				success : function(val) {
				
				console.log("사이즈는>???->"+val.length);
				
		
					$(val).each(function(index, obj){
	 
					
				$("div").eq(index).attr('val-two',obj.writer); 		
		 		$(".samesseq").eq(index).val(obj.seq); 
		 		$(".title").eq(index).val(obj.title);
		 		$(".samesuniquewriter").eq(index).val(obj.writer); 
		 		$(".regdate").eq(index).val(obj.regdate);
		 		$(".cnt").eq(index).val(obj.cnt); 
						
						
		 		/* input class="sames seq" value="${board.seq}"></div>
                <div class="same table-cell title"><input class="sames title" value="${board.title}"></div>
                <div class="same table-cell writer"><input class="sames uniquewriter"  value="${board.writer}"></div>
                 <div class="same table-cell regdate"><input class="sames regdate" value="${board.regdate}"></div>
                  <div class="same table-cell cnt"><input class="sames cnt" value="${board.cnt}"></div>
            </div>		 */
						
						
					})
				

				
				},
				error : function(request, status) {
					alert("목록 가져오기를 할 수 없습니다.");
				}
			});

		})

		
		
		$(".myimg").click(function(){
			$("#modalContainer.hidden").css({"display":"block"})
			$("#modalContent").css({"display":"block"})
		$("#modalContainer.hidden").css({
			"position":"absolute" ,"top":"50%",
		　"left":"50%",
		　"transform": "translate(-50%,-50%)",
		　"background-color":"white",
		 "z-index": "100",
		 "width":"1200px",
		"height": "600px"
		})
			
		})
		
		$(".cancelimginsert").click(function(){
		console.log("dd");
		$("modalContent").css({"display":"none"})
		$("#modalContainer.hidden").css({"display":"none"})
		})
		
		
	/* 	$("input[data-val=choice]").click(function(){
		
			console.log("디스값은->>"+$(this).val());
			
		}) */	
		
	/* 	$("#showboard").click(function(){
		console.log($(this).val())
		}) */
			
		
	}		
		
		

</script>
</head>