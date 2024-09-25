
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
	<title>Insert title here</title>
</head>
<body>
	<header>
	${loginInfo.user_id}
	<c:if test="${loginInfo == null}" >
	    <a href="/user/login">로그인</a>
	    <a href="/user/register">회원가입</a>
	</c:if>
	<c:if test="${loginInfo != null}" >
	    <c:choose>
	    	<c:when test="${loginInfo.user_role == '조교'}">
	    		<a href="/user/list">어드민</a>
	    	</c:when>
	    </c:choose>

	    <a href="/user/read?uid=${loginInfo.user_id}">마이페이지</a>
        <a href="/user/logout"> 로그아웃</a>
	</c:if>
	</header>
</body>
</html>


