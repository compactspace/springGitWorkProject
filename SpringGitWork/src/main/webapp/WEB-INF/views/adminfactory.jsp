<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!doctype html>
<html>

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>index페이지</title>
<link
	href="https://fonts.googleapis.com/css2?family=Orbit&family=Sunflower:wght@300&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
</head>
<style>
body {
	bottom: 0px 0px;
	margin: 0px 0px;
}

.root {
	display: flex;
}

.justlog {
	margin: 0 30px;
	display: flex;
	flex-direction: row;
	min-height: 50px;
	color: #fff;
	background-color: #262626;
	border-radius: 6px;
	border: 0;
	justify-content: center;
	align-items: center;
	column-gap: 8px;
	text-decoration: none;
	cursor: pointer;
	transition: transform .2s;
}

.leftwrapper {
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	background-color: #000;
	z-index: 11;
	flex: 0 0 240px;
	min-width: 240px;
	height: 100vh;
}

.sidebar {
	flex: 1;
	display: flex;
	gap: 20px;
	flex-direction: column;
	padding: 30px 0;
	position: fixed;
	top: 0;
	/* 	width: 240px; */
	overflow: auto;
	height: calc(100vh - 220px);
	background-color: #000;
}

ul {
	margin: 0;
	padding: 0;
	list-style: none;
}

.sidebarmenu {
	display: block;
	background: #262626;
	color: #fc6b2d;
	font-family: Pretendard, sans-serif;
	font-size: 16px;
	line-height: 27.2px;
	font-weight: 700;
	word-break: keep-all;
	height: 50px;
	padding: 0 24px 0 35px;
	text-decoration: none;
	color: #fff;
	background: #000000;
	border: none;
	outline: none;
	box-shadow: none;
	cursor: pointer;
}

/* 롸이트바 시작  */
.rigthwrapper {
	width: 100%;
}

.header {
	width: 100%;
	/* padding: 0 50px; */
	display: inline-flex;
	align-items: center;
	border-bottom: 1px solid #f5f5f5;
	background-color: #fff;
	position: sticky;
	top: 0;
	height: 40px;
	z-index: 10;
	left: 240px;
	font-family: Pretendard, sans-serif;
	font-size: 14px;
	line-height: 22.4px;
	font-weight: 700;
	word-break: keep-all;
}

.mainbody {
	padding-left: 50px;
	padding-right: 50px;
	background-color: #fbfbfb;
}

.sectionarea {
	margin-left: auto;
	margin-right: auto;
	width: 940px;
	display: flex;
	flex-direction: column;
	padding: 40px 0 140px;
	width: 1100px;
	background-color: #fbfbfb;
}

.sectionone {

    display: grid;
    grid-template-rows: 50% 50%;
    grid-template-columns: 50% 50%;
	
}

.infoarea{

}










/* 새로운 테이블 디자인 시작 */
table {
    width: 1028px;
    text-align: center;
    border: 1px solid #fff;
    border-spacing: 1px;
    font-family: 'Cairo', sans-serif;
  margin: auto;
}

caption {
    font-weight: bold;
}

table td {
    padding: 10px;
    background-color: #eee;
}

table th {
    background-color: #333;
    color: #fff;
    padding: 10px;
}

img {
    width: 90px;
    height: 90px;
}

#view,
#delete {
    border: none;
    padding: 5px 10px;
    color: #fff;
    font-weight: bold;
}

#view {
    background-color: #03A9F4;
}

#delete {
    background-color: #E91E63;
}

.tablefoot {
    padding: 0;
    border-bottom: 3px solid #009688;
}
/* 새로운 테이블 디자인 종료 */
</style>
<script>

var product_group;

window.onload=function(){
	
	//클라이언트 상품 페이지 에 노출 여부 함수
	$("button[class=openstatus]").on("click",(e)=>{
		/* console.log(e)
		console.log(e.target) */
		console.log(e.target.getAttribute("value"))		
		product_group=$(e.target).parent().prev().prev().prev().prev().prev().prev().text();
		
		//씨발 잘 모르겟는데 e 까지는 html 이나 자바 객체인듯 하고
		//e.target 에 $ 를 씌워야 제이쿼리 객체료 변신.ㅎ
		//console.log($(e.target).parent().prev().prev().prev().prev().prev().val());		
	 	let product_cod=$(e.target).parent().prev().prev().prev().prev().text();
	 	
	 /* 	console.log($(e.target).parent().prev().prev().prev())
	 	console.log($(e.target).parent().prev().prev().prev().prev().text()); */
	 	
	 	
		let product_Registration_status=$(e.target).val();		
		console.log("제품코드 :"+product_cod+" 그리고 변경 상태 :"+product_Registration_status);
		
		  $.ajax({
			
			url:"statusopen.do",
			type:"post",
			data:{"product_Registration_status":product_Registration_status,"product_cod":product_cod},
			
			success:(data)=>{
					
				alert("고객 상품페이지에 "+product_Registration_status+" 상태로 변경 하셨습니다.");
				/* window.location.href="adminproductlist22.do?product_group="+product_group; */				
				if(product_Registration_status=="open"){
					
					$(e.target).parent().prev().prev().text("open");					
				}else{
					$(e.target).parent().prev().prev().text("hidden");					
				}				
				
			}
			
		})// 아작스 함수 종료  			
		
	})// 클릭함수 종료	
	
	let key=localStorage.getItem("key");	
	$(".Authorization").val("Bearer "+key);	
	
	//바로 this 나 $(this) 가 먹히지 않는다면
	// 이벤트 e로받고, e.target으로 자바스크립트 객체로 받은후 $ 로 감싸 제이쿼리로 받자...
	$(".product_groupvalue").on("change",(e)=>{		
		//console.log($(e.target).val());
		let product_group=$(e.target).val();
		$(".product_group").val(product_group)	
	})

}// 윈도우 온로드 종료
</script>

<body>
<div class="root">
		<div class="leftwrapper">
			<div class="sidebar">
				<span class="justlog">관리자모드</span>
				<ul>
					<li><a class="sidebarmenu" href="adminhome.jsp"> <span>Home</span></a></li>
					<li><a class="sidebarmenu"  href="resoveinfolist.do"> <span>예약현황</span></a></li>
					<li><a class="sidebarmenu" href="admindetailreserveinfo.jsp"> <span>예약상세조회</span></a></li>				
					<li><a class="sidebarmenu" href="adminproductlist22.do"> <span>고객노출 상품관리</span></a></li>
					<li><a class="sidebarmenu" href=""> <span>재고현황</span></a></li>
					<li><a class="sidebarmenu"> <span>주문형황</span></a>
					<sec:authorize access="hasRole('ROLE_ADMIN')">
								<!-- <a class="nav-link" href="/adminhome.do">관리자 모드</a> -->	
								<h3 class="managermode">관리자모드</h3>
							<p>principal : <sec:authentication property="principal"/></p>					
							</sec:authorize>
							<sec:authorize access="hasRole('ROLE_ADMIN')">
								<!-- <a class="nav-link" href="/adminhome.do">관리자 모드</a> -->	
								<h3 class="managermode">관리자모드</h3>
							<p>principal : <sec:authentication property="principal"/></p>					
							</sec:authorize>
							
					
					
					</li>
				</ul>
			</div>
			<div class="sidebarbottom"></div>

		</div>
		<div class="rigthwrapper">
			<div class="header">
			<h2 id="header1">관리자님 상품관리페이지</h2>>
			</div>
			<div class="mainbody">
				<div class="sectionarea">
					<div class="sectionone">
				
		<!--  새로운 테이블 시작 -->
		<table>
        <caption>상품 판매 및 홈페이지 노출 관리</caption>
        <thead>
            <tr>
                <th>제품 이미지</th>
                <th>제품 류</th>
                <th>제품명</th>
                <th>제품코드</th>
                <th>판매상태</th>
                <th>홈페이지 노출</th>
                <th>판매상태 관리하기</th>
                <th>노출상태 관리하기</th>
                <th>제품군 선택 
                	<select name="product_group" class="product_groupvalue" form="myForm">
					<option value="pencile" selected>목탄연필군</option>
					<option value="colorpencile">색연필군</option>
					<option value="제품군미정">제품군미정</option>
				</select>	</th>                 
            </tr>
        </thead>
        <tbody>
        <c:forEach var="p" items="${productService}" varStatus="i">
            <tr>
                <td><img src="img_product/${p.product_img}" alt="img"></td>
                
                <td>${p.product_group}</td>
                  <td>${p.product_name}</td>
                <td >${p.product_cod}</td>
                   <td>${p.product_status}</td>
                   <td>${p.product_Registration_status}</td> 
                       <td>
                <!-- view 와 delete 는 css 전용 id니 당황도 말고 삭제도 하지 말것  -->
                   <button id="view" class="statuschange" type=button value="판매">판매로변경</button>
				   <button id="delete" class="statuschange" type=button value="품절">품절로변경</button>                  
                </td>                  
                <td>
                <!-- view 와 delete 는 css 전용 클래스니 당황도 말고 삭제도 하지 말것  -->
                   <button  id="view" class="openstatus" type=button value="open">홈페이지에상품등록</button>
				   <button id="delete" class="openstatus" type=button value="hidden">홈페이지에상품철회</button>                  
                </td>
                 <td>
             
                  <form action="adminproductchoicegroup.do" method="get" id="myForm">
						<input type="hidden" class="Authorization" name="Authorization"  >
						<input type="hidden" class="product_group"  name="product_group">
					 	<button id="view"  type="submit" >선택</button>
					<br>
				</form>			
				              
                </td>
            </tr>
            </c:forEach>       
        </tbody>
        <tfoot>
            <td colspan="5" class="tablefoot"></td>            
        </tfoot>
    </table>		
				
				
				
				
				
				


					</div>
					<div class="section"></div>
				</div>
			</div>
		</div>
	</div>				
	<!--  테이블 종료 -->
			<script>			
	$("button[class=statuschange]").on("click", function(e) {		
		console.log("상품코드는->>"+$(this).parent().prev().prev().prev().text())	
		console.log("어떤상태로->>"+$(this).val()) 
	let	product_status=$(this).val()
	let product_cod=$(this).parent().prev().prev().prev().text();
		
		$.ajax({
			url : "statuschange.do",
			method : "get",
			data : {
				
				"product_cod" : product_cod,
				"product_status": product_status
				
			},
			success : function(data) {	
				
				console.log($(e.target).parent().prev().prev());				
				
				alert(product_status+" 로 변경하셨습니다.");				
				
				if(product_status=="판매"){
					$(e.target).parent().prev().prev().text("판매");
				}else{
					$(e.target).parent().prev().prev().text("품절");
				}				
				
			},
			error : function() {

			}

		})  // 아작스 통신 종료
 
	})// 클릭함수 종료
	
	
</script>		
</body>
</html>