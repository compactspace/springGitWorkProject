<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<sec:csrfMetaTags />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<meta charset="UTF-8">
<title>주문 관리</title>

<style>
html, body {
	height: 100%;
	margin: 0;
	font-family: 'Roboto', sans-serif;
}

#pageWrapper {
	display: flex;
	height: 100vh;
}

#sidebar {
	width: 240px;
	border-right: 1px solid #e0e0e0;
	overflow-y: auto;
}

#mainContent {
	flex: 1;
	padding: 24px;
	overflow-y: auto;
}

#contentHeader {
	padding: 20px 24px;
	background-color: #f5f7fa;
	border-left: 6px solid #4a90e2;
	border-radius: 4px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.08);
	margin-bottom: 20px;
}

#contentHeader h1 {
	margin: 0;
	font-size: 1.8em;
	font-weight: 700;
	color: #333;
}

#contentHeader .header-subtitle {
	margin: 6px 0 0 0;
	font-size: 0.95em;
	color: #666;
}

#contentBody {
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	min-height: 400px;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
}

#searchFilters {
	margin-bottom: 20px;
}

#searchFilters input {
	padding: 5px 8px;
	margin-right: 10px;
	width: 120px;
}

#searchFilters button {
	padding: 6px 12px;
	margin-right: 5px;
	background-color: #4a90e2;
	border: none;
	color: #fff;
	border-radius: 4px;
	cursor: pointer;
}

#searchFilters button:hover {
	background-color: #357ABD;
}

#statusFilters {
	margin-bottom: 20px;
}

#statusFilters button {
	padding: 6px 12px;
	margin-right: 5px;
	background-color: #4a90e2;
	border: none;
	color: #fff;
	border-radius: 4px;
	cursor: pointer;
	transition: background-color 0.2s, transform 0.1s;
	font-weight: 500;
}

#statusFilters button:hover {
	background-color: #357ABD;
	transform: translateY(-2px);
}

#statusFilters button.active {
	background-color: #50C878;
}

/* ===== 동적 주문 테이블 스타일 ===== */
.order-table {
	display: flex;
	flex-direction: column;
}

.order-header, .order-row {
	display: flex;
}

.order-header {
	background-color: #f5f5f5;
	font-weight: bold;
	padding: 8px 0;
}

.order-row {
	padding: 6px 0;
	border-bottom: 1px solid #eee;
}

.order-cell {
	flex: 1;
	text-align: center;
}

.empty-result {
	text-align: center;
	padding: 20px;
}

/* 주문 상세모달 시작 */
#orderDetailContent {
	width: 100%;
	padding: 10px;
	font-family: 'Arial', sans-serif;
	box-sizing: border-box;
}

/* 헤더 & 내용 행 */
.modal-header-row, .modal-content-row {
	display: flex;
	align-items: center;
}

/* 컬럼 비율 */
.col-product {
	min-width: 360px;
	max-width: 380px;
	padding: 5px;
}

.col-price {
	flex: 1 1 80px;
	padding: 5px;
	text-align: center;
}

.col-qty {
	flex: 1 1 60px;
	padding: 5px;
	text-align: center;
}

.col-amount {
	flex: 1 1 80px;
	padding: 5px;
	text-align: center;
}

.col-status {
	flex: 1 1 80px;
	padding: 5px;
	text-align: center;
	font-weight: bold;
}

/* 헤더 스타일 */
.modal-header-row {
	font-weight: bold;
	border-bottom: 2px solid #ccc;
	background-color: #f5f5f5;
}

/* 내용 행 스타일 */
.modal-content-row {
	border-bottom: 1px solid #eee;
	padding: 10px 0;
}

/* 상품 영역 */
.product-cell {
	display: flex;
	align-items: center;
}

.product-img img {
	width: 50px;
	height: 50px;
	object-fit: cover;
	border: 1px solid #ddd;
	border-radius: 4px;
	margin-right: 10px;
}

.product-info {
	display: flex;
	flex-direction: column;
	justify-content: center;
}

.product-info .name {
	font-weight: bold;
	margin-bottom: 4px;
}

.product-info .info {
	font-size: 0.85em;
	color: #666;
}
/* 주문 상세모달 종료 */
.modal-total-amount {
	text-align: right;
	padding: 12px 20px;
	font-size: 1.1em;
	font-weight: 700;
	border-top: 1px solid #ddd;
	margin-top: 10px;
}

/*  결제 정보 시작 */
/* 결제정보 전체 */
.modal-payment-row {
	margin-top: 20px;
	border-top: 1px solid #ccc;
	padding-top: 12px;
}

/* 헤더 */
.payment-header {
	font-weight: bold;
	padding: 8px;
	border-radius: 4px;
	margin-bottom: 12px;
}

.payment-header.completed {
	color: #2a7a2a;
}

.payment-header.pending {
	color: #c00;
}

/* 결제정보 그리드: 2열 */
.payment-body {
	display: grid;
	grid-template-columns: repeat(2, 1fr); /* 2열 */
	gap: 12px 24px; /* 행 간격 12px, 열 간격 24px */
}

/* 개별 라벨+값 flex */
.payment-row {
	display: flex;
	align-items: center;
	gap: 8px;
}

.payment-row .label {
	background-color: #f0f0f0;
	padding: 4px 8px;
	border-radius: 4px;
	font-weight: bold;
	min-width: 100px;
	text-align: center;
}

.payment-row .value {
	font-weight: normal;
	color: #222;
}

/*  결제 정보 종료 */

/* 주문자 정보 시작 */
.modal-customer-row {
	margin-top: 20px;
	border-top: 1px solid #ccc;
	padding-top: 12px;
}

.customer-header {
	font-weight: bold;
	padding: 8px;
	border-radius: 4px;
	color: #1a4a7a;
	margin-bottom: 12px;
}

.customer-body {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 12px 24px;
}

.customer-row {
	display: flex;
	align-items: center;
	gap: 8px;
}

.customer-row .label {
	background-color: #f0f0f0;
	padding: 4px 8px;
	border-radius: 4px;
	font-weight: bold;
	min-width: 100px;
	text-align: center;
}

.customer-row .value {
	font-weight: normal;
	color: #222;
}

/* 주문자 정보 종료  */

/* 주문 상태 시작  */
.modal-status-row {
	margin-top: 20px;
	padding: 10px;
	border-top: 1px solid #ddd;
	display: flex;
	flex-direction: column;
	gap: 10px;
}

.status-header {
	font-weight: bold;
}

.status-label {
	padding: 2px 6px;
	border-radius: 4px;
	background-color: #ffd700; /* 연한 주황 강조 */
	color: #333;
}

.status-change {
	display: flex;
	align-items: center;
	gap: 10px;
}

.status-options {
	display: flex;
	gap: 5px;
}

.status-btn {
	padding: 4px 8px;
	border: 1px solid #ccc;
	border-radius: 4px;
	background-color: #f5f5f5;
	cursor: pointer;
	transition: background 0.2s;
}

.status-btn:hover {
	background-color: #e0e0e0;
}

/* 주문 상태 종료  */

/* 창고선택 모달 시작 */
/* 모달 전체 */
.dm-modal {
	display: none; /* JS에서 block으로 토글 */
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	z-index: 9999;
	/* 중앙 배치 */
	display: flex;
	justify-content: center;
	align-items: center;
}

/* 모달 내용 */
.dm-modal-content {
	background-color: #fff;
	padding: 20px 30px;
	border-radius: 8px;
	max-width: 860px;
	max-height: 80vh;
	overflow-y: auto;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
	display: flex;
	flex-direction: column;
	gap: 15px;
}

/* 모드 선택 라디오 */
.dm-mode-select {
	display: flex;
	gap: 20px;
}

/* 수동 모드 카드 */
.dm-inventory-card {
	border: 1px solid #ddd;
	padding: 10px;
	margin-bottom: 10px;
	border-radius: 6px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	flex-wrap: wrap;
}

.dm-inventory-card p {
	margin: 0 10px 5px 0;
}

.dm-input-number {
	width: 60px;
}

/* 버튼 그룹 정렬 */
.dm-btn-group {
	display: flex;
	justify-content: flex-end;
	gap: 10px;
}

.dm-btn {
	padding: 6px 12px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.dm-submit-btn {
	background-color: #4CAF50;
	color: white;
}

.dm-close-btn {
	background-color: #f44336;
	color: white;
}

/*  창고선택 모달 종료 */
</style>



<script>
var selectedOrderItemList=null;
const contextPath = "${pageContext.request.contextPath}";
var   orderStatusList=[];
var   targetObjToinventory=null
var   IV_target=null;
let fullInventoryListJson= ${fullInventoryListJson}

//console.log("fullInventoryListJson",fullInventoryListJson);


const statusTransitions = {
	    1: [2, 6],   // Pending → Paid, Cancelled
	    2: [3, 6],   // Paid → Preparing, Cancelled
	    3: [4, 6],   // Preparing → Shipping, Cancelled
	    4: [5],      // Shipping → Delivered
	    5: [7],      // Delivered → RefundRequested
	    7: [8],      // RefundRequested → Refunded
	    6: [],       // Cancelled → X
	    8: []        // Refunded → X
	};


const statusEnum = {
		  1: 'Pending',
		  2: 'Paid',
		  3: 'Preparing',
		  4: 'Shipping',
		  5: 'Delivered',
		  6: 'Cancelled',
		  7: 'RefundRequested',
		  8: 'Refunded'
		};






$(function() {
	const token = $("meta[name='_csrf']").attr("content");
	const header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({
		beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		}
	});

	$("#startDate, #endDate").datepicker({
		dateFormat : 'yy-mm-dd'
	});

	$("#orderDetailModal").dialog({
	    autoOpen: false,
	    width: 500,
	    modal: true
	});

	
	

	
	
	
	
	// 문서 위임할 이벤트 여기서 수동 재고 이벤트들을 등록하자.	
document.addEventListener('change', function(e) {
    if (!e.target.classList.contains('dm-input-number')) return;

 
    var input = e.target; 
    
    
    var productId = input.getAttribute('data-product-id');
    var inventoryId = input.getAttribute('data-inventory-id');
    var lotNo= input.getAttribute('data-lot-no');
    var warehouseId= input.getAttribute('data-warehouse-id');
    var orderItemId= input.getAttribute('data-order-item-id');
    var  orderInfoId= input.getAttribute('data-order-info-id');
   
    
    
    var orderQuantity = parseInt(input.getAttribute('data-order-quantity'), 10);   
    if (IV_target == null) {
        IV_target = {}; // IV_target을 객체로 초기화
        IV_target[inventoryId] = new Map(); // 이제 안전하게 Map 할당 가능
    };
    
    if(!IV_target.hasOwnProperty(inventoryId)){
    	  IV_target[inventoryId] = new Map(); // 이제 안전하게 Map 할당 가능
    }
    
    IV_target[inventoryId].set("inventoryId",inventoryId);
	IV_target[inventoryId].set("lotNo",lotNo);
	IV_target[inventoryId].set("warehouseId",warehouseId);
	IV_target[inventoryId].set("productId",productId);
	IV_target[inventoryId].set("orderItemId",orderItemId);
	IV_target[inventoryId].set("orderInfoId",orderInfoId);
	
	IV_target[inventoryId].set("orderQuantity",orderQuantity);
	 var 창고별담은재고 = input.value; // 단일 input 값
	   
    // 같은 제품의 모든 input 합산
    var inputs = document.querySelectorAll('.dm-input-number[data-product-id="' + productId + '"]');
    var total = 0;
    for (var i = 0; i < inputs.length; i++) {
        total += parseInt(inputs[i].value, 10) || 0;
    }
    
    if(total <=orderQuantity){
    	IV_target[inventoryId].set("warehouseByQuantity",창고별담은재고);
    }
    
    
    if (total > orderQuantity) {
        alert('주문 수량을 초과했습니다!');
        input.value = Math.max(0, orderQuantity - (total - parseInt(input.value, 10)));
        total = orderQuantity;
    }
    IV_target[inventoryId].set("warehouseAlltotal_qty",total);    
    
   
   /*  console.log('제품 ' + productId + ' 현재 합산 수량: ' + total); */   
    console.log(IV_target);
    
});
	
	
	

document.addEventListener('click', function(e){
	
	//console.log(e.target);	
    if(e.target.id === 'deliveryBtn') { 
    
    	delegateToDelive() .then(response => {
            console.log("출고 처리 완료:", response);
        	doNextStepSearchTriger(3)
        })
        .catch(error => {
            console.error("출고 처리 실패:", error);
            // 오류 메시지 표시 등
        });
    	
    	
    	 /* if (!validateAllInputs(IV_target)) {
    		 	console.log("유효성 실패");
    	        return; // 합산 초과, 제출 중단
    	    }   
    	    
    	 
    	    const requestList = Object.values(IV_target).map(m => Object.fromEntries(m));
    	    
    	    
    	 // 1️⃣ 컨테이너 초기화
    	    const container = document.getElementById('dm-manualMode');
    	    container.innerHTML = ""; // 기존 내용 초기화
    	    
 	     $.ajax({
    	        url:contextPath+ "/api/admin/delegate-to-deliver", // Spring 컨트롤러 URL
    	        type: "POST",
    	        contentType: "application/json", // JSON 전송
    	        data: JSON.stringify(requestList), // 객체 → JSON 문자열
    	        success: function(response) {
    	            console.log("출고 요청 성공:", response);
    	            $("#dm-nestedModal").fadeOut();
    	        },
    	        error: function(xhr, status, error) {
    	            console.error("출고 요청 실패:", xhr);
    	            $("#dm-nestedModal").fadeOut();
    	        }
    	    });
    	    
    	     */
    	    
    	    
    	    
    	
    }
});
	
function delegateToDelive() {
    if (!validateAllInputs(IV_target)) {
        console.log("유효성 실패");
        return; // 합산 초과, 제출 중단
    }   

    const requestList = Object.values(IV_target).map(m => Object.fromEntries(m));

    // 1️⃣ 컨테이너 초기화
    const container = document.getElementById('dm-manualMode');
    container.innerHTML = ""; // 기존 내용 초기화

    return new Promise((resolve, reject) => {
        $.ajax({
            url: contextPath + "/api/admin/delegate-to-deliver", // Spring 컨트롤러 URL
            type: "POST",
            contentType: "application/json", // JSON 전송
            data: JSON.stringify(requestList), // 객체 → JSON 문자열
            success: function(response) {
                console.log("출고 요청 성공:", response);
                $("#dm-nestedModal").fadeOut();
                $("#orderDetailModal").dialog("close");
                resolve(response); // 성공 시 resolve
            },
            error: function(xhr, status, error) {
                console.error("출고 요청 실패:", xhr);
                $("#dm-nestedModal").fadeOut(); // 실패 시에도 모달 닫기
                $("#orderDetailModal").dialog("close");
                reject(xhr); // 실패 시 reject
            }
        }); // <-- $.ajax 끝
    }); // <-- Promise 끝
}

	
	 // JSP EL 사용, 따옴표 처리 중요
var statusList = JSON.parse('${orderStatusListJson}');
	 

// 조건에 맞춰 제거
var filteredStatusList = statusList.filter((status, index) => {
  // 0번 제거
  if (index === 0) return false;
  
  // statusId가 5,6,7인 항목 제거
  if ([5, 6, 7].includes(status.statusId)) return false;
  
  return true; // 나머지는 유지
});
statusList=filteredStatusList;






    // 만약 JSON.parse가 필요하다면 문자열로 전달 후 파싱
    // var statusList = JSON.parse('${orderStatusListJson}');

    var orderStatusList = [];
    

    statusList.forEach(function(item){
        var statusObj = {
            statusId: item.statusId,
            statusCode: item.statusCode,
            statusName: item.statusName
        };
        orderStatusList.push(statusObj);
    });

    
    console.log(orderStatusList)
    
    

	
	
	  $(document).on('click', '.order-row', function() {
	        const orderInfoId = $(this).data('order-info-id'); // order_info_id 가져오기
	        const name = $(this).data('name');                // name 가져오기
	        const email = $(this).data('email');              // email 가져오기
	        const phone = $(this).data('phone');              // phone 가져오기
	        const zipcode = $(this).data('zipcode');          // zipcode 가져오기
	        const address = $(this).data('address');          // address 가져오기
	        const addressDetail = $(this).data('address-detail'); // address_detail 가져오기
	        const orderStatusId = $(this).data('order-status_id');

	
	      
	      
	        if (!orderInfoId) return;

	        
	        $.ajax({
	            url: contextPath + '/api/admin/get-order-detail',
	            method: 'POST',
	            data: { orderInfoId: orderInfoId },
	            success: function(data) {
	                var paymentInfo = data.paymentInfo;   // 결제정보 1건
	                var orderItemList = data.orderItemList; // 주문항목 여러건
	                console.log(orderItemList)
	                selectedOrderItemList=orderItemList
	                console.log(selectedOrderItemList);
	                
	                if (!orderItemList || orderItemList.length === 0) {
	                    $("#orderDetailContent").html("<p>상품 정보가 없습니다.</p>");
	                    $("#orderDetailModal").dialog("open");
	                    return;
	                }
	                
	                
	                
	                
	                var html = "";

	                // -------------------------------
	                // 1행: 주문상품 테이블
	                // -------------------------------
	                html += '<div class="modal-row">';
	                html += '<div class="modal-header-row">';
	                html += '<div class="col col-product">주문상품</div>';
	                html += '<div class="col col-price">판매가</div>';
	                html += '<div class="col col-qty">주문수량</div>';
	                html += '<div class="col col-amount">주문금액</div>';
	                html += '<div class="col col-status">상태</div>';
	                html += '</div>';

	                var totalAmount = 0;
	                
	                
	                console.log("orderStatusList",orderStatusList)
	                
	                
	                
	                
	                
	                
	                
	                // 현재 상태에서 허용되는 다음 상태 ID 목록 가져오기
var possibleStatusIds = statusTransitions[orderStatusId] || [];

// orderStatusList에서 실제 상태 객체로 필터링
var possibleStatusAction = orderStatusList.filter(s => possibleStatusIds.includes(s.statusId));

					
					var currentStatusObj = orderStatusList.find(s => s.statusId === orderStatusId);
					
					
					
					
					var currentStatusName = currentStatusObj ? currentStatusObj.statusName : '알 수 없음';

					
				
					
					
					
					
					
					
	                orderItemList.forEach(function(item) {
	                	
	                
	                	
	                	
	                	
	                    var imageUrl = contextPath + '/images/' + item.file_category + '/' + item.file_name;
	                    var productName = item.product_name;
	                    var productInfo = item.product_info;
	                    var price = item.price_per_unit;
	                    var qty = item.quantity;
	                    var amount = price * qty;

	                    totalAmount += amount;

	                    html += '<div class="modal-content-row">';
	                    html += '<div class="col col-product">';
	                    html += '<div class="product-cell">';
	                    html += '<div class="product-img"><img src="' + imageUrl + '" alt="' + productName + '" /></div>';
	                    html += '<div class="product-info">';
	                    html += '<div class="name">' + productName + '</div>';
	                    html += '<div class="info">' + productInfo + '</div>';
	                    html += '</div>'; // product-info
	                    html += '</div>'; // product-cell
	                    html += '</div>'; // col-product

	                    
	                    html += '<div class="col col-price">' + price.toLocaleString() + '원</div>';
	                    html += '<div class="col col-qty">' + qty + '개</div>';
	                    html += '<div class="col col-amount">' + amount.toLocaleString() + '원</div>';
	                    html += '<div class="col col-status"> 현재 주문상태: '+currentStatusName+'</div>';
	                    html += '</div>'; // modal-content-row
	                    
	                    
	                    
	                    
	                });

	                html += '</div>'; // modal-row 끝

	                // 총 주문 금액
	                html += '<div class="modal-total-amount">';
	                html += '<span>총 주문 금액: </span>';
	                html += '<strong>' + totalAmount.toLocaleString() + '원</strong>';
	                html += '</div>';

	                // -------------------------------
	                // 2행: 결제정보
	                // -------------------------------
	           // -------------------------------
// 2행: 결제정보
// -------------------------------
html += '<div class="modal-payment-row">';

if (paymentInfo.payment_id!=null) {		
	let style = "color:#28a745; font-weight:600;"; // 기본: 결제완료
	if(currentStatusName === '주문취소' || currentStatusName === '환불완료'){
	    style = "color:#dc3545; font-weight:600; font-style:italic;"; // 취소/환불
	}

	html += '<div class="payment-header" style="color:#333;">결제정보 <span style="' + style + '">' + currentStatusName + '</span></div>';

	    html += '<div class="payment-body">';
	    html += '<div class="payment-row"><div class="label">결제방식:</div><div class="value">' + paymentInfo.payment_method + '</div></div>';
	    html += '<div class="payment-row"><div class="label">결제금액:</div><div class="value">' + Number(paymentInfo.payamount).toLocaleString() + '원</div></div>';
	    html += '<div class="payment-row"><div class="label">결제번호:</div><div class="value">' + paymentInfo.payment_number + '</div></div>';
	    html += '<div class="payment-row"><div class="label">결제일:</div><div class="value">' + paymentInfo.paycreated_at + '</div></div>';
	    html += '</div>';        
    
} else {
    html += '<div class="payment-header" style="color:#333;">결제정보 <span class="pending" style="color:#dc3545;">(미결제 주문건)</span></div>';
	    html += '<div class="payment-body">';
	    html += '<div class="payment-row"><div class="label">결제방식:</div><div class="value">-미결제-</div></div>';
	    html += '<div class="payment-row"><div class="label">결제금액:</div><div class="value">-미결제-</div></div>';
	    html += '<div class="payment-row"><div class="label">결제번호:</div><div class="value">-미결제-</div></div>';
	    html += '<div class="payment-row"><div class="label">결제일:</div><div class="value">-미결제-</div></div>';
	    html += '</div>';
}



html += '</div>'; // modal-payment-row 끝





//-------------------------------
//3행: 주문자정보
//-------------------------------
html += '<div class="modal-customer-row">';
//헤더
html += '<div class="customer-header">주문자정보</div>';
if (paymentInfo.payment_id!=null) {
	//body: 2열 구조
	html += '<div class="customer-body">';
	html += '<div class="customer-row"><div class="label">주문자명:</div><div class="value">' + name + '</div></div>';
	html += '<div class="customer-row"><div class="label">이메일:</div><div class="value">' + email + '</div></div>';
	html += '<div class="customer-row"><div class="label">연락처:</div><div class="value">' + phone + '</div></div>';
	html += '<div class="customer-row"><div class="label">우편번호:</div><div class="value">' + zipcode + '</div></div>';
	html += '<div class="customer-row"><div class="label">주소:</div><div class="value">' + address + '</div></div>';
	html += '<div class="customer-row"><div class="label">상세주소:</div><div class="value">' + addressDetail + '</div></div>';
	html += '</div>'; // customer-body 끝
	
}else{	
	//body: 2열 구조
	const emptyInfon="미결제로 정보 없음"	
	html += '<div class="customer-body">';
	html += '<div class="customer-row"><div class="label">주문자명:</div><div class="value">' + emptyInfon+ '</div></div>';
	html += '<div class="customer-row"><div class="label">이메일:</div><div class="value">' + emptyInfon + '</div></div>';
	html += '<div class="customer-row"><div class="label">연락처:</div><div class="value">' + emptyInfon + '</div></div>';
	html += '<div class="customer-row"><div class="label">우편번호:</div><div class="value">' + emptyInfon + '</div></div>';
	html += '<div class="customer-row"><div class="label">주소:</div><div class="value">' + emptyInfon + '</div></div>';
	html += '<div class="customer-row"><div class="label">상세주소:</div><div class="value">' + emptyInfon + '</div></div>';
	html += '</div>'; // customer-body 끝
	
	
}




html += '</div>'; // modal-customer-row 끝




//-------------------------------
//: 주문상태 및 변경
//-------------------------------
html += '<div class="modal-status-row">';



//현재 상태 헤더
html += '<div class="status-header">주문상태 변경</div>';


//현재 상태 헤더
html += '<div class="status-header">현재 주문상태: <span class="status-label">' + currentStatusName + '</span></div>';

//상태 변경 영역
html += '<div class="status-change">';

//가능한 상태 목록 (현재 상태 제외)

if(currentStatusName!='주문취소'&&currentStatusName!='환불완료'){	
html += '<div class="status-label">상태 변경:</div>';
html += '<div class="status-options">';
possibleStatusAction.forEach(function(status) {
	html += '<button class="status-btn" ' +
    'data-status-id="' + orderStatusId + '" ' +
    'data-merchant-uid="' + paymentInfo.payment_number + '" ' +
    'data-imp-uid="' + paymentInfo.imp_uid + '" ' +
    'data-order_info_id="' + orderInfoId + '" ' +
    'data-payment_id="' + paymentInfo.payment_id + '" ' +
    
    
    'data-amount="' + paymentInfo.payamount + '">' +
    status.statusName +
    '</button>';

});
html += '</div>'; // status-options

html += '</div>'; // status-change
html += '</div>'; // modal-status-row 끝
}

	                $("#orderDetailContent").html(html);
	                $("#orderDetailModal").dialog("open");
	            },
	            error: function() {
	                alert("가상 요청 중 오류 발생");
	            }
	        });

	        
	        
	        

	    });
    
    
    
   
    
 // 자동/수동 토글
	 document.querySelectorAll('input[name="dm-deliveryMode"]').forEach(radio => {
    radio.addEventListener('change', function() {
      if(this.value === 'auto') {
        document.getElementById('dm-autoMode').style.display = 'block';
        document.getElementById('dm-manualMode').style.display = 'none';
      } else {
        document.getElementById('dm-autoMode').style.display = 'none';
        document.getElementById('dm-manualMode').style.display = 'block';
      }
    });
  });
	
    
    
    
    
    
    
   //다음
	 async function doNextStepSearchTriger(nowAction){	
			if(nowAction!=6 && nowAction!=8){
				nowAction=nowAction+1;
			}
			
			const	status=statusEnum[nowAction];	
			
			const today = new Date();
			const firstDay = new Date(today.getFullYear(), today.getMonth(), 1);
			const lastDay = new Date(today.getFullYear(), today.getMonth() + 1, 0);
			$("#startDate").val($.datepicker.formatDate('yy-mm-dd', firstDay));
			$("#endDate").val($.datepicker.formatDate('yy-mm-dd', lastDay));
			await searchOrders($.datepicker.formatDate('yy-mm-dd', firstDay), $.datepicker.formatDate('yy-mm-dd', lastDay), status);
					
		}  
	
	let selectedStatus = '';

	function searchOrders(start, end, status) {
		$.ajax({
			url : contextPath + "/api/admin/search-order-list-with-date",
			type : "GET",
			data : {
				startDate : start,
				endDate : end,
				status : status
			},
			success: function(data) {
			    var orders = data.ordersSummary.findOrders;
			    var html = "";

			    if (orders && orders.length > 0) {
			        html += "<div class='order-table'>";
			        html += "<div class='order-header'>";
			        html += "<div class='order-cell'>주문번호</div>";
			        html += "<div class='order-cell'>주문일</div>";
			        html += "<div class='order-cell'>상태</div>";
			        html += "<div class='order-cell'>주문자명</div>";			 
			     
			        html += "<div class='order-cell'>총금액</div>";
			        html += "<div class='order-cell'>총수량</div>";
			        html += "</div>";

			        for (var i = 0; i < orders.length; i++) {
			        	
			        
			        	
			        	
			        	var o = orders[i];
			        	html += "<div class='order-row' " +
			        	    "data-order-info-id='" + (o.order_info_id || "") + "' " +
			        	    "data-order-status_id='" + (o.status_id || "") + "' " +
			        	    "data-name='" + (o.name || "") + "' " +
			        	    "data-email='" + (o.email || "") + "' " +
			        	    "data-phone='" + (o.phone || "") + "' " +
			        	    "data-zipcode='" + (o.zipcode || "") + "' " +
			        	    "data-address='" + (o.address || "") + "' " +
			        	    "data-address-detail='" + (o.address_detail || "") + "'>" 

			            
			            html += "<div class='order-cell'>" + (o.merchant_uid || "") + "</div>";
			            html += "<div class='order-cell'>" + (o.order_date ? formatTimestamp(o.order_date) : "") + "</div>";
			            html += "<div class='order-cell'>" + (o.status_name || "") + "</div>";
			            html += "<div class='order-cell'>" + (o.name || "") + "</div>";
			          
			     
			            html += "<div class='order-cell'>" + (o.draft_total_amount || 0) + "</div>";
			            html += "<div class='order-cell'>" + (o.draft_total_quantity || 0) + "</div>";
			            html += "</div>";
			        }
			        html += "</div>";
			    } else {
			        html = "<div class='empty-result'>검색 결과가 없습니다.</div>";
			    }

			    $("#contentBody").html(html);
			},
			error : function() {
				alert("검색 중 오류가 발생했습니다.");
			}
		});
	}

	// 날짜 버튼 이벤트
	$("#btnApplyPeriod").click(function() {
		const start = $("#startDate").val();
		const end = $("#endDate").val();
		if (!start || !end) {
			alert("시작일과 종료일을 선택해주세요.");
			return;
		}
		searchOrders(start, end, selectedStatus);
	});
	$("#btnRecent7Days").click(function() {
		const end = new Date();
		const start = new Date();
		start.setDate(end.getDate() - 6);
		$("#startDate").val($.datepicker.formatDate('yy-mm-dd', start));
		$("#endDate").val($.datepicker.formatDate('yy-mm-dd', end));
		searchOrders($.datepicker.formatDate('yy-mm-dd', start), $.datepicker.formatDate('yy-mm-dd', end), selectedStatus);
	});
	$("#btnCurrentMonth").click(function() {
		const today = new Date();
		const firstDay = new Date(today.getFullYear(), today.getMonth(), 1);
		const lastDay = new Date(today.getFullYear(), today.getMonth() + 1, 0);
		$("#startDate").val($.datepicker.formatDate('yy-mm-dd', firstDay));
		$("#endDate").val($.datepicker.formatDate('yy-mm-dd', lastDay));
		searchOrders($.datepicker.formatDate('yy-mm-dd', firstDay), $.datepicker.formatDate('yy-mm-dd', lastDay), selectedStatus);
	});
	$("#btnPreviousMonth").click(function() {
		const date = new Date();
		date.setMonth(date.getMonth() - 1);
		const firstDay = new Date(date.getFullYear(), date.getMonth(), 1);
		const lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0);
		$("#startDate").val($.datepicker.formatDate('yy-mm-dd', firstDay));
		$("#endDate").val($.datepicker.formatDate('yy-mm-dd', lastDay));
		searchOrders($.datepicker.formatDate('yy-mm-dd', firstDay), $.datepicker.formatDate('yy-mm-dd', lastDay), selectedStatus);
	});

	// 상태 버튼 이벤트
	$("#statusFilters button").click(function() {
		selectedStatus = $(this).data("status");
		const start = $("#startDate").val();
		const end = $("#endDate").val();
		searchOrders(start, end, selectedStatus);
	});
	
	

	
	console.log(selectedOrderItemList)
	
	
	
	
	$("#orderDetailContent").on("click", ".status-btn", function() {
        const statusId = $(this).data("status-id");
        const merchantUid = $(this).data("merchant-uid");
        const impUid = $(this).data("imp-uid");
        const amount = $(this).data("amount");
        const orderInfoId = $(this).data("order_info_id");
        const paymentId= $(this).data("payment_id");
    
        /* console.log("선택한 상태 ID:", statusId);
        console.log("merchantUid:", merchantUid);
        console.log("impUid:", impUid);
        console.log("amount:", amount);     
        
        
        console.log("선택한 리스트:", selectedOrderItemList);
   */
   
        
     // snake → camel
       const converted = keysToCamel(selectedOrderItemList);
   targetObjToinventory=converted;
	   console.log("데이터:", targetObjToinventory);   
        
    
        
       
       

      if(statusId===3){
     $("#dm-nestedModal").fadeIn(); // 모달 보이기 
     
     
   //  console.log(fullInventoryListJson);
     	renderManualMode(fullInventoryListJson);
    	  
    	  
    	  
    	  // 이부분을 나중에 택배회사PG라 가정하고 개발하라 지금은 주석처리
    
        } 

     
    });	
});





//모달 렌더 함수
function renderManualMode(fullInventoryListJson) {
  // fullInventoryListJson 예시: {1: Array(20), 2: Array(20)}

	
	
  const container = document.getElementById('dm-manualMode');
  container.innerHTML = ""; // 기존 내용 초기화

  // warehouseId 기준 그룹화 (fullInventoryListJson이 이미 warehouseId별 배열이므로 그대로 사용)
  for (const [warehouseId, items] of Object.entries(fullInventoryListJson)) {
    const warehouseTitle = document.createElement('h4');
    

    const {warehouse}=items[0]

    const warehouseName=warehouse.name;
    const warehouseId=warehouse.warehouseId;
    
    warehouseTitle.className = "dm-warehouse-title";
    warehouseTitle.textContent = "창고: "+warehouseName;
    container.appendChild(warehouseTitle); 
 
    
    
    //섹스
    items.forEach(inv => {
    	  // targetObjToinventory에서 productId가 일치하는 항목 찾기
    	  const target = targetObjToinventory.find(t => t.productId === inv.productId);   	  
    	  
    	  if (target) {
    	    const card = document.createElement('div');
    	    card.className = "dm-inventory-card";    	   
    	    card.innerHTML =
    	        '<p class="dm-product">제품: ' + inv.productId + '</p>' +
    	        '<p class="dm-quantity">창고재고: ' + inv.quantity + '</p>' +
    	        '<p class="dm-order-quantity">주문수량: ' + target.quantity + '</p>' +
    	        '<p class="dm-product-info">제품명: ' + target.productName + '</p>' +
    	        '<label class="dm-input-label">' +
    	        '수량:' +
    	        '<input type="number" min="0" max="' + target.quantity + '" ' +
    	        'name="dm-manualQty_' + inv.inventoryId + '" ' +
    	        'class="dm-input-number" ' +
    	        'data-product-id="' + target.productId + '" ' +
    	        'data-inventory-id="' + inv.inventoryId + '" ' +
    	        'data-lot-no="' + inv.lotNo + '" ' +
    	        'data-warehouse-id="' + warehouseId + '" ' +
    	        'data-order-item-id="' + target.orderItemId + '" ' +
    	        'data-order-info-id="' + target.orderInfoId + '" ' +
    	        
    	        'data-order-quantity="' + target.quantity + '">' +
    	        '</label>';

    	       
    	    container.appendChild(card);
    	  }
    	});
  }
}



function formatTimestamp(ts) {
    if (!ts) return "";
    var date = new Date(ts);
    var yyyy = date.getFullYear();
    var mm = (date.getMonth() + 1 < 10 ? "0" : "") + (date.getMonth() + 1);
    var dd = (date.getDate() < 10 ? "0" : "") + date.getDate();
    var hh = (date.getHours() < 10 ? "0" : "") + date.getHours();
    var min = (date.getMinutes() < 10 ? "0" : "") + date.getMinutes();
    var sec = (date.getSeconds() < 10 ? "0" : "") + date.getSeconds();
    return yyyy + "-" + mm + "-" + dd + " " + hh + ":" + min + ":" + sec;
}



function toCamel(s) {
    return s.replace(/_([a-zA-Z])/g, (_, c) => c.toUpperCase());
}

function keysToCamel(obj) {
    if (Array.isArray(obj)) {
        return obj.map(v => keysToCamel(v));
    }

    if (obj !== null && typeof obj === "object") {
        return Object.keys(obj).reduce((acc, key) => {
            acc[toCamel(key)] = keysToCamel(obj[key]);
            return acc;
        }, {});
    }

    return obj;
}




function dmOpenModal() {
	  document.getElementById('dm-nestedModal').style.display = 'block';
	}

	function dmCloseModal() {
	  document.getElementById('dm-nestedModal').style.display = 'none';
	}
	
	
	//유효성
function validateAllInputs(IV_target) {
    var allValid = true;
    var productTotals = {}; // 제품별 합산
    var productOrderQty = {}; // 제품별 주문수량

    // 각 창고 Map 돌면서 합산
    for (var inventoryId in IV_target) {
        var map = IV_target[inventoryId];
        console.log("map, ",map)        
        var productId = map.get("productId");
        var qty = parseInt(map.get("warehouseByQuantity"), 10) || 0;
        var orderQty = parseInt(map.get("orderQuantity")|| 0, 10);
		console.log("orderQty:",orderQty);         
        
        
        if (!productTotals[productId]) productTotals[productId] = 0;
        productTotals[productId] += qty;

        
        /// 제품 단위 주문수량(orderQty) 저장
// IV_target에는 같은 제품(productId)이 여러 창고에 있을 수 있음
// 모든 창고에서 orderQty는 동일해야 하므로, 첫 값만 사용하면 충분
// 이미 productOrderQty[productId]가 존재하면 덮어쓰지 않음 → 중복 방지
        if (!productOrderQty[productId])productOrderQty[productId] = orderQty;
    }
    
    
  /*   console.log('targetObjToinventory, ',targetObjToinventory);   
    
    console.log('productOrderQty',productOrderQty);
    
	console.log('productTotals',productTotals);
	
	
	console.log('productTotals.length',Object.getOwnPropertyNames(productTotals).length);	 */	
    // 제품별 합산과 주문수량 비교
  /*   for (var productId in productTotals) {
        var total = productTotals[productId];
        var targetQty = productOrderQty[productId];    
        
        
        if (total !== targetQty) {
            console.warn(
                "제품 " + productId + " 합산(" + total + ")이 주문수량(" + targetQty + ")과 일치하지 않습니다."
            );
            allValid = false;
        }
    } */

    
	
	for (const item of targetObjToinventory) {	  
	    var total = productTotals[item.productId];
	    var targetQty = item.quantity;        

	    // 우선 모든 에러 숨기기
	    const errorWrap = document.querySelector('.dm-error-wrap');
	    if (!errorWrap) break; // 요소 없으면 종료
	    errorWrap.style.display = 'none';
	    const allErrors = errorWrap.querySelectorAll('.dm-error');
	    allErrors.forEach(err => err.style.display = 'none');

	    // 값 없음 → empty 에러
	    if (!total) {
	        errorWrap.style.display = 'block';
	        const emptyError = errorWrap.querySelector('.dm-error-empty');
	        if (emptyError) emptyError.style.display = 'block';
	        return allValid = false;
	    }

	    // 값 불일치 → qty-mismatch 에러
	    if (total !== targetQty) {
	        errorWrap.style.display = 'block';
	        const mismatchError = errorWrap.querySelector('.dm-error-qty-mismatch');
	        if (mismatchError) mismatchError.style.display = 'block';
	        return allValid = false;
	    }
	}
	 return allValid = true;
	 
}
	
	





	
	
	

</script>


</head>
<body>
	<div id="pageWrapper">
		<div id="sidebar">
			<%@ include file="../compoents/adminVerticalBar/adminVerticalBar.jsp"%>
		</div>
		<div id="mainContent">
			<div id="contentHeader">
				<h1>주문 관리</h1>
				<div class="header-subtitle">주요 요약 정보</div>
			</div>

			<div id="statusFilters">
				<c:forEach var="status" items="${orderStatusList}">
					<button data-status="${status.statusCode}">
						${status.statusName}</button>
				</c:forEach>
			</div>

			<div id="searchFilters">
				<label for="startDate">시작일:</label> <input type="text"
					id="startDate" readonly> <label for="endDate">종료일:</label>
				<input type="text" id="endDate" readonly>
				<button id="btnApplyPeriod">기간 적용</button>
				<button id="btnRecent7Days">최근 7일</button>
				<button id="btnCurrentMonth">당월</button>
				<button id="btnPreviousMonth">전월</button>
			</div>

			<div id="contentBody"></div>
			<div id="orderDetailModal" title="주문 상세" style="display: none;">
				<div id="orderDetailContent">불러오는 중...</div>
			</div>

		</div>
	</div>

	<div id="dm-nestedModal" class="dm-modal" style="display: none;">
		<div class="dm-modal-content">
			<h3>배송 재고 선택</h3>

			<!-- 선택 모드 라디오 -->
			<label class="dm-radio-label"> <input type="radio"
				name="dm-deliveryMode" value="auto" checked> 자동
			</label> <label class="dm-radio-label"> <input type="radio"
				name="dm-deliveryMode" value="manual"> 수동
			</label>

	<div class="dm-error-wrap" style="display: none;">
					<span class="dm-error dm-error-empty" style="display: none;">
						⚠ 입력된 수량이 없습니다. 값을 입력해주세요. </span> <span class="dm-error dm-error-over"
						style="display: none;"> ⚠ 입력한 수량이 재고 수량을 초과했습니다. </span> <span
						class="dm-error dm-error-qty-mismatch" style="display: none;"> ⚠
						주문 수량과 선택한 수량이 일치하지 않습니다. </span>
				</div>
				
				



			<!-- 자동 모드 안내 -->
			<div id="dm-autoMode" class="dm-mode-info" style="margin-top: 10px;">
				<p>자동 모드: 창고 FIFO 순으로 재고 차감</p>
			</div>





			<!-- 수동 모드: 창고별 재고 카드 -->
			<div id="dm-manualMode" class="dm-mode-info"
				style="margin-top: 10px; display: none;">
			



				<c:forEach var="entry" items="${fullInventoryList}">
					<h4 class="dm-warehouse-title">창고: ${entry.key}</h4>
					<c:forEach var="inv" items="${entry.value}">
						<div class="dm-inventory-card">
							<p class="dm-product">제품: ${inv.productId}</p>
							<p class="dm-quantity">재고: ${inv.quantity}</p>
							<label class="dm-input-label"> 수량: <input type="number"
								min="0" max="${inv.quantity}"
								name="dm-manualQty_${inv.inventoryId}" class="dm-input-number">
							</label>
						</div>
					</c:forEach>
				</c:forEach>
			</div>
		

			<button id="deliveryBtn">배송 진행</button>
			<button onclick="dmCloseModal()" class="dm-btn dm-close-btn">닫기</button>
		</div>
	</div>

	<!-- 배송 버튼 -->
	<button onclick="dmOpenModal()" class="dm-btn dm-open-btn">배송하기</button>




</body>
</html>
