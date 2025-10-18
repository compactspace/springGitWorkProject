<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
.container {
	font-family: Arial, sans-serif;
	max-width: 600px;
	margin: 20px auto;
	padding: 15px;
	border: 1px solid #ddd;
	border-radius: 8px;
}

.title {
	color: #2c3e50;
}

.info-text {
	font-size: 16px;
	color: #555;
}

.info-list {
	list-style: none;
	padding: 0;
	font-size: 14px;
	color: #666;
}

.info-list strong {
	font-weight: bold;
}

.booking-date {
	margin-top: 20px;
	font-weight: bold;
	color: #2980b9;
}

.notice {
	max-width: 600px;
	margin: 20px auto 0;
	font-size: 14px;
	color: #2980b9;
	font-weight: bold;
	text-align: center;
}

/* 새로 추가한 클래스 */
.header-box {
	max-width: 600px;
	margin: 20px auto;
	padding: 15px 20px;
	border: 1px solid #2980b9;
	border-radius: 8px;
	color: #2c3e50;
	font-weight: bold;
}

.header-title {
	font-size: 24px;
	margin-bottom: 8px;
}

.header-date {
	font-size: 16px;
}

.info-row {
	display: flex;
	justify-content: space-between;
	font-family: Arial, sans-serif;
	padding: 8px 0;
}

.divider {
	border: none;
	border-top: 1px solid black;
	margin: 0;
}

.payment-price {
	font-size: 18px;
	color: #d32f2f; /* 붉은 계열 */
	font-weight: bold;
}

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

/* step1 모달 종료 */
</style>


<div class="reservation-section">
	<div class="notice">예약결제전 아래의 내용을 확인해주세요</div>

	<div class="header-box">
		<div class="header-title">${onedayClassInfo.onedayclass_name}</div>
		<div class="header-date">선택한 일정: ${choiceOpendayInfo}</div>
	</div>

	<div class="info-row">
		<div class="left">${onedayClassInfo.onedayclass_name}</div>
		<div class="right">${onedayClassInfo.onedayclass_price}원</div>
	</div>

	<hr class="divider" />

	<div class="info-row">
		<div class="left">결제금액</div>
		<div class="right payment-price">${onedayClassInfo.onedayclass_price}
			원</div>
	</div>

	<div class="container">
		<ul class="info-list">
			<li><strong>주소:</strong> ${onedayClassInfo.address}</li>
			<li><strong>주차:</strong> ${onedayClassInfo.park}</li>
			<li><strong>소요시간:</strong> ${onedayClassInfo.playtime}</li>
			<li><strong>최대 인원:</strong> ${onedayClassInfo.maximum_guests}</li>
		</ul>
	</div>
</div>


<!-- 예약자 섹션 시작 -->
<div class="booker-section container">
	<h2 class="title">예약자 정보</h2>

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

	<!-- 필요하면 더 추가 -->
	<button id="test">결제 테스트 (localStorage 기반)</button>
</div>

<!-- === 결제 모달 === -->
<div class="modal-backdrop" id="paymentModal">
	<div class="modal" id="modalStep1">
		<!--  <div class="modal-header">카드 선택
  <span class="modal-close" onclick="closeModal()">×</span>
</div> -->

		<div class="modal-body-grid">
			<div class="col-1">
				<p style="font-size: 18px; font-weight: bold;">신용카드</p>
			</div>

			<div class="col-2">
				<!-- 약관들 -->
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

				<!-- 카드 버튼들 -->
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
							<!-- 상품명 + 외 N건 텍스트가 여기 들어감 -->
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

			<!-- ✅ 공통 3열 -->
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

</div>

<script type="module">
$("#test").click(() => {
	 if (!validateOrdererInfo()) {
	    alert("주문자 정보를 다시 확인해주세요.");
	    return;
	  }  
	 if(validateOrdererInfo()){
		 
		 openPaymentModal();
	 };
	});
	
	
	
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



function openPaymentModal() {
	  $("#paymentModal").show();
	  $("#modalStep1").show();
	  $("#modalStep2, #modalStep3, #modalStep4").hide();
	  $(".card-num, .cvv-input, .pw-input").val("");
	  $("#agreeCheck").prop("checked", false);
	  $("#finalizePayment").prop("disabled", true);
	  updatePaymentSummary();
	}





function updatePaymentSummary() {	
	
	  let summaryText =" ${onedayClassInfo.onedayclass_name}";  

	  $("#product-summary, .product-summary").text(summaryText);

	  const amountValue = Number("${onedayClassInfo.onedayclass_price}")
	  const formattedAmount = "₩" + amountValue.toLocaleString();

	  $("#modal-total-amount, .modal-total-amount").text(formattedAmount);  
	  
	
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


function updateStep4Summary() {
	  console.log("=== updateStep4Summary 시작 ===");

	  // 1. 상품 정보 출력 (원데이 클래스 단일)
	  const $finalCartList = $("#final-cart-list");
	  $finalCartList.empty();

	  const className = "${onedayClassInfo.onedayclass_name}";
	  const classPrice = Number("${onedayClassInfo.onedayclass_price}");

	  $finalCartList.append(
	    '<li>' + className + ' - 가격: ' + classPrice.toLocaleString() + '원</li>'
	  );

	  // 2. 주문자 정보 출력
	  const name = $("#orderer_name").val().trim();
	  const email = $("#orderer_email").val().trim();
	  const phone = $("#orderer_phone").val().trim();

	  $("#final-orderer-info").html(
	    '이름: ' + name + '<br />' +
	    '이메일: ' + email + '<br />' +
	    '연락처: ' + phone
	  );

	  // 3. 결제 정보 출력
	  const formattedAmount = "₩" + classPrice.toLocaleString();
	  const cardInfoText = selectedCard ? "선택한 카드: " + selectedCard : "카드가 선택되지 않았습니다.";

	  $("#final-payment-info").html(
	    '총 결제 금액: <strong>' + formattedAmount + '</strong><br />' +
	    cardInfoText
	  );

	  console.log("=== updateStep4Summary 끝 ===");
	}



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

	  updateStep4Summary();
	});


$("#backToStep3").click(() => {
$("#modalStep4").hide();
$("#modalStep3").show();
});

$("#agreeCheck").change(function() {
$("#finalizePayment").prop("disabled", !this.checked);
});


$("#finalizePayment").click(() => {

 // 2. 주문자 정보 출력
	  const name = $("#orderer_name").val().trim();
	  const email = $("#orderer_email").val().trim();
	  const phone = $("#orderer_phone").val().trim();

let t='${onedayClassInfo.onedayclass_num}';
if(t===undefined){
console.log(t)
return;
}


	 $.ajax({
                url:  "/finall/api/users/onedayclass-applicant",
                type: "POST",
                data: {
                    reserverest_id: '${reserveRest_id}',
name:name,
email:email,
phone:phone,
price:'${onedayClassInfo.onedayclass_price}',
selectedDate:'${selectedDate}',
onedayclass_num:'${onedayClassInfo.onedayclass_num}'


                },
                success: function (data) {                   
window.location.replace('/finall/');             

            
                },
                error: function (xhr, status, error) {
                    console.error("리뷰 더보기 오류:", error);
                }
            });

	});

</script>
