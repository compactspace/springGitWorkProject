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
<title>신청 현황</title>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<link rel="stylesheet"
    href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
    type="text/css" />

<style>
/* 공통 CSS시작  */
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
    padding: 20px 24px;
    background-color: #f5f7fa;
    border-left: 6px solid #4a90e2;
    border-radius: 4px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.08);
    margin-bottom: 20px;
}

#contentHeader h1 {
    margin: 0;
    font-size: 1.8em;
    font-weight: 700;
    color: #333;
}

#contentHeader .header-subtitle {
    margin: 6px 0 0 0;
    font-size: 0.95em;
    color: #666;
}


#contentBody {
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    min-height: 400px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.05);
}

#documentStatusTable {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

#documentStatusTable th, #documentStatusTable td {
    border: 1px solid #ddd;
    padding: 10px;
    text-align: left;
}

#documentStatusTable th {
    background-color: #f5f5f5;
}

.status-badge {
    padding: 4px 8px;
    border-radius: 4px;
    font-weight: bold;
}

.status-pending {
    background-color: #ccc;
    color: #333;
}

.status-approved {
    background-color: #4CAF50;
    color: #fff;
}

.status-rejected {
    background-color: #f44336;
    color: #fff;
}
/* 공통 CSS종료  */
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
            <h1>신청 현황</h1>
            <p class="header-subtitle">회원 가입시 제출했던 회사정보에 대한 승인상태 확인</p>
        </div>
        <div id="contentBody">
            <table id="documentStatusTable">
                <thead>
                    <tr>
                        <th>문서 제목</th>
                        <th>제출 날짜</th>
                        <th>상태</th>
                        <th>검토자</th>
                        <th>검토 날짜</th>
                        <th>연락처</th>
                        <th>거절 사유</th>
                    </tr>
                </thead>
                
                <tbody>
                    <c:forEach var="doc" items="${currentMyDocuments}">
                        <tr>
                            <td>${doc.document_type}</td>
                            <td>${doc.uploaded_at}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${doc.status == 'pending'}">
                                        <span class="status-badge status-pending" title="검토 대기중">대기중</span>
                                    </c:when>
                                    <c:when test="${doc.status == 'approved'}">
                                        <span class="status-badge status-approved" title="승인 완료">승인</span>
                                    </c:when>
                                    <c:when test="${doc.status == 'rejected'}">
                                        <span class="status-badge status-rejected" title="${doc.review_comment}">거절</span>
                                    </c:when>
                                </c:choose>
                            </td>
                            <td>${doc.full_name}</td>
                            <td>${doc.reviewed_at}</td>
                            <td>${doc.email} / ${doc.phone}</td>
                            <td>${doc.review_comment}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
