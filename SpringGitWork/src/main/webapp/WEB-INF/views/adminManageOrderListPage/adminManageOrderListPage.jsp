<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<sec:csrfMetaTags />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
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
.col-product {	min-width: 360px;
    max-width: 380px; padding: 5px; }
.col-price   { flex: 1 1 80px; padding: 5px; text-align: center; }
.col-qty     { flex: 1 1 60px; padding: 5px; text-align: center; }
.col-amount  { flex: 1 1 80px; padding: 5px; text-align: center; }
.col-status  { flex: 1 1 80px; padding: 5px; text-align: center;  font-weight: bold; }


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

.product-info .name { font-weight: bold; margin-bottom: 4px; }
.product-info .info { font-size: 0.85em; color: #666; }
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

</style>

<script>
var selectedOrderItemList=null;
const contextPath = "${pageContext.request.contextPath}";
var    orderStatusList=[];
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

	
	
	
	
	
	 // JSP EL 사용, 따옴표 처리 중요
   var statusList = JSON.parse('${orderStatusListJson}');

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

    
    
   /*  console.log(orderStatusList); */
	
	
	  $(document).on('click', '.order-row', function() {
	        const orderInfoId = $(this).data('order-info-id'); // order_info_id 가져오기
	        const name = $(this).data('name');                // name 가져오기
	        const email = $(this).data('email');              // email 가져오기
	        const phone = $(this).data('phone');              // phone 가져오기
	        const zipcode = $(this).data('zipcode');          // zipcode 가져오기
	        const address = $(this).data('address');          // address 가져오기
	        const addressDetail = $(this).data('address-detail'); // address_detail 가져오기
	        const orderStatusId = $(this).data('order-status_id');

	     /*    console.log("orderInfoId: " + orderInfoId);
	        console.log("Name: " + name);
	        console.log("Email: " + email);
	        console.log("Phone: " + phone);
	        console.log("Zipcode: " + zipcode);
	        console.log("Address: " + address);
	        console.log("Address Detail: " + addressDetail);
	        console.log("orderStatusId: " + orderStatusId); */
	        
	      
	      
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
   //스섹
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
	   console.log("업보 청산 변환 결과:", converted);        
        
        
        
  
        
        
        
        
        
        
        
        
        
        
      if(statusId===7){
        	 $.ajax({
                 url: contextPath + '/api/admin/delegate-to-pg-refund',
                 type: 'POST',
                 data: {
                	 impUid: impUid, // 전역 또는 적절한 변수로 전달
                	 merchantUid: merchantUid,
                	 amount:amount,
                	 orderInfoId:orderInfoId,
                	 paymentId:paymentId
                	 
                 },
                 
                 

                 
                 success: function(response) {
            const    	 promiseAfterSuccesPgRefund=afterSuccesPgRefund(impUid,merchantUid,amount,amount,orderInfoId,paymentId,converted);
            promiseAfterSuccesPgRefund.then(() => {
            	  doNextStepSearchTriger(statusId);
            	}).catch(err => {
            	  console.error("환불 후 처리 실패:", err);
            	});
                	 
                 },
                 error: function(jqXHR, textStatus, errorThrown) {
                     console.log("jqXHR:", jqXHR);
                     console.log("textStatus:", textStatus);
                     console.log("errorThrown:", errorThrown);
                 }
             });
        } 

     
    });	
});





function afterSuccesPgRefund(impUid,merchantUid,amount,amount,orderInfoId,paymentId,converted){
	
	return new Promise((resolve,reject)=>{
		
		  $.ajax({
		      	 url: contextPath + '/api/admin/after-succes-pg-refund',
		   	 	type: 'POST',
		   	    contentType: 'application/json', // << 이거 꼭 필요   	    
		   	 data: JSON.stringify({
		         impUid: impUid,
		         merchantUid: merchantUid,
		         orderInfoId: orderInfoId,
		         paymentId: paymentId,
		         amount: amount,
		         orderItemList: converted
		     }),
		        success:function(res){
		        	
		        	const {message}=res
		        	alert(message);
		        	selectedOrderItemList=null;
		        	$("#orderDetailModal").dialog("close");
		        	  resolve(res); // ★ 추가됨
		        },
		        error: function(jqXHR, textStatus, errorThrown) {
		            console.log("jqXHR:", jqXHR);
		            console.log("textStatus:", textStatus);
		            console.log("errorThrown:", errorThrown);
		            alert(message);
		            selectedOrderItemList=null;
		        	$("#orderDetailModal").dialog("close");
		        	reject(jqXHR);
		        	
		            
		        }
		        
			   })
		
		
	})
	
	 
	
	
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
				<label for="startDate">시작일:</label> <input type="text" id="startDate" readonly>
				<label for="endDate">종료일:</label> <input type="text" id="endDate" readonly>
				<button id="btnApplyPeriod">기간 적용</button>
				<button id="btnRecent7Days">최근 7일</button>
				<button id="btnCurrentMonth">당월</button>
				<button id="btnPreviousMonth">전월</button>
			</div>

			<div id="contentBody"></div>
			<div id="orderDetailModal" title="주문 상세" style="display:none;">
    <div id="orderDetailContent">불러오는 중...</div>
</div>
			
		</div>
	</div>
</body>
</html>
