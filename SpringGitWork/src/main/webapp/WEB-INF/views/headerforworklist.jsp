<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html>

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>index페이지</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Orbit&family=Sunflower:wght@300&display=swap"
	rel="stylesheet">
 <link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<style>
p {
	background-color: rgb(119, 193, 61) font-family: 'Sunflower', sans-serif;
}

#carousel {
	margin: 0 auto;
	/* 메인사진 주석처리 해가며 어느게 가장 이쁜지 비교해보자*/
/* 	background-image: url(./img/main.jpg); */
	background-image: url(./img/worklist.jpg);
	background-repeat: no-repeat;
	background-size: 1200px 500px;
	height: 500px;
}

* {
	margin: 0;
	padding: 0;
}

body {

	margin: 0 0 0 0px;
}

/* 배치도 생각으로 전체 wrapper 감싼후 마진 오토 */
#wrapper {
	max-width: 1020px;
	margin: 0 auto;
	padding: 0px;
}

header {
	position: relative;
	height: 70px;
	background: #fff;
	margin: 0;
}

#carousel {
	height: 450px;
	background-color: #BABABA;
	vertical-align: middle;
}

#carouselimg {
	text-align: center;
}

h2 {
	font-weight: 500;
	color: #333333;
	font-style: normal;
}

nav {
	position: absolute;
	top: 20px;
	width: 100%;
}

.myimg{
    background: transparent;
    font-size: 30px;
    border: none;

}


.myimg:focus{

  
    

}


.myimg:hover{

  background-color:black;
  color:white;	
      transition: 0.7s;

}

.gologin{

   font-size: 30px;
}
.gologin:hover{

  background-color:black;
  color:white;	
      transition: 0.7s;

}

.gologin:hover{

  background-color:black;
  color:white;	
      transition: 0.7s;

}





ul {
	display: flex;
	list-style-type: none;
}

li {
	display: inline-block;
	width: 30%;
	text-align: center;
	color: #333333;
	letter-spacing: .01em;
	font-style: normal;
	font-weight: 300;
}

a {
	text-decoration: none;
	color: #333333;
}

.article1 {
	background: #fff;
	height: 100%;
	margin: 0 auto;
	padding: 40px 0 40px;
}

#header1 {
	width: 100%;
	float: left;
	margin: 0px 0px 30px 50px;
	color: #333333;
}

p {
	display: block;
	width: 80%;
	margin: 0px 0px 0px 50px;
	font-weight: 300;
}

/* Section 2 */


#content1{
max-width: 1020px;
margin: 20px auto;
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


.Section2_2>.infoimg{
width:100%;
height:100%

}

.imgarea{
    background-size: 100% 100%;
background-repeat: no-repeat;
}


.titleinfo {
    font-size: 25px;
display:block;
	color: #333333;
}

.detailinof{
display:block
}

.btnarea{

}

.addbtn{
    color: #333333;
        font-weight: 500;
  border: 0;
  background-color: transparent;
  padding: 10px 0px;
   
       font-size: 18px;
display: block;
    margin-right: 0px;
    margin-left: auto;

   
   
/*     border: 1px solid #03c75a; */
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    border-radius: 3px;
}

}


#Section2_3 {
	float: right;
	margin: 0;
	width: 500px;
	overflow: hidden;
}

#info3 {
	width: 90%;
	float: left;
	margin: 0px 0px 30px 50px;
}



/* 미구현 footer영역 */
footer {
	text-align: center;
	display: block;
	height: 40px;
	background: #424141;
	margin: 20px 0 0 0;
	
	
}


/*  #modalContainer{
display:none
}  */
#modalContent{
display:none
}

#modalContent{

}

.imgs{
    position: absolute;
    right: 0px;     
    top: 25px;
    height:200px;
    width: 200px;
}

.alldivwrapper{
    width: 1200px;
    position: relative;
 
}

.imgdiv{
    padding-top: 150px;
}


#loginformwrapper{
    background-color: white;
    height: 1300px;
    width: 1200px;
    border: 1px solid #ddd;

    
}

.loginform{


    height: 900px;
    
}
.container{
    display: flex;
    flex-direction: column;
}

.passwordinput,.idinput{
background-color: rgb(232, 240, 254);
    border: none;
    border-bottom: 1px solid #bdbdbd;
  
    width: 100%;

    height: 50px;
}
h3{
    color: #797979;
}


.iddiv, .passworddiv{
    margin-left: auto;
    margin-right: auto;
    width: 95%;
 

    

}
textarea{
    width: 900px;
    height: 150px;
}
.passworddiv{
text-align: center;
}

.logindiv,.membershipdiv{
padding-top: 10px;
padding-bottom: 10px;
    margin-left: auto;
    margin-right: auto;
    width: 95%;
    height: 40px;
    border: none;
    background-color:#1a70dc;
    color: aliceblue;
    line-height: 35px;
}

.loginbtn{
padding-top: 10px;
padding-bottom: 50px;
    margin-left: auto;
    margin-right: auto;
    width: 95%;
    height: 40px;
    border: none;
    background-color:#1a70dc;
    color: aliceblue;
    line-height: 35px;
}





.login_membershipdivwrapper{
    text-align: center;
}

#examplecontainer{

}

#noimgitems{
width:350px;
 float: left;
 margin-right: 160px;
    margin-left: 140px;

}

#yesimgitems{
width:350px;
 float: left;

}

.yesorno{
width:400px;
height:600px;
}




.btnarea{
display:flex;
}

</style>

<script>

var media = window.matchMedia("screen and (max-width: 1026px)");






window.addEventListener("resize", function() {
	 if(media.matches){
		 console.log("900px 이하")
		 let selector=document.getElementsByClassName("Section2_2")
		 console.log(selector);
		 
		 
	 }else{
		 console.log("900px 이상")
	 }
		 
		 
		 
		 })




window.onload=function(){

	
	
	
	$(".myimg").click(function(){
		$("#modalContainer.hidden").css({"display":"block"})
		$("#modalContent").css({"display":"block"})
	$("#modalContainer.hidden").css({
		"position":"absolute" ,"top":"50%",
	　"left":"50%",
	　"transform": "translate(-50%,-50%)",
	　"background-color":"white",
	 "z-index": "100",
	 "width":"1200px",
	"height": "600px"
	})
		
	})
	
	$(".cancelimginsert").click(function(){
	console.log("dd");
	$("modalContent").css({"display":"none"})
	$("#modalContainer.hidden").css({"display":"none"})
	})
	

	//고객노출 시 품절로 할 함수
$(".productstatus").on("click",()=>{	
	let key=localStorage.getItem("key");
	let product_cod=$(".product_cod").val();
	
console.log($(this).parent());

	let product_status=$(".productstatus").val();
/* 	$.ajax({
		url:"statuschange.do?product_cod="+product_cod+"&product_status="+product_status,
		 beforeSend: function (xhr) {
	            xhr.setRequestHeader("Content-type","application/json");
	            xhr.setRequestHeader("Authorization","Bearer "+key);	         
	            },
		type:"get",
		success:(dtaa)=>{
			console.log(data)
			
		}//석세스 함수 종료
		
	})//아작수 함수 종료 */
	
	
	
	
})//클릭함수 종료	
	
	

	
	
	
}


</script>
</head>

