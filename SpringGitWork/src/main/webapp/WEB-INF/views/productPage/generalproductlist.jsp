<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link
	href="https://fonts.googleapis.com/css2?family=Orbit&family=Sunflower:wght@300&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>


<style>
/* 폰트 통일 및 기본 세팅 */
body {
	margin: 0;
	background-color: #fff !important;
	font-family: 'Sunflower', 'Orbit', sans-serif;
	color: #333;
	line-height: 1.5;
}

#wrapper {
	max-width: 1020px;
	margin: 0 auto;
	padding: 0 15px;
}

header {
	position: relative;
	height: 70px;
	background: #fff;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
}

#carousel {
	height: 450px;
	background-color: #BABABA;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 2rem;
	color: #fff;
}

#content1 .article1 {
	max-width: 900px;
	margin: 30px auto;
	padding: 0 15px;
}

#content1 h2#header1 {
	font-size: 2.8rem;
	font-weight: 700;
	margin-bottom: 10px;
	color: #1a1a1a;
}

#content1 p {
	font-size: 1.15rem;
	color: #666;
}

/* 모바일 헤더 */
#mobilecontent1 {
	display: none;
}

.productgrouparea {
	max-width: 1020px;
	margin: 30px auto;
	padding: 0 15px;
}

.productul {
	display: flex;
	list-style: none;
	padding: 0;
	margin: 0;
	border-bottom: 2px solid #eee;
}

.group {
	background-color: #f5f5f5;
	flex: 1;
	text-align: center;
	padding: 15px 0;
	font-weight: 600;
	color: #444;
	cursor: pointer;
	border-right: 1px solid #ddd;
	transition: background-color 0.3s ease, color 0.3s ease;
	user-select: none;
}

.group:last-child {
	border-right: none;
}

.group:hover, .group.active {
	background-color: #4a90e2;
	color: white;
	font-weight: 700;
}

#productContainer {
	max-width: 1020px;
	margin: 20px auto 60px;
	padding: 0 15px;
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
	gap: 20px;
}

.same-product-container{
max-width: 1020px;
	margin: 20px auto 60px;
	padding: 0 15px;
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
	gap: 20px;
}




/* 추천 섹터 시작 */
.section-header {
    max-width: 1020px;
    margin: 40px auto 10px;
    padding: 0 15px;
}

.section-header h3 {
    font-size: 1.6rem;
    font-weight: 700;
    margin-bottom: 5px;
}

.section-header p {
    font-size: 1rem;
    color: #666;
}

.recommended-simple {
    max-width: 1020px;
    margin: 0 auto 20px;
    padding: 0 15px;
    font-size: 0.95rem;
    color: #555;
}

.section-divider {
    max-width: 1020px;
    margin: 10px auto 30px;
    border: none;
    border-top: 1px solid #eee;
}
/* 추천 섹터 종료 */


/* 상품 아이템 스타일 (ajax 로드되는 구조에 맞게) */
.product-item {
	background: #fff;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.07);
	border-radius: 8px;
	overflow: hidden;
	display: flex;
	flex-direction: column;
	transition: box-shadow 0.3s ease;
}

.product-item:hover {
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
}

.product-item .imgarea {
	background-size: cover !important;
	background-position: center center !important;
	height: 180px;
}

.titleinfo {
	font-size: 1.3rem;
	font-weight: 700;
	padding: 10px 15px 5px;
	color: #222;
}

.detailinof {
	font-size: 1rem;
	color: #666;
	padding: 0 15px 10px;
	flex-grow: 1;
}

.price {
	font-size: 1.15rem;
	font-weight: 600;
	color: #2c3e50;
	padding: 0 15px 10px;
}

.addbtn {
	cursor: pointer;
	background-color: transparent;
	border: 2px solid #4a90e2;
	color: #4a90e2;
	font-weight: 600;
	font-size: 1rem;
	border-radius: 4px;
	margin: 0 15px 15px;
	padding: 10px 0;
	text-align: center;
	transition: background-color 0.3s ease, color 0.3s ease;
}

.addbtn:hover {
	background-color: #4a90e2;
	color: #fff;
}

.soldout {
	color: #e74c3c;
	font-weight: 900;
	padding-left: 15px;
}

/* 반응형 */
@media screen and (max-width: 701px) {
	#content1 .article1 {
		padding: 0 10px;
	}
	#mobilecontent1 {
		display: block;
		max-width: 600px;
		margin: 0 auto 20px;
		padding: 0 15px;
	}
	.mobilecontent1header h3 {
		font-size: 1.8rem;
		margin-bottom: 5px;
	}
	.mobilecontent1header p {
		font-size: 1rem;
		color: #555;
	}
	.productul {
		justify-content: center;
		gap: 10px;
		flex-wrap: wrap;
		border-bottom: none;
	}
	.group {
		flex: none;
		min-width: 120px;
		border-right: none;
		border-radius: 4px;
		padding: 12px 10px;
		font-size: 1rem;
		background-color: #f9f9f9;
	}
	.group.active, .group:hover {
		background-color: #4a90e2;
		color: #fff;
	}
	#productContainer {
		grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
		margin: 0 auto 40px;
		width: 90%;
		gap: 15px;
	}
	.product-item .imgarea {
		height: 140px;
	}
	.titleinfo {
		font-size: 1.1rem;
		padding: 8px 10px 4px;
	}
	.detailinof {
		font-size: 0.9rem;
		padding: 0 10px 8px;
	}
	.price {
		font-size: 1rem;
		padding: 0 10px 8px;
	}
	.addbtn {
		font-size: 0.95rem;
		margin: 0 10px 10px;
	}
}

#mobileNave {
	display: none;
}

/*모바일 시작  */
@media screen and (max-width: 760px) {
	/* 네비게이션 전환 */
	#pcNave {
		display: none;
	}
	#mobileNave {
		display: block;
	}
}
/*모바일 종료  */
</style>


<script>
$(document).ready(function() {
    initializePage();  // 페이지 로드 시 필요한 초기 설정 수행
});


// 페이지 초기화 함수
function initializePage() {
  const defaultGroup = "pencile";
  loadProductList(defaultGroup);
  var defaultcategoryId=4;
  loadPaintProductList(defaultcategoryId);
  // 기본 설명 렌더링
  const groupInfo = groupDescriptions[defaultGroup];
  if (groupInfo) {
    $('#groupTitle').text(groupInfo.title);
    $('#groupDescription').text(groupInfo.description);
  }
  
  

  // 기본 그룹 탭에 active 클래스 추가
  $('.group').removeClass('active');  // 혹시 모를 기존 상태 제거
  $(`.group[data-value="${defaultGroup}"]`).addClass('active');
  // 클릭 핸들러 등록
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
                       alert("상품 ${productName}의 가격이 변경되었습니다.\n기존가격: "+oldPrice+"원 → 현재가격: "+newPrice+"원"); 
                        
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


// 간단한 수채화 물감 상품을 로드하는 함수
function loadPaintProductList(categoryId) {
    $.ajax({
        url: "/finall/api/guest/product-categorylist",  // 상품 목록을 처리하는 URL
        type: "GET",
        data: { category_id: 4 },  // 상품 그룹을 파라미터로 전달
        success: function(response) {
          // 성공적으로 받은 응답을 처리
            updateProductPaintContainer(response);
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
                       alert("상품 ${productName}의 가격이 변경되었습니다.\n기존가격: "+oldPrice+"원 → 현재가격: "+newPrice+"원"); 
                        
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
    const productGroup = $(this).data('value');  // 예: 'pencile'

   // console.log("productGroup: "+productGroup)
    // 상품 목록 로드
    loadProductList(productGroup);

    // 설명 정보가 있으면 렌더링
    const groupInfo = groupDescriptions[productGroup];
    if (groupInfo) {
      $('#groupTitle').text(groupInfo.title);
      $('#groupDescription').text(groupInfo.description);
    }

    // 선택된 탭 스타일링 (선택적)
    $('.group').removeClass('active');
    $(this).addClass('active');
  });
}



// 상품 목록을 #productContainer에 업데이트하는 함수
function updateProductContainer(htmlContent) {
    $("#productContainer").html(htmlContent);  // 받아온 HTML을 #productContainer에 삽입
}

function updateProductPaintContainer(htmlContent) {
    $("#productPaintContainer").html(htmlContent);  // 받아온 HTML을 #productContainer에 삽입
}


const groupDescriptions = {
		  pencile: {
		    title: "연필류",
		    description: "인물화에 필요한 연필과 지우개로 구성되어 있습니다. 선명한 표현을 위한 기본 아이템입니다."
		  },
		  색연필: {
		    title: "색연필류",
		    description: "색감을 표현하기 위한 파스텔과 수성 색연필로 구성하였습니다."
		  },
		  "제품군 미정": {
		    title: "기타",
		    description: "기본 구성 외에 추가적인 미술용품들로 구성되어 있습니다."
		  }
		};


</script>
  <!-- 인증 여부를 JS로 안전하게 넘기기 -->
    <script>
      var isAuthenticated = ${isAuthenticated};
    //  console.log("isAuthenticated: "+isAuthenticated);
    </script>
    
    

    
    
    <script>
    $(document).ready(function() {
        addEventListeners();
        toggleCancelCartButton(); 
    });

    function toggleCancelCartButton() {
        const cart = JSON.parse(localStorage.getItem('cart'));
        if (cart && cart.length > 0) {
            $(".cancel-cart-btn").show();
        } else {
            $(".cancel-cart-btn").hide();
        }
    }
    
    
 // 기존 addEventListeners() 대신
    function addEventListeners() {
        // 동적 생성되는 버튼에도 적용 가능
        $("#productContainer ,#productPaintContainer").on("click", ".add-to-cart-btn", handleAddToCart);
        
        $(".add-all-to-cart-btn").on("click", handleAddAllToCart);
        $(".cancel-cart-btn").on("click", handleCancelCart);
    }
 
 

    function handleAddToCart() {
    	console.log(localStorage.getItem('cart'));
   // console.log("isAuthenticated: "+isAuthenticated);
   
   
    
    	
        if (!isAuthenticated) {
            showLoginModal();
            return;
        }

        var $item = $(this).closest(".product-item");
        var productCod = $item.data("product-cod");
        var productId = $item.data("product-id");  // ← productId 가져오기
        var productName = $item.find(".product-name").text();
        var productPrice = $item.find(".price").text().replace(' 원', '');
        var productImg = $item.find(".product-image").css("background-image");

        var cart = JSON.parse(localStorage.getItem('cart')) || [];
        
        
        
        
        
        
        var existingProduct = cart.find(item => {
            console.log("find 내부 productCod:",item.productCod, " 그리고 타겟 프로덕트 코드: ",productCod);
            console.log("item.productCod === productCod ?", item.productCod === productCod);
            return item.productCod === productCod;
        });
        console.log(existingProduct);
        
        
        
        
        
        
        
        

        if (existingProduct) {
        	console.log(existingProduct);
        	
        	
            alert("이미 장바구니에 담긴 상품입니다.");
            return;
        }

        
        
        var newProduct = {
            productCod: productCod,
            productId: productId,  // ← productId 추가
            productName: productName,
            productPrice: productPrice,
            productImg: productImg,
            quantity:1
        };

        cart.push(newProduct);
        localStorage.setItem('cart', JSON.stringify(cart));
        toggleCancelCartButton();
        
        alert("장바구니에 담았답니다.");

     /*    $.ajax({
            url: '/addToCart',
            method: 'POST',
            data: newProduct,
            success: function(response) {
                if (response.success) {
                    alert("상품이 장바구니에 추가되었습니다.");
                } else {
                    alert("장바구니에 추가하는데 문제가 발생했습니다.");
                }
            },
            error: function() {
                alert("장바구니에 추가하는데 문제가 발생했습니다.");
            }
        }); */
    }


    function handleAddAllToCart() {
        if (!isAuthenticated) {
            showLoginModal();
            return;
        }
        
        
        var allProducts = [];
        $(".product-item").each(function() {
            var productCod = $(this).data("product-cod");
            var productId = $(this).data("product-id");  // ← productId 가져오기
            var productName = $(this).find(".product-name").text();
            var productPrice = $(this).find(".price").text().replace(' 원', '');
            var productImg = $(this).find(".product-image").css("background-image");

            
            allProducts.push({
                productCod: productCod,
                productId: productId,  // ← productId 추가
                productName: productName,
                productPrice: productPrice,
                productImg: productImg,
                quantity:1
            });
        });

        localStorage.setItem('cart', JSON.stringify(allProducts));
        toggleCancelCartButton();

 /*        $.ajax({
            url: '/addAllToCart',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(allProducts),
            success: function(response) {
                if (response.success) {
                    alert("모든 상품이 장바구니에 추가되었습니다.");
                } else {
                    alert("장바구니에 추가하는데 문제가 발생했습니다.");
                }
            },
            error: function() {
                alert("장바구니에 추가하는데 문제가 발생했습니다.");
            }
        }); */
    }  

    
    function handleCancelCart() {
        localStorage.removeItem('cart');
        toggleCancelCartButton();
        alert("장바구니가 비워졌습니다.");

      /*   $.ajax({
            url: '/cancelCart',
            method: 'POST',
            success: function(response) {
                alert("서버에서 장바구니가 취소되었습니다.");
            },
            error: function() {
                alert("장바구니 취소에 문제가 발생했습니다.");
            }
        }); */
        
    }
    
    function showLoginModal() {
        $("#login-modal").show();
        $("#modal-backdrop").show();
    }

    function closeLoginModal() {
        $("#login-modal").hide();
        $("#modal-backdrop").hide();
    }
    </script>


<body>
	<div class="allwarpper">
		<div id="pcNave">
			<%@ include file="../pcNave.jsp"%>
		</div>
		<div id="mobileNave">
			<%@ include file="../mobileNave.jsp"%>
		</div>

<div class="banner-container">
<img src="${pageContext.request.contextPath}/resources/img_product_banner/product_page_banner.jpeg" alt="Left Banner">
</div>



			<!-- 추천 섹터 -->
<div class="section-header">
    <h3>추천 기본 그림 상품</h3>
    <p>처음 시작하신다면 아래 기본 구성부터 추천드립니다.</p>
</div>
<div class="recommended-simple">
    연필 + 지우개 + 스케치북 구성의 기본 드로잉 세트를 먼저 확인해보세요.
</div>

<hr class="section-divider">




		<div id="content1">
			<div class="article1">
				<h2 id="groupTitle">미술용품</h2>
				<p id="groupDescription">합리적인 가격으로 미술용품을 판매하고 있습니다.</p>
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
				<c:forEach var="group" items="${groupInfolist}">
					<li class="group" data-value="${group.groupName}">
						${group.groupName}</li>
				</c:forEach>
			</ul>
		</div>	

		<!-- 상품 목록이 삽입될 영역 -->
		<div id="productContainer" class="same-product-container">
			<!-- 여기에 Ajax로 받아온 상품 목록이 삽입됩니다. -->
		</div>
			
		
		
		
		
		<!-- 전문가용 물감 섹터 -->
<div class="section-header">
    <h3>🎨 색을 다루는 분들을 위한 선택</h3>
    <p>수채화 · 유화 전용 물감 라인업</p>
</div>


<hr class="section-divider">
			<!-- 상품 목록이 삽입될 영역 -->
		<div id="productPaintContainer" class="same-product-container">
			<!-- 여기에 Ajax로 받아온 상품 목록이 삽입됩니다. -->
		</div>
		
		
		
	</div>
</body>
</html>
