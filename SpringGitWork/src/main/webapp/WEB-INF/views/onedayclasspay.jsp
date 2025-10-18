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
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<style>
body {
	width: 480px;
	margin: 0px auto !important;
	background: #f5f6f8;
	box-shadow: 0 0 17px 3px rgb(171 171 171/ 50%);
	position: relative;
}

.allwarpper {
	width: 480px;
	margin: 0px auto;
	padding-bottom: 67px;
	background-color: #fff;
	padding-right: 0;
	padding-left: 0;
	position: fixed;
	top: 50%;
	margin-top: -387.5px;
}

.header {
	max-width: 480px;
	z-index: 13;
	border-bottom: 0px solid rgb(240, 243, 248);
	margin: 0px auto;
	padding: 0 15px;
	height: 50px;
	background: #fff;
	display: flex;
	flex-direction: row;
	align-content: center;
	align-items: center;
	justify-content: space-between;
}

.header h1 {
	font-size: 16px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: normal;
	word-wrap: break-word;
	display: -webkit-box;
	-webkit-box-orient: vertical;
	-webkit-line-clamp: 1;
	font-weight: 600;
	width: 100%;
	text-align: center;
}

.classinfoarea {
	margin-top: 75px;
	position: relative;
	display: flex;
	flex-direction: row;
	flex-wrap: nowrap;
	align-content: center;
	justify-content: flex-start;
	padding: 0 15px;
}

.img {
	width: 80px;
	height: 80px;
	border-radius: 6px;
	background-position: center;
	background-repeat: no-repeat;
	background-size: cover;
}

.classtype {
	font-size: 14px;
	color: #555555;
}

.classinfo {
	color: #555555;
	line-height: 1;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: normal;
	word-wrap: break-word;
	display: -webkit-box;
	-webkit-box-orient: vertical;
}

.classopen {
	width: 100%;
	color: #000;
	font-weight: 600;
	line-height: 2;
}

.classopenday {
	color: #000;
	font-weight: 600;
	line-height: 2;
	font-size: 14px;
}

.headerlinecut {
	background: #f5f6f8;
	border-top: 10px solid #f0f3f8;
	margin-top: 20px;
	margin-bottom: 20px;
	border: 0;
	height: 10px;
}

.applicantarea {
	
}

.applicanttitle {
	osition: relative;
	display: grid;
	grid-template-columns: auto 10px;
	align-content: center;
	justify-content: space-between;
	color: #252525;
	font-size: 18px;
	align-items: center;
}

.titlename {
	font-weight: 700;
	font-size: 18px;
	line-height: 20px;
}

.applicantname {
	margin-left: 15px;
	margin-right: 15px;
	margin-top: 20px;
	margin-bottom: 20px;
}

.nameinputarea {
	border: 1px solid #dddddd;
	height: 50px;
	margin-top: 5px;
	border-radius: 7px;
}

.applierName {
	width: 95%;
	height: 100%;
	border: none;
	argin-left: 8px;
	padding-left: 8px;
	padding-right: 12px;
	display: inline;
	box-sizing: border-box;
	color: black;
	font-style: normal;
}

.classpricearea {
	padding: 0px 15px;
}

.classpricearea h3 {
	font-size: 18px !important;
}

.classpricearea .row {
	color: #555555;
	display: flex;
	justify-content: space-between;
}

.pricecut {
	background: #f5f6f8;
	height: 2px;
	border-top: 1px solid #eee;
}

.confirmprice {
	color: #ff5862;
}

.payarea {
	padding: 0px 15px;
}

.payarea h3 {
	text-align: right;
	font-size: 18px !important;
}

#insertreserveinfo {
	display: none;
}

@media screen and (max-width: 701px) {

 .allwarpper{max-width: 344px;}
 
}
</style>
<script>


/* "&onedayclass_name="+$(".onedayclass_name").text()
+"&onedayclass_info="+$(".onedayclass_info").text()
+"&onedayclass_price="+$("#onedayclass_price").val(); */


let y="<%=request.getParameter("onedayclass_name")%>"
let x=${user_code};
console.log(x)

window.onload=()=>{
	
	
	
	
	
	let merchant_uid;
	let IMPKEY = "imp77544746";
var IMP = window.IMP; // 생략가능
	
	// imp 객체를 가맹점식별코드로 초기화 한다 암기
	// 물론  위에 스크립트 불러와야함
	
	IMP.init(IMPKEY);
	
							   //test(navigator.userAgent)  헤더 정규패턴??
	var isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent) ? true : false;
	   
	//모바일이 아닌 경우 스크립트
	$("#check_module").click(function () {
		merchant_uid=new Date().getTime();
	//IMP.request_pay 를 요약하자면 첫 번째 매개변수 {} 꼴에서 데이터를 넣어 통신 요청을하고
		// 두번째 매개인자인 콜백함수 fucntion(rsp)가 아작스의 success함수처럼 응답을 받아와 처리하는듯
		IMP.request_pay({
			pg: "danal_tpay.9810030929", 
			pay_method: 'card',
			//callback에서 결제가 성공하면 rsp의 imp_uid와 merchant_uid를 가맹점 서버에 인자로 전달
			//또한 추후 취소 api나 주문조회 api에서도 필요하므로 데이터베이스 컬럼에 다시 추가하자. ㅠ
			merchant_uid: merchant_uid,
			
			name: "<%=request.getParameter("onedayclass_name")%>",				
			<%-- 개발 편의를 위해 지금 결제 금액을 100원으로 고정했으나 추후는 파라미터로 넣자. 
			amount: "<%=request.getParameter("onedayclass_price")%>", --%>	
			amount:100,
			buyer_name: ${user_code},			
			buyer_postcode: '123-456',
			}, function (rsp) {//아작스의 함수 success 비슷 rsp 는 성공 에러 다 받음 	
			
				console.log(rsp)
				
				if (rsp.success) {	
						
					    console.log(rsp.success)
						console.log(rsp.merchant_uid)	
					
					chk = true;
				} else {
					var msg = '결제에 실패했다 자식아';
					msg += '\n에러내용 : ' + rsp.error_msg;
					alert(msg);
					chk = false;
				}
				if(chk==true){					
					alert("트리거 작동시작");		
					$("#insertreserveinfo").trigger("click");	
				
				}
		}); 
	
	});	//결제 AIP호출 종료
	
	
	
	$("#trigertest").click(()=>{
		merchant_uid=new Date().getTime();
		$("#insertreserveinfo").trigger("click");	
		
	})
	
	
	
	//결제 성공후 트리거에 의해 작동되는 함수
	$("#insertreserveinfo").click(function () {
		
		
		 $.ajax({
			url : "insertreserveinfo.do",
			data : {merchant_uid:merchant_uid,onedayclass_num:"<%=request.getParameter("onedayclass_num")%>", user_code:${user_code}, openday:"<%=request.getParameter("openday")%>" ,rest:"<%=request.getParameter("rest")%>"},
			success : function(val){
				console.log("트리거 성공")
				if(val=="true"){
					alert("잠시후다시 해주세요");
				}else if(val=="false"){
					alert("결제에 성공했습니다.");
					
					window.location.replace("/finall/mainhome.jsp")
					
				}
				
				}
			
		}); 
		 
	});//결제 성공후 트리거에 의해 작동되는 함수종료
	
	
	
}




</script>
</head>
<body>

	<div class="allwarpper">

		<div class="header">
			<div class="leftheader">뒤로</div>
			<h1>결제하기</h1>
			<div class="rightheader">뒤로</div>
		</div>


		<div class="classinfoarea">

			<div class="imginfoarea">
				<div class="img"
					style="background-image:url(<%=request.getParameter("reserve_img")%>)">

				</div>

			</div>

			<div class="textinfoarea">
				<!--나중 백단으로 <input type="hidden" 은 이자리에 추가>  -->

				<div class="classcontent">
					<span class="classtype">원데이클래스</span>
				</div>
				<div class="classinfo">
					<%=request.getParameter("onedayclass_info")%>
				</div>
				<div class="classopen">
					개설일: <span class="classopenday"> <%=request.getParameter("openday")%>
					</span>
				</div>

			</div>

		</div>

		<hr class="headerlinecut"></hr>

		<div class="applicantarea">
			<!-- 백단 연결시 <input type="hidden" 신청자명 추가자핮.> -->
			<div class="applicanttitle">
				<span class="titlename"> 신청자이름 </span>
			</div>

			<div class="applicantinsert">
				<div class="applicantname">
					<span>이름</span>
					<div class="nameinputarea">
						<input type="text" class="applierName" placeholder="이름을 입력해주세요">
					</div>
				</div>
			</div>

		</div>

		<hr class="headerlinecut"></hr>

		<div class="classpricearea">
			<h3>결제금액</h3>

			<div class="row">
				<div class="pricename">클래스 금액</div>
				<div class="price">
					<span><%=request.getParameter("onedayclass_price")%></span>
				</div>
			</div>

			<div class="row">
				<div class="pricename">할인금액</div>
				<div class="price">
					<span>0원</span>
				</div>
			</div>

			<div class="row">
				<div class="pricename">추가선택</div>
				<div class="price">
					<span>없음</span>
				</div>
			</div>

			<div class="row">
				<div class="pricename">쿠폰 할인금액</div>
				<div class="price">
					<span>0원</span>
				</div>
			</div>

			<div class="row">
				<div class="pricename">포인트 할인금액</div>
				<div class="price">
					<span>0원</span>
				</div>
			</div>
			<hr class="pricecut">

			<div class="row">
				<div class="pricename">최종 결제 금액</div>
				<div class="confirmprice">
					<span><%=request.getParameter("onedayclass_price")%></span>
				</div>
			</div>
		</div>

		<hr class="headerlinecut"></hr>

		<div class="payarea">
			<h3 id="check_module">결제하기</h3>

		</div>

		<button id="insertreserveinfo" type="button">컨트롤러</button>

<button id="trigertest" type="button">결제가 됬다는 가정하에 결제후 삽입하는 버튼 트리거 테스트</button>
	</div>
	<!-- allwarpper 종료 -->







	${user_code}
	<%=request.getParameter("onedayclass_num")%>
	<%=request.getParameter("openday")%>
</body>
</html>