<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/WEB-INF/views/inc/header.jsp" %>

<h1>회원 상세보기</h1>
<div>
	<h3>
		<span>아이디 : </span>
		<span>${user.user_id}</span>
	</h3>
</div>
<div>
	<h3>
		<span>이름: </span>
		<span>${user.user_name}</span>
	</h3>
</div>

<a href="modify?uid=${param.uid}">수정</a>
<a href="remove?uid=${param.uid}">삭제</a>
<a href="javascript:history.go(-1)">뒤로가기</a>
</body>
</html>