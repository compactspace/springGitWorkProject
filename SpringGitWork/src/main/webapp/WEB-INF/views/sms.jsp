<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<!DOCTYPE html>
<html>
<head>
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
</head>
<body>
 <input id="mTel" value= "01093130686">
 <input type = "button" onclick="authnum()" class = "authbtn" value = "인증번호받기">
<script> 
function authnum() {
	   var inputed = $("#mTel").val();
	   startTimer();
	   $.ajax({
	      data: {
	         mTel : inputed
	      },
	      url : "sendMessage.do",
	      success: function() {
	         $(".authbtn").prop("disabled",true);
	         $(".authbtn").css("display", "none");
	         $(".successMessage").css("display", "block");
	      }      
	   });
	}

</script>
<!-- 여기서 인증값을 태워보낼지는 고하면서 고민해보자  -->
<form action="isauthnum.do">
<input type="text" name="authnumber" class="authnumber" placeholder="인증번호를 입력해주세요" >

 <input type ="submit" class="insertauthnumber" >

</form>
	<button onclick="startTimer();">시간제한</button>

<input type="text" class="time"> 





</div>




</body>
</html>