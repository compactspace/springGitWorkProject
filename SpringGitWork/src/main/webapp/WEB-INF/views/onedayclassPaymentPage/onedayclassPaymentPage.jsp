<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>

<sec:csrfMetaTags />
<script type="module" src="https://fakepg.r-e.kr:7010/fake-pg/script2.js"></script>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
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
</style>

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


<script>
const currentReserveCart = JSON.parse(localStorage.getItem("reserveCart") || "[]");
const merchantId = '${merchantId}';
const merchant_uid='${merchant_uid}'
const pgUrl = '${pgUrl}';
const selectedDate="${selectedDate}"
const onedayPrice="${onedayClassInfo.onedayclass_price}";
const isEqual="${isEqual}"
const priceUpdated="${priceUpdated}"

	var selectedCart =null
$(document).ready(function() {
	
	if(isEqual==="false"){		
		openUpdatedPriceModal();
	}	
	
	
	if(!wrongEntrance()){
		// alert("날짜를 다시 선택해주세요")
		// 여기서 윈도우 조작
	}
   
	if(currentReserveCart.length===0){
	//	alert("날짜를 다시 선택해주세요")
	};
	
	
	
	console.log(currentReserveCart);
	 selectedCart = currentReserveCart.filter(item => !!item && item.selected === true && item.quantity>0);
	
	
});


/* 
잘못된 진입. 즉 다이렉트로 url요청으로 온경우나/ 사용자가 로컬스토리지를 페이지 진입후 삭제한경우
*/
function wrongEntrance() {
	const merchantId = '${merchantId}';
	const merchant_uid = '${merchant_uid}';
	const pgUrl = '${pgUrl}';
	const selectedDate = "${selectedDate}";

	// 모든 값이 null, undefined, 빈 문자열이 아닐 때만 true
	if (
		merchantId != null && merchantId.trim() !== "" &&
		merchant_uid != null && merchant_uid.trim() !== "" &&
		pgUrl != null && pgUrl.trim() !== "" &&
		selectedDate != null && selectedDate.trim() !== ""
	) {
		return true;
	}

	return false;
}



function openUpdatedPriceModal() {
    const modal = document.getElementById("agreementUpdatedPayAlertModal");
    modal.style.display = "flex";
}

function closeUpdatedPriceModal() {
    const modal = document.getElementById("agreementUpdatedPayAlertModal");
    modal.style.display = "none";
}

function confirmUpdatedPrice(isConfirmed) {
    closeUpdatedPriceModal();

    if (isConfirmed) {
        console.log("변동된 가격으로 진행");
        comfirmUpdatedPriceRquest();
 
        
    } else {
        console.log("진행 취소");
        rejactUpdatedPriceRquest();
      
        // 👉 취소 처리 로직
        
        
    }
}





function comfirmUpdatedPriceRquest() {
    const confirmData = {
        merchant_uid: merchant_uid,
        priceUpdated: priceUpdated,
        selectedDate: selectedDate,
        isAgree: true
    };

    $.ajax({
        url: "${pageContext.request.contextPath}/api/users/aggre-updated-onedayprice",
        type: "POST",
        data: confirmData, // JSON.stringify 대신 그냥 객체 전달
        success: function(res) {
            if (res.success) {
                alert(res.message); // 가격 동의 완료 메시지
                reserveCartUpdateByConfirmUpdatedPrice();
            } else {
                alert("실패: " + res.message);
            }
        },
        error: function(xhr, status, error) {
            console.error("AJAX 에러:", error);
            alert("서버와 통신 중 오류가 발생했습니다.");
        }
    });
}


function rejactUpdatedPriceRquest() {
    const rejectData = {
        merchant_uid: merchant_uid,
        priceUpdated: priceUpdated,
        selectedDate: selectedDate,
        isAgree: false  // 동의하지 않음
    };

    
    
    $.ajax({
        url: "${pageContext.request.contextPath}/api/users/aggre-updated-onedayprice",
        type: "POST",
        data: rejectData,  // 객체 그대로 전달
        success: function(res) {
        	console.log(res);        	
            if (res.success) {
                alert(res.message); // 서버에서 오는 메시지
                removeReserveCartByRejectUpdatedPrice();
            } else {
                alert("실패: " + res.message);
            }
        },
        error: function(xhr, status, error) {
            console.error("AJAX 에러:", error);
            alert("서버와 통신 중 오류가 발생했습니다.");
        }
    });
}

function reserveCartUpdateByConfirmUpdatedPrice() {
    // 1. localStorage에서 현재 장바구니 가져오기
    let currentCart = JSON.parse(localStorage.getItem("reserveCart") || "[]");

    // 2. 첫 번째 아이템 가격 업데이트
    if(currentCart.length > 0 && typeof priceUpdated !== 'undefined') {
        currentCart[0].productPrice = priceUpdated;
    }

    // 3. localStorage에 다시 저장
    localStorage.setItem("reserveCart", JSON.stringify(currentCart));

    // 4. 화면 가격 업데이트
    const productPriceDiv = document.querySelector('.info-row .right'); // 상품 가격
    if (productPriceDiv && typeof priceUpdated !== 'undefined') {
        productPriceDiv.textContent = priceUpdated + "원";
    }

    const paymentPriceDiv = document.getElementById('onedayclass-price'); // 결제금액
    if (paymentPriceDiv && typeof priceUpdated !== 'undefined') {
        paymentPriceDiv.textContent = priceUpdated + "원";
        paymentPriceDiv.setAttribute('data-onedayclass-price', priceUpdated);
    }
}


function removeReserveCartByRejectUpdatedPrice() {
    // 로컬 스토리지에서 'reserveCart' 제거
    localStorage.removeItem("reserveCart");

    // 페이지를 루트('/')로 이동
    const rootPage="${pageContext.request.contextPath}/guest/"
    location.replace(rootPage);
}

</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
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
			<div class="right payment-price" id="onedayclass-price"
				data-onedayclass-price="${onedayClassInfo.onedayclass_price}">${onedayClassInfo.onedayclass_price}
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
		<button id="openfake">결제 테스트 (localStorage 기반)</button>


	</div>

	<div id="paymentModal2"
		style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); justify-content: center; align-items: center;">
		<div
			style="position: relative; background: #fff; width: 100%; height: 100%; border-radius: 10px; display: flex; flex-direction: column;">
			<iframe id="pg-iframe" style="flex: 1; border: none;"></iframe>
			<button id="closeModal" style="padding: 10px; margin: 10px;">닫기</button>
		</div>
	</div>



	<div id="agreementUpdatedPayAlertModal"
		style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); justify-content: center; align-items: center; z-index: 9999;">

		<div
			style="background: #fff; padding: 30px; border-radius: 8px; width: 350px; text-align: center;">
			<h3 style="margin-bottom: 20px;">수업 가격이 변동되었습니다.</h3>
			<p style="margin-bottom: 30px;">변동된 가격으로 진행하시겠습니까?</p>

			<div style="display: flex; justify-content: center; gap: 15px;">
				<button onclick="confirmUpdatedPrice(true)"
					style="padding: 8px 20px; background: #4CAF50; color: #fff; border: none; border-radius: 4px; cursor: pointer;">
					예</button>
				<button onclick="confirmUpdatedPrice(false)"
					style="padding: 8px 20px; background: #f44336; color: #fff; border: none; border-radius: 4px; cursor: pointer;">
					아니오</button>
			</div>
		</div>

	</div>



	<script>


$("#openfake").click(() => {
	/*  if (!validateOrdererInfo()) {
	    alert("주문자 정보를 다시 확인해주세요.");
	    return;
	  }   */
		 openPayment();
	/*  if(validateOrdererInfo()){
		 
		 openPayment();
		 
		 
		 
		 
	 }; */
	});
	
	
	
function openPayment() {
 
    
    const amount=$("#onedayclass-price").data("onedayclass-price");
   
    
    
    // iframe src 설정
    var iframe = document.getElementById('pg-iframe');
    iframe.src = pgUrl + "?merchantId=" + merchantId;

    // 모달 표시
    var modal = document.getElementById('paymentModal2');
    modal.style.display = 'flex';

    const amountValue = Number(amount) || 0;
    const formattedAmount = "₩" + amountValue.toLocaleString();
    
   
    
    var paymentData = {
        	type: "PAYMENT_DATA",  // ← 여기 타입 추가,
            merchant_id: merchantId,
            merchant_uid: merchant_uid,
            amountValue: amountValue,                  
            selectedCart: currentReserveCart,
            userId: 1234,
            order: {
                userId: 1234,
                merchantUid:merchant_uid,
                items: selectedCart.map(item => ({                  
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
            },            
            surviceCallBackURL:"/reserve-payment-callback"
        };
    
    
    //console.log(paymentData);    
    iframe.onload = function() {

        // iframe에 결제 데이터 전송
        iframe.contentWindow.postMessage(
            { type: "PAYMENT_DATA", ...paymentData }, 
            "*"
        );

        // 결제 완료 후 콜백 처리
        onPaymentComplete(function(res) {
            console.log("JSP에서 SDK 콜백 호출됨:", res);

            const { success } = res;
            localStorage.removeItem("reserveCart");

            if (success) {
                const { successCode, successMassage, imp_uid } = res;

                // imp_uid 예: imp_123456789012
                const impUid = imp_uid;

                // 전송 직전에 깊은 복사 후 impUid 추가
                const dataToSend = structuredClone(paymentData);
                dataToSend.payment.impUid = impUid;
               let email = $("#orderer_email").val().trim();
               let phone = $("#orderer_phone").val().trim();
               let name= $("#orderer_name").val().trim();
               
               
               
               
               
              
               
               
                $.ajax({
                    url: "/finall/api/users/onedayclass-applicant",
                    type: "POST",
                    data: {
                        reserverest_id: '${reserveRest_id}',
                        name: name,
                        email: email,
                        phone: phone,
                        price: onedayPrice,
                        selectedDate: selectedDate,
                        onedayclass_num: '${onedayClassInfo.onedayclass_num}'
                    },
                    
                    
                    
                    success: function(data) {
                        window.location.replace('/finall/');
                    }
                });
                
            } else {
                // 결제 실패 처리
                const { errorCode, errorMassage } = res;
                console.log(res);
            }
        });

    };    
    
    
    
    
    
    
    
    
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


</script>
</body>
</html>