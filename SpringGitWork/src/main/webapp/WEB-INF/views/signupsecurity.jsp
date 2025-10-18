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

.imgdiv {
	padding-top: 150px;
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

#idslengthcheck {
	display: none;
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
</style>
<script>

//문자발송 일일 한도 초과로 내일까지만 주석처리하자.
/* var user_where="phone";
var user_tell="${user_tell}";
var user_name="${user_name}"; */
	window.onload = function() {
/* 	 	$(".alldivwrapper").hide();
	 $("input[class='phone']").on("click",function(){
		
			if($(this).val()=="핸드폰번호로가입하기"){
				
				//발송문자 일일 한도 초과로 직접 수동으로 보내자 내일 주석 해재 ㅠ
		 location.href="idIsphone.do?id="+${user_tell}+"&user_where="+${user_where}+"&user_name="+${user_name}; 	 
				//location.href="idIsphone.do?id="+"01093130686"+"&user_where="+"phone"+"&user_name="+"신원찬";
				
			} else{
				$(".alldivwrapper").show();
			}			
				
		})   */

		$("#finallsubmit").on("click",()=>{
			 console.log("클릭함수 확인");
			console.log("id는->"+$("#ids").val()+" 입력한 비번은 "+$("#pwd").val()) 
			$.ajax({
				url:"securitysignup.do",
				type:"post",
				data:{"user_id":$("#ids").val(),"user_pwd":$("#pwd").val()},
				success:(data)=>{
					console.log("성공시 받아온 데이터 data는")
					console.log(data)
					
					if(data=="signupfalse"){
						alert("금새 동일한 아이디로 누가 가입하였습니다. 다른 아이디로 다시 시도해주세요")
					}else{
						location.replace("securityloginform.jsp");
					}
					
				}
			})
			
		})
		
		
		
	

	}
</script>
</head>

<body>
	<div class="alldivwrapper">
		<div class="imgdiv">
			<h2>
				로그인 <img src="./img_membership/membership.png">
			</h2>

		</div>
		<div id="loginformwrapper">

		<!-- 	<form action="insertmembership.do" id="membershipform" method="post"> -->
				<div class="iddiv">
					<h3>등록할아이디</h3>


					<input type="text" class="idsinput" id="ids" name="user_id" data-val="false"> 
					<input type="text" class="idinput" id="ids2" placeholder="ID">
					<%--  <input type="text" class="idinput" placeholder="ID"  value="${userVO.id}" > --%>
					<h1 id="idslengthcheck">아이디는4자이상 7자이상만</h1>
					<h1 id="idspattern">패턴이틀립니다.</h1>
					<input type="button" id="idduplicationcheck" data-val="false" value="아이디중복확인">
				</div>

				<script>
        if($("#ids").val()==null&&$("#ids2").val()==null){
        	alert("먼저 아이디를 입력해주세요")
        }else{       	
        	
        	$("#idduplicationcheck").on(
    				"click",
    				function() {
    					console.log("입력한 아이디값 은->>>>>>"+$("#ids").val())
    					$.ajax({
    						url : "securitycheckid.do",
    						method : "POST",
    						data : {
    							"user_id" : $("#ids").val()
    						},
    						success : function(data) {
    							console.log("받아온 데이터는 투루 일까요 펠스 일까요오");
    							console.log(data);
    								let check=document.getElementsByClassName('ok')
    							if (data) {
    								
    							
    								
    								$("#idduplicationcheck").after(
    										"<div class=ok >사용가능한아이디입니다.</div>");
    								$("#pwd").removeAttr("disabled");
    							 	$("#checkpwd").attr("disabled","true");
    								$("#idduplicationcheck").attr("data-val",
    										"true");
    								$("#id").attr("data-val", "true");

    							} else {
    								
    								$("#idduplicationcheck").after(
    										"<div class=ok>이미있는아이디입니다.</div>");
    							}
    						},
    						error : function() {

    						}

    					})

    				})
        	
        }
    	
        </script>


				<div class="passworddiv">
					<h3>비밀번호</h3>
					<input type="password" class="pwdinput" id="pwd" name="password" data-val="false">
					 <input type="password"	class="checkpwdinput" id="checkpwd" name="checkpwd"	value="${userVO.password}">
				</div>
				<input type="hidden" class="user_where" id="user_where" name="user_where" value="finalluser">
				<!-- <input type="hidden" class="user_code" id="user_code" name="user_code"> -->
				<br> <br>
				<div class="login_membershipdivwrapper">
					<input class="finallsubmitinput" id="finallsubmit" type="button" value="회원가입">
				</div>
		<!-- 	</form> -->
		</div>
	</div>

	<script>

$("#pwd").attr("disabled", "true");
	$("#checkpwd").attr("disabled", "true"); 
$("#idduplicationcheck").attr("disabled", "true");

$("#finallsubmit").attr("disabled","true")
$("#pwdlengthcheck").hide();
$("#pwdpattern").hide();


/* data-val 는 최종 제출 하기전  하나라도 부족한게 있는지 체크하는 용도임 */
$("#id").attr("data-val", "false");
$("#idduplicationcheck").attr("data-val", "false")
$("#checkpwd").attr("data-val", "false");

$("#pwd").attr("data-val", "false");
var id = document.querySelector("#ids")
var pwd = document.querySelector("#pwd");
var checkpwd = document.querySelector("#checkpwd");


id.onclick=function(){
	let check=document.getElementsByClassName('ok')
	console.log(check)
if(check.length==1 || check.length>=1){
	check[0].remove();
}
}

id.onkeyup = function() {

	 						


	
	// console.log("onkeyup 이벤트는->" + ": 키보드를 눌렀다가 땐 !후!   ");
	// console.log("id.value->" + id.value);

	//이게 배열이였던가 문자열이였던가 객체였던가 뭔지도 모르고 렝스를 쓰게되네
	//여기선 인풋창에 입력하는 함수부부분
	let idlength = id.value
	if (idlength.length !== 0) {
		/* console.log("이프문을 탄다.");
		console.log("함수호출이 되는지 확인만해본다.->" + idlengthcheck(idlength)); */

		if (idlengthcheck(idlength)) {
			$("#idslengthcheck").hide();

			if (idspattern(idlength)) {
				$("#idslengthcheck").hide();
				$("#idspattern").hide();
				$("#idduplicationcheck").removeAttr("disabled");

			} else {
				$("#pwd").attr("disabled", "true");
				$("#idduplicationcheck").attr("disabled", "true");
				$("#idduplicationcheck").attr("data-val", "false");
			}

		} else {

			$("#idslengthcheck").show();
			$("#idspattern").show();
			$("#pwd").attr("disabled", "true");
			$("#idduplicationcheck").attr("disabled", "true");
			$("#idduplicationcheck").data("val", "false");
		}

	}

}//아이디입력창 폼 함수 종료



pwd.onkeyup = function(){
	

	let pwdlength = pwd.value
	console.log("벡스페이스시길이"+pwdlength.length);
	if (pwdlength.length !== 0) {
		$("#pwdlengthcheck").show();
		   
		if (pwdlengthcheck(pwdlength)) {
			$("#pwdlengthcheck").hide();
			 
			          
			if (pwdpattern(pwdlength)||pwdlengthcheck(pwdlength)) {
				$("#pwdpattern").show();
				console.log(pwdpattern(pwdlength));
				if(pwdpattern(pwdlength)&&pwdlengthcheck(pwdlength)){
					$("#checkpwd").removeAttr("disabled");						
					$("#pwdpattern").hide();
					$("#pwdlengthcheck").hide();
					if($("#checkpwd").val()!=''&&pwdpattern(pwdlength)){
						console.log("어머나 이게 나?"+$("#checkpwd").val())
						$("#checkpwd").val('');
						$("#checkpwd").attr("disabled","true"); }
					
				}
			} 

		} else if($("#checkpwd").val()!=''&&pwdlength.length !== 0){
			$("#checkpwd").val('');
			$("#checkpwd").attr("disabled","true");
			$("#finallsubmit").attr("disabled","true");
		} else {
			$("#pwdpattern").hide();
		}
		  $("#pwdpattern").hide();
			
		 	
	}

}

checkpwd.onkeyup=function(){
	/* $("#checkpwd").attr("disabled","true");   */
	let check=checkpwd.value;
	if($("#pwd").val()==check){
		console.log("비밀번호일치")
		$("#finallsubmit").removeAttr("disabled");
	}else{
		console.log("비밀번호 불일치")
		$("#finallsubmit").attr("disabled","true");
	}
	
	
}


//아이디 길이 만족 함수
function idlengthcheck(value) {

	return value.length > 4 && value.length < 7;

}
//아이디는 대소/문/숫 판별만족함수
function idspattern(str) {
	return /^[A-Za-z0-9][A-Za-z0-9]*$/.test(str);
}

//패스워드 길이 만족 함수
function pwdlengthcheck(value) {

	return value.length > 7 && value.length < 40;

}

//패스워드 대소/문/숫 판별만족함수
function pwdpattern(str) {
	return /^[A-Za-z0-9][A-Za-z0-9]*$/.test(str);
}

</script>









</body>

</html>

