<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Orbit&family=Sunflower:wght@300&display=swap" rel="stylesheet">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<style>
body {
    margin: 0;
    background-color: #FFF !important;
}

#wrapper {
    max-width: 1020px;
    margin: 0 auto;
    padding: 0;
}

header {
    position: relative;
    height: 70px;
    background: #fff;
}

#carousel {
    height: 450px;
    background-color: #BABABA;
    vertical-align: middle;
}

#content2 {
    grid-gap: 10px;
    display: grid;
    grid-template-rows: 333px 333px 333px 333px 333px;
    grid-template-columns: 50% 50%;
    max-width: 1020px;
    margin: 20px auto;
}

.sameinfo {
    display: grid;
    grid-template-rows: 80% 20%;
    background: #fff;
}

.Section2_2 {
    box-shadow: 0 19px 38px rgba(0, 0, 0, 0.30), 0 15px 12px rgba(0, 0, 0, 0.22);
    height: 100%;
    display: grid;
    grid-template-rows: 50% 50%;
}

.imgarea {
    background-size: 100% 100%;
    background-repeat: no-repeat;
}

.titleinfo {
    font-size: 25px;
    display: block;
    color: #333333;
}

.detailinof {
    display: block;
}

.addbtn {
    color: #333333;
    font-weight: 500;
    border: 0;
    background-color: transparent;
    padding: 10px 0px;
    font-size: 18px;
    display: block;
    margin-right: 0px;
    margin-left: auto;
    box-sizing: border-box;
    border-radius: 3px;
}

.soldout {
    color: red;
    font-weight: 900;
}

.productgrouparea {
    max-width: 1020px;
    margin: 20px auto;
}

.productul {
    display: flex;
    list-style-type: none;
}

.group {
    background-color: #cecece;
    width: 100%;
    text-align: center;
    padding: 10px;
}

@media screen and (max-width: 701px) {
    #content2 {
        grid-template-columns: 154px 154px !important;
        margin: 0 auto;
        width: 90%;
    }

    .mobileheader {
        display: block;
    }

    #mobilecontent1 {
        display: block;
    }
}
</style>

<script>
$(document).ready(function() {
    initializePage();  // 페이지 로드 시 필요한 초기 설정 수행
});

// 페이지 초기화 함수
function initializePage() {
    // 최초 로드시 기본값 "pencile"에 맞는 상품 목록을 불러옵니다.
    loadProductList("pencile");

    // 상품 그룹 클릭 시 이벤트 핸들러 등록
    setupProductGroupClickHandler();
}


// 상품 목록을 로드하는 함수
function loadProductList(productGroup) {
    $.ajax({
        url: "/finall/api/guest/productGroupList",  // 상품 목록을 처리하는 URL
        type: "GET",
        data: { product_group: productGroup },  // 상품 그룹을 파라미터로 전달
        success: function(response) {
            updateProductContainer(response);  // 성공적으로 받은 응답을 처리
            
            // 1. 로컬스토리지 cart 가져오기
            var cart = JSON.parse(localStorage.getItem('cart')) || [];

            if (cart.length === 0) {
                // 로컬스토리지 비어있으면 별도 처리 없음
                return;
            }

            // 2. 새로 로드된 상품 정보 파싱 - DOM 기준 (htmlContent가 삽입된 상태이므로)
            $("#productContainer .product-item").each(function() {
                var productCod = $(this).data("product-cod");
                var priceText = $(this).find(".price").text().replace(' 원', '');
                var newPrice = parseInt(priceText, 10);

                // 3. 로컬스토리지에서 동일 상품 찾기
                var localItem = cart.find(item => item.productCod == productCod);

                if (localItem) {
                    var oldPrice = parseInt(localItem.productPrice, 10);
                    // 4. 가격 변동 체크
                    if (oldPrice !== newPrice) {
                        var productName = $(this).find(".product-name").text();
                    /*     alert(`상품 "${productName}"의 가격이 변경되었습니다.\n기존가격: ${oldPrice}원 → 현재가격: ${newPrice}원`); */
                        // 필요시 로컬스토리지 업데이트도 고려 가능
                        
                    }
                }
            });
            
            
            
        },
        error: function(xhr, status, error) {
            console.log("Error: " + error);  // 에러 발생 시 콘솔에 출력
        }
    });
}

// 상품 그룹 클릭 시 해당 그룹의 상품 목록을 불러오는 함수
function setupProductGroupClickHandler() {
    $('.group').on('click', function() {
        var productGroup = $(this).data('value');  // 클릭된 상품 그룹의 value 값      
        loadProductList(productGroup);  // 해당 그룹에 맞는 상품 목록을 불러옴
    });
}

// 상품 목록을 #productContainer에 업데이트하는 함수
function updateProductContainer(htmlContent) {
    $("#productContainer").html(htmlContent);  // 받아온 HTML을 #productContainer에 삽입
}
</script>

<body>
    <div class="allwarpper">
        <%@ include file="../pcNave.jsp"%>
        <div id="content1">
            <div class="article1">
                <h2 id="header1">미술용품</h2>
                <p>합리적인 가격으로 미술용품을 판매하고 있습니다. 가장 기본적인 구성으로, 인물화에 필요한 연필과, 지우개
                    그리고 색감을 표현하기 위한 파스텔과, 수성 색연필로 구성하였습니다.</p>
            </div>
        </div>

        <div id="mobilecontent1">
            <div class="mobilecontent1header">
                <h3>미술용품</h3>
                <p>가장 기본적인 제품들로 구성하였습니다.</p>
            </div>
        </div>
        
        <div class="productgrouparea">
            <ul class="productul">        
                <li class="group" data-value="pencile">연필류</li>
                <li class="group" data-value="colorpencile">색연필류</li>
                <li class="group" data-value="groupdetermined">기타</li>
            </ul>
        </div>

        <!-- 상품 목록이 삽입될 영역 -->
        <div id="productContainer">
            <!-- 여기에 Ajax로 받아온 상품 목록이 삽입됩니다. -->
        </div>
    </div>
</body>
</html>
