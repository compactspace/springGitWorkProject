<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	
<!DOCTYPE html>
<html>
<sec:csrfMetaTags />
<head>
    <meta charset="UTF-8">
    <title>작품 상세</title>

    <!-- Summernote CSS/JS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script> 
    
    <style>
    .artworkContent-wrapper {
        max-width: 800px;
        margin: 40px auto;
        padding: 20px;       
    }

    /* Summernote 기본 에디터 크기 조절 */
    .note-editor.note-frame {
        border: none;
        background-color: transparent;
    }
    
    
    

    .note-editable {
        border-radius: 6px;
        padding: 20px;
        min-height: 700px !important;
        background-color: transparent !important;
        font-size: 16px;
        line-height: 1.6;
        color: #333;
    }



    
</style>
    
    
</head>
<body>


<%@ include file="../pcNave.jsp"%>
<%-- <h2>${artWorkDetail.title}</h2> --%>

<div class="artworkContent-wrapper">
<div id="artworkContent">${artWorkDetail.content}</div>
<div class="comment-fragment">
</div>
</div>

<script>
    $(document).ready(function () {
        $('#artworkContent').summernote({
            lang: 'ko-KR',
            toolbar: false,
            airMode: false,
            disableResizeEditor: true,
            height: 300,
            disableDragAndDrop: true,
            shortcuts: false,
            placeholder: '내용이 없습니다.',
            callbacks: {
                onInit: function () {
                    // 읽기 전용 설정
                    $('#artworkContent').next('.note-editor').find('.note-editable').attr('contenteditable', false);
                }
            }
        });        
        
        getMoreArtworkComment();     
        
        let data = ${listJson};
        console.log(data);
        
        
    });
    
    
    
    

 
 function getMoreArtworkComment(){
	  $.ajax({
      	url:"${pageContext.request.contextPath}/guest/artwork-comment",
      	type:"POST",
      	data:{test:"x"},
      	 success: function(responseHtml) {
      	        // 받아온 HTML을 .comment-fragment 내부에 삽입
      			$('.comment-fragment').append(responseHtml);
      	        
      	        
      	    }
      	
      })
	 
 }

</script>

</body>
</html>
