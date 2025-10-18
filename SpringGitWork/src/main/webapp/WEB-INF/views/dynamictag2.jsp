<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
				$("#insertme").html(str);
			}
			
			
		})
		
		
		
		
		
		
		
		
		
	})
	
}

</script>

<body>
<c:forEach var="p" items="${list}" varStatus="i">
<h1>애초에 jstl을 돌리고 온거임 ${p} </h1>
</c:forEach>


</body>
</html>