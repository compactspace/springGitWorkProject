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
    box-shadow: 0 4px 6px rgba(0,0,0,0.05);
  }

  .gentle-btn:hover {
    background-color: #1e82cc;
  }

  
  
  
</style>

<div class="class-detail-container">
  <div class="class-detail-title">${onedayclassInfo.onedayclass_name}</div>

  <div class="class-detail-info">${onedayclassInfo.onedayclass_info}</div>


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


  <div class="class-images">
    <img src="${pageContext.request.contextPath}/resources/${onedayclassInfo.imagelocallpath1}" alt="class image 1" />
    <img src="${pageContext.request.contextPath}/resources/${onedayclassInfo.imagelocallpath2}" alt="class image 2" />
    <img src="${pageContext.request.contextPath}/resources/${onedayclassInfo.imagelocallpath3}" alt="class image 3" />
    <img src="${pageContext.request.contextPath}/resources/${onedayclassInfo.imagelocallpath4}" alt="class image 4" />
    <img src="${pageContext.request.contextPath}/resources/${onedayclassInfo.imagelocallpath5}" alt="class image 5" />
  </div>

  <!-- 추가 더미 정보 매핑용 -->
  <input type="hidden" id="onedayclassNum" value="${onedayclassInfo.onedayclass_num}" />

  <div class="class-detail-extra">
    <p><span class="label">한줄 요약:</span> <span id="extraShortDesc"></span></p>
    <p><span class="label">추천 대상:</span> <span id="extraTarget"></span></p>
    <p><span class="label">수업 혜택:</span> <span id="extraBenefit"></span></p>
    <p><span class="label">추천 대상자:</span> <span id="extraRecommend"></span></p>
    <p><span class="label">Tip:</span> <span id="extraTip"></span></p>
  </div>
  
  
  <div style="text-align: center; margin-top: 30px;">
  <a href="${pageContext.request.contextPath}/guest/getonedayclass-info?nextpage=0&onedayclass_name=${onedayclassInfo.onedayclass_name}" class="gentle-btn">
    부담 없이 신청하고 경험해보세요
  </a>
</div>
  
</div>
