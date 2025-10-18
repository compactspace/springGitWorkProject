<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>

	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Document</title>
	<style>
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
			height: 530px;
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
	</style>
	<script>
	var lastpwdcheck;
	var lasttelcheck;
	var lastdatecheck;
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
				console.log("비밀번호최종->" + lastpwdcheck);
				console.log("핸드폰최종->" + lasttelcheck);
				console.log("날짜최종->" + lastdatecheck);
				if (lastpwdcheck & lasttelcheck & lastdatecheck) {
					authnum();
				
				} else{
					alert("생년월일 또는 핸드폰번호를 다시 입력해주세요")
				}

			})
			
			$("#getauth2").on("click", function () {
				
				console.log("핸드폰최종->" + lasttelcheck);
				console.log("날짜최종->" + lastdatecheck);
				if (lasttelcheck) {
					authnum();
				
				} else{
					alert("생년월일 또는 핸드폰번호를 다시 입력해주세요")
				}

			})
			

		}
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
								<span class="goback"></span>
							</button>


<% String smsfor2=request.getParameter("smsfor");
    
%>
<%=request.getParameter("finallsum") %>
<%=request.getParameter("finallsum") %>

							<h3 class="m-0"><span>결제전 본인인증</span></h3>
					
						</div>
					</div>
					<div class="smsformbody">
				
			
						
						<form action="payforauthnum.do?receipt_buyer_id='${id}' &receipt_paid_amount='${pay}'" method="post" autocomplete="off">
					
						
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
							<!-- bro3:여기서 사용할 비번-->
							<!-- password 데이터베이스에 들어갈 값이며, 여기서 유효성등을 처리-->					
						
			
				
							
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
								<button class='authnumber'  id="getauth2" type="button">인증번호요청</button>

							</div>
						
							<input type="hidden"  name="finallsum" value=<%=request.getParameter("finallsum") %>>
						</form>

					</div>
				</div>
			</div>
		</div>
	</div>
<script> 
function authnum() {
	
	

		


	  var inputed = $("#tell").val();	  
	  let timer=startTimer();
	  console.log("timer->>>>"+timer)
	   $.ajax({
	      data: {
	         mTel : inputed
	      },
	      url : "sendMessage.do",
	      success: function() {
	    	  $("#date").val("받은 인증번호를기입해주세요");
	          $("label[for='date']").text('인증번호');
	    	  $("#givemeauthnum>button").prop("type",'submit')
	    	  $("#givemeauthnum").empty();
	    	  $("#givemeauthnum").append("<button class='btn' type='submit' >인증하기</button>")
	    	  $("#givemeauthnum").after("<input type='button' onclick='authnum()' value='인증번호재요청'></button>")

	     
	      }      
	   });
	
	
	}

</script>
	<script>
var timer;
var isRunning = false; // isRunning 변수를 전역 범위에서 정의

// 타이머
function startTimer() {
	alert("보내드린 인증번호를 1분이내로 입력해주세요")
    var display = $(".authnumber"); // display 변수 설정
    var leftSec = 10000; // 유효시간 설정 (예시로 20으로 설정)

    // 이미 타이머가 실행 중인 경우 중지
    if (isRunning) {
        clearInterval(timer);
    }

    isRunning = true;

    // startTimer 함수 호출
    timer = setInterval(function () {
    
        var minutes = parseInt(leftSec / 60, 10);
        var seconds = parseInt(leftSec % 60, 10);

        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;

        display.html(minutes + ":" + seconds);
        display.css('color', 'red');

        // 타이머 끝
        if (--leftSec < 0) {
            clearInterval(timer);
            display.css('color', 'red');
            // display.html('시간초과');
            $("#phoneChk1").val("").prop('disabled', true).css('background-color', '#4692B8').css("margin-right", "94px");
            // $("#phoneChk1").toggleClass('ph_color_change');
            $("#phoneChk1").attr("placeholder", "time out").toggleClass('ph_color_change');
            $("#phoneChk2").css("display", "none"); //인증버튼 숨기기
            $("#phoneChksendbtn").text("재전송").css("width", "80px").css('margin-right', '25px');
            display.css("display", "none"); //시간 숨기기
            isRunning = false;
            alert("입력제한시간을 초과하셨습니다.")        
            $(".insertauthnumber").css({"display":"none"})
            <%session.removeAttribute("AuthNumber");%>
            location.href="worklist.jsp";
        }
    }, 1000);
}
</script>
</body>

</html>