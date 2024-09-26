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
<%@ include file="/WEB-INF/views/inc/header.jsp" %>
<h1>회원 수정 화면 </h1>
<form action="modify" method="post">
	<div>
		<h3>
			<span>아이디 : </span>
			<input type="text" name="user_id" value="${user.user_id}" readonly="readonly">
		</h3>
	</div>
	<div>
		<h3>
			<span>비번: </span>
			<input type="password" name="user_pwd" value="${user.user_pwd}" >
		</h3>
	</div>
	<div>
		<h3>
			<span>이름: </span>
			<input type="text" name="user_name" value="${user.user_name}" >
		</h3>
	</div>
	<div>
		<h3>
			<span>이메일: </span>
			<input type="text" name="user_email" value="${user.user_email}" >
		</h3>
	</div>
	<div>
		<h3>
			<span>전화번호: </span>
			<input type="text" name="user_phone" value="${user.user_phone}" >
		</h3>
	</div>
	<div>
		<h3>
			<span>생년월일: </span>
			<input type="date" name="user_birth_date" value="${user.user_birth_date}" >
		</h3>
	</div>
	<div >
		<label class="label" >성별: </label>
        <input type="radio" name="user_gender" id="male" value="M" 
        	<c:if test="${user.user_gender == 'M'}">checked</c:if>
        > <label for="male">남성</label>
        <input type="radio" name="user_gender" id="female" value="F"
        	<c:if test="${user.user_gender == 'F'}">checked</c:if>
        > <label for="female">여성</label>
	</div>
	<div >
		<label class="label" >??: </label>
        <input type="radio" name="user_role" id="student" value="student" 
        	<c:if test="${user.user_role == 'student'}">checked</c:if>
        > <label for="student">학생</label>
        <input type="radio" name="user_role" id="student" value="teacher"
        	<c:if test="${user.user_role == 'teacher'}">checked</c:if>
        > <label for="teacher">교수</label>
	</div>
	
	<input type="submit" value="수정">
</form>
</body>
</html>