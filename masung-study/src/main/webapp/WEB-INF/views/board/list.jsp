<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${not empty loginInfo}">
		<a href="/user/logout">${loginInfo.name}</a>
	</c:if>


	<h1>전체 게시글보기</h1>
	<!--  
	<div class="row content">
		<div class="col">
			<div class="card">
				<div class="card-body">
					<h5 class="card-title">검색</h5>
					<form action="/board/list" method="get" name="searchForm"
						id="searchForm">
						<input type="hidden" name="page" value=1>

						<div class="mb-3">
							<input type="checkbox" name="types" value="title"
								<c:forEach var="type" items="${pageRequestDTO.types}">${type == 'title' ? 'checked' : '' }</c:forEach>>제목
							<input type="checkbox" name="types" value="writer"
								<c:forEach var="type" items="${pageRequestDTO.types}">${type == 'writer' ? 'checked' : '' }</c:forEach>>작성자
							<input type="text" name="keyword" class="form-control"
								value='${pageRequestDTO.keyword}'>
						</div>
						<div class="input-group mb-3 dueDateDiv">
							<input type="date" name="from" class="form-control"
								value="${pageRequestDTO.from}"> <input type="date"
								name="to" class="form-control" value="${pageRequestDTO.to}">
						</div>
						<div class="input-group mb-3">
							<div class="float-end">
								<button class="btn btn-primary" type="submit">검색</button>
								<button class="btn btn-info clearBtn" type="reset">초기화</button>
							</div>
						</div>
					</form>
				</div>
			</div>

		</div>
	</div>
	-->
	<div class="card-body">
		<h5 class="card-title">${pageResponseDTO.total}개의글</h5>

		<div class="mb-3">
			<form action="/board/list" method="get" name="searchForm"
				id="searchForm">
				<select name="size" id="size">
					<c:forTokens var="size" items="10,15,20,30,50" delims=",">
						<option value="${size}"
							${pageRequestDTO.size == size ? 'selected' : '' }>${size}</option>
					</c:forTokens>
				</select>
			</form>
		</div>

		<table class="table">
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
				<c:forEach var="board" items="${pageResponseDTO.list}">
					<tr>
						<td>${board.board_number}</td>
						<td><a
							href="read?id=${board.board_number}&${pageRequestDTO.link}">${board.board_title}</a></td>
						<td>${board.user_id}</td>
						<td>${board.board_reg_date}</td>
						<td>${board.board_viewcnt}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<jsp:include page="/WEB-INF/views/inc/page_nav.jsp"></jsp:include>

	<a href="register">등록</a>

</body>
</html>
