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
    <div class="card-body">
        <h5 class="card-title">회원 리스트</h5>
        <table class="table">
            <thead>
                <tr>
                    <th scope="col">번호</th>
                    <th scope="col">아이디</th>
                    <th scope="col">이름</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="user" items="${pageResponseDTO.list}" varStatus="status">
                <tr>
                    <td>${(pageResponseDTO.page - 1) * pageResponseDTO.size + status.count}</td>
                    <td><a href="read?uid=${user.user_id}">${user.user_id}</a></td>
                    <td>${user.user_name}</td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <jsp:include page="/WEB-INF/views/inc/page_nav.jsp"></jsp:include>
</div>

</body>
</html>