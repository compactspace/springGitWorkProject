<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
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

#emptycarousel {
	position: relative;
	margin-top: 500px;
	margin: 0 auto;
	background-image: url(./img_cart/emptycart.png);
	background-repeat: no-repeat;
	background-size: 250px 250px;
}

#carousel {
	position: relative;
	margin-top: 600px;
	margin: 0 auto;
	background-repeat: no-repeat;
	background-size: 250px 250px;
}
/* jstl 조건문으로 가져올시 씹히니 스크립트로 걸어보자. */
#emptycart {
	margin: 0 auto;
	position: absolute;
	width: 100%;
	height: 300px;
	background: #f7f7f7;
	top: 230px;
	border-top: 2px solid #bdbdbd;
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
	/*  background-color: #BABABA;  */
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

footer {
	text-align: center;
	display: block;
	height: 40px;
	background: #424141;
	margin: 20px 0 0 0;
}

table {
	border-top: 1px solid black;
	width: 100%;
}

img {
	height: 70px;
}

.imgs {
	padding-top: 20px;
	padding-bottom: 20px;
}

.col1 {
	width: 20px;
}

.col1>img {
	width: 45px;
	height: 65px;
}

.col2 {
	width: 10%;
}

td {
	text-align: center;
}

input {
	border: none;
}

#finallsum {
	height: 90px;
	border-top: 1px solid black;
	border-bottom: 1px solid black;
	background-color: #F5F5F5;
}

.isorder {
	margin-top: 8px;
}

.isorder_1 {
	display: inline-block;
	width: 120px;
	text-align: center;
	color: white;
	background-color: #ed1c24;
	padding-top: 10px;
	padding-bottom: 10px;
}

.isorder_2 {
	display: inline-block;
	width: 120px;
	text-align: center;
	color: white;
	background-color: #232a32;
	padding-top: 10px;
	padding-bottom: 10px;
}

.finallpurchace {
	display: flex;
	width: 30%;
	height: 30px;
}

.subfinallpurchace {
	width: 50%;
	line-height: 2;
}

.wannadelete {
	height: 60px;
	background-color: #F5F5F5;
}

.deletebtn {
	padding-top: 10px;
}

.deletebtn>button {
	background-color: white;
	width: 120px;
	height: 40px;
}

#result>input {
	text-align: center
}
</style>
</head>
<body>
<h1> 이게 리엑트처럼 세션값 변하는거 감지 못하나 아작스통신이여서???"${checkmycart}"</h1>





	<input type="hidden" class="come" value>
	<div id="wrapper">

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
		<!-- header 끝 -->
		<c:choose>
			<c:when test="${userId eq null}">
				<button id="goback" data-val="goback"></button>
			</c:when>
			<c:when test="${checkmycart eq 0}">
				<div id="emptycarousel">
					<div id="carouselimg"></div>


					<div id="emptycart">
						<h3 style="text-align: center; margin-top: 100px;">장바구니가
							비어있어요</h3>
					</div>
			</c:when>
			<c:otherwise>
				<div id="carousel">
					<div id="carouselimg">
						<div>
							<ul>
								<li>step1.장바구니</li>
								<li>step2.결제하기</li>
							</ul>
						</div>
					</div>


					<form action="pay2.jsp" class="comeonmodal" id="forminfo">
						<table>
							<tbody>
								<c:forEach var="my" items="${mycart}">

									<tr>
										<th colspan="2">상품정보</th>
										<th>수량</th>
										<th>개당가격</th>
										<th>수량대비가격</th>
										<th>확인</th>
									</tr>
									<tr>

										<td class="col1">
										<img src="./img_product/${my.product_img}"></td>
										<td class="col2">
											<div>
											     <input type="hidden" name="cart_id" value ="${my.cart_id }">
												<input id="id" type="hidden" name="product_img" type="hidden" value="./img_product/${my.product_img}">
												<input id="id" type="hidden" name="id"  value="${my.id}">
												<input id="product_name"  name="product_name" type="text" value="${my.product_name}">
												<br>
												<input id="product_cod" name="receipt_product_cod" type="text" value="${my.product_cod}">
												<br>
											</div>
										</td>
										<td><input class=pluss type='button' value='+'>

											<div id='result'>
												<input name="salequantity" value="${my.product_quantity}">
											</div> <input class=pluss type='button' value='-' /></td>
										<td class="onetoonprice">${my.product_price}</td>

										<td class="quantityprice">${my.product_price*my.cart_quantity}</td>

										<td class="col5"><input type="checkbox" class="finalladd"></td>
									</tr>

								</c:forEach>
								<td id="finallsum" colspan="6"><div class="finallpurchace">
										<div class="subfinallpurchace">합계금액:</div>
										<input id="ajaxfinallsum" type="text" name="finallsum"
											value="0">
									</div></td>
							</tbody>
						</table>
						<div class="isorder">
							<div class="wannadelete">
								<div class="deletebtn">
									<button type="button" class="allchoicebtn">전체선택</button>
									<button type="button" class="allclearbtn">전체선택해제</button>
									<button type="button" class="dropcart">장바구니비우기</button>
								</div>
							</div>
							<a href="productlist.do" class="isorder_1">계속 쇼핑하기</a>
							<input id="lastorder" class="isorder_2" type="submit" value="주문하기">
					</form>
			</c:otherwise>
		</c:choose>

		<div class="paymodal"></div>
		<button type="button" id="form">폼객체확인하기 버튼</button>
	</div>

<script>
$("#form").on("click",()=>{
	
	let forminfo=document.getElementById("forminfo");
	console.log(forminfo);
	
})

</script>





	<script>
		var arraycheck = [];
		var quantityprice = [];
		var total = 0;
		$(document)
				.ready(
						function() {

							$("#lastorder").attr("disabled", true);

							$("#lastorder").on("mouseenter", function() {
								/* alert("먼저 상품 확인 체크를 눌러주세요!"); */
							})

							$(".allchoicebtn")
									.on(
											"click",
											function() {

												$("input[class=finalladd]")
														.each(
																function(index) {
																	if ($(this)
																			.is(
																					":checked") == false) {
																		/* console.log("체크박스갯수는");
																		console.log($(this));
																		console.log("체크박스갯수 길이는");
																		console.log($(this).size()); */
																		arraycheck
																				.push(this);
																	}
																})

												console.log(arraycheck);
												$.each($(arraycheck), function(
														index) {

													$(arraycheck).prop(
															"checked", true);
													total += parseInt($(this)
															.parent().prev()
															.text());
													console.log("total");
													console.log(total);
												})
												let alreadytotal = parseInt($(
														"#ajaxfinallsum").val());
												total = total + alreadytotal
												$("#ajaxfinallsum").val(total);

												//	$("input[class=finalladd]").trigger("click");
												//obj가 자바스크립트 객체였네  그래서 제이쿼리 text() val() 인식을 못함
												/* 	$.each($("td[class=quantityprice]"),function(index,obj){
													           parseInt
														total+=parseInt(obj.innerText);
													
													})  */

												$("input[class=pluss]").attr(
														"disabled", true);
												$(".allchoicebtn").attr(
														"disabled", true);
												$("#lastorder").attr(
														"disabled", false);
											})

							$(".allclearbtn").on(
									"click",
									function() {
										//prop은 이미 반영된것을 인지 못하는듯
										//그래서 지금 attr 해보니 작동됨
										$("input[class=finalladd]").attr(
												"checked", false);
										arraycheck.length = 0;
										total = 0;
										$("#ajaxfinallsum").val(0);
										$(".allchoicebtn").attr("disabled",
												false);
										$("#lastorder").attr("disabled", true);
									})

							$(".dropcart")
									.on(
											"click",
											function() {
												let deletearry = [];
												let url = '';

												//location.href="/dropcart.do"

												$("input[class=finalladd]")
														.each(
																function(index) {
																	if ($(this).is(":checked") == true) {
																		let x = $(
																				this)
																				.parent()
																				.prev()
																				.prev()
																				.prev()
																				.prev()
																				.children()
																				.children(
																						"#product_cod")
																				.val();

																		deletearry
																				.push(x);
																		console
																				.log(x);
																	}
																})
												console.log("ddd->>"
														+ deletearry.length);

												for (let i = 0; i < deletearry.length; i++) {

													if (i == 0) {
														url += 'dropcart.do?product_cod='
																+ deletearry[i]
														console
																.log('deletearry[0]')
														console
																.log(deletearry[i])
													}
													if (i == 1) {
														console
																.log('deletearry[1]')
														url += '&'
																+ 'product_cod='
																+ deletearry[i]
																+ "&";
														console
																.log(deletearry[i])
													}
													if (i > 1) {
														console
																.log('deletearry[2]')
														url += 'product_cod='
																+ deletearry[i]
																+ "&";
														console
																.log(deletearry[i])
													}
												}
												url += "&" + "id="
														+ '${userId}';
												console.log(url);
												location.href = url;
											})

							$("#phonesms").on("click", function() {
								location.href = "payforsms.jsp?smsfor=pay";

							})

							//////////////////////

							$(".paymodal").hide();
							$(".isorder_2").on("click", function() {
								$(".comeonmodal").css({
									"position" : "relative"
								});
								$(".paymodal").css({
									"position" : "absolute",
									"width" : "100%",
									"background-color" : "white",
									"top" : "0px"
								});
								$(".paymodal").show();

								$("#check_modules").trigger("click");
								$("#check_modules").hide();

							})

							if ($("#goback").attr("data-val") == 'goback') {
								location.href = "login.jsp"
							}

							$("input[class=pluss]")
									.on(
											"click",
											function() {
												var qunitity;
												if ($(this).val() == "+") {
													alert("특가상품은 한개씩입니다.");

												} else if ($(this).val() == "-") {

											/* 	  console.log($(this).prev().prev().parent().prev().prev().parent().prev().remove())
												 
										 	 console.log($(this).prev().prev().parent().prev().prev().parent().remove())  */
												/*    console.log($(this).prev().prev().parent().prev().prev().parent().prev().parent())  */
												  
												 
																	
											 $("#ajaxfinallsum").val(0);
													console.log("거짓이면 마이너스")
													let that = $(this);
													let ids = $(this).parents()
															.prevAll(".col2")
															.children()
															.children('#id')
															.val();
													let product_cods = $(this)
															.parents()
															.prevAll(".col2")
															.children()
															.children(
																	'#product_cod')
															.val();
													let minnus = parseInt($(this).prev().text()) - 1;
													console.log("??->>"+ $(this).parents().prevAll(".col2").children(
																					'#product_cod')
																			.val());
													console.log("ids->>" + ids);
													console
															.log("product_cods->>"
																	+ product_cods);
													console.log("minnus->>"
															+ minnus)
													$(this).prev().text(minnus)
													//여기서부터는 의심가면 무조건 주석처리하며 할것
													// sql매퍼 다시 고쳐야함
													// location.href = "isZeor.do?id="+ids+"&product_cod="+product_cods ; 
													$
															.ajax({
																url : "ajaxisZeor.do?",
																data : {
																	
																	"id" :"${userId}",
																	"plusone" : "1",
																	"product_cods" : product_cods
																},
																type : "POST", //type=우리가보내는 타입
																success : function(
																		val) {
																	console
																			.log("취소시 this의 바인드 변수 that값은");
																	console
																			.log(that);
																	if (val == "") {
																		

																		 that.prev().prev().parent().prev().prev().parent().prev().remove()
																		  that.prev().prev().parent().prev().prev().parent().remove()
																		window.location.reload(true);
																

																	} else {

																		let qunitity = val;
																		let oneprice = that.parent().next().text();
																		let already = that.parent.next().next().text();
																		that.parent().next().next().text(already- oneprice);																		
																			
																	}

																}

															}) 

												}

											})

							$("input[class=finalladd]")
									.on(
											"click",
											function() {
												let ischecked = $(this).is(
														':checked');

												console.log("ischecked->>"
														+ ischecked);
												if (ischecked) {
													$("#lastorder").attr(
															"disabled", false);
													arraycheck.length = 0;
													total = 0;
													$(this).prop('checked',
															true);
													console.log("배열사이즈");
													console.log($(this).size());
													if ($(this).size() == 4) {

														$(".allchoicebtn")
																.attr(
																		"disabled",
																		true);
													}
													console.log($(this)
															.parents().prev()
															.prev().prev()
															.children());
													$(this).parents().prev()
															.prev().prev()
															.children().attr(
																	"disabled",
																	true);

													/* 		$("input[class=pluss]").attr("disabled", true) */
													let finalladd = $(this)
															.parent().prev()
															.text();
													let x = $("#finallsum")
															.children()
															.children(
																	"#ajaxfinallsum")
															.val();
													let xx = parseInt(finalladd)
															+ parseInt(x);
													console
															.log("finalladd->>>>>>>"
																	+ finalladd)
													console.log("xx->>>>>>>"
															+ xx)

													$("#finallsum")
															.children()
															.children(
																	"#ajaxfinallsum")
															.val(xx);
													$("#lastorder").attr(
															"disabled", false);
												} else {
													$(this).prop('checked',
															false);
													$(".allchoicebtn").attr(
															"disabled", false);
													$("input[class=pluss]")
															.attr("disabled",
																	false);
													let finalladd = $(this)
															.parent().prev()
															.text();
													console.log($(this)
															.parent().prev()
															.prev());
													let x = $("#finallsum")
															.children()
															.children(
																	"#ajaxfinallsum")
															.val();
													let xx = parseInt(x)
															- parseInt(finalladd);
													console.log("빼기에서 전체가:"
															+ finalladd);
													console.log("뺄가격:" + x);
													console.log("뺄가격:" + xx);
													$("#finallsum")
															.children()
															.children(
																	"#ajaxfinallsum")
															.val(xx);
													arraycheck.length = 0;
													total = 0;
													$("#lastorder").attr(
															"disabled", true);
												}

											})

						})
	</script>

	<script>
		
	</script>



</body>
</html>