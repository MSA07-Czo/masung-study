<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 가입</title>
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
            width: 450px;
            text-align: left;
        }

        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }

        .form-group input[type="text"],
        .form-group input[type="password"],
        .form-group input[type="date"],
        .form-group input[type="radio"] {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
        }

        .form-group input[type="radio"] {
            width: auto;
            margin-right: 10px;
        }

        .form-group label.inline {
            display: inline-block;
            margin-right: 20px;
        }

        input[type="submit"],
        input[type="button"] {
            width: 100%;
            padding: 0.75rem;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            margin-top: 1rem;
        }

        input[type="button"]:hover,
        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .error-message {
            color: red;
            font-size: 0.9rem;
        }

        .gender-role-group {
            display: flex;
            justify-content: space-between;
        }

        .form-group input[type="text"],
        .form-group input[type="password"] {
            box-sizing: border-box;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>회원 가입</h1>
        <form action="register" method="post">
            <div class="form-group">
                <label for="uid">아이디</label>
                <input type="text" name="user_id" id="uid">
                <p id="afterIdInput"></p>
                <input type="button" id="idCheckButton" value="아이디 중복 확인">
            </div>

            <div class="form-group">
                <label for="pwd">비밀번호</label>
                <input type="password" name="user_pwd" id="pwd">
            </div>

            <div class="form-group">
                <label for="pwd2">비밀번호 확인</label>
                <input type="password" name="user_pwd2" id="pwd2">
            </div>

            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" name="user_name" id="name">
            </div>

            <div class="form-group">
                <label for="email">이메일</label>
                <input type="text" name="user_email" id="email">
            </div>

            <div class="form-group">
                <label for="phone">전화번호</label>
                <input type="text" name="user_phone" id="phone">
            </div>

            <div class="form-group">
                <label for="birth_date">생년월일</label>
                <input type="date" name="user_birth_date" id="birth_date">
            </div>

            <div class="form-group gender-role-group">
                <div>
                    <label>성별</label><br>
                    <label class="inline"><input type="radio" name="user_gender" value="M"> 남성</label>
                    <label class="inline"><input type="radio" name="user_gender" value="F"> 여성</label>
                </div>

                <div>
                    <label>역할</label><br>
                    <label class="inline"><input type="radio" name="user_role" value="student"> 학생</label>
                    <label class="inline"><input type="radio" name="user_role" value="teacher"> 교수</label>
                </div>
            </div>

            <input type="submit" value="등록">
        </form>
    </div>

    <script>
        document.querySelector("#idCheckButton").addEventListener("click", async e => {
            const response = await fetch("http://localhost:8090/idCheck?uid=" + uid.value);
            const jsonData = await response.json();
            
            const uidInputNode = document.getElementById("uid");
            const pNode = document.getElementById("afterIdInput");
            console.log(pNode)
            let oldTxtNode = pNode.childNodes[0]
            console.log(oldTxtNode)
            if (oldTxtNode == undefined) {
            	oldTxtNode = pNode.appendChild(document.createTextNode(""));
            }
            
            const newTxtNode = document.createTextNode(jsonData.result ? "현재 사용 중인 아이디입니다." : "사용 가능한 아이디입니다.");
            
            if (jsonData.status === 1) {
            	const txtChange = pNode.replaceChild(newTxtNode, oldTxtNode);
            } else {
                alert("서버 오류 발생");
            }
        });
        
    </script>

</body>
</html>