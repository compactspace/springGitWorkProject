<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
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
    
</style>
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
    <c:when test="${empty searchyList}">
        <div class="no-result">검색 결과가 없습니다.</div>
    </c:when>
    <c:otherwise>
        <div class="artwork-list">
            <c:forEach var="artwork" items="${searchyList}">
                <div class="artwork-item" data-artworkid=${artwork.artwork_id}>
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
</div>

<div class="paging-render"></div>

</body>
</html>

