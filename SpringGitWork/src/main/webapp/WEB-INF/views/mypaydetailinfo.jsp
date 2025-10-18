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
	display: flex;
    flex-direction: column;
	position: relative;
	max-width: 560px;
	/* 	max-height: 688px; */
	margin: 0 auto;
	width: 560px;
	background-color: rgb(171 171 171/ 50%);
	box-shadow: 0 0 17px 3px rgb(171 171 171/ 50%);
	grid-template-rows: 70% 30%;
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
	max-height: 890px;
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
	/* display: none */
	
}

.paycontent {
	/* background-color: white; */
	
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

.payinfolabel {
	display: grid;
	grid-template-columns: 50% 50%;
}

.payinfoarea {
	margin-left: auto;
	margin-top: 10px;
	margin-right: auto;
	width: 95%;
	background: white;
	border-radius: 10px 10px 10px 10px;
}

.cancelcontent .cancelname {
	padding: 10px 10px;
	text-align: right;
	color: white;
	font-weight: 700;
	background: #1e81f8;
}

.cancelinfo {
	height: 70%;
	margin-left: auto;
	margin-top: 5px;
	margin-right: auto;
	width: 95%;
	background: white;
	border-radius: 10px 10px 10px 10px;
	justify-content: space-between;
	display: flex;
	flex-direction: column;
}

.cancelinfo  #cancelbtn {
	padding-right: 10px;
	text-align: right;
	padding-bottom: 10px;
	color: #98CBFD;
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
		
		
	}//윈도우 함수 종료
</script>

</head>
<body>
	<div class="allwarpper">
	
		<%@ include file="mobileNave.jsp"%>

		<div class="paymentstatus">
<!-- 
			<h3 id="payarea" class="payarea">결제상세조회</h3>
			<h3 id="paycancelarea" class="paycancelarea">취소상세조회</h3> -->

		</div>

		<div id="content1">
			<h3 id="header1">주문번호:${mypaydetailinfo.get(0).receipt_merchant_uid}</h3>
		</div>
		<div class="totallpayment">
			<h3 class="totallpaymentinfo">주문번호 상세조회</h3>
		</div>
		<div id="bodywrapper">
		
		<c:choose>
		
		
	<c:when test="${iscancelinfo eq 'cancelinfo'}">
	<div class="paycontent">			
				<div class="hidearea">
					<!--ㅂㄷ ㅂㄷ set 변수를 안속에 넣어서 계석 0 0 0 됨 위치도 중요함 ㅂㄷ ㅂㄷ  -->
					<c:set var="canceltotalprice" value="0" />
					<c:forEach items="${mypaydetailinfo}" var="paydetail"
						varStatus="status">

						<%-- 	<input type="hidden" value="${list.add(first.reservestatus)}"> --%>
						<c:set var="receipt_merchant_uid"
							value="${paydetail.receipt_merchant_uid}" />
						<c:set var="receipt_paid_amount"
							value="${paydetail.receipt_paid_amount}" />
						<c:set var="cartvo" value="${paydetail.cartvo}" />
						<c:set var="cartvosize" value="${paydetail.cartvo.size()}" />
						<c:set var="orderinfovo" value="${paydetail.orderinfovo}" />

						<!-- 어쩔수 없음 데이터를 이딴식으로 받아와서 중첩 포이치로 돌려야함  -->
						<c:forEach items="${orderinfovo}" var="orderinfo">


							<c:if test="${orderinfo.orderinfo_pay eq 'no'}">

								<!-- 어쩔수 없음 데이터를 이딴식으로 받아와서 중첩 포이치로 돌려야함  -->
								<div class="payinfoarea">
									<div class="payinfolabel">


										<c:forEach items="${cartvo}" var="cart" begin="0"
											end="${cartvosize}">


											<div class="Section2_2">
												<!-- 2번째 체험상품사진 -->

												<img class="reserve_img"
													src="./img_product/${cart.product_img}" />
												<div class="classname">
													<span>상품명:${cart.product_name}</span>

												</div>
											</div>

											<div class="Section2_3">


												<div class="applicantinfoarea">
													<div class="detail">
														<span>결제수량: ${cart.cart_quantity}</span>
													</div>

													<div class="detail">
														<span>개당가: ${cart.product_price}</span>
													</div>
													<div class="detail">
														<span>수량가격:
															${cart.cart_quantity*cart.product_price}</span>
													</div>

													<div class="detail">
														<span>결제취소일: ${orderinfo.orderinfo_create}</span>
													</div>
												</div>
												<c:set var="canceltotalprice"
													value="${canceltotalprice+cart.cart_quantity*cart.product_price}" />
											</div>
										</c:forEach>
									</div>
								</div>
							</c:if>
						</c:forEach>
					</c:forEach>
				</div>
			</div>
			<div class="cancelcontent">

				<h3 class="cancelname">취소정보</h3>
				<div class="cancelinfo">
					<h3>
						총취소금액:
						<c:out value="${canceltotalprice}" />
					</h3>
					
					<div id="cancel">
						취소완료
					</div>
			
				</div>
			</div>
	
	</c:when>
	<c:otherwise>
	<div class="paycontent">			
				<div class="hidearea">
					<!--ㅂㄷ ㅂㄷ set 변수를 안속에 넣어서 계석 0 0 0 됨 위치도 중요함 ㅂㄷ ㅂㄷ  -->
					<c:set var="canceltotalprice" value="0" />
					<c:forEach items="${mypaydetailinfo}" var="paydetail"
						varStatus="status">

						<%-- 	<input type="hidden" value="${list.add(first.reservestatus)}"> --%>
						<c:set var="receipt_merchant_uid"
							value="${paydetail.receipt_merchant_uid}" />
						<c:set var="receipt_paid_amount"
							value="${paydetail.receipt_paid_amount}" />
						<c:set var="cartvo" value="${paydetail.cartvo}" />
						<c:set var="cartvosize" value="${paydetail.cartvo.size()}" />
						<c:set var="orderinfovo" value="${paydetail.orderinfovo}" />

						<!-- 어쩔수 없음 데이터를 이딴식으로 받아와서 중첩 포이치로 돌려야함  -->
						
					<%-- 	<h1>사이즈:${cartvo.size()}</h1>
						<h1>정보:${cartvo}</h1> --%>
											
											
											<!-- 다 나의 업보다.. ㅅㅂ 조인문을 남발해서 그럼   -->		
								<c:choose>									
								<c:when test="${orderinfovo.size() <=1 }">		
						<c:forEach items="${orderinfovo}" var="orderinfo">


							<c:if test="${orderinfo.orderinfo_pay eq 'yes'}">

								<!-- 어쩔수 없음 데이터를 이딴식으로 받아와서 중첩 포이치로 돌려야함  -->
								<div class="payinfoarea">
									<div class="payinfolabel">


										<c:forEach items="${cartvo}" var="cart" begin="0"
											end="${cartvosize}">


											<div class="Section2_2">
												<!-- 2번째 체험상품사진 -->

												<img class="reserve_img"
													src="./img_product/${cart.product_img}" />
												<div class="classname">
													<span>상품명:${cart.product_name}</span>

												</div>
											</div>

											<div class="Section2_3">


												<div class="applicantinfoarea">
													<div class="detail">
														<span>결제수량: ${cart.cart_quantity}</span>
													</div>

													<div class="detail">
														<span>개당가: ${cart.product_price}</span>
													</div>
													<div class="detail">
														<span>수량가격:
															${cart.cart_quantity*cart.product_price}</span>
													</div>

													<div class="detail">
														<span>결제일: ${orderinfo.orderinfo_create}</span>
													</div>
												</div>
												<c:set var="canceltotalprice"
													value="${canceltotalprice+cart.cart_quantity*cart.product_price}" />
											</div>
										</c:forEach>
									</div>
								</div>
							</c:if>
						</c:forEach>
						</c:when>	
						<c:otherwise>
						
						<c:forEach items="${orderinfovo}" var="orderinfo" end="0">

							<c:if test="${orderinfo.orderinfo_pay eq 'yes'}">

								<!-- 어쩔수 없음 데이터를 이딴식으로 받아와서 중첩 포이치로 돌려야함  -->
								<div class="payinfoarea">
									<div class="payinfolabel">


										<c:forEach items="${cartvo}" var="cart" begin="0"
											end="${cartvosize}">


											<div class="Section2_2">
												<!-- 2번째 체험상품사진 -->

												<img class="reserve_img"
													src="./img_product/${cart.product_img}" />
												<div class="classname">
													<span>상품명:${cart.product_name}</span>

												</div>
											</div>

											<div class="Section2_3">


												<div class="applicantinfoarea">
													<div class="detail">
														<span>결제수량: ${cart.cart_quantity}</span>
													</div>

													<div class="detail">
														<span>개당가: ${cart.product_price}</span>
													</div>
													<div class="detail">
														<span>수량가격:
															${cart.cart_quantity*cart.product_price}</span>
													</div>

													<div class="detail">
														<span>결제일: ${orderinfo.orderinfo_create}</span>
													</div>
												</div>
												<c:set var="canceltotalprice"
													value="${canceltotalprice+cart.cart_quantity*cart.product_price}" />
											</div>
										</c:forEach>
									</div>
								</div>
							</c:if>
						</c:forEach>						
						</c:otherwise>		
						
						
						</c:choose>
					</c:forEach>
				</div>
			</div>
			<div class="cancelcontent">

				<h3 class="cancelname">취소하기</h3>
				<div class="cancelinfo">
					<h3>
						총금액:
						<c:out value="${canceltotalprice}" />
					</h3>
					
					<div id="cancelbtn">
						취소하기
					</div>
					<script>
					$("#cancelbtn").on("click",()=>{
					let receipt_merchant_uid="${receipt_merchant_uid}";
						console.log(receipt_merchant_uid)
						$.ajax({
							url:"cancelpay.do",
							type:"POST",
							data:{"receipt_merchant_uid":receipt_merchant_uid},
							success:(data)=>{
								console.log(data)
								if(data==1){
									alert("결제 취소하셨습니다 메인홈으로 이동합니다.")
									window.location.replace("mainhome.jsp")									
								}else{
									alert("잠시후 다시 시도해주세요")
								}
								
							}
							
						})//아작스 통신 종료
						
					})//클릭함수 종료
					
					</script>
				</div>
			</div>
	
	</c:otherwise>
			
		
			</c:choose>
			
			
			
			
			
			
			
			
			
			
		</div>
	</div>
</body>
</html>