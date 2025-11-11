<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>장바구니</title>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<style>




  .show-mobile{
    	display: none;
    }
    
    
button,
input[type="submit"],
a.continue-shopping {
    font-family: 'Noto Sans KR', sans-serif;
    font-size: 15px;
    font-weight: 500;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.25s ease;
}



.cart-controls button {
    background-color: #ffffff;
    border: 1px solid #ccc;
    color: #333;
    padding: 8px 16px;
    margin-left: 8px;
}

.cart-controls button:hover {
    background-color: #007bff;
    color: #fff;
    border-color: #007bff;
}
.continue-shopping {
    background-color: #f8f9fa;
    border: 1px solid #ccc;
    color: #333;
    padding: 10px 20px;
    text-decoration: none;
    text-align: center;
}

.continue-shopping:hover {
    background-color: #e2e6ea;
}




/* 기본 스타일 */
#emptycarousel {
	display: none;
	text-align: center;
	margin-top: 100px;
}

#carousel {
	display: none;
}

/* 새 div 기반 장바구니 구조 */
.cart-container {
	width: 800px;
	max-width: 800px;
	min-width: 800px;
	margin: 0 auto;
	border: 1px solid #ccc;
	border-radius: 6px;
	overflow: hidden;
}

/* 헤더 */
.cart-header, .cart-row, .cart-footer {
	display: flex;
	align-items: center;
	text-align: center;
}

.cart-header {
	background-color: #f5f5f5;
	font-weight: bold;
	border-bottom: 1px solid #ccc;
}


.cart-controls{width: 800px; margin: 20px auto 10px; text-align: right;}

.cart-row {
	border-bottom: 1px solid #ddd;
}

.cart-cell {
	flex: 1;
	padding: 8px;
	border-right: 1px solid #ccc;
}


.image-cell{
flex:2; display:flex; align-items:center; gap:10px;
}

.cart-cell:last-child {
	border-right: none;
}

img {
	width: 80px;
	height: auto;
}

.quantity-control {
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 8px;
}

.quantity-control button {
	width: 32px;
	height: 32px;
	font-size: 20px;
	font-weight: bold;
	background-color: #f0f0f0;
	border: 1px solid #ccc;
	border-radius: 4px;
	cursor: pointer;
	user-select: none;
	transition: background-color 0.2s ease;
}

.quantity-control button:hover {
	background-color: #ddd;
}

.quantity-control input {
	width: 40px;
	text-align: center;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 4px;
	pointer-events: none;
	background-color: #fff;
	user-select: none;
}





.continue-shopping{padding: 10px 20px; background: #f5f5f5; border: 1px solid #ccc; border-radius: 4px; text-decoration: none;}


.finallpurchace {
	display: flex;
	justify-content: flex-end;
	align-items: center;
	gap: 8px;
	padding: 10px;
}

#mobileNave{
	display: none;
}

/* 모바일 */
@media screen and (max-width: 760px) {


    #pcNave { display: none; }
    #mobileNave { display: block; }

    /* 기존 테이블/헤더 숨김 */
    .cart-header { display: none; }

    /* 기존 카드형 flex 전환 */
    .cart-row {
        flex-direction: column;
        align-items: flex-start;
    }
    
    
    
    
    
    .cart-container {
	max-width: 360px;
	min-width:1px;
	font-size: 15px;
	
}
    
    
    
    .cart-cell {
    justify-content: center;
        border: none;
        width: 100%;
    }
    
    
    .image-cell{
    gap: 0px;
    }
    

    /* 추가 모바일 스타일 */
    table { display: none; }

    .cart-item-card {
        display: flex;
        flex-direction: column;
        border: 1px solid #ccc;
        border-radius: 8px;
        margin: 10px 0;
        padding: 10px;
        background-color: #fff;
    }
    
    
    
    .show-mobile{
    	display: block;
    }
    
    
    .show-mobile-text{
    	text-align: center;
    	border: none;
    	
    }
    
    
    .hiding-mobile{
    	display: none;
    }   
    
    
    .product-image{
   		max-width: 300px;
        min-width: 300px;    
    }
    

    .cart-item-card img {
        width: 100%;
        height: auto;
        margin-bottom: 10px;
        object-fit: cover;
    }

    .cart-item-card .item-info {
        display: flex;
        flex-direction: column;
        gap: 4px;
    }
    
.cart-controls{
   width: auto;
    margin: 20px auto 10px;
    text-align: left;       

}

    .quantity-control {
        gap: 12px;
     
        
    }


    .quantity-control button {
   		width: auto;
        height: auto;
        
    }



    .order-actions {
    	max-width:360px;
        flex-direction: column;
        gap: 10px;
        width: 90%;
        margin: 20px auto;
        position: sticky;
        bottom: 0;
        background: #fff;
        padding: 10px;      
     
    }
    
    
    #ajaxfinallsum{
    padding-top: 3px;
    border: none;
    }
    

    .order-actions a,
    .order-actions input[type="submit"] {
        width: 100%;
        text-align: center;
    }
    
.continue-shopping{
padding: 10px 0px;
}
    #wrapper,
    #carousel {
        padding: 10px;
    }
}

</style>

</head>
<body>


<div id="wrapper">
	<div id="pcNave">
		<%@ include file="../pcNave.jsp"%>
	</div>
	<div id="mobileNave">
		<%@ include file="../mobileNave.jsp"%>
	</div>

	<!-- 비어있을 때 -->
	<div id="emptycarousel">
		<div id="carouselimg"></div>
		<h3>장바구니가 비어있어요</h3>
	</div>

	<!-- 아이템 있을 때 -->
	<div id="carousel">
		<form action="${pageContext.request.contextPath}/users/order" id="forminfo">

			<!-- 버튼 영역 -->
			<div class="cart-controls">
				<button type="button" class="allchoicebtn">전체선택</button>
				<button type="button" class="allclearbtn">전체선택해제</button>
				<button type="button" class="dropcart">장바구니비우기</button>
			</div>

			<!-- 장바구니 영역 -->
			<div class="cart-container">
				<div class="cart-header">
					<div class="cart-cell" style="flex:2;">상품정보</div>
					<div class="cart-cell">수량</div>
					<div class="cart-cell">개당가격</div>
					<div class="cart-cell">수량대비가격</div>
					<div class="cart-cell">확인</div>
				</div>

				<div id="cart-items" class="cart-body">
					<!-- JS에서 아이템 생성 -->
				</div>

				<div class="cart-footer">
					<div class="cart-cell" style="flex:5; text-align:right;">
						<div class="finallpurchace">
							<div class="subfinallpurchace">합계금액:</div>
							<input id="ajaxfinallsum" type="text" name="finallsum" value="0" readonly>
						</div>
					</div>
				</div>
			</div>


			<!-- 주문/쇼핑 버튼 -->
			<div class="order-actions"
				style="width: 800px; margin: 20px auto; display: flex; justify-content: space-between;">
				<a href="${pageContext.request.contextPath}/guest/productlist" class="continue-shopping">
					계속 쇼핑하기
				</a>
				<input id="lastorder" type="submit" value="주문하기"
					style="padding: 10px 20px; background: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer;">
			</div>
		</form>
	</div>
</div>


<script>
let cart;
window.addEventListener('pageshow', function(event) {
	if (event.persisted) {
		cart = JSON.parse(localStorage.getItem("cart") || "[]");
		renderCart();
	} else {
		cart = JSON.parse(localStorage.getItem("cart") || "[]");
		renderCart();
	}
});

const cartItemsTbody = document.getElementById("cart-items");
const totalSumInput = document.getElementById("ajaxfinallsum");
const emptyDiv = document.getElementById("emptycarousel");
const cartDiv = document.getElementById("carousel");

function extractImgUrl(imgStr) {
	const match = imgStr.match(/url\(["']?(.*?)["']?\)/);
	return match ? match[1] : imgStr;
}

function renderCart() {
	cartItemsTbody.innerHTML = "";

	if(cart.length === 0) {
		cartDiv.style.display = "none";
		emptyDiv.style.display = "block";
		totalSumInput.value = "0";
		return;
	} else {
		cartDiv.style.display = "block";
		emptyDiv.style.display = "none";
	}

	let totalSum = 0;

	cart.forEach((item, idx) => {
		const quantity = item.quantity || 1;
		const price = Number(item.productPrice);
		const sum = price * quantity;
		totalSum += sum;
		const imgSrc = extractImgUrl(item.productImg);

		const row = document.createElement("div");
		row.classList.add("cart-row");

		let html = '';
		html += '<div class="cart-cell image-cell">';
		html += '<img class="product-image" src="' + imgSrc + '" alt="' + item.productName + '">';
		html += '<div data-product-cod="' + item.productCod + '">';
		html += '<input type="hidden" name="cart_id" value="' + (item.cartId || '') + '">';
		html += '<input type="hidden" name="product_img" value="' + imgSrc + '">';
		html += '<input type="hidden" name="id" value="' + (item.id || '') + '">';
		html += '<input type="hidden" name="product_id" value="' + item.productId + '">';
		html += '<input type="text" class="hiding-mobile" name="product_name" value="' + item.productName + '" readonly><br>';
		html += '<input type="hidden" name="user_code" value="' + (item.userCode || '') + '">';
		html += '</div></div>';
	
		html += '<div class="cart-cell show-mobile" ><input type="text" class="show-mobile-text" name="product_name" value="' + item.productName + '" readonly></div>'
		html += '<div class="cart-cell"><div class="quantity-control">';
		html += '<button type="button" class="pluss" data-idx="' + idx + '" data-action="minus">-</button>';
		html += '<input name="cart_quantity" value="' + quantity + '" readonly>';
		html += '<button type="button" class="pluss" data-idx="' + idx + '" data-action="plus">+</button>';
		html += '</div></div>';

		html += '<div class="cart-cell onetoonprice">' + price.toLocaleString() + ' 원</div>';
		html += '<input type="hidden" name="pricePerUnit" value="' + price + '">';

		html += '<div class="cart-cell quantityprice">' + sum.toLocaleString() + ' 원</div>';
		html += '<div class="cart-cell"><input type="checkbox" class="finalladd" data-idx="' + idx + '" ' + (item.selected ? 'checked' : '') + '></div>';

		row.innerHTML = html;
		cartItemsTbody.appendChild(row);
	});

	totalSumInput.value = totalSum.toLocaleString();
}

// 수량 변경 이벤트
cartItemsTbody.addEventListener("click", (e) => {
	if(e.target.classList.contains("pluss")) {
		const idx = e.target.getAttribute("data-idx");
		const action = e.target.getAttribute("data-action");
		if(action === "plus") {
			cart[idx].quantity = (cart[idx].quantity || 1) + 1;
		} else if(action === "minus" && cart[idx].quantity > 1) {
			cart[idx].quantity--;
		}
		localStorage.setItem("cart", JSON.stringify(cart));
		renderCart();
	}
});

// 체크박스 변경
cartItemsTbody.addEventListener("change", (e) => {
	if(e.target.classList.contains("finalladd")) {
		const idx = e.target.getAttribute("data-idx");
		cart[idx].selected = e.target.checked;
		localStorage.setItem("cart", JSON.stringify(cart));
	}
});




// 주의 해라
// 현재 모바일 태그 때문에  input  product_name  value 가 중복으로 2개가 들어가
// 밑에서 그걸 제거 한후 보내는 거다.
document.addEventListener("DOMContentLoaded", () => {
	const form = document.getElementById("forminfo");
	form.addEventListener("submit", (e) => {
		const selectedItems = cart.filter(item => item.selected);
		if (selectedItems.length === 0) {
			e.preventDefault(); // 폼 전송 막기
			alert("주문할 상품을 최소 한 개 이상 선택해주세요.");
			return false;
		}
		
		// 1️⃣ 기본 전송 막기
		e.preventDefault();

		const elements = [...form.elements];
		let seenInBlock = new Set();

		for (let i = 0; i < elements.length; i++) {
			const el = elements[i];
			const name = el.name;

			if (!name) continue;

			if (name === "cart_id") {
				// 새로운 블록 시작
				seenInBlock.clear();
				seenInBlock.add(name);
				continue;
			}

			if (seenInBlock.has(name)) {
				// 중복이면 제거
				el.remove();
			} else {
				seenInBlock.add(name);
			}
		}

		// 2️⃣ 제거 후 최종 폼 필드 로그 확인 (선택)
		console.log("=== [최종 전송 필드] ===");
		[...form.elements].forEach(el => console.log(el.name, el.value));

		// 3️⃣ 중복 제거된 상태 그대로 폼 전송
		form.submit();
		
		
	});
});



// 전체선택 / 해제 / 비우기
document.querySelector(".allchoicebtn").addEventListener("click", () => {
	cart.forEach(item => item.selected = true);
	localStorage.setItem("cart", JSON.stringify(cart));
	renderCart();
});

document.querySelector(".allclearbtn").addEventListener("click", () => {
	cart.forEach(item => item.selected = false);
	localStorage.setItem("cart", JSON.stringify(cart));
	renderCart();
});

document.querySelector(".dropcart").addEventListener("click", () => {
	if(confirm("장바구니를 비우시겠습니까?")) {
		cart = [];
		localStorage.removeItem("cart");
		renderCart();
	}
});
</script>

</body>
</html>
