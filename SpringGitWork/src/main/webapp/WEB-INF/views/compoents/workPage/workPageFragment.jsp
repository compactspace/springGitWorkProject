<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
    /* 카드들을 감싸는 div 스타일 */
    .card-container {
        display: flex;
        flex-wrap: wrap;
        gap: 20px; /* 카드 사이 간격 */
        justify-content: center; /* 가운데 정렬 */
    }

    /* card 클래스는 기존 스타일 유지 */
</style>

<script >
function goToDetail(work_id) {
    window.location.href = "${pageContext.request.contextPath}/guest/work-detail-page?work_id=" + work_id;
}
</script>



<div class="card-container">
    <c:forEach var="work" items="${workReviews}">
        <div class="card" onclick="goToDetail('${work.work_id}')">
            <img src="${pageContext.request.contextPath}/resources/${work.thumbnail_url}" alt="썸네일" width="180" height="120"><br>
            <strong>${work.title}</strong><br>
            <small>작성자: ${work.user_code}</small>
        </div>
    </c:forEach>
</div>
