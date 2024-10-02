<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style type="text/css">
		.page-list.active {
			font-weight: bold;
			color: #007bff;
		}
	</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/header.jsp"></jsp:include>

	<h1>전체 게시글보기</h1>

	<div class="row content">
		<div class="col">
			<div class="card">
				<div class="card-body">
					<h3 class="card-title">검색</h3>
					<form id="searchForm">
						<input type="hidden" name="page" value=1>

						<div class="mb-3">
							<select id="searchType" name="searchType" class="form-select">
								<option value="title"
									${pageRequestDTO.searchType == 'title' ? 'selected' : ''}>제목</option>
								<option value="writer"
									${pageRequestDTO.searchType == 'writer' ? 'selected' : ''}>작성자</option>
								<option value="both"
									${pageRequestDTO.searchType == 'both' ? 'selected' : ''}>제목+작성자</option>
							</select> <input type="text" name="keyword" class="form-control"
								value="${pageRequestDTO.keyword}">
						</div>

						<div class="input-group mb-3 dueDateDiv">
							<input type="date" name="from" class="form-control"
								value="${not empty pageRequestDTO.from ? pageRequestDTO.from : ''}">
							<input type="date" name="to" class="form-control"
								value="${not empty pageRequestDTO.to ? pageRequestDTO.to : ''}">
						</div>
						<div class="input-group mb-3">
							<div>
								<button class="btn btn-primary" id="searchBtn" type="button">검색</button>
								<button class="btn btn-info clearBtn" id="resetBtn" type="reset">초기화</button>
							</div>
						</div>

						<div class="card-body">
							<h5 id="boardListTotal" class="card-title"></h5>
							<div class="mb-3">
								<select name="size" id="size"
									onchange="updatePageSize(this.value)">
									<c:forTokens var="size" items="10,15,20,30,50" delims=",">
										<option value="${size}"
											${pageRequestDTO.size == size ? 'selected' : ''}>${size}</option>
									</c:forTokens>
								</select>
							</div>
						</div>
					</form>
				</div>
			</div>

		</div>
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
		<tbody id="boardList">
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/inc/page_nav.jsp"></jsp:include>

	<template id="boardTemplate">
		<tr>
			<td class="board-number"></td>
			<td><a href="read?board_number=" class="board-title"></a></td>
			<td class="board-writer"></td>
			<td class="board-date"></td>
			<td class="board-viewcount"></td>
		</tr>
	</template>

	<a href="register">등록</a>

	<script>
const searchForm = document.getElementById("searchForm");

function performSearch(){
    const formData = new FormData(searchForm);
    const params = new URLSearchParams(formData).toString();
    
    fetch("/async/board/list?" + params)
        .then(response => response.json())
        .then(data => {
            updateBoardList(data.pageResponse);
            fetchPageData(getParam(1, data.pageRequest));
        })
        .catch(error => {
            console.error("비동기 처리 도중 오류발생:", error);
        });
}

function updatePageSize(size) {
    const formData = new FormData(searchForm);
    formData.set("size", size);
    const params = new URLSearchParams(formData).toString();
    
    fetch("/async/board/list?" + params.toString())
        .then(response => response.json())
        .then(data => {
            updateBoardList(data.pageResponse);
            fetchPageData(getParam(1, data.pageRequest));
        })
        .catch(error => {
            console.error("비동기 처리 도중 오류 발생:", error);
        });
}

function updateBoardList(data) {
	const template       = document.getElementById("boardTemplate");
    const boardList      = document.getElementById("boardList");
    const boardListTotal = document.getElementById("boardListTotal");
    
    boardListTotal.textContent = data.total +"개의글";
    boardList.innerHTML = "";
    
    if (data.list && data.list.length > 0) {
        data.list.forEach(board => {
            const clone = template.content.cloneNode(true);
            
            clone.querySelector('.board-number').textContent = board.board_number;
            clone.querySelector('.board-title').textContent = board.board_title;
            clone.querySelector('.board-title').href = "read?board_number=" + board.board_number;
            clone.querySelector('.board-writer').textContent = board.user_name;
            clone.querySelector('.board-date').textContent = board.board_reg_date;
            clone.querySelector('.board-viewcount').textContent = board.board_viewcnt;

            boardList.appendChild(clone);
        });
    } else {
        boardList.innerHTML = "<tr><td></td><td>검색 결과가 없습니다.</td></tr>";
    }
}

document.getElementById("searchBtn").addEventListener("click", e => {
	performSearch();
});

searchForm.addEventListener("submit", e => {
	e.preventDefault();
	e.stopPropagation();
	performSearch();
});

searchForm.addEventListener("reset", e => {
	e.preventDefault();
	e.stopPropagation();
	searchForm.searchType.value = "title";
	searchForm.keyword.value = "";
	searchForm.from.value = "";
	searchForm.to.value = "";
});
</script>
</body>
</html>