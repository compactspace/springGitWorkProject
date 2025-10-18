<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<style>

input, button {
    box-sizing: border-box;
}

#before-verified-container {
	width: 400px;
	margin: auto;
	font-family: Arial;
	margin-top: 40px;
}

#smsResult {
	font-weight: bold;
	margin-bottom: 20px;
}

#phone {
	margin-bottom: 10px;
	padding: 8px;
	width: 100%;
}

#sendCodeBtn {
	padding: 10px;
	background-color: #4285F4;
	color: white;
	border: none;
	cursor: pointer;
	width: 100%;
}

#cooldownMessage {
	margin-top: 10px;
	font-weight: bold;
	color: #d9534f;
}

#verifyForm {
	margin-top: 20px;
}

#code {
	margin-bottom: 10px;
	padding: 8px;
	width: 100%;
}

#verifyBtn {
	padding: 10px;
	background-color: #4285F4;
	color: white;
	border: none;
	cursor: pointer;
	width: 100%;
}

#verified-container, #lockpage-container {
	width: 400px;
	margin: auto;
	font-family: Arial;
	margin-top: 40px;
	display: none;
}
</style>





<%-- 쿨다운 시간 세션에서 가져오기 --%>
<c:if test="${empty sessionScope.cooldownStartTime}">
	<c:set var="cooldownStartTime" value="0" />
</c:if>
<c:if test="${empty sessionScope.cooldownDuration}">
	<c:set var="cooldownDuration" value="0" />
</c:if>

<c:if test="${not empty sessionScope.cooldownStartTime}">
	<c:set var="cooldownStartTime"
		value="${sessionScope.cooldownStartTime}" />
</c:if>
<c:if test="${not empty sessionScope.cooldownDuration}">
	<c:set var="cooldownDuration" value="${sessionScope.cooldownDuration}" />
</c:if>


<c:choose>
	<c:when test="${ lockPage eq 'false' and smsVerified eq 'false'}">
		<div class="container" id='before-verified-container'>

			<h2>문자 인증</h2>


			<div class="message" id="smsResult"></div>

			<form id="smsForm">
				<input type="text" id="phone" placeholder="휴대폰 번호 (01012345678)"
					required />
				<button type="button" id="sendCodeBtn">
					인증번호 요청</button>
			</form>

			<div id="cooldownMessage"></div>

			<form id="verifyForm">
				<input type="text" id="code" placeholder="인증번호 입력" required />
				<button type="button" id="verifyBtn">
					인증하기</button>
			</form>
		</div>
	</c:when>
	<c:otherwise>

	</c:otherwise>
</c:choose>
<div class="container" id="verified-container"></div>

<div class="container" id="lockpage-container"></div>

<script type="module">
  import { initLockPage, removeCoolDown, insertCurrentPasswordForm, insertPasswordChangeForm,startVerificationCountdown } from '${pageContext.request.contextPath}/resources/js/mypage/changePassword.js';

  const contextPath = "${pageContext.request.contextPath}";


  const lockPage = "${lockPage}" || "false";
  const attemptCnt = parseInt("${attemptCnt}") || 0;

 let cooldownStartTime = ${cooldownStartTime};  // 세션에서 전달된 고정 시간 (ms)
  let cooldownDuration = ${cooldownDuration};    // 쿨다운 기간 (ms)  

  initLockPage(lockPage, attemptCnt);
  removeCoolDown(contextPath,cooldownStartTime,cooldownDuration); 
  insertPasswordChangeForm("password-change-container");

	

let authToken = null;

$(document).ready(function () {
    authToken = localStorage.getItem("authToken");
    enableSendButton();
});

$("#sendCodeBtn").click(function () {
    const phone = $("#phone").val().trim();
    if (!phone) {
        alert("휴대폰 번호를 입력하세요.");
        return;
    }
    if (!/^01[0-9]{8,9}$/.test(phone)) {
        alert("올바른 휴대폰 번호를 입력해주세요.");
        return;
    }

    $.ajax({
        url: "${pageContext.request.contextPath}/api/users/request-sms-code",
        type: "POST",
        data: { phone: phone },
        success: function (res) {
            	
            if (!res.success) {
                let msg = "인증번호 발송에 실패했습니다.";
                const smsStatus = res.data.status;               
                	
                switch (smsStatus) {                		
                    case "TOO_MANY_REQUESTS":
                        msg = "요청 횟수가 초과되었습니다. 잠시 후 다시 시도해주세요.";
                        break;
                    case "TOO_SOON":
                        msg = "잠시 후에 다시 요청해주세요.";
                        break;
                    case "UNAUTHORIZED":
                        msg = "인증 권한이 없습니다.";
                        break;
                    case "FAIL":
                    default:
                        msg = "인증번호 발송에 실패했습니다.";
                }

                $("#smsResult").text(msg)
                    .removeClass().addClass("message error");
                return;
            }
            
            // ✅ 성공 시
            authToken = res.data.token;
            localStorage.setItem("authToken", authToken);
            $("#smsResult").text("인증번호가 발송되었습니다.")
                .removeClass().addClass("message success");            
                        
            let cooldownStartTime=res.data.cooldownStartTime;
            let cooldownDuration=res.data.cooldownDuration;
            
            
            initCooldownUI(cooldownStartTime,cooldownDuration)
            
        },
        error: function (e) {
            console.error(e);
            $("#smsResult").text("서버와 통신 실패. 나중에 다시 시도해주세요.")
                .removeClass().addClass("message error").css("color", "red");
        }
    });
});

$("#verifyBtn").click(function () {
    const code = $("#code").val().trim();
    authToken = localStorage.getItem("authToken");
    if (!authToken) {
        alert("인증번호 요청을 먼저 해주세요.");
        return;
    }
    if (!code) {
        alert("인증번호를 입력하세요.");
        return;
    }

    $.ajax({
        url: "${pageContext.request.contextPath}/api/users/verify-sms-code",
        type: "POST",
        data: { code: code, token: authToken },
        success: function (res) {
        	const success=res.success;
        	
        		if(success){
        			const status = res.data.status;  			
        			
        			  if (status === "SUCCESS") {
        	                alert("인증 성공! 비밀번호 변경이 가능합니다.");
        	                localStorage.removeItem("authToken");
        	                const {verifiedTTL,ttlStartTime}=res.data        	                
        	                console.log('verifiedTTL: '+verifiedTTL+" ttlStartTime: "+ttlStartTime);
        	                
        	                let beforeVerifiedContainer=document.getElementById('before-verified-container');
        	                const verifiedContainer=document.getElementById('verified-container');
        	                insertCurrentPasswordForm('verified-container',contextPath);
        	                startVerificationCountdown(verifiedTTL, ttlStartTime);
        	                verifiedContainer.style.display = 'block';
        	                beforeVerifiedContainer.style.display = 'none';
        	            } else if (status === "EXPIRED") {
        	                alert("인증번호가 만료되었습니다. 다시 시도하세요.");
        	                localStorage.removeItem("authToken");
        	                enableSendButton();
        	            } else if (status === "INVALID_CODE") {
        	                alert("인증번호가 올바르지 않습니다.");
        	            } else if (status === "INVALID_TOKEN") {
        	                alert("잘못된 인증 요청입니다.");
        	            } 
        			
        		}
        	
        	
          
        },
        error: function (e) {
            console.error(e);
            alert("서버와 통신 실패. 나중에 다시 시도해주세요.");
        }
    });
});

function enableSendButton() {
    $("#sendCodeBtn").prop("disabled", false).text("인증번호 요청");
}


 
  
  function initCooldownUI(cooldownStartTime,cooldownDuration) {
	    const now = new Date().getTime();
	    const elapsed = now - cooldownStartTime;
	    const remaining = cooldownDuration - elapsed;

	    const sendBtn = document.getElementById('sendCodeBtn');

	  	
	    
	    console.log('초기화 초:'+Math.ceil(remaining / 1000));	
	    
	    
	    if (remaining > 0) {


	      document.getElementById('cooldownMessage').textContent = 
	    	  "잠시만 기다려주세요. " + Math.ceil(remaining / 1000) + "초 후에 다시 시도 가능합니다.";        
	      sendBtn.disabled = true;
	      setTimeout(() => initCooldownUI(cooldownStartTime, cooldownDuration), 1000);
	      
	    } else {
	    	// 여기서 서버단의 세션 제거. 



	      document.getElementById('cooldownMessage').textContent = '';
	      sendBtn.disabled = false;
	      removeCoolDown();
	      
	    }
	  }
    
  function updateCooldownUI() {
    const now = new Date().getTime();
    const elapsed = now - cooldownStartTime;
    const remaining = cooldownDuration - elapsed;

    const sendBtn = document.getElementById('sendCodeBtn');
  	
    
    console.log('초:'+Math.ceil(remaining / 1000));
    
    
    if (remaining > 0) {
      document.getElementById('cooldownMessage').textContent = 
    	  "잠시만 기다려주세요. " + Math.ceil(remaining / 1000) + "초 후에 다시 시도 가능합니다.";        
      sendBtn.disabled = true;
      setTimeout(updateCooldownUI, 1000);
    } else {
    	// 여기서 서버단의 세션 제거. 
      document.getElementById('cooldownMessage').textContent = '';
      sendBtn.disabled = false;
      removeCoolDown();
    }
  }
  


console.log("cooldownStartTime: "+cooldownStartTime);

  if (cooldownStartTime && cooldownDuration) {
    updateCooldownUI();
  } else {
	  
	  
	  const cooldownMessageEl = document.getElementById('cooldownMessage');
	  const sendCodeBtnEl = document.getElementById('sendCodeBtn');


	  if (cooldownMessageEl && sendCodeBtnEl) {
console.log("여기???1");
	      cooldownMessageEl.textContent = '';
	      sendCodeBtnEl.disabled = false;
	  }
  }
  // 백엔드에서 넘겨준 TTL과 시작 시간
  let verifiedTTL = ${verifiedTTL != null ? verifiedTTL : 0}; // 초 단위
  let ttlStartTime = ${ttlStartTime != null ? ttlStartTime : 0}; // 밀리초 단위  

  
  let verifiedContainer=document.getElementById('verified-container');
  // 조건에 따라 함수 호출
  if (verifiedTTL && verifiedTTL > 0 &&(attemptCnt<3)) {
    verifiedContainer.style.display = 'block';	
    insertCurrentPasswordForm('verified-container',contextPath);
    startVerificationCountdown(verifiedTTL, ttlStartTime);

  }else{
	  verifiedContainer.style.display = 'none';
  }


if (attemptCnt>=1&&attemptCnt<3) {
    const attemptEl = document.getElementById("attemptCountMessage");
     attemptEl.style.color = "gray";
              attemptEl.innerText = `확인 시도: ${attemptCnt}회 / 최대 3회까지 가능합니다.`;
  }



</script>

