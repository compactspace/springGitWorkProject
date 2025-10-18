<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Orbit&family=Sunflower:wght@300&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
</head>

<style>

.fuck{
color:red;
}


</style>
<script>

window.onload=()=>{
	
	$(".btn").on("click",()=>{
		
		let str="<h1 class='fuck'>퍽퍽퍽</h2>"
		
		$.ajax({
			url:"dynamicTagtest.do",
			success:(data)=>{
				console.log(data)	
			/* 	$("#insertme").html(str); */
				$("#insertme2").html(data);
			
				}		
			
		})
		
		
		
		
		
		
		
		
		
	})
	
}

</script>

<body>
<h1 class="btn">
버튼
</h1>
<h2 id="insertme">
</h2>
<h1>jstl 돌림빵당하고 온뒤</h1>
<h2 id="insertme2">
</h2>


</body>
</html>