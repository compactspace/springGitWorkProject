<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!doctype html>
<html>

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
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
	margin: 0 auto;
	/* 메인사진 주석처리 해가며 어느게 가장 이쁜지 비교해보자*/
	/* 	background-image: url(./img/main.jpg); */
	background-image: url(./img/worklist.jpg);
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
	height: 450px;
	background-color: #BABABA;
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

.myimg {
	background: transparent;
	font-size: 30px;
	border: none;
}

.myimg:focus {
	
}

.myimg:hover {
	background-color: black;
	color: white;
	transition: 0.7s;
}

.gologin {
	font-size: 30px;
}

.gologin:hover {
	background-color: black;
	color: white;
	transition: 0.7s;
}

.gologin:hover {
	background-color: black;
	color: white;
	transition: 0.7s;
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
#content1 {
	max-width: 1020px;
	margin: 20px auto;
}

#content2 {
	grid-gap: 10px;
	display: grid;
	grid-template-rows: 333px 333px 333px 333px 333px;
	grid-template-columns: 50% 50%;
	max-width: 1020px;
	margin: 20px auto;
}

.sameinfo {
	display: grid;
/* 	grid-template-rows: 80% 20%; */
	background: #fff;
}

.Section2_2 {
	box-shadow: 0 19px 38px rgba(0, 0, 0, 0.30), 0 15px 12px
		rgba(0, 0, 0, 0.22);
	height: 100%;
	display: grid;
	grid-template-rows: 50% 50%;
}

.Section2_2>.infoimg {
	width: 100%;
	height: 100%
}

.imgarea {
	background-size: 100% 100%;
	background-repeat: no-repeat;
}

.titleinfo {
	font-size: 25px;
	display: block;
	color: #333333;
}

.detailinof {
	display: block
}

.btnarea {
	
}

.addbtn {
	color: #333333;
	font-weight: 500;
	border: 0;
	background-color: transparent;
	padding: 10px 0px;
	font-size: 18px;
	display: block;
	margin-right: 0px;
	margin-left: auto;
	/*     border: 1px solid #03c75a; */
	-webkit-box-sizing: border-box;
	box-sizing: border-box;
	border-radius: 3px;
}

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

/* 미구현 footer영역 */
footer {
	text-align: center;
	display: block;
	height: 40px;
	background: #424141;
	margin: 20px 0 0 0;
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

.passwordinput, .idinput {
	background-color: rgb(232, 240, 254);
	border: none;
	border-bottom: 1px solid #bdbdbd;
	width: 100%;
	height: 50px;
}

h3 {
	color: #797979;
}

.iddiv, .passworddiv {
	margin-left: auto;
	margin-right: auto;
	width: 95%;
}

textarea {
	width: 900px;
	height: 150px;
}

.passworddiv {
	text-align: center;
}

.logindiv, .membershipdiv {
	padding-top: 10px;
	padding-bottom: 10px;
	margin-left: auto;
	margin-right: auto;
	width: 95%;
	height: 40px;
	border: none;
	background-color: #1a70dc;
	color: aliceblue;
	line-height: 35px;
}

.loginbtn {
	padding-top: 10px;
	padding-bottom: 50px;
	margin-left: auto;
	margin-right: auto;
	width: 95%;
	height: 40px;
	border: none;
	background-color: #1a70dc;
	color: aliceblue;
	line-height: 35px;
}

.login_membershipdivwrapper {
	text-align: center;
}

#examplecontainer {
	
}

#noimgitems {
	width: 350px;
	float: left;
	margin-right: 160px;
	margin-left: 140px;
}

#yesimgitems {
	width: 350px;
	float: left;
}

.yesorno {
	width: 400px;
	height: 600px;
}

.btnarea {
	display: flex;
}
</style>

<script>

var media = window.matchMedia("screen and (max-width: 1026px)");






window.addEventListener("resize", function() {
	 if(media.matches){
		 console.log("900px 이하")
		 let selector=document.getElementsByClassName("Section2_2")
		 console.log(selector);
		 
		 
	 }else{
		 console.log("900px 이상")
	 }
		 
		 
		 
		 })




window.onload=function(){
	
	$("button[class=openstatus]").on("click",(e)=>{
		/* console.log(e)
		console.log(e.target) */
		console.log(e.target.getAttribute("value"))	
		
		
		//씨발 잘 모르겟는데 e 까지는 html 이나 자바 객체인듯 하고
		//e.target 에 $ 를 씌워야 제이쿼리 객체료 변신.ㅎ
		//console.log($(e.target).parent().prev().prev().prev().prev().prev().val());	
		
		
	 	let product_cod=$(e.target).parent().prev().prev().prev().prev().prev().val();
		
		let product_Registration_status=e.target.getAttribute("value");
		 $.ajax({
			
			url:"statusopen.do",
			type:"post",
			data:{"product_Registration_status":product_Registration_status,"product_cod":product_cod},
			
			success:(data)=>{
				console.log(data);
				
			}
			
		}) 
		
		
		
	})
	
	
	
	
	
	let key=localStorage.getItem("key");
	
	$(".Authorization").val("Bearer "+key);
	
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
	

	//고객노출 시 품절로 할 함수
$(".product_groupcheck").on("click",()=>{	
	let key=localStorage.getItem("key");
	let product_group=$(".product_groupvalue").val();	
console.log(product_group);
	let product_status=$(".productstatus").val();
  	$.ajax({
		url:"adminproductlist2.do?",
		 beforeSend: function (xhr) {
	            xhr.setRequestHeader("Content-type","application/json");
	            xhr.setRequestHeader("Authorization","Bearer "+key);	         
	            },
		type:"get",
		data:{"product_group":product_group},
		
		success:(data)=>{
			console.log(data)
			location.replace("/finall/"+data);			
		}//석세스 함수 종료		
	})//아작수 함수 종료  
	
})//클릭함수 종료




}


</script>
</head>
<body>
	<div class="allwarpper">
		<div id="wrappers">

			<header>
				<nav>
					<ul>
						<li><a href="onedayclass.jsp">원데이클래스</a></li>
						<li><a href="getworklist.do">참여자분들의 작품</a></li>

						<li><a href="firstgetboad.do?page=0">여러분의게시판</a></li>
						<c:choose>

							<c:when test="${userId ne null && user_where=='finalluser'}">

								<li>${userId}님<a href="myinfo.jsp"> 정보수정</li>
								<li><a href="cartlist.do?id=${userId}">장바구니</a></li>
								<li><a href="logout.do">로그아웃</a></li>
							</c:when>
							<c:when test="${user_where ne'finalluser' && userId ne null }">

								<li><a href="cartlist.do?id=${userId}">장바구니</a></li>
								<li><a href="logout.do">로그아웃</a></li>
							</c:when>

							<c:otherwise>


								<li><a href="login.jsp">로그인</a></li>
							</c:otherwise>
						</c:choose>
						<li><a href="productlist.do">팬시상품</a></li>
					</ul>
				</nav>
				<!-- nav -->
			</header>
			<!-- header -->

		</div>
		<div id="content1">
			<div id="section1"></div>
			<article class="article1">
				<h2 id="header1">관리자님 상품관리페이지</h2>
				<p>제품군선택</p>

				<form action="adminproductlist3.do" method="get" id="myForm">
						<input type="hidden" class="Authorization" name="Authorization"  >
					 <input type="submit">선택</input>
					<br>
				</form>
				
				<select name="product_group" class="product_groupvalue" form="myForm">
					<option value="pencile" selected>목탄연필군</option>
					<option value="colorpencile">색연필군</option>
					<option value="제품군미정">제품군미정</option>
				</select>
				<!-- <button class="product_groupcheck">제품군조회</button> -->
		</div>

		<div id="content2">

			<c:forEach var="p" items="${productService}" varStatus="i">

				<div class="Section2_2">

					<div class="imgarea"
						style="background-image:url('./img_product/${p.product_img}')"></div>
					<%-- 	<img class="infoimg" src="./img_product/${p.product_img}"  /> --%>


					<div class="sameinfo">
						<div class="infoarea">
							<span class="titleinfo">${p.product_name}</span> <span
								class="detailinof">${p.product_info}</span> <span
								class="detailinof">제품 판매상태 :${p.product_status}</span> <span
								class="detailinof">홈페이지 제품등록(노출)상태
								:${p.product_Registration_status}</span>
						</div>

						<input type="hidden" class="product_cod" name="product_cod"
							value="${p.product_cod}"> <input type="hidden"
							name="product_name" value="${p.product_name}"> <input
							type="hidden" name="product_price" value="${p.product_price}">
						<input type="hidden" name="product_img" value="${p.product_img}">

						<div class="btnarea">
							<button class="statuschange" type=button value="품절">품절로변경</button>
							<button class="statuschangesale" type=button value="판매">판매로변경</button>
						</div>
						<div class="btnarea2">
							<button class="openstatus" type=button value="open">홈페이지에상품등록</button>
							<button class="openstatus" type=button value="hidden">홈페이지에상품철회</button>
						</div>

					</div>
				</div>
				<c:set var="even" value="even" />

			</c:forEach>

		</div>
		
		
		
		
		

		<script>
	$("button[class=statuschange]").on("click", function(e) {
		
		//click 이벤트시는 e.target 이나 this나 같다 내가 누른 객체가 뜬다.
	/* 	console.log(e.target);
		console.log(this)
		console.log($(this).parent().prev().prev().prev().prev().prev().prev().val()) */
		//상품담기를 아작스통신으로 바꾸어서.. 어쩔수없이 이렇게 name 값을 일일히 가져와야한다.
		/* console.log($(this).prev().prev().prev().prev().val());
		console.log($(this).prev().prev().prev().prev().prev().val()); 		
		console.log($(this).prev().prev().prev().val()); 
		*/		
		
		
	 	
	console.log("상품코드는->>"+$(this).parent().prev().prev().prev().prev().val())
	
	console.log("어떤상태로->>"+$(this).val()) 
	
	
		$.ajax({
			url : "statuschange.do",
			method : "get",
			data : {
				
				"product_cod" : $(this).parent().prev().prev().prev().prev().val(),
				"product_status": $(this).val()
				
			},
			success : function(data) {
				console.log(data);
				if (data == "0") {
					alert("품절된상품입니다.");
				} else if (data == "1") {
					alert("장바구니에 담았습니다.");
				} else {					

				}
			},
			error : function() {

			}

		})  
 
	})
	
	$("button[class=statuschangesale]").on("click", function(e) {
		
		//click 이벤트시는 e.target 이나 this나 같다 내가 누른 객체가 뜬다.
	/* 	console.log(e.target);
		console.log(this)
		console.log($(this).parent().prev().prev().prev().prev().prev().prev().val()) */
		//상품담기를 아작스통신으로 바꾸어서.. 어쩔수없이 이렇게 name 값을 일일히 가져와야한다.
		/* console.log($(this).prev().prev().prev().prev().val());
		console.log($(this).prev().prev().prev().prev().prev().val()); 		
		console.log($(this).prev().prev().prev().val()); 
		*/		
		
		
	 	
	console.log("상품코드는->>"+$(this).parent().prev().prev().prev().prev().val())
	
	console.log("어떤상태로->>"+$(this).val()) 
	
	
	 	$.ajax({
			url : "statuschange.do",
			method : "get",
			data : {
				
				"product_cod" : $(this).parent().prev().prev().prev().prev().val(),
				"product_status": $(this).val()
				
			},
			success : function(data) {
				console.log(data);
				if (data == "0") {
					alert("품절로 바꾸셨습니다.");
				} else if (data == "1") {
					alert("장바구니에 담았습니다.");
				} else {
					

				}
			},
			error : function() {

			}

		})  //아작스종료 	
		
	})	
	
</script>


		<footer>
			<h1>미구현footer</h1>
		</footer>
</body>
</html>

