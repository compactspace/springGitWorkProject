<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>index페이지</title>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
	integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
	crossorigin="anonymous">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
	integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
	crossorigin="anonymous"></script>
<!-- <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin> -->
<!-- <link
	href="https://fonts.googleapis.com/css2?family=Orbit&family=Sunflower:wght@300&display=swap"
	rel="stylesheet"> -->

<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<!-- Latest compiled and minified CSS -->


<!-- jQuery library -->


<!-- jQuery JS -->
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script> -->







<style>
p {
	background-color: rgb(119, 193, 61) font-family: 'Sunflower', sans-serif;
}

#carousel {
	height: 220px;
	vertical-align: middle;
	border-bottom: 1px solid black;
	background-image: url(./img_icon/gasipan.jpg);
	margin-right: auto;
	margin-left: auto;
	width: 90%;
}

* {
	margin: 0;
	padding: 0;
}

body {
	margin: 0 0 0 0px;
}

/* 배치도 생각으로 전체 wrapper 감싼후 마진 오토 */
#wrapper1 {
	max-width: 1020px;
	margin: 0 auto;
	padding: 0px;
}

#wrapper2 {
	max-width: 980px;
	margin: 0 auto;
	padding: 0px;
}

header {
	position: relative;
	height: 70px;
	background: #fff;
	margin: 0;
}

li#gasipanli:after {
	content: "";
	display: block;
	width: 100%;
	border-bottom: 2px solid #bcbcbc;
}

h2 {
	font-weight: 500;
	color: #797979;
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

.menue_ul {
	margin-right: auto;
	margin-left: auto;
	width: 25%;
	display: flex;
	list-style-type: none;
	justify-content: space-around;
}

.menue_li {
	display: inline-block;
	width: 20%;
	text-align: center;
	color: #333333;
	letter-spacing: .01em;
	font-style: normal;
	font-weight: 400px;
}

a {
	text-decoration: none;
	color: #333333;
}

.article1 {
	background: #fff;
	height: 100%;
	margin: 0 auto;
	padding: 40px 0 40px;
}

#header1 {
	width: 100%;
	float: left;
	margin: 0px 0px 30px 50px;
	color: #333333;
}

p {
	display: block;
	width: 80%;
	margin: 0px 0px 0px 50px;
	font-weight: 300;
}

/* Section 2 */
img {
	display: block;
}

#content2 {
	margin: 20px auto;
}

.sameinfo {
	background: #fff;
	height: 100%;
	margin: 0px auto 0;
	padding: 20px 0 40px;
}

#Section2_2 {
	float: left;
	margin: 0;
	width: 500px;
	overflow: hidden;
}

#info2 {
	width: 90%;
	float: left;
	margin: 0px 0px 30px 50px;
	color: #333333;
}

#Section2_3 {
	float: right;
	margin: 0;
	width: 500px;
	overflow: hidden;
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

/* 미구현 footer영역 */
footer {
	text-align: center;
	display: block;
	height: 40px;
	background: #424141;
	margin: 20px 0 0 0;
}

table {
	border-collapse: collapse;
	border-top: 2px solid black;
	width: 100%;
	height: 400px;
}

tr {
	border-bottom: 1px solid #707070;
	height: 35px;
}

.th1 {
	text-align: left
}

.th2 {
	width: 700px;
}

.th2 .th3 .th4 .th5 {
	text-align: center
}

.title {
	text-align: left;
	height: 35px;
}

.seq, .writer, .regdate, .cnt {
	text-align: center;
}

.table {
	display: table;
	width: 100%;
}

.table-row-group {
	display: table-row-group;
}

.table-row {
	display: table-row;
	height: 40px;
}

.table-cell {
	display: table-cell;
	border-bottom: 1px solid #000;
	text-align: center;
	vertical-align: middle;
}

.thead {
	display: table-header-group;
	vertical-align: middle;
	border-color: inherit;
}

.tbody {
	display: table-row-group;
	vertical-align: middle;
	border-color: inherit;
}

.content {
	font-weight: bold;
}

/*  #modalContainer{
display:none
}  */
#modalContent {
	display: none
}

#modalContent {
	
}

#textcontent {
	
}

#textcontent {
	height: 400px;
}

h1 {
	color: #797979;
}

.imgs {
	position: absolute;
	right: 0px;
	top: 25px;
	height: 200px;
	width: 200px;
}

.alldivwrapper {
	width: 1200px;
	position: relative;
}

.imgdiv {
	padding-top: 150px;
}

#loginformwrapper {
	background-color: white;
	height: 1300px;
	width: 1200px;
	border: 1px solid #ddd;
}

.loginform {
	height: 900px;
}

.container {
	display: flex;
	flex-direction: column;
}

/* .passwordinput, .idinput {
	background-color: rgb(232, 240, 254);
	border: none;
	border-bottom: 1px solid #bdbdbd;
	width: 100%;
	height: 50px;
} */

/* 게시판을 위한 인풋 보더 논처리 
지금 인풋을 감싸는 디브를 줄여야 , 길이 처리가 되어
먼저 인풋 위드스를 줄이며 하자.
 */
input {
	border: none;
}
/*게시번호  */
input.samesseq {
	width: 20px;
}

same.table-cell.content.seq {
	width: 80px;
}
/*게시번호 종료 */
.same.table-cell.title {
	text-align: left;
}

/*글쓴이 영역  */
input.samesuniquewriter {
	width: 50px;
	color: #797979;
	letter-spacing: .01em;
	font-style: normal;
	font-weight: 300;
}

.same.table-cell.writer {
	width: 80px;
}
/*글쓴이 영역 종료  */

/*등록일 영역  */
input.samesregdate {
	width: 50px;
	color: #797979;
	letter-spacing: .01em;
	font-style: normal;
	font-weight: 300;
}

.same.table-cell.regdate {
	width: 80px;
}
/*등록일 영역 종료 */

/*조회수  */
input.samescnt {
	width: 30px;
	color: #797979;
	letter-spacing: .01em;
	font-style: normal;
	font-weight: 300;
}

.same.table-cell.cnt {
	width: 80px;
}
/*조회수 종료  */
h3 {
	color: #797979;
}

.iddiv, .passworddiv {
	margin-left: auto;
	margin-right: auto;
	width: 100%;
}

textarea {
	width: 100%;
	height: 40px;
	resize: none;
}

.passworddiv {
	text-align: center;
}

.logindiv, .membershipdiv {
	padding-top: 10px;
	padding-bottom: 10px;
	margin-left: auto;
	margin-right: auto;
	width: 95%;
	height: 40px;
	border: none;
	background-color: #1a70dc;
	color: aliceblue;
	line-height: 35px;
}

.loginbtn {
	padding-top: 10px;
	padding-bottom: 50px;
	margin-left: auto;
	margin-right: auto;
	width: 95%;
	height: 40px;
	border: none;
	background-color: #1a70dc;
	color: aliceblue;
	line-height: 35px;
}

.login_membershipdivwrapper {
	text-align: center;
}

#examplecontainer {
	
}

#noimgitems {
	width: 350px;
	float: left;
	margin-right: 160px;
	margin-left: 140px;
}

#yesimgitems {
	width: 350px;
	float: left;
}

.yesorno {
	width: 400px;
	height: 600px;
}

/*여기서부턴 게시판 꾸미는  */
div>input {
	border: noen;
}

.myimgwrapper {
	display: inline-block;
	margin-left: auto;
}

.myimgwrapper>button {
	border: 1px solid #797979;
	background-color: transparent;
}

.btnallwrapper {
	display: flex;
	justify-content: center;
}

.myimg {
	padding: 10px;
}

#navbarSupportedContent {
	width: 100%;
	justify-content: center;
}

.getBoardwrapper {
	display: inline-block;
}

.getBoard {
	/* border: 1px solid #797979;
	background-color: transparent;
	padding: 10px; */
	
}

.getBoardwrapper {
	text-align: center;
}

.getBoardwrapper>button {
	border: none;
	background-color: transparent;
	color: #888 !important;
}

.backbtn {
	color: white;
	font-weight: 600;
	background-color: #ff5862;
	border-radius: 9px;
}

.nextbtn {
	color: white;
	font-weight: 600;
	background-color: #ff5862;
	border-radius: 9px;
}

strong {
	font-weight: 400;
	font-size: 1.2em;
}
</style>
<script>

	window.onload = function() {
		
		var mql = window.matchMedia("screen and (max-width: 400px)" );
		mql.addListener(function(e){
			if(e.matches){
			console.log("400px이하 매칭 참");
				 $( '.table-row div:nth-child(5)').hide();
				
			}else{
				console.log("400px초과 매칭 참");	
				$( '.table-row div:nth-child(5)').show();
			}
		})
	
		
		
		
		
		
  $("#qnali").on("click",function(){
	 location.href="qna.jsp";	
	  
  });
	
		
$("button[class=getBoard]").hover(function(){
	$(this).css({"background-color":"black","color":"white"})
	
	
})	
		
$("button[class=getBoard]").mouseout(function(){
	$(this).css({"background-color":"transparent","color":"black"})

	
})			
		
		
		 
		$("button[class=getBoard]").on('click', function() {	
			let page = parseInt($(this).text());			
			$.ajax({
				url : "onepagegetboad.do",
				data : { "page" : $(this).text() },
				type : "POST", //type=우리가보내는 타입
				success : function(val) {
					console.log(val);
// 					$("div#faDiv").empty();
					
					let str = '';
					$.each(val, function(index, obj){
						str += '<div val="${i.index}" class="table-row x" data-val="'+obj.writer+'">';
			 			str += '<div class="same table-cell content seq"><input data-val="choice" class="samesseq" value="'+obj.seq+'"></div>';
			 			str += '<div class="same table-cell title"><input data-val="choice" class="samestitle" value="'+obj.title+'"></div>';
			 			str += '<div class="same table-cell writer"><input data-val="choice" class="samesuniquewriter" value="'+obj.writer+'"></div>';
			 			str += '<div class="same table-cell regdate"><input data-val="choice" class="samesregdate" value="'+obj.regdate+'"></div>';
			 			str += '<div class="same table-cell cnt"><input data-val="choice" class="samescnt" value="'+obj.cnt+'"></div>';
			 			str += '</div>';
					});

		 			$("div#faDiv").html(str);				
				},
				error : function(request, status) {
					alert("목록 가져오기를 할 수 없습니다.");
				}
			});

		

		})
		
			$(".nextbtn").on('click' ,function() {			
		
				let page = parseInt($(this).prev().text());
	
				console.log("next버튼클릭->>"+page);
				
				if(page%10==0){
					location.href="getboadnext.do?page="+page					
				} 
		}) 
		
		
				$(".backbtn").on('click', function() {							
				let page = parseInt($(this).next().text());
				
				if(page==1){
					alert("처음페이지 입니다.");
				} else{
					location.href="getboadbacklist.do?page="+page
				}
				
				console.log("back버튼클릭->>"+page);
				}) 
		
		
		
		
		
		
		$(".myimg").click(function(){
			$("#modalContainer.hidden").css({"display":"block"})
			$("#modalContent").css({"display":"block"})
		$("#modalContainer.hidden").css({
			"position":"absolute" ,"top":"50%",
		　"left":"50%",
		　"transform": "translate(-50%,-50%)",
		　"background-color":"white",
		 "z-index": "100",
		 "width":"1200px",
		"height": "600px"
		})
			
		})
		
		$(".cancelimginsert").click(function(){
		console.log("dd");
		$("modalContent").css({"display":"none"})
		$("#modalContainer.hidden").css({"display":"none"})
		})
		
		
	/* 	$("input[data-val=choice]").click(function(){
		
			console.log("디스값은->>"+$(this).val());
			
		}) */	
	
		//제이쿼리 라이브이벤트
		//자바스크립트로 생성한 태그는 이벤트 상속을 못받는다! 그래서 라이브 이벤트 방식으로 작성해야한다.
		/*형식 : 
			$("지정자보다 높은 부모 또는 조상 요소나 셀렉터").on("이벤트함수 종류", "지정자", function(){
				소스코드 기술;
			} );
		*/
			
		$("#faDiv").on("click","input[data-val=choice]",function(){
			console.log("번호와 글쓴이 일치?-??"+$(this).val())
			console.log("번호와 글쓴이 일치?-??"+$(this).parent().parent().children().children().val())
			console.log("번호와 글쓴이 일치?-??"+$(this).parent().parent().children().next().next().children().val())
			let seq=$(this).parent().parent().children().children().val();
			let writer=$(this).parent().parent().children().next().next().children().val();
			let cnt=$(this).parent().parent().children().next().next().next().next().children().val();
	console.log("seq->>"+seq+','+"writer"+writer+","+"cnt"+cnt);
			
			
		     location.href="showboard.do?writer="+writer+"&seq="+seq+"&cnt="+cnt
			}); 
			
		
	}		
		
		
		

</script>






</head>
<body>
	<%-- 	페이지 값 :${page} 넥스트 값 :${next}
	<c:if test="${page ne null}">
		<div class="myimgwrapper">
			<h1>내가 누른 버튼이 10의 배수이면 다음이 출력되야함</h1>
			<h1>"${next}"</h1>
		</div>
	</c:if> --%>

	<div id="wrapper1">

		<header>
			<nav>
				<ul>
					<li><a href="onedayclass.jsp">원데이클래스</a></li>
					<li><a href="getworklist.do">참여자분들의 작품</a></li>

					<li><a href="firstgetboad.do?page=0">여러분의게시판</a></li>
					<c:choose>
						<c:when test="${userId ne null && user_where=='finalluser'}">

							<li>${userId}님<a href="myinfo.jsp"> 정보수정</li>
							<li><a href="cartlist.do?id=${userId}">장바구니</a></li>
							<li><a href="logout.do">로그아웃</a></li>
						</c:when>
						<c:when test="${user_where ne'finalluser' && userId ne null }">

							<li><a href="cartlist.do?id=${userId}">장바구니</a></li>
							<li><a href="logout.do">로그아웃</a></li>
						</c:when>

						<c:otherwise>


							<li><a href="login.jsp">로그인</a></li>
						</c:otherwise>
					</c:choose>
					<li><a href="productlist.do">팬시상품</a></li>
				</ul>
			</nav>
			<!-- nav -->
		</header>
	</div>

	<!-- header -->
	<br>
	<div id="carousel">
		<!-- <img id="gasipanimg" src="./img_icon/gasipan.jpg"> -->
	</div>

	<br>
	<br>

	<div id="wrapper2">
		<h2 style="text-align: center;">여러분의 게시판입니다.</h2>
		<br> <br>
		<!-- <ul class="menue_ul">
			<li id="gasipanli" class="menue_li">게시판</li>
			<li id="qnali" class="menue_li">Q&A</li>
			<li class="menue_li">NOTICE</li>
		</ul> -->
		<div
			class="menuewrapper navbar navbar-expand-lg navbar-light bg-light menuewrapper">
			<div class="menuediv container">
				<button class="navbar-toggler" type="button" data-toggle="collapse"
					data-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<div class="menueuldive col-md-3">
						<ul class="menueul navbar-nav mr-auto">
							<li id="gasipanli" class="nav-item active">게시판</li>
							<li id="qnali" class="nav-item active">Q&A</li>
							<li class="nav-item active">NOTICE</li>
						</ul>
					</div>
				</div>
			</div>
		</div>

		<div class="table">
			<div class="thead">
				<div class="table-row">
					<div class="table-cell content">no</div>
					<div class="table-cell ">제목</div>
					<div class="table-cell">글쓴이</div>
					<div class="table-cell">등록일</div>
					<div class="table-cell">조회수</div>
				</div>
			</div>

			<div id="faDiv" class="tbody">
				<c:choose>
					<c:when test="${boardlist ne null}">

						<c:forEach items="${boardlist}" var="board" varStatus="i">
							<div val="${i.index}" class="table-row x"
								data-val='${board.writer}'>
								<div class="same table-cell content seq">
									<input data-val="choice" class="samesseq" value="${board.seq}">
								</div>
								<div class="same table-cell title">
									<input data-val="choice" class="samestitle"
										value="${board.title}">
								</div>
								<div class="same table-cell writer">
									<input data-val="choice" class="samesuniquewriter"
										value="${board.writer}">
								</div>
								<div class="same table-cell regdate">
									<input data-val="choice" class="samesregdate"
										value="${board.regdate}">
								</div>
								<div class="same table-cell cnt">
									<input data-val="choice" class="samescnt" value="${board.cnt}">
								</div>
							</div>
						</c:forEach>




					</c:when>
					<c:otherwise>

						<c:forEach items="${firstboardlist}" var="board" varStatus="i">
							<div val="${i.index}" class="table-row x"
								data-val='${board.writer}'>
								<div class="same table-cell content seq">
									<input data-val="choice" class="samesseq" value="${board.seq}">
								</div>
								<div class="same table-cell title">
									<input data-val="choice" class="samestitle"
										value="${board.title}">
								</div>
								<div class="same table-cell writer">
									<input data-val="choice" class="samesuniquewriter"
										value="${board.writer}">
								</div>
								<div class="same table-cell regdate">
									<input data-val="choice" class="samesregdate"
										value="${board.regdate}">
								</div>
								<div class="same table-cell cnt">
									<input data-val="choice" class="samescnt" value="${board.cnt}">
								</div>
							</div>
						</c:forEach>



					</c:otherwise>

				</c:choose>

			</div>


		</div>
		<hr>
		<div class="btnallwrapper">
			<div class="getBoardwrapper">


				<c:if test="${userId ne null}">
					<div class="myimgwrapper">
						<!-- 	<button class="myimg" type="button">게시물 작성하기</button> -->
					</div>
				</c:if>
			</div>

			<!-- 아작스아닌 그냥 버튼 -->

			<div class="btnallwrapper">
				<div class="getBoardwrapper">
					<span class="backbtn"><Strong>back</Strong></span>
					<c:choose>
						<c:when test="${page >10}">
							<c:forEach var="i" begin="${page}" end="${next}" step="1"
								varStatus="status">
								<button class="getBoard">
									<strong>${status.index}</strong>
								</button>

							</c:forEach>

						</c:when>
						<c:otherwise>

							<c:forEach var="i" begin="${page}" end="${next}" step="1"
								varStatus="status">
								<button class="getBoard">
									<strong>${status.index}</strong>
								</button>

							</c:forEach>

						</c:otherwise>
					</c:choose>

					<span class="nextbtn"><Strong>next</Strong></span>


				</div>

			</div>

			<!--  아작스 아닌 그냥버튼 종료-->
		</div>


		<!-- button forEach문으로  어떻게??-->





		<div id="modalContainer" class="hidden">
			<div id="modalContent">
				<div class="alldivwrapper">
					<div class="imgdiv">
						<h1>
							게시물작성
							<!-- <img class="imgs" src="img_membership/membership.png"> -->
						</h1>

					</div>
					<div id="loginformwrapper">

						<form action="/insertboard.do" method="post"
							enctype="multipart/form-data">
							<div class="iddiv">
								<h2>제목</h2>
								<textarea name="title" cols="30" row="5"
									palceholder="150글자 까지만등록가능합니다."></textarea>
								<input type="hidden" name="writer" value="${userId}">
								<!-- <h3>그림을등록해주세요</h3>
							value="${userVO.id}" 를 지워봄 
							<input type="file" name="worklist_img_upload" required> -->
							</div>
							<div class="passworddiv">
								<h3 style="text-align: left">내용</h3>
								<hr>
								<!--value="${userVO.password}" 를 지워봄  -->
								<textarea id='textcontent' name="content" cols="30" row="5"
									palceholder="150글자 까지만등록가능합니다."></textarea>
								<hr>
								<h3>그림을등록해주세요</h3>
								<!--value="${userVO.id}" 를 지워봄  -->
								<input type="file" name="worklist_img_upload" required>
							</div>
							<br> <br>
							<div class="login_membershipdivwrapper">
								<!-- 조심해라! form태그 안에 버튼 태그 타입의 디폴트값은 submit으로  현재 로그인 버튼은 서브밋이다. -->
								<h3 style="text-algin: center">주의사항</h3>
								<hr>
								<p>
									여러분의 작품들은 다양한 연령층이 올리고 공유하는 곳이기에 신체노출과 같은 수위가 높은 사진은 관리자에의해
									삭제될수있습니다.<br> 다음은 예시입니다.
								</p>

								<div id="examplecontainer">
									<div id="noimgitems">
										<img class="yesorno" src="./yseornoimg/noimg.png">
										<h3>나쁜예시</h3>
										<p>상반신 기준 쇄골밑 부분은 모자이크 처리를 하여도 관리자에의해 삭제됩니다</p>
									</div>
									<div id="yesimgitems">
										<img class="yesorno" src="./yseornoimg/yesimg.png">
										<h3>옳바른예시</h3>
										<p>상반신 기준 쇄골밑 부분은 삭제 처리를하면 가능합니다.</p>
									</div>
								</div>

								<button class="loginbtn">게시물등록하기</button>
								<br> <br>
								<button type="button" class="loginbtn cancelimginsert">게시물등록취소</button>
								<br> <br>

							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
</body>
</html>