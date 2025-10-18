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
  /* 부모 컨테이너에 flex 적용: 2열 구조 만들기 */
  #container {
    display: flex;
    height: 100vh; /* 화면 전체 높이 */
  }

  #sidebar {
    width: 230px;
    background-color: #f8f8f8;
    border-right: 1px solid #ddd;
    padding-top: 20px;
    box-sizing: border-box;
    /* 높이는 부모 높이 상속 */
    height: 100%;
  }
  #loginStatus {
    padding: 10px 10px;
    font-weight: bold;
    border-bottom: 1px solid #ddd;
    margin-bottom: 10px;
    color: #333;
    display: flex;
    align-items: center;
    gap: 5px;
  }
  #loginStatus form {
    margin: 0;
  }
  #loginStatus button {
    font-size: 0.85em;
    padding: 2px 6px;
    cursor: pointer;
    background-color: #f44336;
    border: none;
    color: white;
    border-radius: 3px;
  }
  #loginStatus button:hover {
    background-color: #d32f2f;
  }
  #sidebar ul {
    list-style: none;
    padding: 0;
    margin: 0;
  }
  #sidebar ul li {
    padding: 15px 20px;
    cursor: pointer;
    border-bottom: 1px solid #ddd;
  }
  #sidebar ul li:hover {
    background-color: #eee;
  }
  #sidebar ul li.active {
    background-color: #4CAF50;
    color: white;
    font-weight: bold;
  }
  #content {
    flex: 1; /* 나머지 공간 차지 */
    padding: 20px;
    overflow-y: auto; /* 내용 길면 스크롤 가능 */
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
        
    <div id="content">
      <!-- AJAX로 불러온 내용이 표시됩니다 -->
    </div>
  </div>
</body>
</html>

