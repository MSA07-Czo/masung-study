<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 상세보기</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
            color: #333;
        }

        header {
            background-color: #007bff;
            padding: 1rem;
            color: white;
            text-align: center;
            font-size: 1.5rem;
        }

        .container {
            max-width: 800px;
            margin: 2rem auto;
            background-color: white;
            padding: 2rem;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h1 {
            font-size: 2rem;
            margin-bottom: 1.5rem;
            text-align: center;
            color: #007bff;
        }

        .info-group {
            margin-bottom: 1.5rem;
        }

        .info-group h3 {
            display: flex;
            justify-content: space-between;
            font-size: 1.1rem;
            margin: 0;
            padding: 0.5rem 0;
            border-bottom: 1px solid #ddd;
        }

        .info-group span {
            font-weight: bold;
        }

        .actions {
            display: flex;
            justify-content: center;
            margin-top: 2rem;
        }

        .actions a {
            margin: 0 1rem;
            padding: 0.5rem 1.5rem;
            text-decoration: none;
            color: white;
            background-color: #007bff;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .actions a:hover {
            background-color: #0056b3;
        }

        .back-button {
            margin-top: 1.5rem;
            text-align: center;
        }

        .back-button a {
            text-decoration: none;
            color: #007bff;
        }

        .back-button a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/inc/header.jsp" %>

<div class="container">
    <h1>${user.user_name}님 반갑습니다.</h1>

    <div class="info-group">
        <h3>
            <span>아이디 :</span>
            <span>${user.user_id}</span>
        </h3>
    </div>

    <div class="info-group">
        <h3>
            <span>이름 :</span>
            <span>${user.user_name}</span>
        </h3>
    </div>

    <div class="info-group">
        <h3>
            <span>이메일 :</span>
            <span>${user.user_email}</span>
        </h3>
    </div>

    <div class="info-group">
        <h3>
            <span>전화번호 :</span>
            <span>${user.user_phone}</span>
        </h3>
    </div>

    <div class="info-group">
        <h3>
            <span>생년월일 :</span>
            <span>${user.user_birth_date}</span>
        </h3>
    </div>

    <div class="info-group">
        <h3>
            <span>성별 :</span>
            <c:if test="${user.user_gender == 'M'}">
                <span>남성</span>
            </c:if>
            <c:if test="${user.user_gender == 'F'}">
                <span>여성</span>
            </c:if>
        </h3>
    </div>

    <div class="info-group">
        <h3>
            <span>역할 :</span>
            <c:if test="${user.user_role == 'student'}">
                <span>학생</span>
            </c:if>
            <c:if test="${user.user_role == 'teacher'}">
                <span>교수</span>
            </c:if>
        </h3>
    </div>

    <div class="actions">
        <a href="modify?uid=${param.uid}">수정</a>
        <a href="remove?uid=${param.uid}">삭제</a>
    </div>

    <div class="back-button">
        <a href="javascript:history.go(-1)">뒤로가기</a>
    </div>
</div>

</body>
</html>