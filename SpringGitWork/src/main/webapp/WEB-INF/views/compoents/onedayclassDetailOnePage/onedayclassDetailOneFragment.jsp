<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
.class-detail-container {
	border: 1px solid #ddd;
	padding: 20px;
	border-radius: 12px;
	background-color: #f9f9f9;
	margin-bottom: 20px;
	font-family: 'Pretendard', sans-serif;
}

.class-detail-title {
	font-size: 1.8rem;
	font-weight: bold;
	margin-bottom: 10px;
	color: #333;
}

.class-detail-info {
	font-size: 1.05rem;
	margin-bottom: 20px;
	color: #444;
}

.class-meta {
	display: flex;
	flex-wrap: wrap;
	gap: 15px;
	margin-bottom: 20px;
}

.class-meta-item {
	flex: 1 1 200px;
	font-size: 0.95rem;
	background: #fff;
	border-left: 4px solid #2a9df4;
	padding: 10px 15px;
	border-radius: 4px;
	color: #333;
}

.class-meta-item strong {
	display: block;
	color: #2a9df4;
	font-weight: 600;
	margin-bottom: 5px;
}

.class-images {
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
	margin-bottom: 20px;
}

.class-images img {
	width: calc(20% - 10px);
	border-radius: 6px;
	object-fit: cover;
}

.class-detail-extra p {
	margin: 6px 0;
	font-size: 0.95rem;
	color: #444;
}

.class-detail-extra span.label {
	font-weight: 600;
	color: #222;
}

.gentle-btn {
	display: inline-block;
	padding: 12px 20px;
	background-color: #2a9df4;
	color: white;
	font-size: 1rem;
	border-radius: 8px;
	text-decoration: none;
	transition: background-color 0.3s ease;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
}

.gentle-btn:hover {
	background-color: #1e82cc;
}

.mobile-meta-item {
	display: none
}

@media screen and (max-width: 760px) {
	.image-index, .mobile-del {
		display: none;
	}

	.gentle-btn{
	width: 80%;
	}



	/* PC용 메타 숨김, 모바일용 메타 표시 */
	.pc-meta-item {
		display: none !important;
	}
	.mobile-meta-item {
		display: block !important;
	}

	/* 모바일 컨테이너 조정 */
	.class-detail-container {
		padding: 14px 16px;
	}
	.class-detail-title {
		font-size: 1.4rem;
		text-align: center;
		margin-bottom: 6px;
	}
	.class-detail-info {
		font-size: 0.95rem;
		text-align: center;
		margin-bottom: 14px;
	}

	/* 이미지 2열 */
	.class-images {
		display: flex;
		flex-wrap: wrap;
		justify-content: center;
		gap: 6px;
		margin-bottom: 14px;
	}
	.class-images img {
		flex: 1 1 calc(48% - 6px);
		aspect-ratio: 1/1;
		border-radius: 6px;
		object-fit: cover;
	}

	/* 모바일 메타 2열 */
	.mobile-meta-item .class-meta {
		display: flex;
		flex-wrap: wrap;
		gap: 8px;
		justify-content: flex-start;
	}
	.mobile-meta-item .class-meta-item {
		flex: 0 0 calc(50% - 8px); /* 2열 */
		box-sizing: border-box; /* padding 포함 */
		font-size: 0.9rem;
		padding: 8px 10px;
		border-left-width: 3px;
		text-align: center;
	}

	/* 상세 정보 글씨 조정 */
	.mobile-meta-item .class-detail-extra p {
		font-size: 0.9rem;
		line-height: 1.5;
	}

	/* 버튼 전체 너비 */
	.mobile-meta-item .gentle-btn {
		display: block;
		width: 100%;
		text-align: center;
		font-size: 1rem;
		padding: 12px;
	}
}
/* 💻 태블릿 대응 (중간 화면에서 간격 최적화) */
@media screen and (min-width: 761px) and (max-width: 1024px) {
	.class-images img {
		flex: 1 1 calc(33.3% - 8px);
	}
	.class-meta-item {
		flex: 1 1 calc(33.3% - 8px);
	}
}

</style>

<div class="class-detail-container">
  <div class="class-detail-title">${onedayclassInfo.onedayclass_name}</div>

  <div class="class-detail-info">${onedayclassInfo.onedayclass_info}</div>

  <div class="class-images">
    <img src="${pageContext.request.contextPath}/resources/${onedayclassInfo.imagelocallpath1}" alt="class image 1" />
    <img src="${pageContext.request.contextPath}/resources/${onedayclassInfo.imagelocallpath2}" alt="class image 2" />
    <img src="${pageContext.request.contextPath}/resources/${onedayclassInfo.imagelocallpath3}" alt="class image 3" />
    <img src="${pageContext.request.contextPath}/resources/${onedayclassInfo.imagelocallpath4}" alt="class image 4" />
    <img class='image-index' src="${pageContext.request.contextPath}/resources/${onedayclassInfo.imagelocallpath5}" alt="class image 5" />
  </div>


<div class="pc-meta-item">
  <div class="class-meta">
    <div class="class-meta-item">
      <strong>수업 가격</strong>      
      
<fmt:formatNumber value="${onedayclassInfo.onedayclass_price + 0}" pattern="#,###" /> 원

    </div>
    
    
     <div class="class-meta-item">
      <strong>수업 시간</strong>
      ${onedayclassInfo.playtime}
    </div>
    <div class="class-meta-item">
      <strong>최대 인원</strong>
      ${onedayclassInfo.maximum_guests}
    </div>
    <div class="class-meta-item">
      <strong>주소</strong>
      ${onedayclassInfo.address}
    </div>
    <div class="class-meta-item">
      <strong>주차 가능 여부</strong>
      ${onedayclassInfo.park}
    </div>
  </div>
 
   </div>




<div class="mobile-meta-item">
  <div class="class-meta">
    <div class="class-meta-item">
      <strong>수업 가격</strong>      
      
<fmt:formatNumber value="${onedayclassInfo.onedayclass_price + 0}" pattern="#,###" /> 원

    </div>
    
    
     <div class="class-meta-item">
      <strong>수업 시간</strong>
      ${onedayclassInfo.playtime}
    </div>
    
  </div>
  <div class="class-meta">  
    <div class="class-meta-item">
      <strong>최대 인원</strong>
      ${onedayclassInfo.maximum_guests}
    </div>
    <div class="class-meta-item">
      <strong>주소</strong>
      ${onedayclassInfo.address}
    </div>
    <div class="class-meta-item">
      <strong>주차 가능 여부</strong>
      ${onedayclassInfo.park}
    </div>
  </div>
 
   </div>








  <!-- 추가 더미 정보 매핑용 -->
  <input type="hidden" id="onedayclassNum" value="${onedayclassInfo.onedayclass_num}" />

  <div class="class-detail-extra">
    <p><span class="label">한줄 요약:</span> <span id="extraShortDesc"></span></p>
    <p><span class="label mobile-del">추천 대상:</span> <span id="extraTarget"></span></p>
    <p><span class="label mobile-del">수업 혜택:</span> <span id="extraBenefit"></span></p>
    <p><span class="label mobile-del">추천 대상자:</span> <span id="extraRecommend"></span></p>
    <p><span class="label mobile-del">Tip:</span> <span id="extraTip"></span></p>
  </div>
  
  
  <div style="text-align: center; margin-top: 30px;">
  <a href="${pageContext.request.contextPath}/guest/getonedayclass-info?nextpage=0&onedayclass_name=${onedayclassInfo.onedayclass_name}" class="gentle-btn">
    부담 없이 신청하고 경험해보세요
  </a>
</div>
  
</div>
