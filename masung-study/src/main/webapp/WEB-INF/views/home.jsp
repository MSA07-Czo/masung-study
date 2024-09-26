<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<title>Home</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/inc/header.jsp"%>

	<h1>마성의 공부방</h1>
	<div class="card-body">
		<h2 class="card-title">좋아요 TOP 10</h2>
		<table class="table" style="">
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">작성일자</th>
					<th scope="col">조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="board" items="${topGoodList.list}">
					<tr>
						<td>${board.board_number}</td>
						<td><a
							href="read?board_number=${board.board_number}&${pageRequestDTO.link}">${board.board_title}</a></td>
						<td>${board.user_name}</td>
						<td>${board.board_reg_date}</td>
						<td>${board.board_viewcnt}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<div class="card-body">
		<h2 class="card-title">조회수 TOP 10</h2>
		<table class="table" style="">
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">작성일자</th>
					<th scope="col">조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="board" items="${topViewList.list}">
					<tr>
						<td>${board.board_number}</td>
						<td><a
							href="read?board_number=${board.board_number}&${pageRequestDTO.link}">${board.board_title}</a></td>
						<td>${board.user_name}</td>
						<td>${board.board_reg_date}</td>
						<td>${board.board_viewcnt}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

</body>
</html>
