<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<div class="endPageFlag" data-endPageFlag=${endPageFlag} ></div>

<c:choose>
	<c:when test="${joinToReview eq nul}">
		<h1 data-endPageFlag=${endPageFlag} >${endPageFlag} 아직 등록후기가 없습니다. 첫 후기의 주인이 되어주세요</h1>
	</c:when>

	<c:otherwise>
		<c:forEach items="${joinToReview}" var="review">
			<div class="recentreviewwrapper" 
				style="
						<c:if test="${review.review_img eq 'noimg'}">height: 150px;</c:if>">
				<!-- heigth 값을 주고 오버플로 친다음 자바스크립트로 계속 헤이트를 늘려주는 이벤트를 만들어보자. -->
				<div class="recentreview"
					style="						
					<c:if test="${review.review_img eq 'noimg'}">height: 100%;</c:if>">
					<p>${review.review_name}</p>
					<p>수업:${onedayclass.onedayclass_name}</p>
					<c:if test="${review.review_img ne 'noimg'}">
						<div class="reviewimg"
							style="background-image: url('${pageContext.request.contextPath}/resources/img_review/${review.review_img}');"></div>
					</c:if>
					
					<p class="reviewcreate">
						<span class="commentcontent">${review.review_comment}</span> <span
							class="createcontent" style="color: #ff5862;">작성일:
							${review.review_create_at}</span>
					</p>
				</div>
			</div>
		</c:forEach>


	</c:otherwise>
</c:choose>



