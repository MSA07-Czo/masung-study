<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 목록</title>
    <style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f4f4f4;
        color: #000;
        margin: 0;
        padding: 0;
    }

    header {
        background-color: #000;
        color: white;
        text-align: center;
        padding: 1.5rem;
        font-size: 2rem;
    }

    .container {
        max-width: 1000px;
        margin: 3rem auto;
        background-color: white;
        padding: 2rem;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
    }

    h1 {
        font-size: 2rem;
        color: #000;
        text-align: center;
        margin-bottom: 1.5rem;
        font-weight: 600;
    }

    .card {
        border: none;
        margin-bottom: 1.5rem;
    }

    .card-body {
        padding: 0;
    }

    .btn-primary {
        padding: 0.8rem 1.6rem;
        background-color: #000;
        color: white;
        border: none;
        border-radius: 50px;
        font-size: 1rem;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .btn-primary:hover {
        background-color: #333;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 2rem;
        background-color: white;
    }

    th, td {
        padding: 1rem;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }

    th {
        background-color: #f7f7f7;
        font-weight: bold;
        color: #000;
    }

    td {
        color: #333;
    }

    td a {
        color: #000;
        text-decoration: none;
        font-weight: 500;
    }

    td a:hover {
        text-decoration: underline;
    }

    td form button {
        background-color: #000;
        color: white;
        border: none;
        padding: 0.5rem 1rem;
        border-radius: 50px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    td form button:hover {
        background-color: #333;
    }

    .pagination {
        display: flex;
        justify-content: center;
        list-style: none;
        padding: 0;
        margin: 2rem 0;
    }

	.pagination li {
        margin: 0 0.5rem;
    }
    
    .pagination input[type="submit"] {
        background-color: transparent;
        border: 1px solid black;
        color: black;
        padding: 0.5rem 1rem;
        font-size: 1rem;
        cursor: pointer;
        transition: background-color 0.3s ease, color 0.3s ease;
        border-radius: 5px;
    }
    
    .pagination input[type="submit"].active {
        background-color: black;
        color: white;
    }
    
	.pagination input[type="submit"]:hover {
        background-color: black;
        color: white;
    }

    .pagination a {
        background-color: transparent;
        border: 1px solid black;
        color: black;
        padding: 0.5rem 1rem;
        text-decoration: none;
        transition: background-color 0.3s ease, color 0.3s ease;
        border-radius: 5px;
    }

    .pagination a:hover {
        background-color: #000;
        color: white;
    }
    
    #page-prev,
    #page-next {
        visibility: hidden; /* instead of display: none */
    	position: absolute;
    }
    
    #page-prev + label,
    #page-next + label {
	    cursor: pointer;
	    display: inline-block;
	    vertical-align: bottom;
	    font-size: 1.5rem;
	    position: relative;
	    top: 5px;
    }
    
    #page-prev + label:hover,
	#page-next + label:hover {
	    color: #666666;
	}
    
    /* Remove bullet points and styling for older browsers */
    .pagination li::marker {
        content: none;
    }
	/* Ensure active and hover states are visually distinct */
    .pagination .active {
        background-color: black;
        color: white;
    }
    
    .pagination li.active input[type="submit"] {
        background-color: black;
        color: white;
        border-color: black;
    }

    @media (max-width: 768px) {
        table, th, td {
            font-size: 0.9rem;
        }

        .btn-primary {
            font-size: 0.9rem;
            padding: 0.7rem 1.4rem;
        }
    }

    @media (max-width: 480px) {
        .container {
            padding: 1.5rem;
        }

        table, th, td {
            font-size: 0.8rem;
        }
    }
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/inc/header.jsp" %>

<div class="container">
    <h1>회원 목록</h1>
    <div class="row content">
        <div class="col">
            <div class="card">
                <div class="card-body">
                    <!-- <h5 class="card-title">검색</h5> -->
                    <form action="/user/list" method="get" name="searchForm" id="searchForm">
                    	<input type="hidden" name="page" value=1>
                        <div class="mb-3">
                            <input type="text"  name="keyword" id="keyword" class="form-control" placeholder="검색" value ='${pageRequestDTO.keyword}' >
                        </div>
                        <div class="input-group">
                            <div class="float-end">
                                <button class="searchBtn" type="submit">검색</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

        </div>
    </div>
    
    
    <div class="card-body">
        <h5 class="card-title">회원 리스트</h5>
        <table class="table" id="userTable">
            <thead>
                <tr>
                    <th scope="col"></th>
                    <th scope="col">아이디</th>
                    <th scope="col">이름</th>
                    <th scope="col">이메일</th>
                    <th scope="col"></th>
                </tr>
            </thead>
            <tbody id="userTableBody">
                <c:forEach var="user" items="${pageResponseDTO.list}" varStatus="status">
                <tr>
                    <td>${(pageResponseDTO.page - 1) * pageResponseDTO.size + status.count}</td>
                    <td><a href="read?uid=${user.user_id}">${user.user_id}</a></td>
                    <td>${user.user_name}</td>
                    <td>${user.user_email}</td>
                    <td>
                        <form action="remove" method="get" onsubmit="return confirm('정말로 삭제하시겠습니까?');">
                            <input type="hidden" name="uid" value="${user.user_id}">
                            <button type="submit">삭제</button>
                        </form>
                    </td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <template id="userrow">
        	<tr>
        		<td></td>
        		<td><a href="read?uid=${user.user_id}"></a></td>
        		<td></td>
        		<td></td>
        		<td>
        			<form action="remove" method="post" onsubmit="return confirm('정말로 삭제하시겠습니까?');">
                        <input type="hidden" name="uid" value="${user.user_id}">
                        <button type="submit">삭제</button>
                    </form>
        		</td>
        	</tr>
        </template>
    </div>
    
    <div>
   		<form action="/user/list" method="get" name="pageForm" id="pageForm">
   		<input type="hidden" name="keyword" value='${pageRequestDTO.keyword}'>
   		<ul class="pagination">
			<c:if test="${pageResponseDTO.prev}">
				<li class="page-item">
					<input type="submit" class="page-link" id="page-prev" name="page" data-param="${pageRequestDTO.getParam(pageResponseDTO.begin-1)}" value="${pageResponseDTO.begin-1}">
					<label for="page-prev">◀︎</label>
				</li>
			</c:if>
	
			<c:forEach var="num" begin="${pageResponseDTO.begin}" end="${pageResponseDTO.end}">
				<li class="page-item ${pageResponseDTO.page == num ? 'active' : ''}">
					<input type="submit" class="page-link" name="page" data-param="${pageRequestDTO.getParam(num)}" value="${num}">
				</li>
			</c:forEach>
	
			<c:if test="${pageResponseDTO.next}">
				<li class="page-item">
					<input type="submit" class="page-link" id="page-next" name="page" data-param="${pageRequestDTO.getParam(pageResponseDTO.end+1)}" value="${pageResponseDTO.end+1}">
					<label for="page-next">▶︎</label>
				</li>
			</c:if>
		</ul>
		</form>
    	
<%--     	<template id="pagenav">		
			<c:if test="${pageResponseDTO.prev}">
				<li class="page-item">
				<a class="page-link" href="#;" data-param="${pageRequestDTO.getParam(pageResponseDTO.begin-1)}">이전</a></li>
			</c:if>
			<div id="page-number">
			<li><input type="submit" class="page-link" name="page"></li>
			</div>
			<c:if test="${pageResponseDTO.next}">
				<li class="page-item"><a class="page-link" href="#;"
					data-param="${pageRequestDTO.getParam(pageResponseDTO.end+1)}">다음</a></li>
			</c:if>

		</template> --%>
    </div>
</div>

<script>
	document.querySelector(".searchBtn").addEventListener("click", async e => {
		e.preventDefault();
		const response = await fetch("/search?keyword=" + keyword.value);
		const jsonData = await response.json();
		const list = jsonData.list;
		const userRow = document.querySelector("#userrow");
		
		const tbody = document.querySelector("tbody");
		tbody.innerHTML = "";
		
		for (let i=0; i<list.length; i++){
			const newRow = userRow.content.cloneNode(true);
			let td = newRow.querySelectorAll("td");
			let link = newRow.querySelector("td a");
			
			td[0].textContent = ${(pageResponseDTO.page - 1) * pageResponseDTO.size} + i + 1;
			link.textContent = list[i].user_id;
			link.href = "read?uid=" + list[i].user_id
			td[2].textContent = list[i].user_name;
			td[3].textContent = list[i].user_email;
			
			tbody.appendChild(newRow);
		}
	});
	
	document.querySelectorAll(".page-link").forEach(item => {
		item.addEventListener('click', async e => {
			e.preventDefault();
			e.stopPropagation();
			
			const param = e.target.getAttribute("data-param");
			console.log(param);
			const urlParams = new URLSearchParams(param);
			
			let page = urlParams.get("page");
			
			console.log(keyword.value)
			console.log(page)
			
			const response = await fetch("/pagination?keyowrd=" + keyword.value + "?page=" + page);
			const jsonData = await response.json();
			const list = jsonData.list;
			
			console.log(jsonData)

			const pageNav = document.querySelector("#pagenav div");
			const userRow = document.querySelector("#userrow");
			const tbody = document.querySelector("tbody");
			const ul = document.querySelector("ul");
			
			tbody.innerHTML = "";
			ul.innerHTML = "";
			console.log(ul);
			
			for (let i=0; i<list.length; i++){
				const newRow = userRow.content.cloneNode(true);
				let td = newRow.querySelectorAll("td");
				let link = newRow.querySelector("td a");
				
				td[0].textContent = ${(page-1) * pageResponseDTO.size} + i + 1;
				link.textContent = list[i].user_id;
				link.href = "read?uid=" + list[i].user_id
				td[2].textContent = list[i].user_name;
				td[3].textContent = list[i].user_email;
				
				tbody.appendChild(newRow);
			}
			
 			for (let i=jsonData.begin; i<=jsonData.end; i++) {
				const clone = pageNav.content.cloneNode(true);
				
				let li = clone.querySelector("li");
				let pageNum = clone.querySelector("li input");
				if (page === i) {
					li.setAttribute("class", "page-item active");
				} else {
					li.setAttribute("class", "page-item");
				}
				
				pageNum.setAttribute("data-param", "${pageRequestDTO.getParam(" + i + ")}");
				pageNum.setAttribute("value", i);
				
				
				pageNum.textContent = i;
				console.log(jsonData)

				
				ul.appendChild(clone);
			}
			
		})
	});
</script>

</body>
</html>