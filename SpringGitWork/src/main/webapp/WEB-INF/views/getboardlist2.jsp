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
.mobileheader {
	display: none;
}


a {

	color: black !important;
	text-decoration: none !important;
}

a:visited {
	text-decoration: none;
}

.mobileheader {
	display: nonel;
}

ul {
	padding: 0 0;
	margin: 0 0;
}

li {
	list-style: none;
}

.writing {
	max-width: 1050px;
	margin: auto;
	min-width: 300px;
	text-align: right;
}

.writing span {
	background-color: #f4f4f4;
	color: #333;
	padding: 4px 14px 4px 10px;
	font-size: 15px;
	line-height: 1.6;
	border-color: #ccc;
	letter-spacing: -1px;
	box-shadow: none;
}

}

/* 게시판 테이블 css */
@import 'https://fonts.googleapis.com/css?family=Open+Sans:600,700';

* {
	font-family: 'Open Sans', sans-serif;
}

.rwd-table {
	max-width: 1050px;
	margin: auto;
	min-width: 300px;
	border-collapse: collapse;
	table-layout: fixed;
}

th:nth-child(1), td:nth-child(1) {
	width: 60%;
}

th:nth-child(2), td:nth-child(2) {
	width: 10%;
}

th:nth-child(3), td:nth-child(3) {
	width: 10%;
}

th:nth-child(4), td:nth-child(4) {
	width: 10%;
}

th:nth-child(5), td:nth-child(5) {
	width: 10%;
}

th, td {
	padding: 8px;
	text-align: left;
	border-bottom: 1px solid #ddd;
	text-align: center;
	white-space: nowrap;
}

#th1content {
	width: 200px;
	display: block;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

#title div {
	width: 200px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

#writerandregdate {
	display: none;
}

#content {
	display: none;
}

#titleonly {
	display: none;
}

#titles {
	
}

@media screen and (max-width: 701px) {

	#navebarwrapper {
	
		display: none;
	}
	
	.mobileheader {
		display: block;
	}
	.writing a {
		padding: 10px 10px;
	}
	.rwd-table {
		max-width: 450px;
	}
	/* 	.nav {
		max-width: 450px;
	} */
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
	#writeronly {
		display: none;
	}
	#content {
		font-size: 13px;
		display: block;
	}
	#titleonly {
		font-size: 14px;
		display: block;
	}
	#titles {
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
	margin-top: 10px;
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


	
	
	
</script>
</head>
<body>
	<%@ include file="pcNave.jsp"%>
	<%@ include file="mobileNave.jsp"%>
	<div class="container">
	
		<h3>질문/자유게시판</h3>
		<div class="writing">
			<c:if test="${userId ne null}">
				<a href="writeboard.jsp">글작성</a>
			</c:if>
		</div>
		<table class="rwd-table">
			<tbody>
				<tr id="coloumnname">
					<th id="th1"><div id="th1content">제목</div></th>
					<th><div>글쓴이</div></th>
					<th>작성일</th>
					<th>조회수</th>
					<th>게시번호</th>
				</tr>
				<c:forEach var="b" items="${boardlist}">
					<tr class="boardcontents">
						<!-- 이벤트가 전파되어 어쩔수없이 value="${b.seq}" 를 다 추가함... -->
						<td class="title" id="title" data-th="Supplier Code"
							value="${b.seq}">
							<div id="titles" value="${b.seq}">${b.title}</div>
							<div id="titleonly" value="${b.seq}">제목: ${b.title}</div>
						</td>
						<td id="content" data-th="Supplier Code">
							<div>내용 :${b.content}</div>
						</td>
						<td id="writer" data-th="Supplier Name">
							<div id="writerandregdate">작성자: ${b.writer} 작성일
								:${b.regdate}</div>
							<div id="writeronly">${b.writer}</div>
						</td>
						<td id="regdate" data-th="Invoice Number">${b.regdate}</td>
						<td id="cnt" data-th="Invoice Date">${b.cnt}</td>
						<td id="seq" data-th="Invoice Date">${b.seq}</td>
					</tr>
				</c:forEach>
			</tbody>

		</table>
		<!-- <h3>Resize Me</h3> -->
		<div class="buttonarea">
			<div class="buttoncontent">
				<div class="contentline1">
					<div class="searcharea">
						<!--
  select * from board where title=?
  select * from board where content=?
  SELECT * FROM board WHERE title LIKE '%?%' and content LIKE '%?%';
    -->
						<select name="keyword" form="search">
							<option value="titleAndcontent">내용+제목</option>
							<option value="title">제목</option>
							<option value="content">내용</option>
						</select>
						<form action="boardsearch.do?" id="search">
							<input type="text" class="serchvalue" name="serchvalue">
							<input type="hidden" name="nextpage" value="0"> <input
								type="submit" value="검색">
						</form>

					</div>
					<!--   <button>쓰기</button> -->
				</div>
				<div class="contentline2">
					<button class="backpagebtn" value="${boardlist.get(0).backpage}">이전페이지로</button>

					<c:choose>
						<c:when
							test="${boardlist.get(0).startbtn>0 and boardlist.get(0).endbtn eq 0 }">
							<button class="eachbtn" value="${boardlist.get(0).startbtn+1}">${boardlist.get(0).startbtn+1}</button>
						</c:when>
						<c:otherwise>
							<c:forEach var="x" begin="${boardlist.get(0).startbtn}"
								end="${boardlist.get(0).endbtn}">
								<button class="eachbtn" value="${x+1}">${x+1}</button>
							</c:forEach>
						</c:otherwise>
					</c:choose>


					<button class="nextpagebtn" value="${boardlist.get(0).flagendpage}">다음페이지로</button>
				</div>
			</div>
		</div>
	</div>
	<!-- class 컨테이너 태그 종료  -->

	<%-- <c:choose>
<c:when test="${boardlist eq null}">
<h1>해당 게시판의 게시물이 없습니다. 최초로 등록해보세요</h1>
</c:when>

<c:otherwise>
	<h1>다음페이지 nextpage: ${boardlist.get(0).nextpage}</h1> 
	<h1>이전페이지 backpage: ${boardlist.get(0).backpage}</h1>
	<h1>시작 btn: ${boardlist.get(0).startbtn}</h1> 
	<h1>종료 btn: ${boardlist.get(0).endbtn}</h1> 
	<h1>마지막 페이지 기발:  ${boardlist.get(0).flagendpage}</h1>
	<c:forEach var="b" items="${boardlist}">
	<h1>${b.seq} : ${b.title}</h1>
	</c:forEach>	
		<button class="backpagebtn" value="${boardlist.get(0).backpage}">이전페이지로</button>	
	<c:choose>
	<c:when test="${boardlist.get(0).startbtn ne 0 and boardlist.get(0).endbtn eq 0 }">
	<button class="eachbtn" value="${boardlist.get(0).startbtn+1}">${boardlist.get(0).startbtn+1}</button>	
	</c:when>
	
	<c:otherwise>
	<c:forEach var="x" begin="${boardlist.get(0).startbtn}" end="${boardlist.get(0).endbtn}">
		<button class="eachbtn" value="${x+1}">${x+1}</button>
	</c:forEach>
	</c:otherwise>	
	</c:choose>	

		<button class="nextpagebtn" value="${boardlist.get(0).flagendpage}">다음페이지로</button>

</c:otherwise>
</c:choose> --%>






</body>
</html>