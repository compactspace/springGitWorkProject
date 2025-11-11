<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	
<!DOCTYPE html>
<html lang="ko">
<head>
<sec:csrfMetaTags />
<meta charset="UTF-8" />
<title>주문 확인 및 결제</title>
<style>

/* === 기본 스타일 === */
body {
	margin: 0;
	font-family: sans-serif;
	background-color: #f3f5f7;
}

.wrapper {
  max-width: 800px;
  margin: 60px auto;
  padding: 40px;
  background: #ffffff;
  border-radius: 12px;
  box-shadow: 0 4px 16px rgba(0,0,0,0.08);
}

.wrapper h2 {
  font-size: 24px;
  font-weight: 700;
  color: #222;
  margin-bottom: 24px;
  border-bottom: 2px solid #007bff;
  padding-bottom: 10px;
}

/* === 상품 목록 === */
#product-list {
  margin-bottom: 32px;
}

.product {
  background: #fafbfc;
  border: 1px solid #e5e7eb;
  border-radius: 10px;
  padding: 16px;
  display: flex;
  align-items: center;
  margin-bottom: 16px;
  transition: all 0.25s ease;
}

.product:hover {
  box-shadow: 0 3px 10px rgba(0,0,0,0.05);
  transform: translateY(-2px);
}

.product img {
  width: 100px;
  height: 100px;
  object-fit: cover;
  border-radius: 8px;
  margin-right: 20px;
}

.product-info h4 {
  font-size: 17px;
  margin-bottom: 6px;
  color: #333;
}
.product-info p {
  font-size: 14px;
  color: #555;
  margin: 2px 0;
}

/* === 주문자 정보 입력란 === */
.wrapper > div:not(.info-section):not(#product-list) {
  display: flex;
  align-items: center;
  margin-bottom: 12px;
}

label {
  display: inline-block;
  width: 140px;
  font-weight: 600;
  color: #333;
}

input[type="text"],
input[type="number"] {
  flex: 1;
  padding: 10px 12px;
  border: 1px solid #ccc;
  border-radius: 6px;
  font-size: 14px;
  transition: border-color 0.2s;
}

input[type="text"]:focus,
input[type="number"]:focus {
  outline: none;
  border-color: #007bff;
  box-shadow: 0 0 0 3px rgba(0,123,255,0.15);
}

.error-msg {
  margin-left: 10px;
  font-size: 13px;
  color: #e74c3c;
}

/* === 결제 정보 === */
.payment-info {
  background: #f8f9fa;
  border: 1px solid #e1e4e8;
  border-radius: 10px;
  padding: 20px;
  margin-top: 28px;
}

.payment-info h3 {
  font-size: 18px;
  color: #222;
  margin-bottom: 14px;
}

.payment-info input[readonly] {
  background: #e9ecef;
}



#test {
  background: linear-gradient(135deg, #007bff, #0056d2);
  border: none;
  color: #fff;
  font-weight: 600;
  padding: 10px 24px;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.2s ease;
}

#test:hover {
  background: linear-gradient(135deg, #0056d2, #003f9c);
  transform: translateY(-1px);
  box-shadow: 0 4px 10px rgba(0,0,0,0.1);
}




/* === 모달 스타일 === */
.modal-backdrop {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.6);
	display: none;
	z-index: 1000;
}

.modal {
	min-height: 720px;
	background: #fff;
	border-radius: 12px;
	max-width: 820px;
	max-width: 95%;
	box-sizing: border-box;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	font-family: 'Arial', sans-serif;
}

.modal-header {
	font-size: 22px;
	font-weight: bold;
	margin-bottom: 20px;
	text-align: center;
	position: relative;
}

.modal-close {
	position: absolute;
	top: 5px;
	right: 10px;
	font-size: 20px;
	cursor: pointer;
	color: #aaa;
}

.modal-close:hover {
	color: #000;
}

.card-button {
	display: block;
	width: 100%;
	padding: 12px;
	margin: 10px 0;
	border-radius: 8px;
	border: none;
	cursor: pointer;
	color: #fff;
	font-weight: bold;
	font-size: 16px;
}

.card-hyundai {
	background: #1e2d60;
}

.card-shinhan {
	background: #0046ff;
}

.card-kb {
	background: #ff9800;
}

.card-samsung {
	background: #666;
}

.input-group {
	margin-bottom: 18px;
}

.input-group label {
	display: block;
	margin-bottom: 6px;
	font-weight: bold;
}

.card-number-inputs input {
	width: 60px;
	padding: 10px;
	margin-right: 6px;
	font-size: 16px;
	border-radius: 4px;
	border: 1px solid #ccc;
	text-align: center;
}

input.cvv-input, input.pw-input {
	width: 100%;
	padding: 10px;
	font-size: 16px;
	border-radius: 4px;
	border: 1px solid #ccc;
	text-align: center;
}

.modal-footer {
	text-align: center;
	margin-top: 25px;
}

.modal-footer button {
	padding: 10px 20px;
	font-weight: bold;
	border-radius: 6px;
	border: none;
	font-size: 15px;
	cursor: pointer;
}

button.next-btn {
	background: #0070c0;
	color: white;
	margin-left: 10px;
}

button.back-btn {
	background: #ccc;
}

/* step1 모달  시작*/
.modal-body-grid {
	display: grid;
	grid-template-columns: 90px 600px 150px;
	align-items: flex-start;
	min-height: 700px;
}

.modal-body-grid .col-1, .modal-body-grid .col-2, .modal-body-grid .col-3
	{
	padding: 10px;
	height: 100%;
}

.modal-body-grid .col-1, .modal-body-grid .col-3 {
	background: #FF4040;
}

.col-box {
	display: flex;
	flex-direction: column;
}

.col-1 {
	color: #fff;
}

.col-box-col-3 {
	height: 100%;
	justify-content: space-between;
}

.col-box-summary {
	align-items: flex-start;
	color: #fff;
}

.row-box.selectbox {
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 8px 0;
	border-bottom: 1px dashed #ccc;
}

.row-box.selectbox>div:first-child {
	font-weight: bold;
	font-size: 14px;
	color: #333;
}

.row-box.selectbox>div:last-child {
	text-align: right;
}

#step1-next-btn {
	width: 100%;
}

/*모달 종료 */



@media screen and (max-width: 600px) {
  .wrapper {
    padding: 20px;
  }

  .wrapper > div:not(.info-section):not(#product-list) {
    flex-direction: column;
    align-items: flex-start;
  }

  label {
    width: 100%;
    margin-bottom: 6px;
  }

  #test {
    width: 100%;
  }
}


</style>


<script  src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script type="module" src="http://localhost:7010/fake-pg/script2.js"></script>


<script>

//✅ CSRF 토큰을 모든 AJAX 요청에 자동으로 포함시킴
const token = $("meta[name='_csrf']").attr("content");
const header = $("meta[name='_csrf_header']").attr("content");

$.ajaxSetup({
  beforeSend: function(xhr) {
    xhr.setRequestHeader(header, token);
  }
});


</script>
</head>
<body>

	<div class="wrapper">
		<h2>주문 상품 확인</h2>
		<div id="product-list"></div>

		<!-- 주문자 정보 -->
		<div>
			<label for="orderer_name">주문자 이름:</label> <input type="text"
				id="orderer_name" name="orderer_name" /> <span class="error-msg"
				id="error_orderer_name" style="color: red;"></span>
		</div>
		<div>
			<label for="orderer_email">이메일:</label> <input type="text"
				id="orderer_email" name="orderer_email" /> <span class="error-msg"
				id="error_orderer_email" style="color: red;"></span>
		</div>
		<div>
			<label for="orderer_phone">연락처:</label> <input type="text"
				id="orderer_phone" name="orderer_phone"
				placeholder="숫자만 입력 (예: 01012345678)" /> <span class="error-msg"
				id="error_orderer_phone" style="color: red;"></span>
		</div>

		<!-- 결제 정보 -->
		<div class="info-section payment-info">
			<h3>결제 정보</h3>
			<div>
				<label for="amount">총 결제 금액:</label> <input type="number"
					id="amount" name="amount" readonly />
			</div>
			<br />
			<button id="test">결제 테스트 (localStorage 기반)</button>
		</div>
	</div>

	<!-- === 결제 모달 === -->
<!-- 	<div class="modal-backdrop" id="paymentModal">
		<div class="modal" id="modalStep1">
			 <div class="modal-header">카드 선택
  <span class="modal-close" onclick="closeModal()">×</span>
</div>

			<div class="modal-body-grid">
				<div class="col-1">
					<p style="font-size: 18px; font-weight: bold;">신용카드</p>
				</div>

				<div class="col-2">
					약관들
					<div class="row-box selectbox">
						<div>전자금융거래 이용약관</div>
						<div>
							<input type="checkbox" class="term-check">
						</div>
					</div>
					<div class="row-box selectbox">
						<div>개인정보 수집 및 이용 동의</div>
						<div>
							<input type="checkbox" class="term-check">
						</div>
					</div>

					카드 버튼들
					<div class="card-buttons">
						<button class="card-button card-hyundai" data-card="현대카드">현대카드</button>
						<button class="card-button card-shinhan" data-card="신한카드">신한카드</button>
						<button class="card-button card-kb" data-card="국민카드">국민카드</button>
						<button class="card-button card-samsung" data-card="삼성카드">삼성카드</button>
					</div>
				</div>
				<div class="col-3" style="text-align: right;">
					<div class="col-box col-box-col-3">
						<div class="col-box col-box-summary">
							<p id="product-summary"
								style="font-size: 14px; margin-bottom: 12px; font-weight: bold;">
								상품명 + 외 N건 텍스트가 여기 들어감
							</p>

							<p style="font-size: 16px;">
								총 결제 금액: <strong id="modal-total-amount">₩0</strong>
							</p>
						</div>
						<div>
							<div style="margin-top: 20px;">
								<button id="step1-next-btn" class="next-btn">다음</button>
							</div>
						</div>

					</div>
				</div>

			</div>

		</div>

		<div class="modal" id="modalStep2" style="display: none;">
			<div class="modal-body-grid">

				<div class="col-1">
					<p style="font-size: 18px; font-weight: bold;">카드번호</p>
				</div>

				<div class="col-2">
					<div class="modal-header">카드 번호 및 CVV 입력</div>

					<div class="input-group card-number-inputs">
						<label>카드 번호</label> <input type="text" maxlength="4"
							class="card-num" /> - <input type="text" maxlength="4"
							class="card-num" /> - <input type="text" maxlength="4"
							class="card-num" /> - <input type="text" maxlength="4"
							class="card-num" />
					</div>

					<div class="input-group">
						<label>CVV 번호</label> <input type="text" maxlength="3"
							class="cvv-input" />
					</div>

					<div class="modal-footer">
						<button class="back-btn" id="backToStep1">이전</button>
						<button class="next-btn" id="toStep3">다음</button>
					</div>
				</div>

				✅ 공통 3열
				<div class="col-3" style="text-align: right;">
					<div class="col-box col-box-col-3">
						<div class="col-box col-box-summary">
							<p class="product-summary"
								style="font-size: 14px; margin-bottom: 12px; font-weight: bold;"></p>
							<p style="font-size: 16px;">
								총 결제 금액: <strong class="modal-total-amount">₩0</strong>
							</p>
							<p style="font-size: 14px;" id="selected-card-info"></p>
						</div>
					</div>
				</div>

			</div>
		</div>

		<div class="modal" id="modalStep3" style="display: none;">
			<div class="modal-body-grid">
				<div class="col-1">
					<p style="font-size: 18px; font-weight: bold;">비밀번호</p>
				</div>

				<div class="col-2">
					<div class="modal-header">카드 비밀번호 입력</div>
					<div class="input-group">
						<label>카드 비밀번호 앞 2자리</label> <input type="password" maxlength="2"
							class="pw-input" />
					</div>
					<div class="modal-footer">
						<button class="back-btn" id="backToStep2">이전</button>
						<button class="next-btn" id="toStep4">다음</button>
					</div>
				</div>



				<div class="col-3" style="text-align: right;">
					<div class="col-box col-box-col-3">
						<div class="col-box col-box-summary">
							<p class="product-summary"
								style="font-size: 14px; margin-bottom: 12px; font-weight: bold;"></p>
							<p style="font-size: 16px;">
								총 결제 금액: <strong class="modal-total-amount">₩0</strong>
							</p>
							<p style="font-size: 14px;" id="selected-card-info"></p>
						</div>
					</div>
				</div>
			</div>

		</div>

		<div class="modal" id="modalStep4" style="display: none;">
			<div class="modal-header">결제 최종 확인 및 동의</div>

			<div style="padding: 0 20px; max-height: 400px; overflow-y: auto;">
				<h4>주문 상품</h4>
				<ul id="final-cart-list"
					style="margin-bottom: 20px; list-style: none; padding-left: 0;"></ul>

				<h4>주문자 정보</h4>
				<p id="final-orderer-info" style="margin-bottom: 20px;"></p>

				<h4>결제 정보</h4>
				<p id="final-payment-info" style="margin-bottom: 20px;"></p>

				<div>
					<input type="checkbox" id="agreeCheck" /> <label for="agreeCheck">결제에
						동의합니다.</label>
				</div>
			</div>

			<div class="modal-footer">
				<button class="back-btn" id="backToStep3">이전</button>
				<button class="next-btn" id="finalizePayment" disabled>결제완료</button>
			</div>
		</div>

	</div> -->
	
	
	
	
	<%-- <c:out value="${param.product_name}" escapeXml="false"/> --%>
	
	
<button onclick="openPayment()">결제하기</button>
<!-- 결제 모달 영역 -->
<div id="paymentModal2" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); justify-content:center; align-items:center;">
    <div style="position:relative; background:#fff; width:100%; height:100%; border-radius:10px; display:flex; flex-direction:column;">
        <iframe id="pg-iframe" style="flex:1; border:none;"></iframe>
        <button id="closeModal" style="padding:10px; margin:10px;">닫기</button>
    </div>
</div>



	<script >
	
	let x="${pgUrl}";

	function openPayment() {
	    var merchantId = '${merchantId}';
	    var merchant_uid = "${merchant_uid}";
	    var pgUrl = '${pgUrl}';
	    console.log("pgUrl: " + pgUrl);

	    // iframe src 설정
	    var iframe = document.getElementById('pg-iframe');
	    iframe.src = pgUrl + "?merchantId=" + merchantId;

	    // 모달 표시
	    var modal = document.getElementById('paymentModal2');
	    modal.style.display = 'flex';

	    const amountValue = Number($("#amount").val()) || 0;
	    const formattedAmount = "₩" + amountValue.toLocaleString();

	    
	    
	    
	    // iframe가 로드되면 아이프레임으로 데이터 전달
	    iframe.onload = function() {
	        var paymentData = {
	        	type: "PAYMENT_DATA",  // ← 여기 타입 추가,
	            merchant_id: merchantId,
	            merchant_uid: merchant_uid,
	            amountValue: amountValue,
	            formattedAmount: formattedAmount,
	            cart: cart,
	            selectedCart: selectedCart,
	            userId: 1234,
	            order: {
	                userId: 1234,
	                merchantUid:merchant_uid,
	                items: selectedCart.map(item => ({
	                    productId: item.productCod,
	                    productName: item.productName,
	                    quantity: item.quantity,
	                    pricePerUnit: Number(item.productPrice)
	                })),
	                person: {
	                    name: $("#orderer_name").val().trim(),
	                    email: $("#orderer_email").val().trim(),
	                    phone: $("#orderer_phone").val().trim()
	                }
	            },
	            payment: {
	                paymentNumber: "P1234567890", // 예시로 설정
	                paymentMethod: "Credit Card"  // 예시로 설정
	            }
	        };
	        
	        iframe.contentWindow.postMessage({ type: "PAYMENT_DATA", ...paymentData }, "*");

	       
	        
	        
	        
	        
	        
	       
	        
	   		 onPaymentComplete(function(res) {
		        console.log("JSP에서 SDK 콜백 호출됨:", res);
		        
		        const {success}=res;
		        
		        
		        if(success){
		        	const {successCode,successMassage,imp_uid}=res
		        	
		        	// 아임포트 결제 완료 콜백 등에서 imp_uid 값을 받은 다음
		        	const impUid = imp_uid; // 예: imp_123456789012

		        	// 전송 직전에 깊은 복사 후 impUid 추가
		        	const dataToSend = structuredClone(paymentData);
		        	dataToSend.payment.impUid = impUid;
		        	
		        	
		        	console.log(dataToSend);	
		        	
		        	  $.ajax({
		        			url: "${pageContext.request.contextPath}/api/users/after-successpayment-complement",
		        			type: "POST",
		        			contentType: "application/json",
		        			data: JSON.stringify(dataToSend),
		        			success: function(response) {
		        				console.log("서버 응답:", response);

		        		        if (response.success) {
		        		            alert("결제 성공!");
		        		            // 필요하면 response.data로 후속 처리
		        		            
		        		            
		        		            // localStorage에서 최신 cart 읽기
		        		            const currentCart = JSON.parse(localStorage.getItem("cart") || "[]");
		        		            console.log("-----")
		        		            console.log(currentCart)
		        		           console.log("-----")
		        		            // selected가 true인 아이템만 삭제
		        		            const remainingCart = currentCart.filter(item => !(item && item.selected === true));
		        		            console.log("-----")
		        		            console.log(remainingCart)	            
		        		                 console.log("-----")
		        		            // 남은 아이템 저장      
		        		            
		        		            localStorage.setItem("cart", JSON.stringify(remainingCart));
		        		            
		        		            
		        		            
		        		        } else {
		        		            alert("결제 실패: " + response.message);
		        		        }
		        			},
		        			error: function(xhr, status, error) {
		        				console.error("에러 발생:", error);
		        			}
		        		});
		        	
		        	
		        }else{
		        		//말그대로 결제 실패,
		        	const {errorCode,errorMassage}=res
		        	//씨발	        	  
		        	  $.ajax({
		        			url: "${pageContext.request.contextPath}/api/users/after-successpayment-complement",
		        			type: "POST",
		        			contentType: "application/json",
		        			data: JSON.stringify(paymentData),
		        			success: function(response) {
		        				console.log("서버 응답:", response);

		        		        if (response.success) {
		        		            alert("결제 성공!");
		        		            // 필요하면 response.data로 후속 처리
		        		            
		        		            
		        		            // localStorage에서 최신 cart 읽기
		        		            const currentCart = JSON.parse(localStorage.getItem("cart") || "[]");
		        		            console.log("-----")
		        		            console.log(currentCart)
		        		           console.log("-----")
		        		            // selected가 true인 아이템만 삭제
		        		            const remainingCart = currentCart.filter(item => !(item && item.selected === true));
		        		            console.log("-----")
		        		            console.log(remainingCart)	            
		        		                 console.log("-----")
		        		            // 남은 아이템 저장      
		        		            
		        		            localStorage.setItem("cart", JSON.stringify(remainingCart));
		        		            
		        		            
		        		            
		        		        } else {
		        		            alert("결제 실패: " + response.message);
		        		        }
		        			},
		        			error: function(xhr, status, error) {
		        				console.error("에러 발생:", error);
		        			}
		        		});
		        		
		        	
		        }
		        
		        const currentCart = JSON.parse(localStorage.getItem("cart") || "[]");
	            console.log("-----")
	            console.log(currentCart)
	           console.log("-----")
	            // selected가 true인 아이템만 삭제
	            const remainingCart = currentCart.filter(item => !(item && item.selected === true));
	            console.log("-----")
	            console.log(remainingCart)	            
	                 console.log("-----")
	            // 남은 아이템 저장      
	            
	            localStorage.setItem("cart", JSON.stringify(remainingCart));    	
		        	
		        	
		    }); 
	    
	    
		    
		    
		    
	   		 
	   		 
		    
		    
	    };	    
	  
	    
	    
	    
	    
	    
	    // 부모 페이지에서 아이프레임 메시지 수신
	   /*  window.addEventListener("message", function(e) {
	        if (!e.data) return;
	        console.log("부모가 받은 메시지:", e.data); // 결제 완료 로그
	    }, false); */
	}

	
	

	// 모달 닫기 버튼
	document.getElementById('closeModal').addEventListener('click', function() {
	    var modal = document.getElementById('paymentModal');
	    modal.style.display = 'none';
	    // iframe 초기화
	    document.getElementById('pg-iframe').src = '';
	});
	
	
const cart = JSON.parse(localStorage.getItem("cart") || "[]");
const $list = $("#product-list");
let totalAmount = 0;
const selectedCart = cart.filter(item => !!item && item.selected === true);
const cart_idarray = [];
const cart_quantityArray = [];
const product_codArray = [];

if (cart.length === 0) {
  $list.append("<p>장바구니가 비어 있습니다.</p>");
} else {
	selectedCart.forEach((item) => {
    const img = item.productImg.match(/url\(["']?(.*?)["']?\)/);
    const imgSrc = img ? img[1] : item.productImg;
    const quantity = item.quantity || 1;
    const price = Number(item.productPrice);
    const sum = quantity * price;
    totalAmount += sum;

    cart_idarray.push(item.cartId);
    cart_quantityArray.push(quantity);
    product_codArray.push(item.productCod);

    var $product = $('<div class="product">' +
      '<img src="' + imgSrc + '" alt="' + item.productName + '">' +
      '<div class="product-info">' +
        '<h4>' + item.productName + '</h4>' +
        '<p>수량: ' + quantity + '</p>' +
        '<p>개당 가격: ' + price.toLocaleString() + '원</p>' +
        '<p>합계: ' + sum.toLocaleString() + '원</p>' +
      '</div>' +
    '</div>');
    $list.append($product);
  });
  $("#amount").val(totalAmount);
}

function validateOrdererInfo() {
  let isValid = true;
  $(".error-msg").text("");

  const name = $("#orderer_name").val().trim();
  const email = $("#orderer_email").val().trim();
  const phone = $("#orderer_phone").val().trim();

  if (!name) {
    $("#error_orderer_name").text("주문자 이름은 필수 입력 항목입니다.");
    isValid = false;
  }

  if (!email) {
    $("#error_orderer_email").text("이메일은 필수 입력 항목입니다.");
    isValid = false;
  } else {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
      $("#error_orderer_email").text("유효한 이메일 형식이 아닙니다.");
      isValid = false;
    }
  }

  if (!phone.match(/^\d{10,11}$/)) {
    $("#error_orderer_phone").text("전화번호는 숫자 10~11자리로 입력해주세요.");
    isValid = false;
  }

  return isValid;
}


$("#test").click(() => {
/*   if (!validateOrdererInfo()) {
    alert("주문자 정보를 다시 확인해주세요.");
    return;
  }   */
  openPaymentModal();
});


function openPaymentModal() {
  $("#paymentModal").show();
  $("#modalStep1").show();
  $("#modalStep2, #modalStep3, #modalStep4").hide();
  $(".card-num, .cvv-input, .pw-input").val("");
  $("#agreeCheck").prop("checked", false);
  $("#finalizePayment").prop("disabled", true);
  updatePaymentSummary();
}






function updateStep1NextButtonState() {
	  const allTermsChecked = $(".term-check").length > 0 &&
	                          $(".term-check").filter(":checked").length === $(".term-check").length;
	  
	  console.log(allTermsChecked)	  
	  
	  const cardSelected = selectedCard !== null;

	  const isEnabled = allTermsChecked && cardSelected;

	 /*  $("#step1-next-btn").prop("disabled", !isEnabled); */
	}

$(".term-check").on("change", function () {
	  updateStep1NextButtonState();
	});




let selectedCard = null;

$(".card-button").click(function() {
  selectedCard = $(this).data("card");  
  console.log("✅ 카드 선택됨:", selectedCard);
  updateStep1NextButtonState(); 
  updatePaymentSummary(); // ← 추가!
});


//"다음" 버튼 클릭 시 검증 + 페이지 전환
$("#step1-next-btn").click(() => {
  const allTermsChecked = $(".term-check").length > 0 &&
                          $(".term-check:checked").length === $(".term-check").length;
  const cardSelected = selectedCard !== null;

  if (!allTermsChecked && !cardSelected) {
    alert("약관에 모두 동의하고 카드를 선택해주세요.");
    return;
  } else if (!allTermsChecked) {
    alert("약관에 모두 동의해주세요.");
    return;
  } else if (!cardSelected) {
    alert("카드를 선택해주세요.");
    return;
  }

	  $("#modalStep1").hide();
	  $("#modalStep2").show();
	  updatePaymentSummary();
	});

$("#backToStep1").click(() => {
  $("#modalStep2").hide();
  $("#modalStep1").show();
});

$("#toStep3").click(() => {
  let allFilled = true;
  $(".card-num").each(function() {
    if (!$(this).val().match(/^\d{4}$/)) allFilled = false;
  });
  if (!$(".cvv-input").val().match(/^\d{3}$/)) allFilled = false;
  if (!allFilled) {
    alert("카드 번호 및 CVV를 정확히 입력해주세요.");
    return;
  }
  $("#modalStep2").hide();
  $("#modalStep3").show();
  updatePaymentSummary();
});

$("#backToStep2").click(() => {
  $("#modalStep3").hide();
  $("#modalStep2").show();
});

$("#toStep4").click(() => {
  if (!$(".pw-input").val().match(/^\d{2}$/)) {
    alert("비밀번호 앞 2자리를 입력해주세요.");
    return;
  }
  $("#modalStep3").hide();
  $("#modalStep4").show();
  updatePaymentSummary();
});

$("#backToStep3").click(() => {
  $("#modalStep4").hide();
  $("#modalStep3").show();
});

$("#agreeCheck").change(function() {
  $("#finalizePayment").prop("disabled", !this.checked);
});






$("#finalizePayment").click(() => {
	const orderData = {
			
			  userId: 1234,
			  order: {
			    userId: 1234,
			    items: selectedCart.map(item => ({
			      productId: item.productCod,
			      productName: item.productName,
			      quantity: item.quantity,
			      pricePerUnit: Number(item.productPrice)
			    })),
			    person: {
			      name: $("#orderer_name").val().trim(),
			      email: $("#orderer_email").val().trim(),
			      phone: $("#orderer_phone").val().trim()
			    }
			  },
			  payment: {
			    paymentNumber: "P1234567890", // 예시로 설정
			    paymentMethod: "Credit Card" // 예시로 설정
			  }
			};
	
	  
	  
	  

			  console.log(orderData);

  
  console.log(orderData); 
  
  /* $("#paymentModal").hide(); */
  
  $.ajax({
		url: "${pageContext.request.contextPath}/api/users/payment",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify(orderData),
		success: function(response) {
			console.log("서버 응답:", response);

	        if (response.success) {
	            alert("결제 성공!");
	            // 필요하면 response.data로 후속 처리
	            
	            
	            // localStorage에서 최신 cart 읽기
	            const currentCart = JSON.parse(localStorage.getItem("cart") || "[]");
	            console.log("-----")
	            console.log(currentCart)
	           console.log("-----")
	            // selected가 true인 아이템만 삭제
	            const remainingCart = currentCart.filter(item => !(item && item.selected === true));
	            console.log("-----")
	            console.log(remainingCart)	            
	                 console.log("-----")
	            // 남은 아이템 저장      
	            
	            localStorage.setItem("cart", JSON.stringify(remainingCart));
	            
	            
	            
	        } else {
	            alert("결제 실패: " + response.message);
	        }
		},
		error: function(xhr, status, error) {
			console.error("에러 발생:", error);
		}
	}); 
  
});



function generatePaymentNumber() {
	  // UUIDv4 형식 생성 (랜덤)
	  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
	    const r = Math.random() * 16 | 0;
	    const v = c === 'x' ? r : (r & 0x3 | 0x8);
	    return v.toString(16);
	  });
	}


function closeModal() {
	  $("#paymentModal").hide();
	}
	



//예시, 모달 열 때 호출 (openPaymentModal 내부 또는 별도 함수)
function updatePaymentSummary() {
	
  if (selectedCart.length === 0) {
    $("#product-summary, .product-summary").text("상품이 없습니다.");
    $("#modal-total-amount, .modal-total-amount").text("₩0");
    return;
  }

  const firstProductName = selectedCart[0].productName;
  let summaryText = firstProductName;
  if (selectedCart.length > 1) {
    summaryText += ` 외 ${cart.length - 1}건`;
  }
  

  $("#product-summary, .product-summary").text(summaryText);

  const amountValue = Number($("#amount").val()) || 0;
  const formattedAmount = "₩" + amountValue.toLocaleString();

  $("#modal-total-amount, .modal-total-amount").text(formattedAmount);

  
  
  if (selectedCard) {
	  $("#selected-card-info").text("선택한 카드: " + selectedCard);
  }
}






function updateStep4Summary() {
	/*   console.log("=== updateStep4Summary 시작 ==="); */

	  // 장바구니 상품 리스트 출력
	  const $finalCartList = $("#final-cart-list");
	  $finalCartList.empty();
	/*   console.log("selectedCart 배열:", selectedCart); */

	  selectedCart.forEach(item => {
	    const quantity = item.quantity !== undefined ? item.quantity : 1;
	    const price = Number(item.productPrice);
	    const sum = quantity * price;

	   /*  console.log('item.productName:', item.productName);
	    console.log('quantity:', quantity);
	    console.log('price:', price);
	    console.log('sum:', sum);
	    console.log('상품: ' + item.productName + ', 수량: ' + quantity + ', 가격: ' + price + ', 합계: ' + sum); */

	    $finalCartList.append('<li>' + item.productName + ' - 수량: ' + quantity + '개, 합계: ' + sum.toLocaleString() + '원</li>');
	  });

	  // 주문자 정보 출력
	  const name = $("#orderer_name").val().trim();
	  const email = $("#orderer_email").val().trim();
	  const phone = $("#orderer_phone").val().trim();

	/*   console.log("주문자 이름:", name);
	  console.log("주문자 이메일:", email);
	  console.log("주문자 연락처:", phone); */

	  $("#final-orderer-info").html(
	    '이름: ' + name + '<br />' +
	    '이메일: ' + email + '<br />' +
	    '연락처: ' + phone
	  );

	  // 결제 정보 출력
	  const amountValue = Number($("#amount").val()) || 0;
	  const formattedAmount = "₩" + amountValue.toLocaleString();
	  const cardInfoText = selectedCard ? "선택한 카드: " + selectedCard : "카드가 선택되지 않았습니다.";
/* 
	  console.log("결제 금액:", amountValue);
	  console.log("선택 카드:", selectedCard); */

	  $("#final-payment-info").html(
	    '총 결제 금액: <strong>' + formattedAmount + '</strong><br />' +
	    cardInfoText
	  );

/* 	  console.log("=== updateStep4Summary 끝 ==="); */
	}

	// 스탭4 열릴 때 호출
	$("#toStep4").click(() => {
	  if (!$(".pw-input").val().match(/^\d{2}$/)) {
	    alert("비밀번호 앞 2자리를 입력해주세요.");
	    return;
	  }
	  $("#modalStep3").hide();
	  $("#modalStep4").show();

	  updateStep4Summary();
	});



	$("#agreeCheck").change(function() {
		  $("#finalizePayment").prop("disabled", !this.checked);
		});


// 모달 열릴 때 함수 호출
function openPaymentModal() {
  $("#paymentModal").show();
  $("#modalStep1").show();
  $("#modalStep2, #modalStep3, #modalStep4").hide();
  $(".card-num, .cvv-input, .pw-input").val("");
  $("#agreeCheck").prop("checked", false);
  $("#finalizePayment").prop("disabled", true);

  updatePaymentSummary();  // 여기 추가!
}
</script>
</body>
</html>

