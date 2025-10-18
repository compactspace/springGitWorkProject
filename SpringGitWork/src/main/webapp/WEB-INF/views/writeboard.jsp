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
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
<style>


a {
	color: black !important;
	text-decoration: none !important;
}

a:visited {
	text-decoration: none;
}

.mobileheader {
	display: none;
}

ul {
	padding: 0 0;
	margin: 0 0;
}

li {
	list-style: none;
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

@media screen and (max-width: 701px) {
	.mobileheader {
		display: block;
	}
	#navebarwrapper {
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

	/* 버튼 에어리어는 테이블 컬럼이나 길이 수정시마다 같이 수정해줘야함. 따로국밥 div임 */
	.buttonarea {
		padding: 10px 0;
		width: 300px;
	}
	.serchvalue {
		width: 160px;
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

/* 테이블 태그의 위드스는 각 td 값으로 알아서 조정되니
테이블 컬럼 태그가 늘어나면 그만큼 아래 buttonarea의 위드스도 늘리고 줄이고 하라..
 */
.buttonarea {
	max-width: 450px;
	margin: auto;
	/*민 이상!! 민은 이상 민은 이상 min 은 이상!!!  */
	min-width: 330px;
	border-collapse: collapse;
}

.buttoncontent {
	display: flex;
	flex-direction: column;
}

.contentline1 {
	display: flex;
	justify-content: center;
}

}
.contentline2 {
	display: flex;
	justify-content: space-between;
}

.searcharea form {
	display: inline-block;
}

.backpagebtn, .eachbtn, .nextpagebtn {
	border: none;
	background: none;
}

/*게시판 테이블 디자인 종료  */
</style>
<script>	
var startpage;

var nextpage;
var backpage;

var startbtn;
var endbtn;		
	
	
	
	
	window.onload=()=>{		
		
		
		
		
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
		
		//개별 버튼 페이지 게시글
		// select * from board limit  버튼태그 벨류, 10
		// 한편 유지되어야 할 값들은 nextpage backpage 이다.
		$("button[class=eachbtn]").on("click",(e)=>{
			let startpage=$(e.target).val();
			let isserch="${boardlist.get(0).isserch}";
			let keyword="${boardlist.get(0).keyword}";
			let serchvalue="${boardlist.get(0).serchvalue}";

			
			console.log("버튼 값은 ->"+startpage);
			 totalrow="${boardlist.get(0).totalrow}"
				 backpage="${boardlist.get(0).backpage}"

					//el로 불린 값을 사입하면 문자열로 들어가서 ㅂㄷㅂㄷ 그냥 태그 벨류에 심은다음 가져오자..
						flagendpage=JSON.parse("${boardlist.get(0).flagendpage}");
						console.log(flagendpage)
				 
				 
			window.location.href
			="eachbtn.do?startpage="+startpage
			+"&isserch="+isserch
			+"&keyword="+keyword
			+"&serchvalue="+serchvalue
			+"&backpage="+backpage
			+"&totalrow="+totalrow
			+"&flagendpage="+flagendpage
			+"&nextpage=${boardlist.get(0).nextpage}&backpage=${boardlist.get(0).backpage}&startbtn=${boardlist.get(0).startbtn}&endbtn=${boardlist.get(0).endbtn}";
			})
			
		// 다음페이지란	select * from board limit  버튼태그 벨류*5, 10
		$(".nextpagebtn").on("click",(e)=>{
			
			
			
			//ㅂㄷㅂㄷ 그냥 태그 벨류에 심은게 문자열 투르 펠스 로 변형을 아래처럼 해야한다고한다...
			flagendpage=JSON.parse($(e.target).val());
			console.log(flagendpage)
			
			let isserch="${boardlist.get(0).isserch}";
			let keyword="${boardlist.get(0).keyword}";
			let serchvalue="${boardlist.get(0).serchvalue}";
			
			 startpage="${boardlist.get(0).startpage}";

			 nextpage="${boardlist.get(0).nextpage}";
			 
			 backpage="${boardlist.get(0).backpage}";

			 startbtn="${boardlist.get(0).startbtn}";
			 
			 endbtn="${boardlist.get(0).endbtn}";
			 
			 totalrow="${boardlist.get(0).totalrow}"
			 
			 
		 if(flagendpage){				 
				alert("마지막페이지 입니다.");
			 }
		  else{
				 window.location.href
				 ="nextpageboard.do?startpage="+startpage+
						 "&keyword="+keyword+
						 "&serchvalue="+serchvalue+
						 "&nextpage="+nextpage+"&backpage="+backpage+"&startbtn="+startbtn+"&endbtn="+endbtn+"&totalrow="+totalrow+"&isserch="+isserch;
			 }	 
			
		})
		
		$(".backpagebtn").on("click",(e)=>{
			
			let isserch="${boardlist.get(0).isserch}";
			
			let keyword="${boardlist.get(0).keyword}";
			
			let serchvalue="${boardlist.get(0).serchvalue}";
			
			 startpage="${boardlist.get(0).startpage}";

			 nextpage="${boardlist.get(0).nextpage}";
			 
			 backpage="${boardlist.get(0).backpage}";

			 startbtn="${boardlist.get(0).startbtn}";
			 
			 endbtn="${boardlist.get(0).endbtn}";
			 
			 totalrow="${boardlist.get(0).totalrow}"
			 
			 if(backpage<0){
				 alert("처음페이지 입니다.")
			 }else{
				 window.location.href
					="backpageboard.do?startpage="+startpage
							+"&nextpage="+nextpage
							+"&backpage="+backpage
							+"&startbtn="+startbtn
							+"&endbtn="+endbtn
							+"&totalrow="+totalrow
							+"&isserch="+isserch;
					+"&keyword="+keyword
					+"&serchvalue="+serchvalue;
					
	 }
			 
			
			
			
		
			
		})		
		
			
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



	<%@ include file="pcNave.jsp"%>
	<%@ include file="mobileNave.jsp"%>

	<div class="wrapper">

		<div class="myalarm">
			<div class="alarm1">알림</div>
			<div class="alarm2">접기</div>
		</div>


		<div class="writecontent">
			<div class="gasipan">
				<h3>질문/자유게시판</h3>
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
								<td><select class="categoty">
										<option>질문</option>
										<option>잡담</option>
										<option>그림자랑</option>
								</select></td>

								<td style="width: 100%;"><input type="text" name="title"
									placeholder="제목" style="width: 100%;"></td>
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
									<textarea type="text" name="content"></textarea>

								</div>


							</div>

						</div>

					</div>
					<div class="register">
						<button>등록</button>
					</div>
				</form>



				<p>욕설 등 게시글은 경고없이 삭제됩니다.</p>
				<p>논란성이 있는 글은 자제부탁드립니다.</p>
			</div>

		</div>


	</div>


</body>
</html>