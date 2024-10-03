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
		
		/* General body styling */
		body {
		    font-family: 'Roboto', sans-serif;
		    margin: 0;
		    padding: 0;
		    background-color: #f4f4f9;
		    color: #333;
		    font-size: 16px;
		}
		
		/* Header Styling */
		header {
		    background-color: #333;
		    color: #fff;
		    padding: 20px;
		    text-align: center;
		    font-size: 24px;
		}
		
		/* Title styling */
		h1 {
		    text-align: center;
		    margin-top: 20px;
		    font-size: 2rem;
		    font-weight: bold;
		    color: #333;
		}
		
		/* Form Card Styling */
		.card {
		    margin: 20px auto;
		    background-color: white;
		    padding: 1rem 2rem;
		    border-radius: 10px;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Soft shadow for modern feel */
		    max-width: 700px;
		    width: 100%;
		}
		
		h3.card-title {
	        text-align: left;
	        font-weight: bold;
	        margin-bottom: 1rem;
	    }
		
		/* Form Styling */
		form {
		    display: flex;
		    flex-direction: column;
		    gap: 1rem;
		}
		
		.form-select {
		    flex-grow: 1;
		    max-width: 10%;
		    margin-bottom: 1rem;
		    
		}
		
		.form-control {
			height: 2rem;
			font-size: 0.9rem;
		}
		
		input[type="text"], input[type="date"], select {
		    width: 100%;
		    padding: 10px;
		    border: 1px solid #ddd;
		    border-radius: 5px;
		    box-sizing: border-box;
		}
		
		button {
		    padding: 10px 20px;
		    border: none;
		    border-radius: 5px;
		    cursor: pointer;
		    font-weight: bold;
		    transition: background-color 0.3s ease;
		}
		
		/* Primary button styling */
		.btn-primary {
		    background-color: #333;
		    color: white;
		}
		
		.btn-primary:hover {
		    background-color: #555;
		}
		
		/* Info button styling */
		.btn-info {
		    background-color: #666;
		    color: white;
		}
		
		.btn-info:hover {
		    background-color: #888;
		}
		
		/* Search box button group */
		.input-group {
		    display: flex;
		    gap: 10px;
		}
		
		/* Responsive table styling */
		.table {
		    width: 80%;
		    margin: 20px auto;
		    border-collapse: collapse;
		    background-color: #fff;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		    border-radius: 10px;
		    overflow: hidden;
		}
		
		/* Table headers */
		.table thead th {
		    background-color: #f5f5f5;
		    color: #222;
		    font-weight: bold;
		    padding: 10px;
		    text-align: center;
		}
		
		/* Table cells */
		.table tbody td {
		    padding: 12px;
		    text-align: center;
		    border-bottom: 1px solid #ddd;
		    color: #333;
		}
		
		/* Row hover effect */
		.table tbody tr:hover {
		    background-color: #f2f2f2;
		}
		
		/* Template table row styling */
		.table tbody tr:last-child td {
		    border-bottom: none;
		}
		
		/* Pagination links */
		.pagination {
		    display: flex;
		    justify-content: center;
		    margin-top: 20px;
		}
		
		.pagination a {
		    margin: 0 5px;
		    padding: 10px 15px;
		    background-color: #333;
		    color: white;
		    border-radius: 5px;
		    text-decoration: none;
		    transition: background-color 0.3s ease;
		}
		
		.pagination a:hover {
		    background-color: #555;
		}
		
		/* Additional board info styling */
		#boardListTotal {
		    font-size: 1rem;
		    text-align: right;
		    font-weight: 100;
		    margin: 1rem;
		    font-color: #666;
		}
		
		/* Responsive layout for smaller screens */
		@media (max-width: 768px) {
		    .card {
		        width: 90%;
		    }
		
		    .table {
		        width: 100%;
		    }
		}
		
		#size {
			display: inline;
			width: 10%;
			
		}
		
		div > span {
			font-size: 0.8rem;
			color: #777;
			font-weight: 400;
			position: relative;
			top: 4px;
		}
 		
		.register {
			display: block;
		}
		
		p > a {
			font-size: 1rem;
			margin-left: 83.5%;
			margin-bottom: 10rem;
			text-decoration: none;
			color: #555;
			font-weight: 600;
			border: solid 0.9px;
			border-color: #555;
			border-radius: 15px;
			padding: 0.5rem 1rem;
		}
		
		p > a:hover {
			color: white;
			background-color: #222;
			transition: 0.3 ease;
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
							<span>FROM</span>
							<input type="date" name="from" class="form-control"
								value="${not empty pageRequestDTO.from ? pageRequestDTO.from : ''}">
							<span>TO</span>
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
							<div class="mb-3">
								<select name="size" id="size"
									onchange="updatePageSize(this.value)">
									<c:forTokens var="size" items="10,15,20,30,50" delims=",">
										<option value="${size}"
											${pageRequestDTO.size == size ? 'selected' : ''}>${size}</option>
									</c:forTokens>
								</select>
							</div>
							
							<h5 id="boardListTotal" class="card-title"></h5>
						</div>
					</form>
				</div>
			</div>

		</div>
	</div>

	<p class="register">
		<a href="register">글쓰기</a>
	</p>
	
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
    
    boardListTotal.textContent = data.total + "개의 글";
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