
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<sec:csrfMetaTags />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
 html, body {
      margin: 0;
      padding: 0;
      height: 100%;
      width: 100%;
      font-family: 'Roboto', sans-serif;
      overflow: hidden; /* 전역 스크롤 제거 */
    }

    #pageWrapper {
      display: flex;
      height: 100vh;
    }

    /* 좌측 메뉴 */
    #sidebar {
      width: 250px;
      border-right: 1px solid #e0e0e0;
      overflow-y: auto;
      overflow-x: hidden;
      scrollbar-width: none; /* Firefox */
    }
    #sidebar::-webkit-scrollbar {
      display: none; /* Chrome/Safari */
    }

    /* 우측 콘텐츠 */
    #mainContent {
      flex: 1;
      height: 100%;
      padding: 24px;
      overflow-y: auto;
      overflow-x: hidden;
    }

    /* 콘텐츠 헤더 */
    #contentHeader {
      margin-bottom: 20px;
      border-bottom: 1px solid #ddd;
      padding-bottom: 12px;
    }
    #contentHeader h1 {
      margin: 0;
      font-size: 1.6em;
      color: #333;
    }

    /* 콘텐츠 바디 */
    #contentBody {
      background-color: #fff;
      padding: 20px;
      border-radius: 8px;
      min-height: 400px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.05);
    }
/* 내정보 시작 */
.info-container {
	display: flex;
	flex-direction: column;
	width: 400px;
	margin: 40px auto;
	font-family: 'Arial', sans-serif;

	padding: 20px 30px;
}

.info-container h2 {
	margin-bottom: 20px;
	font-size: 1.5em;
	color: #333;
	border-bottom: 1px solid #eee;
	padding-bottom: 10px;
}

.info-row {
	display: flex;
	margin-bottom: 12px;
}

.info-row div:first-child {
	flex: 1;
	font-weight: bold;
	color: #555;
}

.info-row div:last-child {
	flex: 2;
	color: #333;
}
/* 내정보 종료 */
</style>
<script>


const contextPath="${pageContext.request.contextPath}"


window.onload=function(){	
	
	 const token = $("meta[name='_csrf']").attr("content");
	  const header = $("meta[name='_csrf_header']").attr("content");

	  $.ajaxSetup({
	    beforeSend: function(xhr) {
	      xhr.setRequestHeader(header, token);
	    }
	  });  
	  
	
}



</script>


</head>
<body>
	<div id="pageWrapper">
		<!-- 좌측 수직 메뉴 -->
		<div id="sidebar">
			<%@ include
				file="../compoents/teacherVerticalBar/teacherVerticalBar.jsp"%>
		</div>


		<!-- 우측 메인 콘텐츠 -->
		<div id="mainContent">
			<div id="contentHeader">
				<h1>수업 월 등록</h1>
			</div>
			<div id="contentBody">
				
			</div>
		</div>
	</div>

</body>
</html>
