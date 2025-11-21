<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<sec:csrfMetaTags />
<meta charset="UTF-8">
<title>내 정보</title>
<style>
/* 전체 레이아웃 */
#container {
    display: flex;
    min-height: 100vh;
    font-family: 'Helvetica Neue', Arial, sans-serif;
    background-color: #f5f5f5;
    color: #333;
}

/* 사이드바 */
#sidebar {
    width: 220px;
    background-color: #ffffff;
    border-right: 1px solid #e0e0e0;
    padding: 20px;
}

/* 로그인 상태 영역 */
#loginStatus {
    margin-bottom: 30px;
    font-size: 14px;
}

/* 로그인 버튼 */
#logoutForm button {
    transition: 0.2s;
}
#logoutForm button:hover {
    color: #007bff;
}

/* 메뉴 리스트 */
#sidebar ul {
    list-style: none;
    padding: 0;
}
#sidebar ul li {
    padding: 12px 15px;
    margin-bottom: 6px;
    border-radius: 4px;
    cursor: pointer;
    transition: 0.2s;
}
#sidebar ul li:hover {
    background-color: #f0f0f0;
}
#sidebar ul li.active {
    background-color: #e0e0e0;
    font-weight: 500;
}

/* 콘텐츠 영역 */
#content {
    flex: 1;
    padding: 30px;
    background-color: #ffffff;
    border-radius: 8px;
    margin: 20px;
    box-shadow: 0 0 8px rgba(0,0,0,0.05);
}

/* 주문 목록 버튼 */
#load-more-btn {
    display: inline-block;
    padding: 10px 18px;
    margin: 20px 0;
    background-color: #ffffff;
    color: #007bff;
    border: 1px solid #007bff;
    border-radius: 4px;
    cursor: pointer;
    font-weight: 500;
    transition: 0.2s;
}
#load-more-btn:hover {
    background-color: #007bff;
    color: #ffffff;
}





/*환불 모달 시작 */
.modal {
    display: flex;
    opacity: 0;
    visibility: hidden;
    position: fixed;
    z-index: 1000;
    left: 0; top: 0;
    width: 100%; height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    align-items: center;
    justify-content: center;
    transition: opacity 0.3s ease;
}

.modal.show {
    opacity: 1;
    visibility: visible;
}




.modal-content {
    background-color: #fff;
    border-radius: 8px;
    width: 400px;
    max-width: 90%;
    padding: 20px 30px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.2);
    position: relative;
}


.close-btn {
    position: absolute;
    top: 10px; right: 15px;
    font-size: 24px;
    font-weight: bold;
    cursor: pointer;
}


.modal-content h2 {
    margin-top: 0;
    margin-bottom: 15px;
    font-size: 20px;
    text-align: center;
}


.readonly-info p {
    margin: 8px 0;
    font-size: 14px;
    color: #333;
}

/* 입력 영역 */
.input-area {
    margin-top: 15px;
}

.input-area label {
    display: block;
    margin-bottom: 5px;
    font-weight: 500;
}

.input-area textarea {
    width: 100%;
    height: 80px;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
    resize: none;
}


.modal-buttons {
    margin-top: 20px;
    text-align: right;
}

.modal-buttons button {
    padding: 8px 16px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-weight: 500;
    margin-left: 10px;
    transition: 0.2s;
}

#submitRefund {
    background-color: #ff5757;
    color: white;
}

#submitRefund:hover {
    background-color: #e64545;
}

#closeModal {
    background-color: #ccc;
    color: #333;
}

#closeModal:hover {
    background-color: #b3b3b3;
}

/*환불 모달 종료  */






/* 반응형 */
@media (max-width: 768px) {


	
    
    #sidebar {
    	padding:0px 0px;
        width: 100%;
        display: flex;
        justify-content: space-around;
        border-right: none;
        border-bottom: 1px solid #e0e0e0;
        flex-direction: column;
        
    }
    
    #loginStatus{
	margin-bottom: 10px;
	padding: 10px 10px;
	}
    #container {
        flex-direction: column;
    }
    
    #sidebar ul {
    margin-top: 0px;
    	padding: 10px 10px;
        display: flex;
    }
    
    #sidebar  li {
        margin: 0 5px;
    }
}
</style>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!--전역 블록  -->
<script>
// 메뉴별 상태 객체 (offset, limit 등)
  const menuStates = {
    "${pageContext.request.contextPath}/users/mypersonalinfo": { offset: 0, limit: 10 },
    "${pageContext.request.contextPath}/users/payinfo-type": { offset: 0, limit: 10 },
    "${pageContext.request.contextPath}/users/changepassword": { offset: 0, limit: 10 }
  };
</script>


<script type="module">

import { stopVerificationCountdown } from '${pageContext.request.contextPath}/resources/js/mypage/changePassword.js';



$(document).ready(function() {
	  const token = $("meta[name='_csrf']").attr("content");
	  const header = $("meta[name='_csrf_header']").attr("content");

	  $.ajaxSetup({
	    beforeSend: function(xhr) {
	      xhr.setRequestHeader(header, token);
	    }
	  });

	

	  // 현재 활성 메뉴 URL
	  let currentMenuURL = null;

	  // 모든 메뉴 상태를 초기화하는 함수
	  function resetAllMenuStates() {
		 
		  
		  
	    for (const key in menuStates) {
	    	
	      menuStates[key].offset = 0;
	      // 필요한 초기화 더 추가 가능
	    }
	  }	 
	  // 메뉴 AJAX 호출 함수
	  function menuFetch(menuURL) {
	    $.ajax({
	      url: menuURL,
	      method: 'GET',
	      success: function(data) {
	    	  
	    	  
	if(menuURL!="/finall/users/changePassword"){
	        console.log("menuURL: "+menuURL);	  
stopVerificationCountdown();
     
}

	    	  
	        $('#content').html(data);
	        currentMenuURL = menuURL;
	        
	        
	        if (menuURL.endsWith('/users/payinfo-type')) {	   	
	        	resetAllMenuStates();
	          loadOrders();
	        }
	        
	      },
	      error: function() {
	        $('#content').html('내용을 불러오는데 실패했습니다.');
	      }
	    });
	  }

	  // 초기 메뉴 로드
	  const $firstMenu = $('#sidebar ul li').first();
	  $firstMenu.addClass('active');
	  menuFetch($firstMenu.data('value'));

	  // 메뉴 클릭 이벤트 핸들러
	  $('#sidebar ul li').click(function() {
	    $('#sidebar ul li').removeClass('active');
	    $(this).addClass('active');

	    const menuURL = $(this).data('value');

	    // 메뉴 변경 시 모든 메뉴 상태 초기화
	    resetAllMenuStates();

	    menuFetch(menuURL);
	  });

	  // 동적 생성된 load-more 버튼 클릭 이벤트 위임
	  $('#order-list-container').on('click', '#load-more-btn', function() {
	    loadOrders();
	  });
	});
	
</script>


<script>
function loadOrders() {
    const currentOffset = menuStates["${pageContext.request.contextPath}/users/payinfo-type"].offset;
    const limit = 10;

    $.ajax({
        url: "${pageContext.request.contextPath}/users/listMore",
        data: {offset: currentOffset, limit: limit},
        type: 'GET',
        success: function(data) {
            $('#order-list-container').append(data);
            // menuStates 안에 offset 값 직접 업데이트
            menuStates["${pageContext.request.contextPath}/users/payinfo-type"].offset += limit;
        },
        error: function(e) {
            console.log(e);
            alert('주문 목록을 불러오는 데 실패했습니다.');
        }
    });   
    
}





//동적 생성된 refund-btn 이벤트 처리
$(document).on('click', '.refund-btn', function() {
    const paymentId = $(this).data('paymentid');
    const amount = $(this).data('amount');
    const orderId = $(this).data('orderid');

    
    
    
    
    $('#modalPaymentId').text(paymentId);
    $('#modalAmount').text(amount);
    $('#modalOrderId').text(orderId);

    $('#refundModal').addClass('show'); // display: flex 유지, opacity로 보여줌
});


// 모달 닫기 (위임)
$(document).on('click', '#refundModal .close-btn, #closeModal', function() {
    $('#refundModal').removeClass('show');
});


$(document).on('click', '#submitRefund', function() {
    const paymentId = $('#modalPaymentId').text().trim();
    const amount = $('#modalAmount').text().trim();
    const orderId = $('#modalOrderId').text().trim();
    const refundedAmount = $('#modalAmount').text().replace(/[^0-9]/g, '').trim(); // "10,000원" → 10000
    const reason = $('#refundReason').val().trim();

    console.log("orderId: "+orderId);
    
    
    
    
    
    if (!reason) {
        alert('환불 사유를 입력해주세요.');
        return;
    }

    
    
    
    const refundData = {
        paymentId: paymentId,
        refundedAmount: refundedAmount,
        reason: reason,
        orderInfoId:orderId
    };
    
    
     $.ajax({
        url: '${pageContext.request.contextPath}/api/users/request-refund',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(refundData),
        success: function(res) {      	
        		
        	const {message}=res;        		
        	   alert(message);
               $('#refundModal').hide();
               location.reload(); 
        
        
        },   

        
        error: function(xhr) {
        	
        	const {status,responseJSON}=xhr        	
        	
        		if(500<=status && status<=599){        			
        			const {message,code}=responseJSON
        			alert(message) ;
        		}
        }
    });
});



// 모달 바깥 클릭 시 닫기
$(window).click(function(event) {
    if (event.target.id === 'refundModal') {
        $('#refundModal').removeClass('show');
    }
});


</script>
</head>
<body>
  <div id="container"> <!-- 부모 컨테이너 추가 -->
    <div id="sidebar">
      <div id="loginStatus">
        <sec:authorize access="isAuthenticated()">
          <span>로그인 중: </span>
          <span style="margin: 0 5px;"><sec:authentication property="name" /></span>
          <form id="logoutForm" action="${pageContext.request.contextPath}/users/logout" method="POST" style="display: inline;">
  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  <button type="submit" style="background: none; border: none; color: #333; cursor: pointer;">로그아웃</button>
</form>

        </sec:authorize>
        <sec:authorize access="!isAuthenticated()">
          비회원
        </sec:authorize>
      </div>
      <ul>
        <li data-value="${pageContext.request.contextPath}/users/mypersonalinfo">내정보</li>
        <li data-value="${pageContext.request.contextPath}/users/payinfo-type">결제현황</li>
        <li data-value="${pageContext.request.contextPath}/users/changePassword">비밀번호 변경</li>
      </ul>
    </div>
        
      <!-- AJAX로 불러온 내용이 표시됩니다 -->
    <div id="content">
    </div>
  </div>
  
  
  <!-- 여기다가 모달 단, 이렇게 해보자,  -->
  
  <!-- 환불 모달 -->
<div id="refundModal" class="modal">
    <div class="modal-content">
        <span class="close-btn">&times;</span>
        <h2>환불 요청</h2>
        
        <div class="readonly-info">
            <p><strong>주문번호:</strong> <span id="modalOrderId"></span></p>
            <p><strong>결제 ID:</strong> <span id="modalPaymentId"></span></p>
            <p><strong>총 결제 금액:</strong> <span id="modalAmount"></span>원</p>
        </div>

        <div class="input-area">
            <label for="refundReason">환불 사유</label>
            <textarea id="refundReason" placeholder="환불 사유를 입력해주세요"></textarea>
        </div>

        <div class="modal-buttons">
            <button id="submitRefund">환불 요청</button>
            <button id="closeModal">취소</button>
        </div>
    </div>
</div>
  
  
  
  
  
  
  
</body>
</html>

