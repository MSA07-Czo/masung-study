<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
	<h1>마성의 공부방</h1>
	
	<c:if test="${logininfo == null}" >
	    <a href="/login">로그인</a>
	</c:if>
	<c:if test="${logininfo != null}" >
	    <a href="/mypage">마이페이지</a>
        <a href="/logout"> 로그아웃</a>
	</c:if>
</body>
</html>


