<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<title>Home</title>

<style type="text/css">
	/* General styling for the page */
	body {
	    font-family: 'Arial', sans-serif;
	    background-color: #f4f4f4;
	    color: #333;
	    margin: 0;
	    padding: 0;
	    display: flex;
	    flex-direction: column;
	    align-items: center;
	}
	
	#header {
	    width: 100%;
	}
	
	h1 {
	    color: #222;
	    font-weight: 700;
	    text-align: center;
	    margin-top: 20px;
	    font-size: 3rem;
	    margin-top: 3rem;
	}
	
	.view-all {
		color: #888;
		font-size: 1.2rem;
		font-weight: 400;
	}
	
	.view-all:hover {
		color: #222;
		font-weight: 600;
	}
	
	/* Styling for links */
	a {
	    color: #000;
	    text-decoration: none;
	    transition: color 0.3s ease;
	}
	
	a:hover {
	    color: #555;
	}
	
	/* Table styling */
	table {
	    width: 100%;
	    margin-bottom: 40px;
	    border-collapse: collapse;
	    font-family: 'Roboto', sans-serif;
	}
	
	.table thead th {
	    background-color: #f5f5f5;
	    color: #222;
	    padding: 12px;
	    text-align: center;
	    border: none;
	    font-size: 1rem;
	    font-weight: bold;
	}
	
	.table tbody td {
	    padding: 12px;
	    text-align: center;
	    border-bottom: 1px solid #ddd; /* Light gray borders for subtlety */
	    font-size: 0.95rem;
	}
	
		/* Link Styling */
	.table tbody td a {
	    color: #333;
	    text-decoration: none;
	    font-weight: bold;
	}
	
	.table tbody td a:hover {
	    text-decoration: underline;
	}
	
	.table tbody tr:hover {
	    background-color: #f2f2f2; /* Slight background change on hover */
	}
	
	.inline-container {
	    display: flex;
	    justify-content: space-between; /* Add space between the divs */
	    gap: 2rem;
	    padding: 1rem;
	}
	
	/* Container styling */
	.card-body {
	    width: 90%;  /* Adjust width to fit both divs */
	    margin-right: 10px; /* Adds space between the divs */
	    background-color: #fff;
	    padding: 2rem;
	    margin-top: 1rem;
	    border-radius: 20px;
	    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
	    box-sizing: border-box;
	}
	
	.card-title {
	    font-family: 'Montserrat', sans-serif;
	    font-size: 1.5rem;
	    font-weight: bold;
	    margin-bottom: 15px;
	    text-align: center;
	    color: #333; /* Dark gray for elegance */
	}
	
	/* Adding responsiveness */
	@media (max-width: 768px) {
	    .inline-container {
	        flex-direction: column; /* Stacks cards vertically on smaller screens */
	    }
	
	    .card-body {
	        width: 100%; /* Full width for smaller screens */
	    }
	}
		
	/* Divider line */
	hr {
	    border: 1px solid #ddd;
	    width: 100%;
	    margin: 20px 0;
	}
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/inc/header.jsp"%>

	<h1>마성의 공부방</h1>
	<div >
		<a class="view-all" href="/board/list">> 더보기</a>
	</div>
		
	<div class="inline-container">
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
								href="board/read?board_number=${board.board_number}&${pageRequestDTO.link}">${board.board_title}</a></td>
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
								href="board/read?board_number=${board.board_number}&${pageRequestDTO.link}">${board.board_title}</a></td>
							<td>${board.user_name}</td>
							<td>${board.board_reg_date}</td>
							<td>${board.board_viewcnt}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>
