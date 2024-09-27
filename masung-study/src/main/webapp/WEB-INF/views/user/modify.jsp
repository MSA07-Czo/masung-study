<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 수정</title>
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
            max-width: 800px;
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

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group h3 {
            font-size: 1.1rem;
            margin-bottom: 0.5rem;
        }

        .form-group input[type="text"],
        .form-group input[type="password"],
        .form-group input[type="email"],
        .form-group input[type="date"] {
            width: calc(100% - 1rem);
            padding: 0.75rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1rem;
        }

        .radio-group {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .radio-group input {
            margin-right: 0.5rem;
        }

        .radio-group label {
            font-size: 1rem;
        }

        input[type="submit"] {
            width: 100%;
            background-color: #007bff;
            color: white;
            border: none;
            padding: 0.75rem;
            font-size: 1.1rem;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        @media (max-width: 600px) {
            .container {
                padding: 1.5rem;
            }

            h1 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/inc/header.jsp" %>

<div class="container">
    <h1>회원 수정 화면</h1>
    <form action="modify" method="post">
        <div class="form-group">
            <h3>아이디:</h3>
            <input type="text" name="user_id" value="${user.user_id}" readonly="readonly">
        </div>

        <div class="form-group">
            <h3>비밀번호:</h3>
            <input type="password" name="user_pwd" value="${user.user_pwd}">
        </div>

        <div class="form-group">
            <h3>이름:</h3>
            <input type="text" name="user_name" value="${user.user_name}">
        </div>

        <div class="form-group">
            <h3>이메일:</h3>
            <input type="email" name="user_email" value="${user.user_email}">
        </div>

        <div class="form-group">
            <h3>전화번호:</h3>
            <input type="text" name="user_phone" value="${user.user_phone}">
        </div>

        <div class="form-group">
            <h3>생년월일:</h3>
            <input type="date" name="user_birth_date" value="${user.user_birth_date}">
        </div>

        <div class="form-group">
            <h3>성별:</h3>
            <div class="radio-group">
                <input type="radio" name="user_gender" id="male" value="M" <c:if test="${user.user_gender == 'M'}">checked</c:if>>
                <label for="male">남성</label>

                <input type="radio" name="user_gender" id="female" value="F" <c:if test="${user.user_gender == 'F'}">checked</c:if>>
                <label for="female">여성</label>
            </div>
        </div>

        <div class="form-group">
            <h3>역할:</h3>
            <div class="radio-group">
                <input type="radio" name="user_role" id="student" value="student" <c:if test="${user.user_role == 'student'}">checked</c:if>>
                <label for="student">학생</label>

                <input type="radio" name="user_role" id="teacher" value="teacher" <c:if test="${user.user_role == 'teacher'}">checked</c:if>>
                <label for="teacher">교수</label>
            </div>
        </div>

        <input type="submit" value="수정">
    </form>
</div>

</body>
</html>