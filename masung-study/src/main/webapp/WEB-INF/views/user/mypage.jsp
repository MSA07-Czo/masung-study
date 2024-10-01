<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 정보 상세</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f7f7f7;
            color: #333;
            margin: 0;
            padding: 0;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: #fff;
            max-width: 500px;
            margin: 2rem auto;
            padding: 2rem;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
        }

        h1 {
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
            color: #222222;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            font-size: 1rem;
            margin-bottom: 0.5rem;
            color: #333;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 0.75rem;
            font-size: 1rem;
            border: 1px solid #e0e0e0;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .form-group input[disabled] {
            background-color: #f9f9f9;
        }

        .password-group {
            display: flex;
            justify-content: space-between;
        }

        .password-group input {
            width: 100%;
        }

        .password-group button {
            width: 70px;
            padding: 0.75rem;
            font-size: 0.9rem;
            border: 1px solid #333;
            background-color: #fff;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .password-group button:hover {
            background-color: #f0f0f0;
        }

        .gender-group {
            display: flex;
            justify-content: left;
        }

        .gender-group button {
            width: 30%;
            padding: 0.75rem;
            font-size: 1rem;
            border: 1px solid #222;
            background-color: #fff;
            transition: background-color 0.3s ease;
        }

        .gender-group button.selected {
            background-color: #222;
            color: #fff;
        }

        .actions {
            text-align: center;
            margin-top: 1.5rem;
        }

        .actions button {
            padding: 0.75rem 1.5rem;
            font-size: 1rem;
            border: none;
            background-color: #222222;
            color: white;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .actions button:hover {
            background-color: #444444;
        }
        
        .remove {
        	text-align: center;
        	margin-top: 0.6rem;
        	font-size: 0.7rem;
        }
        
        .remove > a {
        	color: #aaaaaa;
        	text-decoration-line: none;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/inc/header.jsp"%>
<div class="container">
    <h1>회원 정보 상세</h1>

    <div class="form-group">
        <label for="id">아이디</label>
        <input type="text" id="id" value="${user.user_id}" disabled>
    </div>

    <div class="form-group">
        <label for="password">비밀번호</label>
        <div class="password-group">
            <input type="password" id="password" value="${user.user_pwd}" disabled>
        </div>
    </div>

    <div class="form-group">
        <label for="name">이름</label>
        <input type="text" id="name" value="${user.user_name}" disabled>
    </div>
    
    <div class="form-group">
        <label for="email">이메일</label>
        <input type="email" id="email" value="${user.user_email}" disabled>
    </div>

    <div class="form-group">
        <label for="phone">전화번호</label>
        <input type="text" id="phone" value="${user.user_phone}" disabled>
    </div>
    
    <div class="form-group">
        <label for="birth_date">생년월일</label>
        <input type="date" id="birth_date" value="${user.user_birth_date}" disabled>
    </div>

    <div class="form-group">
        <label>성별</label>
        <div class="gender-group">
            <button class="gender-button <c:if test='${user.user_gender == "M"}'>selected</c:if>">남성</button>
            <button class="gender-button <c:if test='${user.user_gender == "F"}'>selected</c:if>">여성</button>
        </div>
    </div>
    
    <div class="form-group">
        <label>직업</label>
        <div class="gender-group">
            <button class="gender-button <c:if test='${user.user_role == "student"}'>selected</c:if>">학생</button>
            <button class="gender-button <c:if test='${user.user_role == "teacher"}'>selected</c:if>">교수</button>
        </div>
    </div>
    
    <div>
    	<hr style="border:solid 0.01px #dddddd">
    </div>

    <div class="actions">
        <button type="button" onclick="location.href='/user/modify?uid=${user.user_id}'">수정하기</button>
    </div>
    
    <div class="remove">
    	<a href="/user/remove?uid=${user.user_id}">회원탈퇴</a>
    </div>

</div>

</body>
</html>