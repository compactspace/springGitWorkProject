<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<title>학생 작업물 / 후기</title>
<style>
#allwrapper {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
    box-sizing: border-box;
}

 .select-label {
      display: inline-block;
      font-size: 1.1rem;
      color: #444;
      font-weight: 600;
      margin-right: 10px;
      vertical-align: middle;
      user-select: none;
  }

  #classSelect {
      padding: 6px 12px;
      font-size: 1rem;
      border: 1.5px solid #aaa;
      border-radius: 6px;
      background-color: #fff;
      cursor: pointer;
      transition: border-color 0.25s ease;
      vertical-align: middle;
  }

  #classSelect:hover, #classSelect:focus {
      border-color: #2a9df4;
      outline: none;
      box-shadow: 0 0 5px rgba(42, 157, 244, 0.6);
  }
  
  
  #workpage-fragment{
      padding-top: 20px;
    padding-bottom: 20px;
  }  
</style>
<script>
    const classMap = {
        1: '취미 만화반',
        2: '취미 실사화반',
        3: '취미 풍경화반',
        4: '취미 정물화반',
        5: '취미 디지털드로잉반',
        6: '취미 크로키반',
        7: '취미 애니메이션반'
    };

    window.onload = function () {
        const select = document.createElement('select');
        select.id = 'classSelect';
        select.name = 'onedayclass_num';

        for (const key in classMap) {
            const option = document.createElement('option');
            option.value = key;
            option.textContent = classMap[key];
            if (parseInt(key) === 1) { // 기본값 1번 선택
                option.selected = true;
            }
            select.appendChild(option);
        }

        document.getElementById('classSelectWrapper').appendChild(select);

        eventInit(); // 함수 호출 방식 수정
        findReviewGroupOnedayClass(select.value); // 현재 선택된 값 전달
    };
    
    const findReviewGroupOnedayClass = (selectedValue) => {
        if (selectedValue === undefined) {
            selectedValue = 1;
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/guest/indReviewGroupOnedayClass?onedayclass_num=" + selectedValue,
            method: "GET",
            success: (res) => {
                $("#workpage-fragment").html(res);
            },
            error: (err) => {
                console.error("JSP 조각 불러오기 실패:", err);
            }
        });
    };

    const eventInit = () => {
        $("#classSelect").on("change", function () {
            const selectedValue = $(this).val();
            findReviewGroupOnedayClass(selectedValue);
        });
    };
</script>
</head>

<body>
  <div id="allwrapper">
    <%@ include file="../pcNave.jsp"%>

    <div class="header-wrapper">
      <h2>학생 작업물 / 후기</h2>
      <div class="subtitle">다양한 학생들의 작품과 소중한 후기를 만나보세요.</div>
    </div>

    <div id="classSelectWrapper" style="margin-bottom: 20px;">
      <label for="classSelect" class="select-label">수업 종류 선택:</label>
      <!-- select는 JS에서 추가됨 -->
    </div>

    <div id="workpage-fragment"></div>
  </div>
</body>
</html>
