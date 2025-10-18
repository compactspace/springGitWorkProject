<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>내 정보</title>
<style>
h1 {
	text-align: center;
	font-weight: normal;
	color: #444;
	margin-bottom: 30px;
}

table {
	width: 100%;
	border-collapse: collapse;
	font-size: 14px;
}

th, td {
	padding: 10px 8px;
	border-bottom: 1px solid #ddd;
	text-align: left;
	vertical-align: middle;
}

th {
	background-color: #eee;
	width: 130px;
	font-weight: bold;
	color: #555;
}

tr:hover {
	background-color: #fafafa;
}
</style>
</head>
<body>
	<h1>내 정보</h1>
	<table>
		<tr>
			<th>아이디</th>
			<td>${myinfolist.id}</td>
		</tr>
		<tr>
			<th>이메일 주소</th>
			<td>${myinfolist.email != null && myinfolist.email != '' ? myinfolist.email : '미기입'}</td>
		</tr>
		<tr>
			<th>연락처</th>
			<td>${myinfolist.user_tell}</td>
		</tr>
		<tr>
			<th>가입일</th>
			<td>${myinfolist.create_signup}</td>
		</tr>
		<tr>
			<th>이름</th>
			<td>${myinfolist.user_name}</td>
		</tr>
		<tr>
			<th>주소</th>
			<td>${myinfolist.user_address != null ? myinfolist.user_address : '미기입'}</td>
		</tr>
		<tr>
			<th>유저 코드</th>
			<td>${myinfolist.user_code}</td>
		</tr>
		<tr>
			<th>유저 구분</th>
			<td>${myinfolist.user_where}</td>
		</tr>
	</table>
</body>
</html>
