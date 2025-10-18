<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>


<head>

<!-- 아이디 : 4~12글자, 영어나 숫자만 가능하다.
    8글자 이상, 영문, 숫자, 특수문자를 모두 사용해야 한다.
    비밀번호 확인 : 비밀번호와 일치해야 한다. -->
<style>
.alldivwrapper {
	width: 500px;
	position: relative;
	margin-left: auto;
	margin-right: auto;
}


img {
	position: absolute;
	right: 0px;
	top: 23px;
	height: 200px;
	width: 200px;
}

#membershipform {
	border: 1px solid #ddd;
}


#idspattern {
	display: none;
}

.idsinput {
	background-color: rgb(232, 240, 254);
	border: none;
	border-bottom: 1px solid #bdbdbd;
	width: 100%;
	height: 50px;
}

.idinput {
	background-color: rgb(232, 240, 254);
	border: none;
	border-bottom: 1px solid #bdbdbd;
	width: 100%;
	height: 50px;
}

#idduplicationcheck {
	/* 이유는 모르겠는데 위드스100% 로가 씹혀 그냥 절대단위 px으로 함 */
	width: 505px !important;
	background-color: rgb(232, 240, 254);
	border: none;
	border-bottom: 1px solid #bdbdbd;
	height: 50px;
}

.checkpwdinput {
	background-color: rgb(232, 240, 254);
	border: none;
	border-bottom: 1px solid #bdbdbd;
	width: 100%;
	height: 50px;
}

.pwdinput {
	background-color: rgb(232, 240, 254);
	border: none;
	border-bottom: 1px solid #bdbdbd;
	width: 100%;
	height: 50px;
}

.finallsubmitinput {
	padding-top: 10px;
	padding-bottom: 10px;
	margin-left: auto;
	margin-right: auto;
	width: 100%;
	height: 40px;
	border: none;
	background-color: #1a70dc;
	color: aliceblue;
	line-height: 30px;
}


#currentPasswordMessage.verification-message {
  max-width: 500px;
  margin: 10px auto;
  padding: 8px 12px;
  border: 1px solid #1a70dc;
  border-radius: 6px;
  background-color: #f0f5ff;
  font-family: 'Noto Sans KR', sans-serif;
  color: #333;
  font-size: 13px;
  box-sizing: border-box;
  display: flex;
  justify-content: space-between;
  align-items: center;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}


/* 인증 만료 시작  */
#currentPasswordMessage.verification-message .info-text {
  flex: 1;
  margin-right: 8px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

#countdown-timer {
  font-weight: 700;
  color: #1a70dc;
  white-space: nowrap;
}

#countdown-timer.red-alert {
  color: #e63946;
}
/* 인증 만료 종료  */
</style>
<script>	

window.onpopstate = function(event) {
	  console.log("popstate 발생!");
	  console.log(event.state); // pushState로 저장했던 state 객체
	};
	
	let authToken = null;
	 window.onload = function() {				 
		 $("#test").on("click",function(){
		     history.pushState({page: "current"}, "", "?sex"); // URL을 변경
		      console.log("히스토리 추가됨");			 
		 })		 
		 aliveVerifySmsCode();

	} 
	 
	 
	 
	 
	 
	 
	 function aliveVerifySmsCode() {
		    const authToken = localStorage.getItem("authToken");
		    
		    $.ajax({
		        url: "${pageContext.request.contextPath}/api/guest/alive-verify-sms-code",
		        type: "POST",
		        data: { token: authToken },
		        success: function (res) {
		            const success = res.success;

		            if (success) {
		                const status = res.data.status;

		                if (status === "SUCCESS") {
		                    const { verifiedTTL, ttlStartTime } = res.data;
		                    console.log('verifiedTTL: ' + verifiedTTL + " ttlStartTime: " + ttlStartTime);
		                    startVerificationCountdown(verifiedTTL, ttlStartTime);

		                } else if (status === "EXPIRED" ||(status === "INVALID_CODE")||(status === "INVALID_TOKEN")) {
		                   	 alert("인증이 만료되었습니다. 다시 시도하세요.");
		                     localStorage.removeItem("authToken"); 
		                     window.location.href = '${pageContext.request.contextPath}/guest/get-signup-page';
		                    
		                } 
		            }
		        },
		        error: function (e) {
		            console.error(e);
		            alert("서버와 통신 실패. 나중에 다시 시도해주세요.");
		        }
		    });
		}

		 
	 
	 
	// 모듈 내부
	 let countdownIntervalId = null;

	 function startVerificationCountdown(ttl, startTime) {
		  const timeRemainingSpan = document.getElementById('time-remaining');
		  const expireAt = startTime + (ttl * 1000);

		  countdownIntervalId = setInterval(() => {
		    const now = new Date().getTime();
		    const remaining = Math.ceil((expireAt - now) / 1000);

		    console.log("remaining: " + remaining)
		    if (remaining > 0) {
		      timeRemainingSpan.textContent = remaining;
		    } else {
		      timeRemainingSpan.textContent = '0';
		      clearInterval(countdownIntervalId);
		      countdownIntervalId = null;
		      removeCoolDown(); // 세션 제거
		      // 남은 시간이 0이 되면 메시지 지우거나 변경 가능
		      // document.getElementById('currentPasswordMessage').textContent = '';
		    }
		  }, 1000);
		}


	 function stopVerificationCountdown() {
	   if (countdownIntervalId) {
	     clearInterval(countdownIntervalId);
	     countdownIntervalId = null;
	  //   console.log('⏹️ 인증 타이머 중단됨');
	   }
	 }
	 	 
	 
	 
	 function removeCoolDown (contextPath,cooldownStartTime,cooldownDuration)  {
		
		  $.ajax({
			  url: "${pageContext.request.contextPath}/api/guest/signup-remove-smsCoolDown",
		    type: "POST",
		    success: function (res) {
		      console.log(res);
		      if (res.success) {
		        cooldownStartTime = null; // 세션에서 전달된 고정 시간 (ms)
		        cooldownDuration = null;  // 쿨다운 기간 (ms)
		        localStorage.removeItem("authToken"); 
                window.location.href = '${pageContext.request.contextPath}/guest/get-signup-page';
		      }
		    },
		    error:function(res){
		    	localStorage.removeItem("authToken"); 
                window.location.href = '${pageContext.request.contextPath}/guest/get-signup-page';
		    }
		  });
		};
	 
	 
</script>
</head>

<body>
  <!-- <button id="test">히스토리 추가</button> -->
 
	<div class="alldivwrapper">
  <div id="currentPasswordMessage" class="verification-message">
  <span class="info-text">인증기한 만료 시 재인증이 필요합니다.</span>
  <span id="countdown-timer">인증번호 유효시간: <strong id="time-remaining">--</strong>초 남음</span>
</div>


			<!-- 회원가입으로 덮어 씌우기 시작 -->
		<div id="loginformwrapper">

			<!-- 	<form action="insertmembership.do" id="membershipform" method="post"> -->
			<div class="iddiv">
				<h3>등록할아이디</h3>


				<input type="text" class="idsinput" id="ids" name="id"
					data-val="false" placeholder="ID 입력"> 
			
		
				<span id="idspattern">아이디 형식이 올바르지 않습니다. 아이디는 4자 이상 7자 이하입니다.</span>
<span class="possible-id" style="display: none;">사용 가능한 아이디입니다.</span>
<span class="already-using-id" style="display: none;">이미 사용 중인 아이디입니다.</span>
<input type="button" id="idduplicationcheck" data-val="false" value="아이디 중복 확인">

					
			</div>


		


			<div class="passworddiv">
				<h3>비밀번호</h3>
				<input type="password" class="pwdinput" id="pwd" name="password" data-val="false">
				<span class="step1pwderr" style="display: none;">비밀번호 형식이 올바르지 않습니다.</span>	
				<input type="password" class="checkpwdinput" id="checkpwd" name="checkpwd" value="${userVO.password}">
				<span class="step2pwderr" style="display: none;">비밀번호가 일치하지 않습니다.</span>	
			</div>
			
			<input type="hidden" class="user_where" id="user_where"
				name="user_where" value="finalluser">
			<!-- <input type="hidden" class="user_code" id="user_code" name="user_code"> -->
			<br> <br>
			<div class="login_membershipdivwrapper">
				<input class="finallsubmitinput" id="finallsubmit" type="button"
					value="회원가입">
			</div>
			<!-- 	</form> -->
		</div>
	</div>
<script>
var idDuplicCheck=false;
var 패스워드1차2차검증=false;

stepRollback();
  function stepRollback(){
	  
	  	$("#idspattern").hide();
		$(".possible-id").hide();
		$(".already-using-id").hide();  
	  // 초기 상태 설정
	  $("#pwd").attr("disabled", "true");
	  $("#checkpwd").attr("disabled", "true");
	  $("#idduplicationcheck").attr("disabled", "true");
	  $("#finallsubmit").attr("disabled", "true");	 
	  $("#pwdlengthcheck").hide();
	  $("#pwdpattern").hide();
	 	idDuplicCheck=false;
	 	패스워드1차2차검증=false;
 		 currentInputFieldId=null;
	  	 currentStep1Pwd=null;
		 currentStep2Pwd=null	
  }
  

  function step1PwdRollback (){
	  
	 	 checkpwd.value=''
		  패스워드1차2차검증=false;
  }

  

  // data-val은 최종 제출 전 체크용
  $("#ids").attr("data-val", "false");
  $("#idduplicationcheck").attr("data-val", "false");
  $("#checkpwd").attr("data-val", "false");
  $("#pwd").attr("data-val", "false");

  // 요소 선택
  var id = document.querySelector("#ids");
  var pwd = document.querySelector("#pwd");
  var checkpwd = document.querySelector("#checkpwd");

  var currentInputFieldId=null;
  var currentStep1Pwd=null;
  var currentStep2Pwd=null	

 
 id.oninput= function () {
 	let value = $(this).val(); 	
 	if (idDuplicCheck && (value !== currentInputFieldId)) {
 		// 이미 중복체크 했던 값과 다르면 초기화
 		stepRollback();
 		idDuplicCheck = false;
 		checkedId = "";
 		pwd.value="";
 		checkpwd.value=""
 	}
 };
  
  // 아이디 입력 시 패턴 및 길이 확인
  id.onkeyup = function () {
 	currentInputFieldId = id.value;

    if (idspattern(currentInputFieldId) && idlengthcheck(currentInputFieldId)) {
      $("#idspattern").hide();
      $("#idduplicationcheck").removeAttr("disabled");
    } else {
      $("#idspattern").show();
      $("#pwd").attr("disabled", "true");
      $("#idduplicationcheck").attr("disabled", "true");
      $("#idduplicationcheck").data("val", "false");
    }
  };

  
  // 1차 비밀번호 입력 시 유효성 확인
  pwd.onchange = function () {
    let step1Pwd = pwd.value;
    
    console.log("벡스페이스시 길이: " + step1Pwd.length +" 유효성: "+pwdpattern(step1Pwd));
    
    if (pwdpattern(step1Pwd)) {
        $("#checkpwd").removeAttr("disabled");
        $(".step1pwderr").hide();
        currentStep1Pwd=step1Pwd;
         
      }
   
	if(!pwdpattern(step1Pwd)){
		$(".step1pwderr").show()
	}; 
  };  
  
  
  pwd.oninput= function () {
  	let value = $(this).val(); 	
  	if (value !== currentStep1Pwd) {  	
  		step1PwdRollback();
  	}
  };  
  
  //2차 비밀번호 확인 입력 시 체크
  checkpwd.onchange = function () {
	  currentStep2Pwd = checkpwd.value;

    
    if ($("#pwd").val() === currentStep2Pwd) {  
    	패스워드1차2차검증=true;
    	$(".step2pwderr").hide(); 
      $("#finallsubmit").removeAttr("disabled");
    } else {
    	패스워드1차2차검증=false;
    	$(".step2pwderr").show(); 
      $("#finallsubmit").attr("disabled", "true");
    }
  };
  
  
  checkpwd.oninput= function () {
	  	let value = $(this).val(); 	
	  	if ((패스워드1차2차검증) &&value !== currentStep2Pwd) {  	
	  		step1PwdRollback();
	  	}
	  };  
  // 아이디 길이 확인 함수 (5~7자)
  function idlengthcheck(value) {
    return value.length > 4 && value.length <= 7;
  }

  // 아이디 패턴 확인 (영문 + 숫자만)
  function idspattern(str) {
    return /^[A-Za-z0-9]+$/.test(str);
  }

  // 비밀번호 길이 확인 함수 (8~39자)
  function pwdlengthcheck(value) {
    return value.length > 7 && value.length < 40;
  }

  // 비밀번호 패턴 확인 (영문 + 숫자만)
function pwdpattern(str) {
  return /^(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,16}$/.test(str);
}
  

  
 

$("#finallsubmit").on("click",()=>{
	console.log("아이디 중복확인: "+idDuplicCheck+" 비밀번호 교차검증:"+패스워드1차2차검증);
	
	
	if(!idDuplicCheck|| !패스워드1차2차검증){
		return;
	}
	 $.ajax({
		url:"${pageContext.request.contextPath}/api/guest/action-signup",
		type:"post",
		data:{"id":$("#ids").val(),"password":$("#pwd").val()},
		success:(data)=>{
			console.log("성공시 받아온 데이터 data는")
			console.log(data)
			
			if(data=="signupfalse"){
				alert("금새 동일한 아이디로 누가 가입하였습니다. 다른 아이디로 다시 시도해주세요")
			}else{
				location.replace("${pageContext.request.contextPath}/guest/login");
			}
			
		}
	}) 
	
})
  
  
  
  
  
	$("#idduplicationcheck").on(
			"click",
			function() {
				
				
				$.ajax({
					url : "${pageContext.request.contextPath}/api/guest/checkout-signup-id",
					type : "POST",
					data : {
						"id" : $("#ids").val()
					},
					success : function(data) {
					
						
							let check=document.getElementsByClassName('ok')
						if (data) {
							
							idDuplicCheck=true;    							
							$("#pwd").removeAttr("disabled");
						 	$("#checkpwd").attr("disabled","true");
							$("#idduplicationcheck").attr("data-val",
									"true");
							$("#id").attr("data-val", "true");
							$(".possible-id").show();
						} else {						
						
							$(".already-using-id").show();  
						}
					},
					error : function() {

					}

				})

			})

</script>


</body>

</html>

