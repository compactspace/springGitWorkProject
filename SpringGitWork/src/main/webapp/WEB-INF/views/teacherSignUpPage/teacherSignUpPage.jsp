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




html, body {
    height: 100%;
    margin: 0;
    display: flex;
    justify-content: center; /* 수평 중앙 */
    align-items: center;     /* 수직 중앙 */  
}




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

/* 사업자 정보 필드 시작 */

/* 전체 wrapper 스타일 */
#documentWraaper {
	display: none; /* 기존 숨김 유지 */
	max-width: 600px;
	margin: 30px auto;
	padding: 25px;
	border: 1px solid #ddd;
	border-radius: 10px;
	background-color: #f9f9f9;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
	font-family: 'Noto Sans KR', sans-serif;
}

/* 안내 문구 스타일 */
.info-text {

	color: #006064;
	border-radius: 6px;
	font-size: 0.95em;
	line-height: 1.5;
}

/* 제목 */
#documentWraaper h3 {
	margin-bottom: 20px;
	font-size: 1.2em;
	color: #333;
}

/* 회사 정보 필드 & 파일 업로드 필드 공통 스타일 */
#documentWraaper .company-info-field, #documentWraaper .document-field {
	display: flex;
	flex-direction: column;
	margin-bottom: 15px;
}

/* 라벨 스타일 */
#documentWraaper label {
	font-weight: 500;
	margin-bottom: 5px;
	color: #555;
}

/* 입력창 스타일 */
#documentWraaper input[type="text"], #documentWraaper input[type="email"],
	#documentWraaper input[type="file"] {
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 6px;
	font-size: 0.95em;
	transition: border 0.2s, box-shadow 0.2s;
}

/* 포커스 효과 */
#documentWraaper input[type="text"]:focus, #documentWraaper input[type="email"]:focus,
	#documentWraaper input[type="file"]:focus {
	border-color: #007bff;
	box-shadow: 0 0 5px rgba(0, 123, 255, 0.3);
	outline: none;
}

/* 제출 버튼 스타일 */
#documentWraaper #submitDocuments {
	padding: 12px 20px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 6px;
	font-size: 1em;
	cursor: pointer;
	transition: background-color 0.2s;
}

/* 버튼 호버 효과 */
#documentWraaper #submitDocuments:hover {
	background-color: #0056b3;
}

/* readonly 입력창 배경 색 */
#documentWraaper input[readonly] {
	background-color: #e9ecef;
	cursor: not-allowed;
}

/* 반응형 */
@media ( max-width : 640px) {
	#documentWraaper {
		padding: 20px;
		margin: 20px;
	}
}
/* 사업자 정보 필드 종료 */
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
			<span class="info-text">인증기한 만료 시 재인증이 필요합니다.</span> <span
				id="countdown-timer"> 인증번호 유효시간: <strong id="time-remaining">--</strong>초
				남음
			</span>
		</div>


		<div id="loginformwrapper">

			<!-- <form action="insertmembership.do" id="membershipform" method="post"> -->
			<div class="iddiv">
				<h3>등록할아이디</h3>
				<input type="text" class="idsinput" id="ids" name="id"
					data-val="false" placeholder="ID 입력"> <span id="idspattern">
					아이디 형식이 올바르지 않습니다. 아이디는 4자 이상 7자 이하입니다. </span> <span class="possible-id"
					style="display: none;">사용 가능한 아이디입니다.</span> <span
					class="already-using-id" style="display: none;">이미 사용 중인
					아이디입니다.</span> <input type="button" id="idduplicationcheck"
					data-val="false" value="아이디 중복 확인">
			</div>

			<div class="passworddiv">
				<h3>비밀번호</h3>
				<input type="password" class="pwdinput" id="pwd" name="password"
					data-val="false"> <span class="step1pwderr"
					style="display: none;">비밀번호 형식이 올바르지 않습니다.</span> <input
					type="password" class="checkpwdinput" id="checkpwd" name="checkpwd"
					value="${userVO.password}"> <span class="step2pwderr"
					style="display: none;">비밀번호가 일치하지 않습니다.</span>
			</div>

			<input type="hidden" class="user_where" id="user_where"
				name="user_where" value="finalluser">
			<!-- <input type="hidden" class="user_code" id="user_code" name="user_code"> -->

			<br>
			<br>
			<div class="login_membershipdivwrapper">
				<input class="finallsubmitinput" id="finallsubmit" type="button"
					value="다음단계">
			</div>

		</div>




		<div id="documentWraaper" style="display: none">
			<h3>회사 정보 기재</h3>
			<p class="info-text">
				✨ 이 폼은 포트폴리오용 데모입니다.<br> 실제 제출 기능은 동작하지만, 모든 개인정보는 허구의 데이터입니다.<br>
				예를 들어 회사명, 대표자명, 사업자번호 등은 샘플 데이터로 작성되어 있습니다.<br> 사업자등록증명원 업로드
				시에도 실제 문서가 아닌, 의미 없는 예시 사진(jpg, png)을 사용해주세요.<br> 안전하게 제출
				테스트용으로만 이용하실 수 있습니다.
			</p>

			<form id="documentForm" enctype="multipart/form-data">
				<!-- 하드코딩된 회사 정보 입력 -->
				<div class="company-info-field">
					<label for="company_name">회사명:</label> <input type="text"
						id="company_name" name="company_name" value="홍길동컴퍼니" readonly>
				</div>
				<div class="company-info-field">
					<label for="registration_number">사업자번호:</label> <input type="text"
						id="registration_number" name="registration_number"
						value="123-45-67890" readonly>
				</div>
				<div class="company-info-field">
					<label for="representative_name">대표자명:</label> <input type="text"
						id="representative_name" name="representative_name" value="홍길동"
						readonly>
				</div>
				<div class="company-info-field">
					<label for="company_phone">전화번호:</label> <input type="text"
						id="company_phone" name="company_phone" value="010-1234-5678"
						readonly>
				</div>
				<div class="company-info-field">
					<label for="address">주소:</label> <input type="text" id="address"
						name="address" value="서울시 강남구 테헤란로 123" readonly>
				</div>
				<div class="company-info-field">
					<label for="email">이메일:</label> <input type="email" id="email"
						name="email" value="example@company.com" readonly>
				</div>

				<!-- 기존 사업자등록증 파일 업로드 -->
				<div class="document-field">
					<label for="businessCertificate">사업자등록증명원: 사진 파일로 등록해주세요
						(ex: jpg, png)</label> <input type="file" id="businessCertificate"
						name="businessCertificate" accept="image/jpeg, image/png" required>
				</div>

				<button type="button" id="submitDocuments">서류 제출</button>
			</form>
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
		 currentStep2Pwd=null;	
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
	
	
	if(!idDuplicCheck|| !패스워드1차2차검증){
		return;
	}
	
	$("#loginformwrapper").hide();
	$("#documentWraaper").show();
	
	
	
	

})
  
$("#submitDocuments").on("click", function() {
    var fileInput = $("#businessCertificate")[0];
    
    if (fileInput.files.length === 0) {
        alert("파일을 선택해주세요.");
        return;
    }

    var file = fileInput.files[0];

    if (!isValidFileType(file)) {
        alert("지원되지 않는 파일 형식입니다. jpg, jpeg, png만 가능합니다.");
        return;
    }

    if (!isValidFileSize(file)) {
        alert("파일 용량이 너무 큽니다. 2MB 이하로 업로드해주세요.");
        return;
    }

    // FormData 생성 및 AJAX 전송 (이전 답변 참고)
    var formData = new FormData();
    formData.append("id", $("#ids").val());
    formData.append("password", $("#pwd").val());
    formData.append("businessCertificate", file);
    
    
    
 	// 하드코딩 회사 정보 추가
    formData.append("company_name", $("#company_name").val());
    formData.append("registration_number", $("#registration_number").val());
    formData.append("representative_name", $("#representative_name").val());
    formData.append("company_phone", $("#company_phone").val());
    formData.append("address", $("#address").val());
    formData.append("email", $("#email").val());

    
    $.ajax({
        url: "${pageContext.request.contextPath}/api/guest/teacher-action-signup",
        type: "POST",
        data: formData,
        processData: false,
        contentType: false,
    	success:(data)=>{			
			if(data=="signupfalse"){
				alert("금새 동일한 아이디로 누가 가입하였습니다. 다른 아이디로 다시 시도해주세요")
			}else{
				location.replace("${pageContext.request.contextPath}/teacher/login-page");
			}
			
		},
        error: function() {
            alert("서버 전송 실패. 다시 시도해주세요.");
        }
    });
});

  function isValidFileType(file) {
    const allowedExtensions = ["jpg", "jpeg", "png"];
    const fileExt = file.name.split(".").pop().toLowerCase();
    return allowedExtensions.includes(fileExt);
}
function isValidFileSize(file) {
    const maxSize = 2 * 1024 * 1024; // 2MB
    return file.size <= maxSize;
}

  
  
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

