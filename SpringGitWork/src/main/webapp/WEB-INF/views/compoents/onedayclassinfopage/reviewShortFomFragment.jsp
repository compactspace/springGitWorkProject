<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>




<div id="shortReviewFragment">
    <c:forEach items="${shortReviewList.reivewvo}" var="review">
        <div class="short-recentreviewwrapper">
            <div class="short-recentreview">
                <p>${review.review_name}</p>
                <p>수업: ${onedayclass.onedayclass_name}</p>

                <c:if test="${review.review_img ne 'noimg'}">
                    <!-- 카드에서는 썸네일 -->
                    <img class="short-reviewimg-card"
                         src="${pageContext.request.contextPath}/resources/img_review/${review.review_img}" />
                </c:if>

                <p class="short-reviewcreate">
                    <span class="short-commentcontent">${review.review_comment}</span>
                    <span class="short-createcontent" style="color: #ff5862;">작성일: ${review.review_create_at}</span>
                </p>
            </div>
        </div>
    </c:forEach>
</div>

<!-- 모달 구조 -->
<div id="shortReviewModal" style="display:none;">
    <div class="short-modal-overlay"></div>
    <div class="short-modal-content">
        <span class="short-modal-close">&times;</span>
        <div class="short-modal-body">
            <!-- 클릭한 카드 내용이 복사됨 -->
        </div>
    </div>
</div>

<style>
/* 카드 스타일 */
.short-recentreviewwrapper {
    flex: 1 1 calc(33.33% - 16px);
    background-color: #fff;
    border-radius: 10px;
    padding: 12px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.08);
    cursor: pointer;
    margin-bottom: 16px;
    transition: transform 0.2s ease;
}
.short-recentreviewwrapper:hover {
    transform: translateY(-3px);
}
.short-recentreview {
    display: flex;
    flex-direction: column;
    gap: 6px;
}
.short-reviewimg-card {
    width: 100%;
    height: 150px;
    object-fit: cover;
    border-radius: 6px;
    margin-bottom: 6px;
}

/* 모달 */
.short-modal-overlay {
    position: fixed;
    top:0; left:0; right:0; bottom:0;
    background: rgba(0,0,0,0.5);
    z-index: 999;
}
.short-modal-content {
    position: fixed;
    top: 50%; left: 50%;
    transform: translate(-50%, -50%);
    background: #fff;
    max-width: 800px;
    width: 90%;
    border-radius: 12px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.3);
    z-index: 1000;
    padding: 20px;
    overflow-y: auto;
    max-height: 90vh;
}
.short-modal-close {
    position: absolute;
    top: 12px;
    right: 16px;
    font-size: 1.5rem;
    font-weight: bold;
    color: #555;
    cursor: pointer;
}
.short-modal-close:hover {
    color: #ff5862;
}
.short-modal-body .short-reviewimg-card {
    width: 100%;
    height: auto; /* 원본 비율 유지 */
    max-height: 70vh;
    object-fit: contain;
    margin-bottom: 12px;
}
</style>

<script>
// 모달 열기
function openShortReviewModal(cardElement){
    const modal = document.getElementById('shortReviewModal');
    // 카드 내부 내용을 clone하고 이미지 클래스 변경
    const clone = cardElement.cloneNode(true);
    const img = clone.querySelector('.short-reviewimg-card');
    if(img) {
        img.style.height = 'auto';
        img.style.maxHeight = '70vh';
        img.style.objectFit = 'contain';
    }
    modal.querySelector('.short-modal-body').innerHTML = '';
    modal.querySelector('.short-modal-body').appendChild(clone);
    modal.style.display = 'block';
}

// 모달 닫기
function closeShortReviewModal(){
    document.getElementById('shortReviewModal').style.display = 'none';
}

// 카드 클릭 이벤트
$(document).on('click', '.short-recentreviewwrapper', function(){
    openShortReviewModal(this);
});

// 닫기 버튼 클릭
$(document).on('click', '.short-modal-close', function(){
    closeShortReviewModal();
});

// 배경 클릭 시 닫기
$(document).on('click', '.short-modal-overlay', function(){
    closeShortReviewModal();
});
</script>