<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<meta charset="UTF-8">
<title>검색 결과</title>
<style>
    /* 기존 스타일 유지 */
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        margin: 20px;
    }
    h2 {
        color: #333;
    }
    .artwork-list {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
    }
    .artwork-item {
        background: white;
        border-radius: 8px;
        box-shadow: 0 2px 6px rgb(0 0 0 / 0.1);
        padding: 15px;
        width: 300px;
        box-sizing: border-box;
        transition: box-shadow 0.3s ease;
    }
    .artwork-item:hover {
        box-shadow: 0 4px 12px rgb(0 0 0 / 0.2);
    }
    .artwork-img {
        width: 100%;
        height: 180px;
        object-fit: cover;
        border-radius: 5px;
        margin-bottom: 12px;
        background-color: #eee;
    }
    .artwork-info {
        font-size: 14px;
        color: #555;
        line-height: 1.4;
    }
    .no-result {
        font-size: 18px;
        color: #999;
        margin-top: 50px;
        text-align: center;
    }
    .search-summary {
        margin-top: 48px;
        margin-bottom: 48px;
        color: #555;
        align-items: center;
        text-align: center;
        width: 100%;
        display: inline-block;
        font-size: 24px;
    }
    .highlight {
        color: #f28c28; /* 은은한 주황색 */
        font-weight: 600;
    }
    .first-render , .paging-render{
    
    max-width: 950px;
    margin: auto;
    }
    
    
    
    /* 페이징 버튼 시작 */
    
   .paging-render {
    display: flex;
    justify-content: center;
    gap: 12px;
    flex-wrap: wrap;
        margin-top: 25px;
        
}

.paging-render button {
    background-color: #f8f9fa;
    border: 1.5px solid #f28c28;
    color: #f28c28;
    font-size: 16px;
    font-weight: 600;
    padding: 8px 14px;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.3s ease;
    min-width: 44px;
    box-shadow: 0 2px 6px rgba(242, 140, 40, 0.3);
    user-select: none;
    white-space: nowrap;
}

.paging-render button:hover:not(:disabled) {
    background-color: #f28c28;
    color: white;
    box-shadow: 0 4px 10px rgba(242, 140, 40, 0.6);
}

.paging-render button:disabled {
    background-color: #f28c28;
    color: white;
    border-color: #d46b00;
    cursor: default;
    box-shadow: none;
    font-weight: 700;
}

.paging-render button#prevBtn,
.paging-render button#nextBtn {
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1px;
}

    /* 페이징 버튼 종료 */
    
    /* 상품 검색결과 시작 */
    .product-list {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
}

.product-item {
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 6px rgb(0 0 0 / 0.1);
    padding: 15px;
    width: 300px;
    box-sizing: border-box;
    transition: box-shadow 0.3s ease;
}

.product-item:hover {
    box-shadow: 0 4px 12px rgb(0 0 0 / 0.2);
}

.product-item p {
    font-size: 14px;
    color: #555;
    line-height: 1.4;
}
    /* 상품 검색결과 종료 */
    
    
    /* 카트 담기 버튼 시작 */
     .btn-area {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .sold-out {
            color: #f44336;
            font-weight: bold;
        }
        .add-to-cart-btn {
            background-color: #3a87ad;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .add-to-cart-btn:hover:not(:disabled) {
            background-color: #2a5b7c;
        }
        .login-message {
            color: #f44336;
            font-size: 13px;
            margin-left: 10px;
            font-weight: bold;
        }
        .control-buttons {
            margin-bottom: 30px;
            text-align: right;
        }
        .control-buttons button {
            margin-left: 10px;
            background-color: #5a9bd5;
            border: none;
            color: white;
            padding: 10px 18px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .control-buttons button:hover {
            background-color: #3a6fa3;
        }
        .cancel-cart-btn {
            display: none;
        }
    
    /*카트 담기 버튼 종료  */
    
    
    
    
    /* 로그인 모달 시작*/
       /* 모달 스타일 */
        #login-modal {
            display: none;
            position: fixed;
            top: 40%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: #fff;
            padding: 20px 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.3);
            z-index: 1001;
            width: 300px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        #login-modal p {
            font-size: 16px;
            font-weight: bold;
            margin: 0 0 20px 0;
            color: #333;
        }
        #login-modal .modal-buttons {
            text-align: right;
        }
        #login-modal button {
            padding: 8px 16px;
            border: none;
            background-color: #ccc;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
            transition: background-color 0.3s ease;
        }
        #login-modal button:hover {
            background-color: #bbb;
        }
        #login-modal a {
            padding: 8px 16px;
            background: #3a87ad;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }
        #login-modal a:hover {
            background-color: #2a5b7c;
        }

        #modal-backdrop {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 1000;
        }
    /*  로그인 모달 종료 */
    
    
    
</style>
  <!-- 인증 여부를 JS로 안전하게 넘기기 -->
    <script>
      var isAuthenticated = ${isAuthenticated};
  //  console.log("isAuthenticated: "+isAuthenticated);
    </script>
        
    
    
<script>
// totalCnt는 서버에서 JSP EL로 가져오는 부분 유지
const totalCnt = "${totalCnt}" || 0;
const currentSearChQuery="${query}";



// 변수명 명확하게 분리
const itemsPerPage = 10;    // 한 페이지에 보여줄 아이템 수
const pageBtnGroupSize = 5; // 한 번에 보여줄 페이지 버튼 개수

//쿠키에서 totalCnt 읽기 함수
function getTotalCntFromCookie() {
    const match = document.cookie.match(/cachyTotalCnt=(\d+)/);
   /*  console.log(match);
    console.log(match?.[1]); */    
    return Number(match?.[1] ?? 0);
}




// 쿠키에 totalCnt 저장 함수 (초기 로드 시 한번만)
function setTotalCntCookie(totalCnt) {
    document.cookie = "cachyTotalCnt=" + totalCnt + "; path=/; max-age=3600; SameSite=Lax";
    document.cookie = "query=" + encodeURIComponent(currentSearChQuery)+ "; path=/; max-age=3600; SameSite=Lax";

}



// 페이징 UI 그리기 (버튼 UI 생성만)
function paginUiUpdate(currentPage, pageBtnGroupSize) {
    const pagingContainer = $(".paging-render");
    pagingContainer.empty();

    // 쿠키에서 totalCnt 읽어서 계산
    const cachedTotalCnt = getTotalCntFromCookie();
  
    
    const totalPage = Math.ceil(cachedTotalCnt / itemsPerPage);
    const pageBtnCount = pageBtnGroupSize;

    const currentGroup = Math.floor((currentPage - 1) / pageBtnCount);
    const startPage = currentGroup * pageBtnCount + 1;
    let endPage = startPage + pageBtnCount - 1;
   
    
    
    
    if (endPage > totalPage) endPage = totalPage;
    console.log("startPage: "+startPage, "totalPage:   "+totalPage , "endPage: "+endPage);
    
    
    if (startPage > 1) {
        const prevBtn = $('<button>').text('이전').attr('id', 'prevBtn');
        pagingContainer.append(prevBtn);
    }

    for (let i = startPage; i <= endPage; i++) {
        const pageBtn = $('<button>').text(i).attr('data-page', i);
        if (i === currentPage) {
            pageBtn.css('font-weight', 'bold').attr('disabled', true);
        }
        pagingContainer.append(pageBtn);
    }

    if (endPage < totalPage) {
        const nextBtn = $('<button>').text('다음').attr('id', 'nextBtn');
        pagingContainer.append(nextBtn);
    }
    
    // 이전, 다음, 페이지 번호 클릭 이벤트 (이벤트 위임 또는 별도 바깥에 분리하는 게 좋음)
}

// 기존 변수들
let currentQuery = '';
let currentKeywordType = '';
let currentPage = 1;

function fetchSearchPage(query, keywordType, page, skipPush) {
	
    const contextPath="${pageContext.request.contextPath}"
    const url="/guest"
    const reqURL=contextPath+url;
    $.ajax({
        url: '${pageContext.request.contextPath}/api/guest/search/ajax',
        type: 'GET',
        data: {
            query: query,
            keywordType: keywordType || '',
            page: page,
            limit: itemsPerPage
        },
        dataType: 'json',
        success: function(response) {
            const list = response.searchyList || [];
            const ajaxTotalCnt = response.totalCnt || 0; // ajax에서 온 총 개수

            currentQuery = query;
            currentKeywordType = keywordType;
            currentPage = page;

            let listContainer = $(".artwork-list");
            if (listContainer.length === 0) {
                $(".first-render").remove();
                $('body').append('<div class="artwork-list"></div>');
                listContainer = $(".artwork-list");
            }
            listContainer.empty();

            if (list.length === 0) {
                listContainer.html('<div class="no-result">검색 결과가 없습니다.</div>');
            } else {
                list.forEach(artwork => {
                	const item = '<div class="artwork-item" data-artworkid="' + artwork.artwork_id + '">' +
                    '<img class="artwork-img" src="' + contextPath + '/api/guest/get-artwork-image?folder=' + artwork.file_url + '&&name=' + artwork.file_name + '" alt="작품 이미지" />' +
                    '<div class="artwork-info">' +
                    '<p><strong>작성자 코드:</strong> ' + artwork.user_code + '</p>' +
                    '<p><strong>업데이트 날짜:</strong> ' + artwork.updated_at + '</p>' +
                    '</div>' +
                    '</div>';


                    listContainer.append(item);
                });
            }

            // 쿠키에 AJAX에서 받은 totalCnt 저장 (초기 로드시만)
            if (!getTotalCntFromCookie()) {
                setTotalCntCookie(ajaxTotalCnt);
            }

            // 페이지 버튼은 쿠키에 저장된 totalCnt 기준으로 그리기
            paginUiUpdate(page, pageBtnGroupSize);

            if (!skipPush) {
                const params = new URLSearchParams({
                    query: query,
                    keywordType: keywordType || '',
                    page: page
                });
                

                
                const newUrl = contextPath+url+'/search?' + params.toString();
                window.history.pushState(
                    { query, keywordType, currentPage: page },
                    '',
                    newUrl
                );
            }
        },
        error: function(xhr, status, error) {
            console.error('AJAX 검색 요청 실패:', error);
        }
    });
}

// popstate 이벤트 : 뒤로가기, 앞으로가기 시 AJAX 재호출
window.addEventListener('popstate', function(event) {
    if (event.state) {
        fetchSearchPage(event.state.query || '', event.state.keywordType || '', event.state.currentPage || 1, true);
    } else {
        // 새로고침 또는 직접 URL 접근 시 URL 파라미터 읽어서 처리
        const params = new URLSearchParams(window.location.search);
        const q = params.get('query') || '';
        const kt = params.get('keywordType') || '';
        const p = parseInt(params.get('page')) || 1;
        fetchSearchPage(q, kt, p, true);
    }
});


$(document).ready(function() {
	
	
	toggleCancelCartButton();
	addEventListeners();
	
	
	
	
	
    // 초기 로드 시 URL 파라미터에 따라 초기화 (새로고침 대응)
    const params = new URLSearchParams(window.location.search);
    const q = params.get('query') || '';
    const kt = params.get('keywordType') || '';
    const p = parseInt(params.get('page')) || 1;

    currentQuery = q;
    currentKeywordType = kt;
    currentPage = p;

    $(".find-total-cnd").text(totalCnt);
    setTotalCntCookie(totalCnt);

    // 초기 데이터는 서버에서 렌더링한 결과를 사용
    paginUiUpdate(currentPage, totalCnt, pageBtnGroupSize);

    /*
    // 필요하면 URL 파라미터가 있을 경우 ajax 최신화 가능
    if(q !== '' || kt !== '' || p !== 1){
        fetchSearchPage(q, kt, p, true);
    }
    */
});

// 페이징 UI 버튼 클릭 시 (이벤트 위임 방식 - 문서 로드 시 단 한번만 연결됨)
$(document).on('click', '.paging-render button#prevBtn', function() {
    const totalPage = Math.ceil(totalCnt / itemsPerPage);
    const pageBtnCount = pageBtnGroupSize;
    const currentGroup = Math.floor((currentPage - 1) / pageBtnCount);
    const startPage = currentGroup * pageBtnCount + 1;

    const prevGroupStart = startPage - pageBtnCount;
    if (prevGroupStart >= 1) {
        fetchSearchPage(currentQuery, currentKeywordType, prevGroupStart);
    }
});

$(document).on('click', '.paging-render button#nextBtn', function() {
    const totalPage = Math.ceil(totalCnt / itemsPerPage);
    const pageBtnCount = pageBtnGroupSize;
    const currentGroup = Math.floor((currentPage - 1) / pageBtnCount);
    const startPage = currentGroup * pageBtnCount + 1;

    const nextGroupStart = startPage + pageBtnCount;
    if (nextGroupStart <= totalPage) {
        fetchSearchPage(currentQuery, currentKeywordType, nextGroupStart);
    }
});

$(document).on('click', '.paging-render button[data-page]', function() {
    const selectedPage = parseInt($(this).attr('data-page'));
    if (selectedPage !== currentPage) {
        fetchSearchPage(currentQuery, currentKeywordType, selectedPage, false);
    }
});


$(document).on('click', '.artwork-item', function() {
    const artWorkID=$(this).data("artworkid")
    const contextPath="${pageContext.request.contextPath}";
    const reqURL="/guest/get-artwork-detail?artWorkID="+artWorkID;
    window.location.href=contextPath+reqURL;
});




/* 상품 검색 결과 스크립트 시작 */

function toggleCancelCartButton() {
        const cart = JSON.parse(localStorage.getItem('cart'));
        if (cart && cart.length > 0) {
            $(".cancel-cart-btn").show();
        } else {
            $(".cancel-cart-btn").hide();
        }
    }
    
function addEventListeners() {
    $(".add-to-cart-btn").on("click", handleAddToCart);
    $(".add-all-to-cart-btn").on("click", handleAddAllToCart);
    $(".cancel-cart-btn").on("click", handleCancelCart);
}


function handleAddToCart() {
	
	
	
	
	  
	        if (!isAuthenticated) {
	            showLoginModal();
	            return;
	        }

	        
	        var $item = $(this).closest(".product-item");
	      
	        
	        var productCod = $item.data("product-cod");
	        var productId = $item.data("product-id");  // ← productId 가져오기
	        var productName = $item.find(".product-name").data("product-name");
	        var productPrice = $item.find(".price").data("product-price");
	        var productImg = $item.find(".product-image").css("background-image");  
	        
	        
	        
	        
	        var cart = JSON.parse(localStorage.getItem('cart')) || [];
	        var existingProduct = cart.find(item => item.productCod === productCod);

	        if (existingProduct) {
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
	            var productName = $(this).find(".product-name").data("product-name");
	            console.log("productName: "+productName);
	            
	            var productPrice = $(this).find(".price").data("product-price");
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



/* 상품 검색 결과 스크립트 종료  */



</script>

</head>
<body>
<%@ include file="../pcNave.jsp" %>

<div class="search-summary">
    검색에 대한 
    <span class="highlight find-total-cnd"></span>개의 
    <span class="highlight">자료</span>를 찾았어요.
</div>



<div class="first-render">
<c:choose>   
    <c:when test="${searchType == 'community'}">
        <c:choose>
            <c:when test="${empty searchyList}">
                <div class="no-result">검색 결과가 없습니다.</div>
            </c:when>
            <c:otherwise>
                <div class="artwork-list">
                    <c:forEach var="artwork" items="${searchyList}">
                        <div class="artwork-item" data-artworkid="${artwork.artwork_id}">
                            <img class="artwork-img" 
                                 src="${pageContext.request.contextPath}/api/guest/get-artwork-image?folder=${artwork.file_url}&&name=${artwork.file_name}" 
                                 alt="작품 이미지" />
                            <div class="artwork-info">
                                <p><strong>작성자 코드:</strong> ${artwork.user_code}</p>
                                <p><strong>업데이트 날짜:</strong> ${artwork.updated_at}</p>                   
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </c:when>


    <c:when test="${searchType == 'product'}">
        <c:choose>
            <c:when test="${empty productList}">
                <div class="no-result">상품 검색 결과가 없습니다.</div>
            </c:when>
            <c:otherwise>
                <div class="product-list">
                  <c:forEach var="product" items="${productList}">          
 
   
   
   
   
   
                  
    <div class="product-item" 
     data-product-cod="${product.productCod}" 
     data-product-id="${product.productId}">
        <c:choose>           
            <c:when test="${product.productFilePath eq null}">
                <img class="product-img" 
                      src="${pageContext.request.contextPath}/resources/img_product/${product.productImg}" 
                     alt="상품 이미지"
                     style="width:100%; height:180px; object-fit:cover; border-radius:5px; margin-bottom:12px; background-color:#eee;" />
            </c:when>
            
            <c:otherwise>
                <img class="product-img" 
                     src="${pageContext.request.contextPath}/images/${product.productFileName}" 
                     alt="상품 이미지"
                     style="width:100%; height:180px; object-fit:cover; border-radius:5px; margin-bottom:12px; background-color:#eee;" />
            </c:otherwise>
        </c:choose>       
        
        
        <div class="product-info">
            <p><strong class="product-name" data-product-name="${product.productName}">상품명:</strong> ${product.productName}</p>
            <p><strong class="price" data-product-price="${product.lastedUpdatePrice}">가격:</strong> ${product.lastedUpdatePrice}원</p>
       
        </div>
        
      
        
             <div class="btn-area">
                            <span class="price">${product.lastedUpdatePrice} 원</span>

                         <button type="button" class="add-to-cart-btn">카트에 담기</button>
                        </div>
    </div>
</c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </c:when>
    

    
    <c:otherwise>
        <div class="no-result">검색 결과가 없습니다.</div>
    </c:otherwise>
</c:choose>
</div>



<div class="paging-render"></div>
  <div id="login-modal">
        <p>로그인이 필요합니다.</p>
        <div class="modal-buttons">
            <button onclick="closeLoginModal()">닫기</button>
            <a href="${pageContext.request.contextPath}/guest/login">로그인하러 가기</a>
        </div>
    </div>
    <div id="modal-backdrop"></div>


</body>
</html>

