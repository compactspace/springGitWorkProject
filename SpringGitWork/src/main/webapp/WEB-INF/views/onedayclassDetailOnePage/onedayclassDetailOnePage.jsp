<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
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
  
  
  #onedayclassDetailOneFragment{
      padding-top: 20px;
    padding-bottom: 20px;
  }  
  
  
  
  
  #mobileNave {
		display: none;
	}
	
@media screen and (max-width: 760px) {
    html, body {
        font-size: 15px; /* 전체 폰트 크기 조정 */
    }

    #allwrapper {
        padding: 10px;
    }

    .header-wrapper h2 {
        font-size: 1.4rem;
        text-align: center;
    }

    .header-wrapper .subtitle {
        font-size: 0.9rem;
        text-align: center;
        margin-bottom: 16px;
    }

    .select-label {
        font-size: 0.95rem;
        display: block;
        margin-bottom: 6px;
    }

    #classSelect {
        width: 100%;
        font-size: 1rem;
        padding: 10px;
    }

    #onedayclassDetailOneFragment {
        padding: 10px 0;
    }

    /* 네비게이션 전환 */
    #pcNave {
        display: none;
    }
    #mobileNave {
        display: block;
    }
}


  
  
</style>
<script>

const classExtraInfoMap = {
		  1: {
		    shortDesc: "캐릭터 팬이라면 추천!",
		    target: "초보자 ~ 중급자",
		    benefit: "완성된 캐릭터 일러스트 소장",
		    recommend: "만화를 좋아하는 모든 분",
		    tip: "그림 준비물은 모두 제공됩니다."
		  },
		  2: {
		    shortDesc: "사랑하는 사람의 얼굴을 작품으로",
		    target: "인물화를 처음 그리는 분",
		    benefit: "소중한 사람을 위한 선물 제작 가능",
		    recommend: "연인, 가족, 친구",
		    tip: "사진을 미리 준비하면 좋아요."
		  },
		  3: {
		    shortDesc: "여행 사진, 풍경 사진을 그림으로!",
		    target: "자연을 사랑하는 분",
		    benefit: "자신만의 풍경화 완성",
		    recommend: "여행을 좋아하는 분",
		    tip: "자신이 찍은 사진을 가져오세요."
		  },
		  4: {
		    shortDesc: "일상 속 물건도 예술이 된다",
		    target: "관찰력을 기르고 싶은 분",
		    benefit: "사물 표현력 향상",
		    recommend: "그림 초보자에게 추천",
		    tip: "가볍게 참여할 수 있어요."
		  },
		  5: {
		    shortDesc: "디지털 드로잉의 첫걸음",
		    target: "아이패드나 타블렛을 가진 분",
		    benefit: "툴 사용법 + 기본 드로잉 습득",
		    recommend: "디지털 입문자",
		    tip: "태블릿 기기를 가져오면 더 좋습니다."
		  },
		  6: {
		    shortDesc: "빠른 손그림 실력 향상",
		    target: "인체 드로잉 연습자",
		    benefit: "관찰력과 속도 향상",
		    recommend: "만화/애니 지망생",
		    tip: "포즈 다양하게 연습합니다."
		  },
		  7: {
		    shortDesc: "움직이는 그림을 직접 제작",
		    target: "애니메이션에 관심 많은 분",
		    benefit: "기초 애니메이션 제작 경험",
		    recommend: "창작에 관심 있는 분",
		    tip: "기본 캐릭터는 제공됩니다."
		  }
		};




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
            url: "${pageContext.request.contextPath}/guest/get-onedayclass-detail-one-fragment?onedayclass_num=" + selectedValue,
            method: "GET",
            success: (res) => {
                $("#onedayclassDetailOneFragment").html(res);
                
                
                const extra = classExtraInfoMap[selectedValue];
                
                if (extra) {
                    $("#extraShortDesc").text(extra.shortDesc);
                    $("#extraTarget").text(extra.target);
                    $("#extraBenefit").text(extra.benefit);
                    $("#extraRecommend").text(extra.recommend);
                    $("#extraTip").text(extra.tip);
                }
                
                
            },
            error: (err) => {
                console.error("JSP 조각 불러오기 실패:", err);
            }
        });
    };

    const eventInit = () => {
        $("#classSelect").on("change", function () {
            const selectedValue = $(this).val();
       /*      console.log("선택된값: "+selectedValue) */
            findReviewGroupOnedayClass(selectedValue);
       
       
        });
    };
</script>
</head>

<body>
  <div id="allwrapper">
   
<div id="pcNave">
 <%@ include file="../pcNave.jsp"%>
</div>
<div id="mobileNave">
 <%@ include file="../mobileNave.jsp"%>
</div>

    <div class="header-wrapper">
      <h2>수업 소개</h2>
      <div class="subtitle">다양한 학생들의 작품과 소중한 후기를 만나보세요.</div>
    </div>

    <div id="classSelectWrapper" style="margin-bottom: 20px;">
      <label for="classSelect" class="select-label">수업 종류 선택:</label>
      <!-- select는 JS에서 추가됨 -->
    </div>

    <div id="onedayclassDetailOneFragment"></div>
  </div>
</body>
</html>
