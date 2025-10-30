<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
    uri="http://www.springframework.org/security/tags"%>

<sec:csrfMetaTags />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수업 월 등록</title>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<link rel="stylesheet"
    href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
    type="text/css" />

<style>
html, body {
    height: 100%;
    margin: 0;
    font-family: 'Roboto', sans-serif;
}

#pageWrapper {
    display: flex;
    height: 100vh;
}

#sidebar {
    width: 240px;
    border-right: 1px solid #e0e0e0;
    overflow-y: auto;
}

#mainContent {
    flex: 1;
    padding: 24px;
    overflow-y: auto;
}

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

#contentBody {
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    min-height: 400px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.05);
}

/* 월별 카드 UI */
#monthContainer {
    display: flex;
    gap: 16px;
    flex-wrap: wrap;
    margin-top: 20px;
}

.monthCard {
    width: 120px;
    height: 100px;
    border-radius: 8px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    cursor: pointer;
    transition: transform 0.2s, box-shadow 0.2s;
    text-align: center;
}

.monthCard:hover {
    transform: translateY(-4px);
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}

.monthCard.alreadyOpen {
    background-color: #f0f7ff;
    border: 1px solid #2196f3;
    color: #2196f3;
}

.monthCard.possibleOpen {
    background-color: #f9f9f9;
    border: 1px dashed #ccc;
    color: #555;
}

.monthTitle {
    font-size: 1.2em;
    font-weight: bold;
    margin-bottom: 8px;
}

.monthStatus {
    font-size: 0.9em;
}
</style>

<script>
const contextPath = "${pageContext.request.contextPath}";

window.onload = function() {    
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
        <%@ include file="../compoents/teacherVerticalBar/teacherVerticalBar.jsp"%>
    </div>

    <!-- 우측 메인 콘텐츠 -->
    <div id="mainContent">
        <div id="contentHeader">
            <h1>수업 월 등록</h1>
        </div>
        <div id="contentBody">
            <div id="monthContainer">
                <c:forEach var="month" items="${monthList}">
                    <div class="monthCard ${month.status}">
                        <div class="monthTitle">
                            <c:out value="${fn:substring(month.displayText,0,2)}"/>월
                        </div>
                        <div class="monthStatus">
                            <c:out value="${month.status == 'alreadyOpen' ? '수업 관리' : '수업 추가'}"/>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
</body>
</html>

