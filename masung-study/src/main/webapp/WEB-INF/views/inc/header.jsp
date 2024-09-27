<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Header Design</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 2rem;
            background-color: #007bff;
            color: white;
        }

        header .logo a{
            font-size: 1.5rem;
            font-weight: bold;
            text-decoration: none;
            color: white;
        }

        header nav a {
            margin-left: 1rem;
            color: white;
            text-decoration: none;
            font-size: 1rem;
            transition: color 0.3s ease;
        }

        header nav a:hover {
            color: #ffcc00;
        }

        .user-info {
            display: flex;
            align-items: center;
        }

        .user-info span {
            margin-right: 1rem;
            font-weight: bold;
        }

        .login-info {
            margin-right: 1rem;
            display: flex;
            align-items: center;
        }

        .login-info a {
            margin-left: 1rem;
        }

        .btn {
            padding: 0.5rem 1rem;
            background-color: #ffcc00;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            color: #007bff;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #ffaa00;
        }

    </style>
</head>
<body>

    <header>
        <div class="logo">
        	<a href="/">HOME</a>
        </div>
        <nav class="user-info">
            <c:if test="${loginInfo == null}">
                <a href="/user/login">로그인</a>
                <a href="/user/register">회원가입</a>
            </c:if>

            <c:if test="${loginInfo != null}">
                <div class="login-info">
                    <span>${loginInfo.user_id} 님</span>
                    <a href="/user/read?uid=${loginInfo.user_id}">마이페이지</a>
                    <c:choose>
                        <c:when test="${loginInfo.user_role == 'teacher'}">
                            <a href="/user/list">어드민</a>
                        </c:when>
                    </c:choose>
                    <a href="/user/logout">로그아웃</a>
                </div>
            </c:if>
        </nav>
    </header>

</body>
</html>