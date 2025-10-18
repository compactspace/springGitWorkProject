<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%@ include file="header.jsp"%> --%>
<%-- <%@ include file="changebody.jsp"%> --%>
<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>index페이지</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Orbit&family=Sunflower:wght@300&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<style>
* {
	margin: 0;
	padding: 0;
}

body {
	margin: 0 0 0 0px;
	box-shadow: 0 0 17px 3px rgb(171 171 171/ 50%);
	background-color: #FFF !important;
}

p {
	background-color: rgb(119, 193, 61) font-family: 'Sunflower', sans-serif;
}

#wrappers {
	max-width: 560px;
	margin: 0 auto;
	box-shadow: 0 0 17px 3px rgb(171 171 171/ 50%);
}

#carousel {
	margin: 0 auto;
	/* 메인사진 주석처리 해가며 어느게 가장 이쁜지 비교해보자*/
	/* 	background-image: url(./img/main.jpg); */
	background-image: url(./img/main2.jpg);
	background-repeat: no-repeat;
	background-size: 100% 400px;
	height: 300px;
	vertical-align: middle;
}

/* 배치도 생각으로 전체 wrapper 감싼후 마진 오토 */
#wrapper {
	position: relative;
	max-width: 560px;
	    max-height: 688px;
	
	margin: 0 auto;
	display: grid;
	grid-template-rows: 10% 80%;
	box-shadow: 0 0 17px 3px rgb(171 171 171/ 50%);
}

header {
	position: relative;
	height: 70px;
	background: #fff;
	margin: 0;
}

#carouselimg {
	text-align: center;
}

h2 {
	font-weight: 500;
	color: #333333;
	font-style: normal;
}

nav {
	position: absolute;
	top: 20px;
	width: 100%;
}

ul {
	display: flex;
	list-style-type: none;
}

li {
	display: inline-block;
	width: 30%;
	text-align: center;
	color: #333333;
	letter-spacing: .01em;
	font-style: normal;
	font-weight: 300;
}

a {
	text-decoration: none;
	color: #333333;
}


#header1 {
	width: 100%;
	color: #333333;
	padding: 20px 0px;
	font-weight: 600;
}



/* Section 2 */
img {
	display: block;
}
#content1{
    border-bottom: 1px solid rgba(230, 230, 230, 0.5);
    }
#content2 {
border-bottom: 4px solid rgba(230, 230, 230, 0.5);
    height: 480px;
	display: grid;
	grid-template-columns: 50% 50%;
}

.sameinfo {
    color: #252525;
	background: #fff;
	margin: 0px auto 0;
	padding: 20px 0 40px;
}

.sameinfo>h2{
margin-left: 5px;

}

.sameinfo>p {
	display: block;
	width: 80%;
	margin: 5px 0px 0px 5px;
	font-weight: 300;
}




#Section2_2 {
	width: 100%;
	height: 100%;
}

}
#info2 {
	width: 90%;
	float: left;
	margin: 0px 0px 30px 50px;
	color: #333333;
}

#Section2_3 {
	/* display: grid;
	grid-template-rows: 40% 40%; */
	max-width: 490px;
}

#iconrow {
	height: 480px;
	width: 100%;
	display: flex;
	flex-direction: column;
}

.detail{
display: flex;
padding-bottom: 10px;
}


.infoicon {
	height: 20px;
	width: 20px;
}



.reserve_img {
	width: 250px;
	height: 250px
}

}
}
#info3 {
	width: 90%;
	float: left;
	margin: 0px 0px 30px 50px;
}

.clearfix:after {
	content: ".";
	display: block;
	height: 0;
	clear: both;
}



.sinchung{
max-width: 560px;
	margin: 0 auto;
    background-color: #FF5862;
    color: #fff;
        width: 100%;
}

.sinchung>h3{
width: 50%;
    margin: 0 auto;
    text-align: center;
        padding-top: 15px;
}


.allwarpper{

    position: absolute;
    /*컨텐츠의 위쪽 기준 으로 50% 수직임  */
    top: 50%;
       /*따라서 높의 절반만큼 올려준다. */
    margin-top:-339.5px;
    
     /*컨텐츠의 왼쪽 기준 으로 50% 이동임  */
        left: 50%;
         /*따라서 컨텐츠의 널비 절반만큼 올려준다. */
        margin-left: -280px;
}



 #ui-datepicker-div {
    
	/* display: grid !important;
	height: 480px;
	left: 0px !important;
	position: relative !important;
	max-width: 1020px !important;
	margin: 0 auto !important;
	top: -730px !important;
	width: 80%;
	grid-gap: 20px;
	grid-template-rows: 0px 40px 430px 0px; */
	
	
	/*    margin-top: -243.75px;
    top: 50%;
    position: absolute;
   
    z-index: 1;
    display: grid;
    height: 480px;
    max-width: 1020px;

    width: 80%;
    gap: 20px;
    grid-template-rows: 0px 40px 430px 0px; 
	 */
	
	
	
}
 
.ui-datepicker-title {
	display: flex !important;
}

.ui-datepicker select.ui-datepicker-year {
	width: 30% !important;
}

.ui-widget-header{

    background-color: #FF5862;
 
}
.ui-datepicker-calendar tr{
font-size: 14px;
}
.ui-datepicker-week-end>span{

color: #FF5862;
}

.ui-state-default{
text-align: center !important;

}

.ui-datepicker-trigger{
  
    width: 120px;
    height: 35px;
    font-weight: 600;
    color: white;
    background-color: #FF5862;
    border-radius: 5px;
    border: none;
}

.restcount{
width: 120px;
    height: 35px;
    font-weight: 600;
    color: white;
    background-color: #FF5862;
    border-radius: 5px;
    border: none;

}


.restcountarea{
padding: 10px 0px;
}
@media screen and (max-width: 701px) {


#content2{

display: flex !important;

}

.allwarpper{
top: 0px !important;
    margin-top: 0px !important;
     left: 0px !important;
    margin-left: 0px !important;
}


.reserve_img {
    width: 150px !important;
    height: 150px !important;
    padding-bottom: 100px !important;

}
#ui-datepicker-div{
    margin-left: 0px !important;  

}


}

</style>
</head>
<script type="text/javascript">
	window.onload = function() {
		let dateposition = document.getElementById("wrappers").scrollHeight;

		console.log(dateposition)
		$(".ui-datepicker-trigger").trigger("click");

	}

	$(function() {

		$("#onedayclass_name").change(function() {
			
			console.log("값이 변하면 떠야하는디???")
			console.log($(this).val());

			$.ajax({
				url : "selectOneDayClass.do",
				data : {
					onedayclass_name : $(this).val()
				},
				method : "POST",
				success : function(val) {
					console.log(val);

					$.each(val, function(index, obj) {
						console.log("클래스정보 "+obj.onedayclass_info);
						console.log("클래스 이름"+obj.onedayclass_name);
						console.log("클래스 비용 " +obj.onedayclass_price);
						console.log("클래스 대표이미지 "+obj.reserve_img);
						console.log("클래스 번호"+obj.onedayclass_num);
						let names = obj.onedayclass_name
						$(".reserve_img").attr("src", obj.reserve_img)
						$(".onedayclass_name").text(names);
						$(".onedayclass_info").text(obj.onedayclass_info);
						$(".onedayclass_num").val(obj.onedayclass_num)			
					

					});

				}

			})

			/* if($(this).val()=="취미만화반"){
				console.log("ddd");
			$(".reserve_img").attr("src",'./img_onedayclass/manhwa.jpg');
			}                    	 */

		})

		/*reserveinfo 로직을 바꾸면 지워버려라  */
	/* 	$(".reservebtn")
				.on(
						"click",
						function() {
							$
									.ajax({
										url : "insertreserve.do",
										data : {
											check : $("#check").val(),
											id : $("#id").val(),
											reserve_day : $(".reserve_day")
													.val(),
											onedayclass_price : $(
													"#onedayclass_price").val(),
											onedayclass_name : $(
													"#onedayclass_name").val()
										},
										method : "POST",
										success : function(val) {
											if (val == "true") {
												alert("예약완료");
											} else if(val == "false") {
												alert("죄송합니다. 저희 원데이 클래스는 소규모로, 같은시간에 모든 수업이 일괄적으로 진행되기에 동일한 날짜에 다른 수업을 예약할 수 없습니다.");
											} else if(val == "needjoin"){
												alert("~로그인이필요해요~");
											}

										}

									})

						})
						 */
						
						 
						 //백단에 자리수가 있는지 물어보는 것임

//SELECT  rest FROM reserverest WHERE onedayclass_num=1 and openday='2024-04-19'; 
		
		let rest;
		
						 $("#openday").change(function(e) {
							 console.log("오픈체인지");
						let onedayclass_num=$(".onedayclass_num").val();
						let openday=$("#openday").val();
						//console.log("클래스 번호는 "+onedayclass_num+"개설강의 날짜는"+openday)			 
							 
								$.ajax({
									url : "restOneDayClass.do",
									data : {
										onedayclass_num : onedayclass_num,
										openday         : openday
										
									},
									method : "POST",
									success : function(val) {
										console.log(val);
										rest=val
									/* 	console.log(val==1)
									console.log(val==0)
									console.log(val==-1) */
									$(".restcount").text(val+"자리남음");	
										if(val==-1){
											alert("날짜를 다시 선택해주세요")
										}

									}
								})

							 
							 
							 
							 
							 
							 
							 
							 
						 })
						 
						 
						 
						
					$(".reservebtn2").on( "click",
						function() {
					
					let count=$(".restcount").text().split("자리남음");
					console.log(count[0])
					console.log(count[0]=="0")
					console.log(count[0]==0)
		
					
					if(	count[0]==0){
						alert("마감된 날짜입니다. 날짜를 다시 선택해주세요")
					}else{
						$.ajax({
							url : "checkreserveinfo.do",
							data : {
								
								user_code : $("#user_code").val(),
							       openday:$("#openday").val(),
								onedayclass_num: $(".onedayclass_num").val()
								
							},
							method : "POST",
							success : function(val) {
								
								console.log("중복확인후 값");
								console.log(val);
						
								if (val == "true") {
				// 	console.log("결제페이지로 보낼 클래스 넘:->>"$(".onedayclass_num").val()+"그리고 개설강의 날짜는 ->>>"+$("#openday").val())
window.location.replace("/finall/onedayclasspay.jsp?onedayclass_num="+$(".onedayclass_num").val()+"&openday="+$("#openday").val()
		+"&reserve_img="+$(".reserve_img").attr("src")
		+"&onedayclass_name="+$(".onedayclass_name").text()
		+"&onedayclass_info="+$(".onedayclass_info").text()
		+"&onedayclass_price="+$("#onedayclass_price").val()
		+"&rest="+rest
		)								
/* window.location.href="/finall2/onedayclasspay.jsp?onedayclass_num="+$(".onedayclass_num").val()+"&openday="+$("#openday").val()
	+"&reserve_img="+$(".reserve_img").attr("src")
+"&onedayclass_name="+$(".onedayclass_name").text()
+"&onedayclass_info="+$(".onedayclass_info").text()
+"&onedayclass_price="+$("#onedayclass_price").val(); */
									
									
								//	window.location.href="/finall2/onedayclasspay.jsp";
								} else if(val == "false") {
									alert("죄송합니다. 저희 원데이 클래스는 소규모로, 같은시간에 모든 수업이 일괄적으로 진행되기에 동일한 날짜에 다른 수업을 예약할 수 없습니다.");
								} else if(val == "needjoin"){
									alert("로그인이 필요합니다. 로그인 페이지로 이동합니다.");
									window.location.href="/finall2/login.jsp";
									
								}

							}

						})
					}
					})//클릭함수종료	
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						

		//모든 datepicker에 대한 공통 옵션 설정
		//즉 여러개의 datepicker 만들어도 공통 설정됨
		$.datepicker
				.setDefaults({
					dateFormat : 'yy-mm-dd' //Input Display Format 변경= 달력선택시 인풋창에 뜬느 값 형식을 지정
					,
					showOtherMonths : true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
					,
					showMonthAfterYear : true //년도 먼저 나오고, 뒤에 월 표시
					,
					changeYear : true //콤보박스에서 년 선택 가능
					,
					changeMonth : true //콤보박스에서 월 선택 가능                
					,
					showOn : "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
					,
				/* buttonImage : "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로 
					, */
				/* 	buttonImageOnly : true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
					, */
					buttonText : "날짜선택하기" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
					,
					yearSuffix : "년" //달력의 년도 부분 뒤에 붙는 텍스트
					,
					monthNamesShort : [ '1', '2', '3', '4', '5', '6', '7', '8',
							'9', '10', '11', '12' ] //달력의 월 부분 텍스트
					,
					monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월',
							'8월', '9월', '10월', '11월', '12월' ] //달력의 월 부분 Tooltip 텍스트
					,
					dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ] //달력의 요일 부분 텍스트
					,
					dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일', '금요일',
							'토요일' ] //달력의 요일 부분 Tooltip 텍스트
					,
					minDate : "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
					,
					maxDate : "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
				});

		//input을 datepicker로 선언해야 달련 버튼이 자동으로 생긴다.
		//클릭시 그냥 자동으로 달력이 뜸

		//로직 수정후 지워라
		/* $("#reserve").datepicker({
			// beforeShowDay 는 datepicker 제공기능이자 키워드 인듯
			// before 는 사용자가 만드는 함수이고, 대충 원하는 요일 또는 일자 등 함수인듯
			beforeShowDay : before

		}); */
		
		
		$("#openday").datepicker({
			// beforeShowDay 는 datepicker 제공기능이자 키워드 인듯
			// before 는 사용자가 만드는 함수이고, 대충 원하는 요일 또는 일자 등 함수인듯
			beforeShowDay : before

		});
		
		
		
		 

		/* 	$("#check").datepicker({
				// beforeShowDay 는 datepicker 제공기능이자 키워드 인듯
				// before 는 사용자가 만드는 함수이고, 대충 원하는 요일 또는 일자 등 함수인듯
				beforeShowDay : before

			}); */

		//주말만 예약받자.
		function before(date) {
			var day = date.getDay();
			// 달력에 출력해줄 것을 배열로 리턴하는듯
			return [ (day != 1 && day != 2 && day != 3 && day != 4 && day != 5) ];
		}

		//From의 초기값을 오늘 날짜로 설정
		$('#reserve').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)

		$("#reserve").change(function() {
			let x = $("#reserve").val()

			$("#check").val(x);

		})

		$(".ui-datepicker-trigger").on("click",()=>{
		
			 var cssinfo=document.getElementById("ui-datepicker-div")
			    cssinfo.style.display ="grid"
			    cssinfo.style.height=" 480px";
			    cssinfo.style.marginTop= "-243.75px";
			    cssinfo.style.marginLeft="-530.315px";
				cssinfo.style.position="absolute";
			    cssinfo.style.maxWidth="1020px";
			/*     cssinfo.style.margin="0 auto"; */
			     cssinfo.style.top=" 50%";
			    cssinfo.style.maxWidth= "1020px";
			    cssinfo.style.width= "80%";
			    cssinfo.style.gridGap="20px";
			    cssinfo.style.gridTemplateRows= "0px 40px 430px 0px";		    
			    
			    
			    
		})
		
		
		function Changecss(){		
			 var cssinfo=document.getElementById("ui-datepicker-div")
			    cssinfo.style.display ="grid"
			    cssinfo.style.height=" 480px";
			    cssinfo.style.left="0px";
				cssinfo.style.position="relative";
			    cssinfo.style.maxWidth="1020px";
			    cssinfo.style.margin="0 auto";
			     cssinfo.style.top=" -730px";
			    cssinfo.style.width= "80%";
			    cssinfo.style.gridGap="20px";
			    cssinfo.style.gridTemplateRows= "0px 40px 430px 0px";
			    
			  
			    
		}
		
		
	});
	
	
	
	
	
</script>
<body>
<div class="allwarpper">
     <div id="wrappers"> 
<div id="wrapper">




	<div id="content1">
		<div id="section1"></div>

<!-- 딱히 예약 페이지 에선 네브바를 주지 말자.  -->
<%-- <%@ include file="/mobileNave.jsp"%> --%>

		<h3 id="header1">원데이클래스 예약하기</h3>
		<!-- 	<p>
				공란 <img src="미구현예약하러가기링크" width="20px" height="20px"
					alt="planet_icon">
			</p> -->
		<
	</div>

	<div id="content2" class="clearfix">

		<!---Section2_2 시작 --->
		<div id="Section2_2">
			<c:forEach items="${firstonedayclass}" var="first">
				<!-- 2번째 체험상품사진 -->
				<img class="reserve_img" src="${first.reserve_img}" />

				<article class="sameinfo">
					<h2 class="onedayclass_name">${first.onedayclass_name}</h2>
					<p class="onedayclass_info">${first.onedayclass_info}</p>
					<input type="hidden" class="onedayclass_num"
						value="${first.onedayclass_num}">
			</c:forEach>
			</article>
		</div>
		<!-- Section2_2 종료 -->

		<!-- Section2_3 시작 -->
		<div id="Section2_3">


			<div class="infowraper">
				<div id="iconrow" class="row ">
					<div class="detail">
						<img id="infoicon1" class="infoicon"
							src="./img_infoicon/check.png" /> <span>서울시</span>
					</div>

					<div class="detail">
						<img class="infoicon" src='./img_infoicon/time.png' /> <span>이용시간
							2시간</span>
					</div>


					<div class="detail">
						<img class="infoicon" src='./img_infoicon/warnning.png'> <span>주차불가</span>
					</div>

					<div class="detail">
						<img class="infoicon" src='./img_infoicon/headcount.png'> <span>최대이용인원
							4명</span>
					</div>




					<!-- <form action="insertreserve.do"> -->

						<input type="hidden" id="check" name="check"><br>
						<!-- user_code 로 다 작동하면 userId는 지워라. -->
						<input type="hidden" id="id" name="id" value="${userId}"><br>
						<input type="hidden" id="user_code" " name="user_code"
							value="${user_code}"><br>


						<!-- 날짜선택:<input type="text"   id="reserve"  class="reserve_day" name="reserve_day"><br> -->
<div class="dayandrest">
						<div>
							날짜선택:<input type="text" id="openday" class="reserve_day" name="openday">
							
						</div>
						
						<div class="restcountarea">
						<button type="text" class="restcount"></button>
						</div>
</div>

						 참여비용:<input type="text" id="onedayclass_price" name="onedayclass_price" value="3000">
						 과목:<select id="onedayclass_name" name="onedayclass_name">
							<option value="취미만화반">취미만화반</option>
							<option value="취미실사반">취미실사반</option>
							<option value="취미풍경화반">취미풍경화반</option>
						</select>



			<!-- 		</form> -->

				</div>






			</div>





		</div>
		<!-- Section2_3 종료 -->

	</div>
	<!-- content 종료 -->





	<div class="sinchung">
		<!-- <h3 class="reservebtn" >신청하기</h3> -->
		<h3 class="reservebtn2">신청하기</h3>

		<h3 class="attributebtn">버튼 속성값 가져오기 테스트</h3>

		<script>
$(".attributebtn").click((e)=>{
	
$(".reserve_img").attr("src");
$(".onedayclass_name").text();
$(".onedayclass_info").text();
console.log($(".reserve_img").attr("src"))
console.log($(".onedayclass_name").text())
console.log($(".onedayclass_info").text())
/* 
<h2 class="onedayclass_name">${first.onedayclass_name}</h2>
<p class="onedayclass_info">${first.onedayclass_info}</p>
	 */
	
})


</script>

	</div>
</div>
</div>
<!-- wrapper -->
<!-- Footer -->

</div>
</body>
</html>