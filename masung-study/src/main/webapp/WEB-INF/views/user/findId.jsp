<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: #fff;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 400px;
            text-align: center;
        }

        h1 {
            color: #333;
            margin-bottom: 1rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
            text-align: left;
        }

        .form-group label {
            font-weight: bold;
            display: block;
            margin-bottom: 0.5rem;
        }

        .form-group input[type="text"] {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
        }

        input[type="submit"] {
            width: 100%;
            padding: 0.75rem;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .result-message {
            font-size: 1.2rem;
            color: #28a745;
            margin-top: 1rem;
        }

        .result-message a {
            color: #007bff;
            text-decoration: none;
        }

        .result-message a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>아이디 찾기</h1>
        
        <c:if test="${user_id == null}">
            <form action="findId" method="post">
                <div class="form-group">
                    <label for="user_name">이름</label>
                    <input type="text" name="user_name" id="user_name" placeholder="이름을 입력하세요">
                </div>
                <div class="form-group">
                    <label for="user_email">이메일</label>
                    <input type="text" name="user_email" id="user_email" placeholder="이메일을 입력하세요">
                </div>
                <div class="form-group">
                    <label for="user_phone">전화번호</label>
                    <input type="text" name="user_phone" id="user_phone" placeholder="전화번호를 입력하세요">
                </div>
                <input type="submit" value="아이디 찾기">
            </form>
        </c:if>

        <c:if test="${user_id != null}">
            <div class="result-message">
                당신의 아이디는 <strong>${user_id}</strong>입니다.<br>
                <a href="/user/login">로그인 하기</a>
            </div>
        </c:if>
    </div>
</body>
</html>