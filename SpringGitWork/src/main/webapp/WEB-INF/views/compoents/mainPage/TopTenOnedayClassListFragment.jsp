<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
.slider-wrapper {
	position: relative;
	overflow: hidden;
	width: 100%;
}

.slider-track {
	display: flex;
	transition: transform 0.3s ease;
}

.onedayclass-card {
	width: 280px;
	flex-shrink: 0;
	margin-right: 30px;
	padding: 20px;
	background-color: #fff;
	border: 1px solid #eaeaea;
	border-radius: 10px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
	transition: transform 0.2s ease-in-out;
}

.onedayclass-card:hover {
	transform: translateY(-5px);
}

.onedayclass-card img {
	width: 100%;
	height: 180px;
	object-fit: cover;
	border-radius: 8px;
	margin-bottom: 15px;
}

.onedayclass-card .title {
	font-size: 1.3em;
	font-weight: bold;
	color: #333;
	margin-bottom: 10px;
}

.onedayclass-card .info {
	font-size: 0.95em;
	color: #666;
	margin-bottom: 8px;
}

.onedayclass-card .price {
	font-size: 0.95em;
	color: #444;
	margin-bottom: 10px;
}

.onedayclass-card .meta {
	display: flex;
	justify-content: space-between;
	font-size: 0.8em;
	color: #999;
}

.slider-controls {
	text-align: center;
	margin-top: 15px;
}

.slider-button {
	display: inline-block;
	margin: 0 5px;
	padding: 6px 12px;
	background-color: #333;
	color: #fff;
	cursor: pointer;
	border-radius: 4px;
	font-size: 0.9em;
}
</style>
<div id="onedayclass-slider">
  <div class="slider-wrapper">  
 <div class="slider-track" id="onedayclassSlider">
    <c:forEach var="item" items="${onedayclassList}">
  <div class="onedayclass-card"
       data-name="${item.onedayclass_name}">
    <img src="${pageContext.request.contextPath}/resources/${item.reserve_img}" alt="클래스 이미지">
    <div class="title">${item.onedayclass_name}</div>
    <div class="info">${item.onedayclass_info}</div>
    <div class="price"><strong>가격:</strong> ${item.onedayclass_price}원</div>
    <div class="meta">
      <span>⏱ ${item.playtime}</span>
      <span>👥 ${item.maximum_guests}</span>
    </div>
  </div>
</c:forEach>

    </div>
  </div>

  <div class="slider-controls">
    <button class="slider-button btn-prev">‹ 이전</button>
    <button class="slider-button btn-next">다음 ›</button>
  </div>
</div>

<script>
  $(document).ready(function() {

    const container = $('#onedayclass-slider');
    if (container.length === 0) {
      console.log("컨테이너 없음");
      return;
    } else {
      console.log("컨테이너 찾음");
    }

    const track = container.find('#onedayclassSlider');
    const btnPrev = container.find('.btn-prev');
    const btnNext = container.find('.btn-next');


    let currentIndex = 0;
    const visibleCards = 3;
    const cardWidth = 310;


const totalCards = track.children().length;
track.css('width', (totalCards * cardWidth) + 'px');


    function updateSliderPosition() {
      const offset = -(currentIndex * cardWidth);
console.log(offset)
track.css('transform', 'translateX(' + offset + 'px)');
      console.log("슬라이더 이동", currentIndex);
    }
    

    btnPrev.on('click', () => {
      if (currentIndex > 0) {
        currentIndex--;
        updateSliderPosition();
      }
    });

    btnNext.on('click', () => {
      console.log("다음버튼 클릭");
      const totalCards = track.children().length;
      if (currentIndex < totalCards - visibleCards) {
        currentIndex++;
        updateSliderPosition();
      }
    });

$(".onedayclass-card").on('click', function() {
    const name = $(this).data("name");
console.log(name);

    const basePath = "${pageContext.request.contextPath}"; // JSTL 변수 JS에 주입
var url = basePath + "/guest/getonedayclass-info?nextpage=0&onedayclass_name=" + encodeURIComponent(name);

    window.location.href = url;
});


  });






</script>
