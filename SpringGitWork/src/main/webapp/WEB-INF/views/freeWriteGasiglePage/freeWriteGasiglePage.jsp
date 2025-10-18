<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Summernote 테스트</title>

    <!-- Summernote CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.css" rel="stylesheet">

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- Summernote JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.js"></script>

    <!-- Summernote 한국어 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>

    <style>
        body {
            padding: 20px;
            font-family: sans-serif;
        }
        #summernote {
            margin-top: 20px;
        }
    </style>
</head>
<body>

<h2>📝 글쓰기 에디터 예제</h2>

<form method="post" action="/submitContent">
    <textarea id="summernote" name="content"></textarea>
    <br>
    <button type="submit">저장</button>
</form>

<script>
$(document).ready(function() {
    $('#summernote').summernote({
        height: 300,
        lang: 'ko-KR',
        placeholder: '여기에 글을 작성하세요...',
        toolbar: [
            ['style', ['bold', 'italic', 'underline', 'clear']],
            ['font', ['strikethrough', 'superscript', 'subscript']],
            ['fontsize', ['fontsize']],
            ['color', ['color']],
            ['para', ['ul', 'ol', 'paragraph']],
            ['insert', ['picture']],  // 이미지 업로드 버튼
            ['height', ['height']]
        ],
        callbacks: {
            onImageUpload: function(files) {
                uploadImage(files[0]);
            }
        }
    });

    function uploadImage(file) {
        var data = new FormData();
        data.append("file", file);

        $.ajax({
            url: '/uploadImage',  // 서버 이미지 업로드 URL (스프링 컨트롤러 매핑)
            type: 'POST',
            data: data,
            cache: false,
            contentType: false,
            processData: false,
            success: function(url) {
                // 서버가 반환한 이미지 URL을 에디터에 삽입
                $('#summernote').summernote('insertImage', url);
            },
            error: function() {
                alert('이미지 업로드에 실패했습니다.');
            }
        });
    }
});
</script>

</body>
</html>
