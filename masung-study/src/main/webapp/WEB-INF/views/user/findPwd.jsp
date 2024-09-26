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
비밀번호찾기
<c:if test="${user_pwd == null}">
	<form action="findPwd" method="post">
		<div>
			<span>아이디: </span>
			<input type="text" name="user_id" id="user_id">
		</div>
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
		<div>
			<span>생년월일: </span>
			<input type="date" name="user_birth_date" id="user_birth_date">
		</div>
		<input type="submit" value="비밀번호 찾기">
	</form>
</c:if>

<c:if test="${user_pwd != null}">
	비밀번호는 ${user_pwd}입니다.
	<a href="/user/login">로그인 하기</a>
</c:if>
</body>
</html>