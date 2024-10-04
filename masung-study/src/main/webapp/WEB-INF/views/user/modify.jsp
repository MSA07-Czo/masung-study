<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 정보 수정</title>
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
        
        .select-group {
            display: flex;
            justify-content: left;
        }
        
        input[type="radio"] {
            display: none;
        }
        
        input[type="radio"]:checked + label {
            background-color: #333;
            color: white;
        }
        
        .select-group label {
            padding: 0.75rem;
            border: 1px solid #222;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
            display: inline-block;
            width: 25%;
            text-align: center;
            background-color: white;
            color: #222;
        }
        
        /* Rounded border on the leftmost and rightmost labels */
        label:first-of-type {
            border-radius: 5px 0 0 5px;
        }

        label:last-of-type {
            border-radius: 0 5px 5px 0;
        }

        /* Optional styling for text */
        .label-text {
            margin-bottom: 10px;
            font-weight: bold;
        }
        
        /* Hover effect: when hovering over a non-selected label */
        input[type="radio"]:not(:checked) + label:hover {
            background-color: #333;
            color: white;
        }

        /* Ensure the checked label turns white when hovering over an unchecked label */
        input[type="radio"]:not(:checked) + label:hover ~ input[type="radio"]:checked + label {
            background-color: white;
            color: black;
        }

        .actions {
            text-align: center;
            margin-top: 1.5rem;
        }

        .actions input {
            padding: 0.75rem 1.5rem;
            font-size: 1rem;
            border: none;
            background-color: #222222;
            color: white;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .actions input:hover {
            background-color: #444444;
        }
        
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/inc/header.jsp"%>
<div class="container">
    <h1>회원 정보 수정</h1>
	<form action="modify" method="post">
	    <div class="form-group">
	        <label for="id">아이디</label>
	        <input type="text" id="id" name="user_id" value="${user.user_id}">
	    </div>
	
	    <div class="form-group">
	        <label for="password">비밀번호</label>
	        <div class="password-group">
	            <input type="password" id="password" name="user_pwd" value="${user.user_pwd}">
	        </div>
	    </div>
	
	    <div class="form-group">
	        <label for="name">이름</label>
	        <input type="text" id="name" name="user_name" value="${user.user_name}">
	    </div>
	    
	    <div class="form-group">
	        <label for="email">이메일</label>
	        <input type="email" id="email" name="user_email" value="${user.user_email}">
	    </div>
	
	    <div class="form-group">
	        <label for="phone">전화번호</label>
	        <input type="text" id="phone" name="user_phone" value="${user.user_phone}">
	    </div>
	    
	    <div class="form-group">
	        <label for="birth_date">생년월일</label>
	        <input type="date" id="birth_date" name="user_birth_date" value="${user.user_birth_date}">
	    </div>
	
	    <div class="form-group">
	        <label>성별</label>
	        <div class="select-group">
	            <input type="radio" id="male" name="user_gender" value="M" <c:if test='${user.user_gender == "M"}'>checked</c:if>>
	            <label for="male">남성</label>
	            <input type="radio" id="female" name="user_gender" value="F" <c:if test='${user.user_gender == "F"}'>checked</c:if>>
	            <label for="female">여성</label>
	        </div>
	    </div>
	    
	    <div class="form-group">
	        <label>직업</label>
	        <div class="select-group">
	            <input type="radio" id="student" name="user_role" value="student" <c:if test='${user.user_role == "student"}'>checked</c:if>>
	            <label for="student">학생</label>
	            <input type="radio" id="teacher" name="user_role" value="teacher" <c:if test='${user.user_role == "teacher"}'>checked</c:if>>
	            <label for="teacher">교수</label>
	        </div>
	    </div>
	    
	    <div>
	    	<hr style="border:solid 0.01px #dddddd">
	    </div>
	
	    <div class="actions">
	        <input type="submit" value="확인">
	    </div>
    </form>

</div>

</body>
</html>