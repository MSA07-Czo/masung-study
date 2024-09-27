<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 페이지</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
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
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            width: 350px;
        }

        h1 {
            text-align: center;
            color: #333;
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
        .form-group input[type="password"] {
            width: 100%;
            padding: 0.5rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
        }

        .form-group input[type="checkbox"] {
            margin-right: 0.5rem;
        }

        .form-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .form-actions input[type="submit"],
        .form-actions input[type="button"] {
            padding: 0.5rem 1rem;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .form-actions input[type="button"] {
            background-color: #28a745;
        }

        .form-actions input[type="submit"]:hover,
        .form-actions input[type="button"]:hover {
            opacity: 0.9;
        }

        .links {
            text-align: center;
            margin-top: 1rem;
        }

        .links a {
            color: #007bff;
            text-decoration: none;
            margin: 0 0.5rem;
        }

        .links a:hover {
            text-decoration: underline;
        }

        /* Error message alert */
        .error-message {
            color: red;
            text-align: center;
            margin-bottom: 1rem;
            display: none;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>로그인</h1>
        <form action="login" method="post">
            <div class="form-group">
                <label for="user_id">아이디</label>
                <input type="text" name="user_id" id="user_id" placeholder="아이디 입력">
            </div>
            <div class="form-group">
                <label for="user_pwd">비밀번호</label>
                <input type="password" name="user_pwd" id="user_pwd" placeholder="비밀번호 입력">
            </div>
            <div class="form-group">
                <input type="checkbox" name="auto_login" id="auto_login" value="1">
                <label for="auto_login">자동 로그인</label>
            </div>
            <div class="form-actions">
                <input type="submit" value="로그인">
                <input type="button" value="회원가입" onclick="location.href='/user/register'">
            </div>
        </form>
        <div class="links">
            <a href="/user/findId">아이디 찾기</a>
            <a href="/user/findPwd">비밀번호 찾기</a>
        </div>

        <div class="error-message" id="error-message">
            아이디 또는 비밀번호가 잘못되었습니다.
        </div>
    </div>

    <script>
        var error = "${param.error}";
        if (error !== "") {
            document.getElementById('error-message').style.display = 'block';
        }
    </script>
</body>
</html>