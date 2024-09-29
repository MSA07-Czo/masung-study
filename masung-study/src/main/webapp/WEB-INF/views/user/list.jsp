<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    
    <!-- <link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script> -->
    
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 목록</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f9;
            color: #333;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #007bff;
            color: white;
            text-align: center;
            padding: 1rem;
            font-size: 1.5rem;
        }

        .container {
            max-width: 1000px;
            margin: 3rem auto;
            background-color: white;
            padding: 2rem;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h1 {
            font-size: 2rem;
            color: #007bff;
            text-align: center;
            margin-bottom: 2rem;
        }

        .card-title {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 1rem;
        }
        
        .btn-primary {
            padding: 0.6rem 1.2rem;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 2rem;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 0.75rem;
            text-align: left;
        }

        th {
            background-color: #f8f9fa;
            color: #333;
            font-weight: bold;
        }

        td a {
            color: #007bff;
            text-decoration: none;
        }

        td a:hover {
            text-decoration: underline;
        }

        td form {
            display: inline-block;
        }

        td form button {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            cursor: pointer;
        }

        td form button:hover {
            background-color: #c82333;
        }

        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 2rem;
        }

        .pagination a {
            margin: 0 0.5rem;
            padding: 0.5rem 1rem;
            border: 1px solid #ddd;
            color: #007bff;
            text-decoration: none;
            border-radius: 4px;
        }

        .pagination a:hover {
            background-color: #007bff;
            color: white;
        }

        .pagination .active {
            background-color: #007bff;
            color: white;
            border: none;
        }

        @media (max-width: 768px) {
            table, th, td {
                font-size: 0.9rem;
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
                        <%-- <div class="mb-3">
                            <select name="size" id="size">
                            	<c:forTokens var="size" items="10,20,30,50,100" delims=",">
                            		<option value="${size}" ${pageRequestDTO.size == size ? 'selected' : '' }>${size}</option>
                            	</c:forTokens>
                            </select>
                        </div> --%>
                    	
                        <%-- <div class="mb-3">
                            <input type="checkbox" name="finished" id="finished" value="1" ${pageRequestDTO.finished ? 'checked' : '' }>완료여부
                        </div> --%>
                        <div class="mb-3">
                            <%-- <input type="checkbox" name="types" value="title"
                            	<c:forEach var="type" items="${pageRequestDTO.types}">${type == 'user_id' ? 'checked' : '' }</c:forEach>  
                            >아이디
                            <input type="checkbox" name="types" value="writer"
                            	<c:forEach var="type" items="${pageRequestDTO.types}">${type == 'user_email' ? 'checked' : '' }</c:forEach> 
                            >이메일 --%>
                            <input type="text"  name="keyword" class="form-control" placeholder="검색" value ='${pageRequestDTO.keyword}' >
                        </div>
                        <%-- <div class="input-group mb-3 dueDateDiv">
                            <input type="date" name="from" class="form-control" value="${pageRequestDTO.from}">
                            <input type="date" name="to" class="form-control"  value="${pageRequestDTO.to}">
                        </div> --%>
                        <div class="input-group">
                            <div class="float-end">
                                <button class="btn-primary" type="submit">검색</button>
                                <!-- <button class="btn btn-info clearBtn" type="reset">초기화</button> -->
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
            <tbody>
                <c:forEach var="user" items="${pageResponseDTO.list}" varStatus="status">
                <tr>
                    <td>${(pageResponseDTO.page - 1) * pageResponseDTO.size + status.count}</td>
                    <td><a href="read?uid=${user.user_id}">${user.user_id}</a></td>
                    <td>${user.user_name}</td>
                    <td>${user.user_email}</td>
                    <td>
                        <form action="remove" method="post" onsubmit="return confirm('Are you sure you want to remove this user?');">
                            <input type="hidden" name="uid" value="${user.user_id}">
                            <button type="submit">삭제</button>
                        </form>
                    </td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <jsp:include page="/WEB-INF/views/inc/page_nav.jsp"></jsp:include>
</div>

<script>
	const searchForm = document.getElementById("searchForm");
	searchForm.addEventListener("reset", e => {
		e.preventDefault();
		e.stopPropagation();
		searchForm.size.value = 10;
		/* searchForm.finished.checked = false; */
		searchForm.types.forEach(item => item.checked = false);
		searchForm.keyword.value = "";
		/* searchForm.from.value = "";
		searchForm.to.value = ""; */
	});
	
	
	/* document.querySelector("#...").addEventListner("submit", async e => {
		const response = await fetch("http://localhost:8090/serch?keyword=" + value);
		const jsonData = await response.json();
	}); */
</script>

</body>
</html>