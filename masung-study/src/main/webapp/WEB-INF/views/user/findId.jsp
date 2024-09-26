<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
아이디찾기
<c:if test="${user_id == null}">
	<form action="findId" method="post">
		<div>
			<span>이름: </span>
			<input type="text" name="user_name" id="user_name">
		</div>
		<div>
			<span>이메일: </span>
			<input type="text" name="user_email" id="user_email">
		</div>
		<div>
			<span>전화번호: </span>
			<input type="text" name="user_phone" id="user_phone">
		</div>
		<input type="submit" value="아이디 찾기">
	</form>
</c:if>

<c:if test="${user_id != null}">
	당신의 아이디는 ${user_id}입니다.
	<a href="/user/login">로그인 하기</a>
</c:if>
</body>
</html>