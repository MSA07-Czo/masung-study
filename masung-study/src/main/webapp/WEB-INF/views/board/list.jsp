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
	<jsp:include page="/WEB-INF/views/inc/header.jsp"></jsp:include>

	<h1>전체 게시글보기</h1>

	<div class="row content">
		<div class="col">
			<div class="card">
				<div class="card-body">
					<h3 class="card-title">검색</h3>
					<form action="/board/list" method="get" name="searchForm" id="searchForm">
						<input type="hidden" name="page" value=1>

						<div class="mb-3">
							<input type="checkbox" name="titleSearch" id="titleSearch"
								value="true" ${pageRequestDTO.titleSearch ? 'checked' : ''}>
							<label for="titleSearch">제목</label> 
							<input type="checkbox" name="writerSearch" id="writerSearch" 
								value="true" ${pageRequestDTO.writerSearch ? 'checked' : ''}> 
								<label for="writerSearch">작성자</label> 
							<input type="text" name="keyword" class="form-control" value='${pageRequestDTO.keyword}'>
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

	<div class="card-body">
		<h5 class="card-title">${pageResponseDTO.total}개의글</h5>

		<div class="mb-3">
			<form action="/board/list" method="get">
				<select name="size" id="size" onchange="this.form.submit()">
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
							href="read?board_number=${board.board_number}&${pageRequestDTO.link}">
								<c:if test="${board.parent_board_number != 0}">ㄴ</c:if>${board.board_title}</a></td>
						<td>${board.user_name}</td>
						<td>${board.board_reg_date}</td>
						<td>${board.board_viewcnt}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<jsp:include page="/WEB-INF/views/inc/page_nav.jsp"></jsp:include>

	<a href="register">등록</a>
<script>
const searchForm = document.getElementById("searchForm");
searchForm.addEventListener("reset", e => {
	e.preventDefault();
	e.stopPropagation();
	searchForm.size.value = 10;
	searchForm.titleSearch.checked = false;
	searchForm.writerSearch.checked = false;
	searchForm.keyword.value = "";
	searchForm.from.value = "";
	searchForm.to.value = "";
});
</script>
</body>
</html>
