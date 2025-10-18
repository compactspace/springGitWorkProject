<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
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

#headerwrappers {
	max-width: 560px;
	margin: 0 auto;
	box-shadow: 0 0 17px 3px rgb(171 171 171/ 50%);
}

header {
	position: relative;
	height: 70px;
	background: #fff;
	margin: 0;
}

/* 배치도 생각으로 전체 wrapper 감싼후 마진 오토 */
#bodywrapper {
	display: grid;
	grid-gap: 30px;
	position: relative;
	max-width: 560px;
	/* 	max-height: 688px; */
	margin: 0 auto;
	width: 560px;
	background-color: rgb(171 171 171/ 50%);
	box-shadow: 0 0 17px 3px rgb(171 171 171/ 50%);
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

#content1 {
	border-bottom: 1px solid rgba(230, 230, 230, 0.5);
}

.paymentstatus {
	padding-top: 15px;
	gap: 25px;
	font-size: 15px;
	display: flex;
	justify-content: right;
	color: #98CBFD;
}

.paymentstatus h3 {
	position: relative;
}

.payarea::after {
	content: "";
	position: absolute;
	left: 0px;
	bottom: 0px;
	height: 1px;
	width: 100px;
	background: #1e81f8;
}

.paycancelarea::after {
	content: "";
	position: absolute;
	left: 0px;
	bottom: 0px;
	height: 1px;
	width: 100px;
	background: #1e81f8;
}

.totallpayment {
	text-align: right;
	color: white;
	font-weight: 700;
	background: #1e81f8;
}

.totallpaymentinfo {
	padding: 10px 10px;
}

.content2 {
	background: rgb(255, 255, 255);
	border-radius: 10px;
	display: grid;
	grid-template-columns: 140px auto;
}

.classname {
	color: #252525;
	background: #fff;
	padding: 10px 0px;
	font-weight: 600;
	font-size: 13px;
}

.classname>h2 {
	margin-left: 5px;
}

.classname>p {
	display: block;
	width: 80%;
	margin: 5px 0px 0px 5px;
	font-weight: 300;
}

.Section2_2 {
	width: 100%;
	padding: 10px 10px;
	display: grid;
}

}
#info2 {
	width: 90%;
	float: left;
	margin: 0px 0px 30px 50px;
	color: #333333;
}

.Section2_3 {
	display: grid;
}

.cancelarea {
	text-align: right;
}

.cancelicon {
	height: 20px;
	width: 20px;
}

.applicantinfoarea {
	width: 100%;
	display: flex;
	flex-direction: column;
}

.detail {
	display: flex;
	padding: 10px;
}

.detail span {
	font-size: 14px;
}

.reserve_img {
	display: block;
	width: 130px;
	height: 130px;
}

#info3 {
	width: 90%;
	float: left;
	margin: 0px 0px 30px 50px;
}

.allwarpper {
	position: absolute;
	/*컨텐츠의 위쪽 기준 으로 50% 수직임  */
	top: 50%;
	/*따라서 높의 절반만큼 올려준다. */
	margin-top: -339.5px;
	/*컨텐츠의 왼쪽 기준 으로 50% 이동임  */
	left: 50%;
	/*따라서 컨텐츠의 널비 절반만큼 올려준다. */
	margin-left: -280px;
}

.cancelcontent {
	display: none
}

.paycontent {
	background-color: white;
}

.emptyinof {
	font-size: 20px;
}

.emptyimg {
	text-align: center;
}

.emptyimg img {
	padding: 20px;
}

.goclassreserve {
	padding-bottom: 10px;
}

.goclassreserve span {
	color: white;
	font-weight: 700;
	background: #1e81f8;
	border: 1px solid;
	padding: 5px;
}

@media screen and (max-width: 701px) {
	.allwarpper {
		top: 0px !important;
		margin-top: 0px !important;
		left: 0px !important;
		margin-left: 0px !important;
	}
	#headerwrappers, #bodywrapper {
		margin: 0px 0px !important;
		max-width: 360px !important;
	}
}
</style>

<script type="text/javascript">
	window.onload = function() {
		
		$(".goclassreserve").click(()=>{
			window.location.href="/finall2/onedayclass.jsp"
		})

		
		//payarea
		$(".paycancelarea").removeClass('paycancelarea'); 
		
	
		$("#paycancelarea").click(()=>{
			console.log("클릭")
			$(".payarea").removeClass('payarea'); 
			$("#paycancelarea").addClass('paycancelarea'); 
			$(".cancelcontent").css("display", "block");
			$(".paycontent").css("display", "none");
		})

		$("#payarea").click(()=>{
			console.log("클릭")
			$(".paycancelarea").removeClass('paycancelarea'); 
			$("#payarea").addClass('payarea');
			$(".cancelcontent").css("display", "none");
			$(".paycontent").css("display", "block");
		})

		
		
		
		
		let cancels = document.querySelectorAll(".cancelarea")
		
		for (let cancel of cancels) {
			cancel.addEventListener('click', function(event) {
				/* console.log(this.previousSibling)
				console.log(this.nextSibling)
				console.log(this.nextSibling.value) */
				
			/* 	console.log(event.target)
				console.log(event.target.nextSibling.value) */
				
				//이벤트 타겟 제어법을 몰라..제이쿼리를 씀
			
			let next=	$(event.target).next();
				
			/* 	console.log(next)
				console.log(next.val()) */
			let cancelcode=next.val();
			let openday=next.next().val();
			let onedayclass_num=next.next().next().val();
			let reserveinfo_num=next.next().next().next().val();
			/* console.log("코드는"+cancelcode+"  개설강의 날짜"+openday+"  클래스번호"+onedayclass_num) */
	
				cancelPay(cancelcode,openday,onedayclass_num,reserveinfo_num)
		  })
		}
		

		
		//취소 api호출
		function cancelPay(cancelcode,openday,onedayclass_num,reserveinfo_num) {
	// 결제 취소를 위해 필요한 변수들
	//merchant_uid 토큰발급을 위한 변수
	//cancel_request_amount 결제 금액 취소를 위한변수
	// 그리고 취소가 되었다면 수업의 남은 자리수를 올리기위한 변수들
	//onedayclass_num 과 openday
	//UPDATE reserverest rest=10 WHERE onedayclass_null=? AND openday=?
			
			console.log("코드는"+cancelcode+"  개설강의 날짜"+openday+"  클래스번호"+onedayclass_num+"예약번호는 "+reserveinfo_num)
			
		
		 	$.ajax({
			url : "callcancelapi.do",
			method : "get",
			data : {
				"merchant_uid":cancelcode,
				"cancel_request_amount":100,
				"openday":openday,
				"onedayclass_num":onedayclass_num,
				"reserveinfo_num":reserveinfo_num
			},
			success : function(data) {
				console.log(data);
				if(data ==1 || data=="1"){
					alert("취소처리 되었습니다.");
					window.location.reload();	
				}
				else{
					alert("결제에 실패했습니다. 잠시후 다시 시도해주세요");
				}
				
				
			},
			error : function() {

			}

		})//아작스 통신 종료
		
		}//취소 api호출 종료		
		
		
	
		$("#testbtn").on("click",(e)=>{
			
			let displaycss=$(".hidearea").css("display");
			console.log(displaycss)			
			if(displaycss=="block"){
				$(".hidearea").css({"display":"none"})	
			}
			if(displaycss=="none"){
				$(".hidearea").css({"display":"block"})	
			}
			
			
		})
		
		
		
		
	}//윈도우 함수 종료
</script>

</head>
<body>
	<div class="allwarpper">
		<div id="headerwrappers">
<h1 id="testbtn">jstl버튼 테스트</h1>
			<header>
				<nav>
					<ul>
						<li><a href="onedayclass.jsp">원데이클래스</a></li>
						<li><a href="getworklist.do">참여자분들의 작품</a></li>

						<li><a href="firstgetboad.do?page=0">여러분의게시판</a></li>
						<c:choose>

							<c:when test="${userId ne null && user_where=='finalluser'}">

								<li>${userId}님<a href="myinfo.jsp"> 정보수정</a></li>
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

		<div class="paymentstatus">

			<h3 id="payarea" class="payarea">나의 결제건</h3>
			<h3 id="paycancelarea" class="paycancelarea">나의 취소건</h3>

		</div>

		<div id="content1">

			<h3 id="header1">나의 결제현황</h3>

		</div>


		<div class="totallpayment">
			<h3 class="totallpaymentinfo">총 결제/환불 ${mypayinfo.size()}건</h3>
		</div>
		<div id="bodywrapper">
			<div class="paycontent">



				<c:choose>
					<c:when test="${mypayinfo eq null  }">
						<h1>결제건이 없습니다.</h1>
					</c:when>
					<c:otherwise>

<div class="hidearea">
						<c:forEach items="${mypayinfo}" var="first" varStatus="status">

							<%-- 	<input type="hidden" value="${list.add(first.reservestatus)}"> --%>
							<c:set var="receipt_merchant_uid"
								value="${first.receipt_merchant_uid}" />
							<c:set var="receipt_paid_amount"
								value="${first.receipt_paid_amount}" />

							<c:set var="cartvo" value="${first.cartvo}" />
							<c:set var="cartvosize" value="${first.cartvo.size()}" />
							<c:set var="orderinfovo" value="${first.orderinfovo}" />

		<!-- 어쩔수 없음 데이터를 이딴식으로 받아와서 중첩 포이치로 돌려야함  --> 
							<c:forEach items="${orderinfovo}" var="orderinfo">


								<c:if test="${orderinfo.orderinfo_pay eq 'yes'}">

									<!-- 어쩔수 없음 데이터를 이딴식으로 받아와서 중첩 포이치로 돌려야함  --> 
									<div class="payinfolabel">
										<h1>고객 결제 번호: ${receipt_merchant_uid}</h1>
										<c:forEach items="${cartvo}" var="cart" begin="0" end="${cartvosize}">
											<div class="Section2_2">
												<!-- 2번째 체험상품사진 -->

												<img class="reserve_img"
													src="./img_product/${cart.product_img}" />
												<div class="classname">
													<span>${cart.product_name}</span>

												</div>
											</div>

											<div class="Section2_3">


												<div class="applicantinfoarea">
													<div class="detail">
														<span>결제수량 ${cart.cart_quantity}</span>
													</div>

													<div class="detail">
														<span>개당가 ${cart.product_price}</span>
													</div>
													<div class="detail">
														<span>총가격 ${orderinfo.orderinfo_pay}</span>
													</div>

													<div class="detail">
														<span>결제일 ${orderinfo.orderinfo_create}</span>
													</div>
												</div>
												<%-- 
											 <div>
											<img class="cancelicon" src='./img_infoicon/headcount.png'>
											<span class="cancelarea">취소하기</span> <input type="hidden"
												value="${first.merchant_uid }"> <input type="hidden"
												value="${first.openday}"> <input type="hidden"
												value="${first.onedayclass_num}"> <input
												type="hidden" value="${first.reserveinfo_num}">
										</div>  --%>


											</div>
										</c:forEach>
									</div>


								</c:if>


							</c:forEach>

						</c:forEach>
						</div>
						<%--  <%   if(!list.contains("payment")){%>
							 <h3 class="emptyinfo">예약하신 정보가 없습니다.</h3>
							 <div class="emptyimg">
							 <img src="./img_cart/empy.png">
							 <div class="goclassreserve"><span>클래스예약하러가기</span></div>
							 </div>
							 <%} %>	 --%>
					</c:otherwise>


				</c:choose>
			</div>

			<div class="cancelcontent">
				<c:choose>

					<c:when test="${myreserveinfo eq null  }">
						<h1>취소하신 정보가 없습니다.</h1>
					</c:when>

					<c:otherwise>
						<%-- <c:forEach items="${myreserveinfo}" var="first">

							<c:if test="${first.reservestatus =='paycancel'}">
								<div class="content2">


									<div class="Section2_2">
										<!-- 2번째 체험상품사진 -->
										<img class="reserve_img" src="${first.reserve_img}" />

										<div class="classname">
											<span>${first.onedayclass_name}</span>

										</div>
									</div>

									<div class="Section2_3">


										<div class="applicantinfoarea">
											<div class="detail">
												<span>예약자명 ${first.user_name}</span>
											</div>
											<div class="detail">
												<span>예약자 연락쳐 ${first.user_tell}</span>
											</div>

											<div class="detail">
												<span>결제금액 ${first.onedayclass_price}</span>
											</div>


											<div class="detail">
												<span>결제일 ${first.application_day}</span>
											</div>
										</div>

										<div>
											<img class="cancelicon" src='./img_infoicon/headcount.png'>
											<input type="hidden" value="${first.merchant_uid }">
											<input type="hidden" value="${first.openday}"> <input
												type="hidden" value="${first.onedayclass_num}"> <input
												type="hidden" value="${first.reserveinfo_num}">
										</div>


									</div>

								</div>
							</c:if>


						</c:forEach> --%>
					</c:otherwise>


				</c:choose>

			</div>
		</div>
	</div>
</body>
</html>