<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>

	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Document</title>
	<style>
	#cooldownMessage {
	margin-top: 10px;
	font-weight: bold;
	color: #d9534f;
}

@media (max-width: 360px){
 body {
  
    
  }
 
 .smsallwrapper{
    width: 100% !important;
 }
 
 .smswrapper{
 margin-left:  !important 0;
    margin-right:  !important 0;
    width: 100% !important;
 }
 
}
	
	
	
	
	
	
	
		.goback {
			position: absolute;
			left: 0;
			top: 23px;
			content: '';
			width: 10px;
			/* 사이즈 */
			height: 10px;
			/* 사이즈 */
			border-top: 5px solid #000;
			/* 선 두께 */
			border-right: 5px solid #000;
			/* 선 두께 */
			transform: rotate(225deg);
			/* 각도 */

		}

		button {
			background-color: transparent;
			border: none;
		}

		.all {
			-webkit-box-flex: 1;
			-ms-flex: 1 1 100%;
			flex: 1 1 100%;
			min-height: 100vh;

			display: flex;

			flex-direction: column;
		}

		.alldivwrapper {
			min-height: 100vh;
			box-orient: vertical;
			width: 100%;
			display: flex;
			flex-direction: column;
			justify-content: center;
		}



		.smsallwrapper {

			width: 380px;
			box-shadow: 0 2px 4px 0 rgba(0, 0, 0, .08);
			border-radius: 0.5rem;
			position: relative;
			margin-left: auto;
			margin-right: auto;
			width: 486px;
			display: flex;
			flex-direction: column;
			min-width: 0;
			word-wrap: break-word;
			background-color: #fff;
			background-clip: border-box;

		}

		.smswrapper {
			margin-left: auto;
			margin-right: auto;
			width: 85%;
		}


		form {
			height: 100px;
			width: 100%;
		}


		.smsformheader {
			display: flex;
		}

		.sms2formheader {
			display: flex;
		}

		.smsformbody {
			display: flex;
			flex-direction: column;
		}


		.smsforminputbro1 {
			border-bottom: 1px solid #ddd;
		}

		.smsforminputbro2 {
			overflow: hidden;
			margin-top: 10px;
    margin-bottom: 10px;
			height: 30px;
			background-color: #e4e4e4;
			border-color: #e4e4e4;
			color: #999;
			width: 100%;
		}

		.smsforminputbro2ul {
			padding: 0px;
            margin-top: 10px;
			list-style: none;
			display: flex;
			flex-direction: column;
			justify-content: flex-start
		}

		.ullabel {
			line-height: 30px;
		}




		.smsforminputbro2ul {

			list-style: none;
			padding: none;

		}

		.bro1inputgroup {
			display: flex;
			justify-content: space-between
		}

		#tell {
			font-size: 20px;
			height: 35px;
		}

		#pwd {
			border-bottom: 1px solid #ddd;
			font-size: 20px;
			height: 35px;
		}

		#sel {
			border: none;
			height: 100%;
			width: 60px;
		}

		.bro3choice1 {
			width: 100%;
		}

		.bro1choice2 {

			width: 100%;
		}


    .smsforminputbro3{margin-bottom: 15px;}
		.bro3choice1 ul {
			list-style: none;
			display: flex;
			flex-wrap: wrap;
			justify-content: flex-end;
		}



		.smsforminputbro4 {
			border-bottom: 1px solid #ddd;
		}

		#name {
			font-size: 20px;
			height: 35px;

		}

		input {
			width: 100%;
			border: none;

			background-color: transparent;
		}

		.smsforminputbro4 {
			margin-bottom: 25px;
		}


		.smsforminputbro5 {
			margin-bottom: 25px;
			border-bottom: 1px solid #ddd;
		}

		#date {
			font-size: 20px;
			height: 35px;
		}

		.heperul {
			padding-left: 10px;
			list-style: none;
		}


		#givemeauthnum {
			margin-top: 10px;
			margin-bottom: auto;
		}

		#getauth {
			background-color: #e4e4e4;
			border-color: #e4e4e4;
			color: #999;
			width: 100%;
			height: 65px;

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
		
		
	</style>
	<script>
	var lastpwdcheck;
	var lasttelcheck;
	var lastdatecheck;
	
	let authToken = null;
	var  cooldownStartTime = null; // 세션에서 전달된 고정 시간 (ms)
    var  cooldownDuration = null;  // 쿨다운 기간 (ms)
    
    
		window.onload = function () {

			
			

$('.smsforminputbro2ul').hide();
		
$(".smsforminputbro2").on("click",function(){
	$('.smsforminputbro2ul').show()
	if($(".smsforminputbro2").css("height")=='30px'){
		$(".smsforminputbro2").css({"height": "120px"});
	}
	else{	
		$('.smsforminputbro2ul').hide();
		$(".smsforminputbro2").css({"height": "30px"});
	}


	

})


			////
			$(".heperul").hide()
			var lastpwdcheck;
			var lasttelcheck;
			var lastdatecheck;
			var pwd = document.querySelector("#pwd");
	
			var tell = document.querySelector("#tell");
			var date = document.querySelector("#date");
			//전화번호는 하이픈없이 11자리로만			
			tell.onkeyup = function () {

				let tellpatter = $("#tell").val();
				console.log("전화번호패턴->" + /^[0-9]{3}-?[0-9]{4}-?[0-9]{4}$/.test(tellpatter))
				if (/^[0-9]{3}-?[0-9]{4}-?[0-9]{4}$/.test(tellpatter)) {

					lasttelcheck = true
				} else {
					lasttelcheck = false;
				}


			}


			//단 영어 대문자 소문자 숫자 6이상으로 
			if(document.querySelector("#pwd")!=null){
			pwd.onkeyup = function () {
				$(".smallheper").css({ "display": "none" });
				let pwdpattern = $("#pwd").val();
				var reg = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;

				if (!reg.test(pwdpattern)) {
					$("small>ul>li").css({ "color": "white", "background-color": "#d7373f" })
					$(".heperul").show()
					$(".heperul li").css({ "color": "#d7373f" })
					$(".heperul li").css({ "color": "#d7373f" })
					lastpwdcheck = false;

				} else {
					$("small>ul>li").text("비밀번호사용가능")
					$("small>ul>li").css({ "color": "white", "background-color": "#008a28" })
					$(".heperul li").css({ "color": "#008a28" })
					lastpwdcheck = true;
				}



			}
			}



			date.onkeyup = function () {
				let datepatter = $("#date").val();

				if (/^\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/.test(datepatter)) {
					lastdatecheck = true;
				} else {
					lastdatecheck = false;
				}

			}
			

			$("#getauth").on("click", function () {
			
				if (lastpwdcheck & lasttelcheck & lastdatecheck) {
					reqeustSignUpSmem();
				
				} else{
					alert("생년월일 또는 핸드폰번호를 다시 입력해주세요")
				}

			})
			
			$("#sendCodeBtn").on("click", function () {
				
				if (lasttelcheck) {
					//여기
					reqeustSignUpSmem();
					
				} else{
					alert("생년월일 또는 핸드폰번호를 다시 입력해주세요")
				}

			})
			
			
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
			        url: "${pageContext.request.contextPath}/api/guest/signup-verify-sms-code",
			        type: "POST",
			        data: { code: code, token: authToken },
			        success: function (res) {
			        	const success=res.success;
			        	
			        		if(success){
			        			const status = res.data.status;  			
			        			
			        			  if (status === "SUCCESS") {
			        	                alert("인증 되었습니다. 회원가입창으로 진행합니다.");			        	             
			        	                const {verifiedTTL,ttlStartTime}=res.data        	                
			        	                console.log('verifiedTTL: '+verifiedTTL+" ttlStartTime: "+ttlStartTime);
			        	                window.location.href = '${pageContext.request.contextPath}/guest/get-signup-page';

			        	               
			        	            } else if (status === "EXPIRED") {
			        	                alert("인증번호가 만료되었습니다. 다시 시도하세요.");
			        	                localStorage.removeItem("authToken");
			        	                
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
			
			
			
			
			
		}
		
		
		function reqeustSignUpSmem() {
			
			
			  var inputed = $("#tell").val();			
			   $.ajax({
			      data: {
			    	  phone : inputed
			      },
			      url : "${pageContext.request.contextPath}/api/guest/request-signup-sms-code",
			      type:"POST",  	  
			    	  
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
			    	  
			    	  
			    	  
			    	  
			    	  
			    	/*   $("#date").val("받은 인증번호를기입해주세요");
			          $("label[for='date']").text('인증번호');
			    	  $("#givemeauthnum>button").prop("type",'submit')
			    	  $("#givemeauthnum").empty();
			    	  $("#givemeauthnum").append("<button type='submit' >인증하기</button>")
			    	  $("#givemeauthnum").after("<input type='button' onclick='authnum()' value='인증번호재요청'></button>")
		 */
		 
		 
			     
			        
			   });
			
			
			}
		
		
		
		
		  function initCooldownUI(cooldownStartTime,cooldownDuration) {
			  
			  console.log("서버시간: "+cooldownStartTime+" 주기 밀리초: "+cooldownDuration)
			    const now = new Date().getTime();
			    const elapsed = now - cooldownStartTime;
			    const remaining = cooldownDuration - elapsed;

			    const sendBtn = document.getElementById('sendCodeBtn');
			    
			    console.log('쿨다운 초:'+Math.ceil(remaining / 1000));	
			    
			    
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
		
		  
		  
		  
		  const removeCoolDown = (cooldownStartTime,cooldownDuration) => {
			 /*  localStorage.removeItem("authToken"); */
			  $.ajax({
			    url: "${pageContext.request.contextPath}/api/guest/signup-remove-smsCoolDown",
			    type: "POST",
			    success: function (res) {
			      console.log(res);
			      if (res.success) {
			        cooldownStartTime = null; // 세션에서 전달된 고정 시간 (ms)
			        cooldownDuration = null;  // 쿨다운 기간 (ms)
			      }
			    },
			  });
			};	
		
	</script>
</head>




<body>
	<div class="all">
		<div class="alldivwrapper">
			<div class="smsallwrapper">
				<div class="smswrapper">
					<div class="smsformheader">
						<div class="sms2formheader">
						<button id="goBackbtn">
								<span class="goback" onclick="window.location.href='${pageContext.request.contextPath}/teacher/login-page'"></span>
							</button>

							<h3 class="m-0"><span>문자 하기</span></h3>
					
						</div>
					</div>
					<div class="smsformbody">
					
						
					
					
						
							<!-- bro1:핸드폰번호 입력폼+인증전송 -->
							<label for="tell">휴대폰번호</label>
							<div class="smsforminputbro1">
								<div class="bro1inputgroup">
									<div class="bro1choice1"><select id="sel">
											<option value="kt">KT</option>
										</select></div>
									<!-- 인증번호 발송 밑 데이터베이스에 들어갈 user_tell 임 -->
									<div class="bro1choice2"><input type="text" id="tell" name="user_tell"
											placeholder="휴대폰 번호를 입력해주세요" required></div>
								</div>
							</div>
							<!-- bro2:그냥 약관 필요없으면 지우자-->
							<div class="smsforminputbro2">
								<div class="ullabel">
								<span>본인확인서비스 약관동의</span>
								</div>
								<ul class="smsforminputbro2ul">
									<li>[필수사항]개인정보이용동의</li>
									<li>[필수사항]개인정보이용동의</li>
									<li>[필수사항]개인정보이용동의</li>
								</ul>
							</div>						
				
							
							<!-- bro4: 이름 데이터베이스 삽입기준이다. 선택사항 단, 형식은 갖추기에 required처리는 하자 -->
							<div class="smsforminputbro4">
								<label for="name">이름
									<input id="name" type="text" name="user_name" id="user_name"
										placeholder="이름을 입력해주세요">
								</label>
							</div>
							<!-- bro5:생년월일이나, 성별 으로 선택사항 데이터베이스에도 넣을생각 없음 그냥형식적인것임-->

							<div class="smsforminputbro5">
								<label class='datelabel' for="date" >생년월일
									
								</label>
								<input name="authnumber" id="date" type="text" placeholder="생년월일을 기재해주세요">
							</div>
							
					
							<div id="givemeauthnum">
								<button class='authnumber'  id="sendCodeBtn" type="button">인증번호요청</button>
							</div>
								<div id="cooldownMessage"></div>
							
						<form id="verifyForm">
				<input type="text" id="code" placeholder="인증번호 입력" required />
				<button type="button" id="verifyBtn">
					인증하기</button>
			</form>

					</div>
				</div>
			</div>
		</div>
	</div>

</body>

</html>