<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<sec:csrfMetaTags />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Summernote 테스트</title>


<!-- Summernote CSS -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.css"
	rel="stylesheet">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Summernote JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.js"></script>

<!-- Summernote 한국어 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>

<script>
        const token = $("meta[name='_csrf']").attr("content");
        const header = $("meta[name='_csrf_header']").attr("content");

        $.ajaxSetup({
            beforeSend: function(xhr) {
                xhr.setRequestHeader(header, token);
            }
        });
    </script>
<style>
body {
    padding: 20px;
    font-family: 'Segoe UI', sans-serif;
    background-color: #f9f9fb;
    color: #333;
}

h2 {
    color: #2c3e50;
}

#summernote {
    margin-top: 20px;
    border-radius: 5px;
}

.custom-save-button {
    display: inline-block;
    background-color: #3498db;
    color: white;
    padding: 10px 20px;
    border-radius: 6px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    font-weight: bold;
    margin-top: 20px;
}

.custom-save-button:hover {
    background-color: #2980b9;
}

/* ✅ 사진 영역 디자인 */
.draft-images {
    margin-top: 40px;
    padding: 20px;
    border: 1px solid #d0e6f7;
    background-color: #f4f9fd;
    border-left: 5px solid #3498db; /* 파랑 구분선 */
    border-radius: 8px;
}

.draft-images h3 {
    margin-bottom: 15px;
    color: #2980b9;
    font-size: 1.2em;
    border-bottom: 1px solid #d0e6f7;
    padding-bottom: 5px;
}

.draft-image-wrapper {
    display: inline-block;
    text-align: center;
    margin: 10px;
    background: #fff;
    border: 1px solid #dbeeff;
    padding: 10px;
    border-radius: 6px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    transition: box-shadow 0.3s;
}

.draft-image-wrapper:hover {
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}

.draft-images img.draft-image {
    max-width: 150px;
    height: auto;
    display: block;
    margin: 0 auto 10px;
    border-radius: 4px;
    border: 1px solid #ccc;
}

/* 삽입/삭제 버튼 스타일 */
.delete-draft-image,
.insert-draft-image,
.insert-rollback-draft-image {
    display: block;
    margin-top: 5px;
    font-size: 0.85em;
    cursor: pointer;
    padding: 5px 8px;
    border-radius: 4px;
    transition: background-color 0.2s;
    text-align: center;
}

.delete-draft-image {
    background-color: #ffdddd;
    color: #c0392b;
    border: 1px solid #e74c3c;
}

.delete-draft-image:hover {
    background-color: #e74c3c;
    color: #fff;
}

.insert-draft-image {
    background-color: #d0ecff;
    color: #2980b9;
    border: 1px solid #3498db;
}

.insert-draft-image:hover {
    background-color: #3498db;
    color: white;
}

.insert-rollback-draft-image {
    background-color: #ffe6e6;
    color: #e74c3c;
    border: 1px solid #e74c3c;
}

.insert-rollback-draft-image:hover {
    background-color: #e74c3c;
    color: white;
}


</style>
</head>
<body>


	<h2>작업물 등록 및 소개</h2>
	<span class="text-content-null" style="display: none;">작업물에 대한 소개 입력은 필수입니다.</span>


    <textarea id="summernote" name="content">
        <c:out value="${unfinishedDraftArtWorkText.content}" escapeXml="false" />
    </textarea>
    <br>
   <button id="submitBtn" type="button" class="custom-save-button">저장</button>



	<div class="draft-images">
		<h3>첨부된 이미지 <span id="current-uploadedcnt"></span><span class="draft-images-null" style="display: none">사진등록은 필수입니다.</span></h3>
		<c:if test="${not empty unfinishedDraftArtWorkImages}">
			<c:forEach var="img" items="${unfinishedDraftArtWorkImages}">
			<div class="draft-image-wrapper">
				<img class="draft-image"
					src="${pageContext.request.contextPath}/api/users/get-draft-image?folder=${img.file_url}&name=${img.file_name}"
					alt="Artwork Image" />
					<div class="delete-draft-image" data-folder=${img.file_url} data-name=${img.file_name}>삭제</div>
					<div class="insert-draft-image" data-url="${pageContext.request.contextPath}/api/users/get-draft-image?folder=${img.file_url}&name=${img.file_name}">삽입</div>
					<div class="insert-rollback-draft-image" style="display:none; cursor:pointer; color:red; font-size:0.9em; margin-top:5px;">삽입취소</div>
</div>
			</c:forEach>
		</c:if>
	</div>





	<script>
    let uploadedImages ="${unfinishedDraftArtWorkImages.size()}"||0;
	let insertedImageSet=new Set();
    let content=null;
    
    
$(document).ready(function() {
    let maxImages = 3;
    initUI();
    
    
    
    
    if(uploadedImages>0){
    	$("#current-uploadedcnt").text(uploadedImages);    	
    }
    
	console.log("uploadedImages: "+uploadedImages);    
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
        popover: {
            image: [] // ✅ 이 부분이 이미지 팝업 제거 핵심입니다.
        },
        callbacks: {
        	
            onImageUpload: function(files) {
                if (uploadedImages>=maxImages) {
                    alert("이미지는 최대 " + maxImages + "장까지만 업로드할 수 있습니다.");
                    return;
                }

                
                for (let i = 0; i < files.length; i++) {
                    uploadImage(files[i]);
                    uploadedImages++;  // 업로드 시 카운트 증가
                }
                $("#current-uploadedcnt").text(uploadedImages);
                console.log("uploadedImages: "+uploadedImages+"  files.length:"+ files.length);
                
                
            },
            
            onMediaDelete: function(target) {
            	console.log("target: "+target)
                uploadedImages--;  // 삭제 시 카운트 감소
            }
        }
    });
    
    
    
    
    $('#summernote').on('summernote.change', function(we, contents, $editable) {
        const currentImages = $($editable).find('img');

        insertedImageSet.forEach((url) => {
            const stillExists = currentImages.filter(function() {
                return $(this).attr('src') === url;
            }).length > 0;

            if (!stillExists) {
                console.log("이미 삭제된 이미지:", url);
                
                // 업로드 카운트 및 셋에서 제거
                insertedImageSet.delete(url);
                uploadedImages--;
                $("#current-uploadedcnt").text(uploadedImages);
             // 💡 버튼 UI 복원 - 문자열 결합 방식
                $(".insert-draft-image[data-url='" + url + "']").show();
                $(".insert-draft-image[data-url='" + url + "']")
                    .siblings(".insert-rollback-draft-image")
                    .hide();
                
            }
        });
    });   
    
    
    function uploadImage(file) {
        var data = new FormData();
        data.append("file", file);

        $.ajax({
            url: '${pageContext.request.contextPath}/api/users/uploadImage',
            type: 'POST',
            data: data,
            cache: false,
            contentType: false,
            processData: false,
            success: function(res) {
                if (res.success) {
                    var folder = res.folder;
                    var fileName = res.fileName;

                    var fullImageUrl = "${pageContext.request.contextPath}/api/users/get-draft-image?folder=" + folder + "&name=" + fileName;
                
                    console.log("fullImageUrl: "+fullImageUrl);                      
                    
                    const contextPath = '${pageContext.request.contextPath}';
                    // 2. draft-images 썸네일에 이미지 추가
                    
                    
                    
                 var imageWrapper =
    '<div class="draft-image-wrapper">' +
        '<img class="draft-image" src="' + fullImageUrl + '" alt="첨부 이미지" />' +
        '<div class="delete-draft-image" data-folder="' + folder + '" data-name="' + fileName + '">삭제</div>' +
        '<div class="insert-draft-image" data-url="' +contextPath + '/api/users/get-draft-image?folder=' + folder + '&name=' + fileName + '">삽입</div>' +
    	'<div class="insert-rollback-draft-image" style="display:none; cursor:pointer; color:red; font-size:0.9em; margin-top:5px;">삽입취소</div>'+
      '</div>';


                    $('.draft-images').append(imageWrapper);

                    
                    const eventHandler = eventResister();
                   
                    eventHandler.deleteEvent();
                	eventHandler.insertEvent(".draft-image-wrapper:last");           



                    
                    
                    
                    
                } else {
                    if (res.status === 500) {
                        alert("서버 오류로 이미지 업로드에 실패했습니다.");
                    } else {
                        alert("이미지 업로드에 실패했습니다.");
                    }
                }
            }
,
            error: function() {
                alert('이미지 업로드에 실패했습니다.');
            }
        });
    }   
    
    
    
    
    
    
});

function initUI() {
	
	const eventHandler = eventResister();
	eventHandler.contentWriteEvent();
	eventHandler.submitEvent();    	
    // uploadedImages가 하나 이상일 때만 이벤트 바인딩    
    if (uploadedImages > 0) {    	
    	eventHandler.deleteEvent();
    	eventHandler.insertEvent();
    	
    }
    
    
    
    
}

    
    
    function deleteImage(folder, name) {
        console.log("folder: " + folder + " name: " + name);

        $.ajax({
            url: '${pageContext.request.contextPath}/api/users/delete-draft-image',
            type: 'POST',
            data: {
                folder: folder,
                fileName: name
            },
            success: function(res) {
                // 성공 처리 (필요 시 구현)
            },
            error: function() {
                alert('이미지 업로드에 실패했습니다.');
            }
        });
    }
   
    
    function eventResister() {
        return {
            deleteEvent: function() {
                $(".draft-images .draft-image-wrapper:last .delete-draft-image").on("click", function () {
                    let folder = $(this).data("folder");
                    let name = $(this).data("name");
                    $(this).closest('.draft-image-wrapper').remove();
                    deleteImage(folder, name);
                    uploadedImages--;
                    $("#current-uploadedcnt").text(uploadedImages);
                });
            },
            
            
            
            
            insertEvent: function(last = '.draft-image-wrapper') {
                $(".draft-images " + last + " .insert-draft-image").on("click", function () {
                    const dbImage = $(this).data("url");
                    const $insertBtn = $(this);
                    const $rollbackBtn = $insertBtn.siblings(".insert-rollback-draft-image");

                    
                    if (insertedImageSet.has(dbImage)) return;                    
                    insertedImageSet.add(dbImage);
                    $(".draft-images-null").hide();
                    $('#summernote').summernote('insertImage', dbImage, function ($image) {
                        $image.attr('alt', '첨부 이미지');
                        $image.attr('draggable', false); // ✅ 드래그 비활성화
                        $insertBtn.hide();
                        $rollbackBtn.show();

                        $rollbackBtn.on('click', function () {
                            $image.remove();
                            $(this).hide();
                            $insertBtn.show();
                            insertedImageSet.delete(dbImage);
                        });
                    });
                });
            },
            
            
            contentWriteEvent: function() {
            
                $('#summernote').on('summernote.change', function(we, contents, $editable) {
                    content = contents;
                 /*    console.log("에디터 내용 변경됨:", content); */
                    $(".text-content-null").hide();
                });
            }

            ,        
            
            
            
            submitEvent: function() {
                $("#submitBtn").on("click", function() {
                    let handler = formFieldHandler(); // ✅ 함수 이름과 변수 이름 다르게
                    let fieldNull = handler.nullCheck();
                    if (!fieldNull) {
                        return;
                    }

                   
                    $.ajax({
                        url:  "${pageContext.request.contextPath}/api/users/draft-artwork-complete",
                        type: 'POST',
                        data: {
                            content: content
                        },
                        success: function(res) {
                          
                        },
                        error: function() {
                           
                        }
                    });
                    
                    
                    
                    
                });
            }
  
           	,
           	//에디터에 첨부된 사진을 벡스페이스 가시적으로 지우는 경우를 의함
           	deleteUIImage:function(){
           		
           		
           	}
           
            
            
            
            
        }
    }
    
    
  
   function formFieldHandler(){
	   
	   
	  return{
		  nullCheck:function(){
			  
			   let isNotNull=true;
			  
			   if(uploadedImages===0){
				   $(".draft-images-null").show();
				   alert("작업물 사진 등록은 필수입니다.")
				   isNotNull=false;
				   
			   }
			   if(content===null){
				   alert("작업물 소개 내용은 필수입니다.");
				   $(".text-content-null").show();
				   isNotNull=false;
				   
			   }			   
			   
			   return isNotNull;
		   }  
		  
		  
	  }
	   
	   
   }
    
    
    

</script>

</body>
</html>
