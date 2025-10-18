<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
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


<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<style>
ul {
	padding: 0 0;
	margin: 0 0;
}

li {
	list-style: none;
}

.menunave {
	margin-right: auto;
	margin-left: auto;
	max-width: 1050px;
	color: white;
	background: #1a73e8;
	font-size: 16px;
	font-weight: 500;
	background-color: #000;
}

.nave {
	display: flex;
	justify-content: space-between;
	margin-right: auto;
	margin-left: auto;
	max-width: 1050px;
	color: black;
	/*   background: #1a73e8; */
	font-size: 13px;
	font-weight: 600;
}

.homeicon {
	background-image: url('./img_icon/homeicon.png');
	background-position: center;
	background-repeat: no-repeat;
	background-attachment: scroll;
	background-size: cover;
	width: 40px;
	height: 39.5px;
}
.wrapper {
	margin-right: auto;
	margin-left: auto;
	max-width: 1050px;
	color: black;
	/*   background: #1a73e8; */
	font-size: 13px;
	font-weight: 600;
}

.nave ul {
	display: flex;
	flex-direction: row;
	justify-content: end;
}

.menunave .menulist {
	overflow: hidden;
	text-overflow: ellipsis;
	justify-content: space-between;
	display: flex;
	flex-direction: row;
}

.nave li {
	padding: 10px 10px;
}

.menunave .menulistcontent {
	height: 100%;
	background-color: #f4f4f4;
	color: #000;
	padding: 20px 20px;
	color: #000;
}

.myalarm {
	text-align: right;
}

.writecontent {
	max-width: 860px;
}

.gasipan {
	padding: 10px;
}

.board {
	padding: 15px;
	background: #f3f3f3;
	border: 1px solid #ddd;
	border-radius: 10px;
}

.writingcontainer {
	height: 600px;
	margin: 10px 0px;
}

textarea {
	width: 100%;
	height: 80%;
	padding: 10px;
	box-sizing: border-box;
	/* border: solid 2px #1E90FF; */
	border-radius: 5px;
	font-size: 16px;
	resize: both;
}

.register {
	text-align: right;
}

.register button {
	background-color: #383F96;
	color: white;
	padding: 0px 15px;
	border: 1px solid #383F96;
}

.tdtitle div {
	width: 50%;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	font-size: 17px;
	line-height: 18px;
}

.tdregdate {
	width: 100%;
	text-align: right;
}

.tdtitleAndtdregdate {
	display: none;
}

@media
screen
and
(max-width:
701px)
{
.tdtitleAndtdregdate {
	display: block;
	display: flex;
	justify-content: space-between;
}

.tdregdate, .tdtitle {
	display: none;
}

table {
	width: 100%;
}

.writecontent {
	max-width: 340px;
	min-width: 340px;
}

.writingcontainer {
	height: 350px;
}

.menunave {
	max-width: 450px;
}

.menulistcontent {
	white-space: nowrap;
	max-height: 64px;
	padding: 10px !important;
}

.rwd-table {
	max-width: 450px;
}

.nav {
	max-width: 450px;
}

#title div {
	
}

#coloumnname, #seq, #cnt {
	display: none;
}

th, td {
	widh: 100%;
	display: block;
	border-bottom: none;
	text-align: left;
}

#writerandregdate {
	font-size: 8px;
	display: block;
}

#regdate {
	display: none;
}

th:nth-child(1), td:nth-child(1), th:nth-child(2), td:nth-child(2), th:nth-child(3),
	td:nth-child(3), th:nth-child(4), td:nth-child(4), th:nth-child(5), td:nth-child(5)
	{
	width: 100%;
}

tr {
	display: block;
	padding-top: 24px;
	padding-bottom: 14px;
	border-bottom: 1px solid #d6d8e1;
}

} /* 메디아 쿼리 종료 */
body {
	/* background: #4B79A1;
background: -webkit-linear-gradient(to left, #4B79A1 , #283E51);
background: linear-gradient(to left, #4B79A1 , #283E51);    */
	
}

h1 {
	text-align: center;
	font-size: 2.4em;
	color: #f2f2f2;
}

.container {
	display: block;
	text-align: center;
}

h3 {
	display: inline-block;
	position: relative;
	text-align: center;
	font-size: 1.5em;
	color: #cecece;
}

h3:before {
	content: "\25C0";
	position: absolute;
	left: -50px;
	-webkit-animation: leftRight 2s linear infinite;
	animation: leftRight 2s linear infinite;
}

h3:after {
	content: "\25b6";
	position: absolute;
	right: -50px;
	-webkit-animation: leftRight 2s linear infinite reverse;
	animation: leftRight 2s linear infinite reverse;
}

/*게시판 테이블 디자인 종료  */
</style>
<script>	
var startpage;

var nextpage;
var backpage;

var startbtn;
var endbtn;		
var seq;	

	
	window.onload=()=>{		
		seq=window.location.search.split("=")[1];
		console.log(window.location.search.split("=")[1])	
	 	$.ajax({
	 		
			url:"getOneViewBoard.do",
			data:{"seq":seq},
		success:(data)=>{			
			console.log(data)
			$(".tdtitle div").text(data.title)
			$(".tdregdate").text(data.regdate)
			$(".tdtitleAndtdregdate #tdregdate").text(data.regdate)
			$(".tdtitleAndtdregdate #tdtitle").text(data.title)
			
		
			
			$("#textarea").val(data.content);
			
		}
			
		})
		 
		
		
		let menulistcontent=$("div[class='menulistcontent']");
	 	for(let k=1; k<menulistcontent.length; k++){			
			$(menulistcontent[k]).css({"background-color":"#000", "color":"rgba(255, 255, 255, .5)"})		
		} 		
		/* 게씨발 하위 a 링크때문에 이벤트 전파가 되어 이상하게 적용된줄알음 이벤트 전파 막자...  */
		$("div[class='menulistcontent']").on("click",(e)=>{
			
			
			for(let k=0; k<menulistcontent.length; k++){
				
				if($(e.target).text()==$(menulistcontent[k]).text()){
					$(menulistcontent[k]).css({"background-color":"#f4f4f4", "color":"#000"   })	
					
				}else{
			  
					$(menulistcontent[k]).css({"background-color":"rgb(0, 0, 0)", "color":"rgba(255, 255, 255, 0.5)"})	
				}
				
				
				
				
				/* console.log(e.target);
				console.log(menulistcontent[k]); */
			}	
			
			
		})	
		
		smartphone();		
			
	}//윈도우 온로드 종료	

function smartphone(){
		
	document.getElementById("menulist").addEventListener("touchstart", successtouchmove, false);
		
	}	
	
	function successtouchmove(smartEvent){
		console.log(smartEvent.target)
	}
	
	
	
</script>
</head>
<body>


	<div class="nave">
	<a href="mainhome.jsp">
		<div class="homeicon" >			
		</div>
		</a>
		<div>
		<ul>
			<c:choose>
				<c:when test="${userId ne null || user_where=='finalluser'}">
					<li><c:if test="${user_where=='finalluser'}">
							<a href="myinfo.jsp">정보수정</a>
						</c:if></li>
					<li><a href="cartlist.do?id=${userId}">장바구니</a></li>
					<li><a href="myreserveinfo.do?user_code=${user_code}">나의예약현황</a></li>
					<li><a href="logout.do">로그아웃</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="login.jsp">로그인</a></li>
					<li><a href="phonesms.jsp">가입</a></li>
				</c:otherwise>

			</c:choose>

		</ul>
		</div>
	</div>

	<div class="menunave">
		<div id="menulist" class="menulist">
			<div class="menulistcontent">
				<a href="firstgetboad.do?startpage=0">자유로운게시판</a>
			</div>
			<div class="menulistcontent">
				<a>원데이클래스</a>
			</div>
			<div class="menulistcontent">
				<a>미술용품</a>
			</div>
			<div class="menulistcontent">
				<a>회원작품목록</a>
			</div>

		</div>
	</div>

	<div class="wrapper">

		<div class="myalarm">
			<div class="alarm1">알림</div>
			<div class="alarm2">접기</div>
		</div>


		<div class="writecontent">

			<div class="gasipan">
				<h3>자유로운게시판</h3>
			</div>
			<div class="board">

				<%-- INSERT INTO BOARD (TITLE,WRITER,CONTENT,filename)
		VALUES
		(#{title},#{writer},#{content},#{filename}) --%>
				<form action="inserttextboard.do">
					<input type="hidden" name="writer" value="${userId}">
					<table class="tabtabl">
						<tbody>
							<tr>

								<td class="tdtitleAndtdregdate">
									<div id="tdtitle"></div>
									<div id="tdregdate"></div>
								</td>

								<td class="tdtitle">
									<div></div>
								</td>
								<td class="tdregdate">
									<div></div>
								</td>
							</tr>
						</tbody>
					</table>

					<div class="editor">

						<div class="writingeditor">
							<div class="writingcontent">
								<!--class="writingtool" 나중에 라이브러리 찾아서 게시판 글꼴 중앙정렬 추가해봐라.. 팸코사이트로  -->
								<!-- 	<div class="writingtool">					
					</div> -->
								<div class="writingcontainer">
									<textarea type="text" name="content" id="textarea"></textarea>

								</div>


							</div>

						</div>

					</div>
					<!-- 	<div class="register">
						<button >등록</button>
					</div> -->
				</form>



				<p>욕설 등 게시글은 경고없이 삭제됩니다.</p>
				<p>논란성이 있는 글은 자제부탁드립니다.</p>
			</div>

		</div>


	</div>


</body>
</html>