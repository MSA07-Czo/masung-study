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
	    <a href="/user/login">로그인</a>
	    <a href="/user/register">회원가입</a>
	   <!-- 나중에 빼야 함  -->    <a href="/user/list">어드민</a>	<!-- 나중에 빼야 함  -->
	</c:if>
	<c:if test="${logininfo != null}" >
	    <c:choose>
	    	<c:when test="${loginifno.user_role == '조교'}">
	    		<a href="/user/list">어드민</a>
	    	</c:when>
	    </c:choose>

	    <a href="/user/mypage">마이페이지</a>
        <a href="/logout"> 로그아웃</a>
	</c:if>
	
	<div class="card-body" >
		<h5 class="card-title">Special Title ...</h5>
		<table class="table" style="100%">
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">제목</th>
					<th scope="col">작성자</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="question" items="${pageResponseDTO.list}">
				<tr>
					<td>${question.board_number}</td>
					<td><a href="read?id=${question.board_number}&${question.link}">${question.board_title}</a></td>
					<td>${question.user_id}</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<div class="card-body" >
		<h5 class="card-title">Special Title ...</h5>
		<table class="table" style="100%">
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">제목</th>
					<th scope="col">작성자</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="answer" items="${pageResponseDTO.list}">
				<tr>
					<td>${answer.board_number}</td>
					<td><a href="read?id=${answer.board_number}&${answer.link}">${answer.board_title}</a></td>
					<td>${answer.user_id}</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
 
 </body>
</html>


