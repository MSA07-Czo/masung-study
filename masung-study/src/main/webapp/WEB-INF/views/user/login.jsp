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
            margin-top: 0.5rem;
            margin-bottom: 2rem;
        }

        .form-group {
            margin-bottom: 0.5rem;
        }

        .form-group label {
            /* display: block; */
            position: relative;
            top: 3px;
            font-weight: medium;
            font-size: 0.85rem;
            color: #999999;
            margin-bottom: 0.5rem;
        }

        .form-group input[type="text"],
        .form-group input[type="password"] {
            width: 93%;
            padding: 0.9rem 0.7rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
        }
        
        .form-group input[type="text"]:focus,
        .form-group input[type="password"]:focus {
            outline: 2px solid #bbb;
        }

        .form-group input[type="checkbox"] {
            display: none;
        }
        
        .form-group input[type="checkbox"] + label{
            cursor: pointer;
        }
        
        .form-group input[type="checkbox"] + label > span{
            vertical-align: middle;
            position: relative;
            top: -7.5px;
        }
        
        .form-group input[type="checkbox"] + label:before{
            content: "";
            display: inline-block;
            width:13px;
			height:13px;
  			border:2px solid #ccc;
  			border-radius: 10px;
  			margin-right: 0.5rem;
            margin-bottom: 1rem;
			vertical-align: middle;
        }
        
        .form-group input[type="checkbox"]:checked + label:before{
            content:"✓";
            display: inline-block;
            text-align: center;
            font-color: black;
            font-size: 1rem;
            font-weight: black;
            background-repeat: no-repeat;
            margin-right: 0.5rem;
            margin-bottom: 1rem;
            
        }

/*         .form-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
        } */
        
        #btn-login {
        	width: 100%
        }

        .form-actions input[type="submit"] {
            padding: 1rem 1rem;
            background-color: #222222;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: bold;
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
            color: #555555;
            text-decoration: none;
            margin: 0 0.5rem;
            font-size: 0.9rem;
        }
        
        .links span {
        	color: #999999;
        	font-size: 0.7rem;
        }

        .links a:hover {
            
        }

        /* Error message alert */
        .error-message {
            color: #ff5555;
            font-size: 0.9rem;
            font-weight: semibold;
            text-align: center;
            margin-top: 1rem;
            display: none;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>로그인</h1>
        <form action="login" method="post">
            <div class="form-group">
                <!-- <label for="user_id">아이디</label> -->
                <input type="text" name="user_id" id="user_id" placeholder="아이디">
            </div>
            <div class="form-group">
                <!-- <label for="user_pwd">비밀번호</label> -->
                <input type="password" name="user_pwd" id="user_pwd" placeholder="비밀번호">
            </div>
            <div class="form-group">
                <input type="checkbox" name="auto_login" id="auto_login" value="1">
                <label for="auto_login"><span>자동 로그인</span></label>
            </div>
            <div class="form-actions">
                <input type="submit" id=btn-login value="로그인">
            </div>
        </form>
        <div class="links">
            <a href="/user/findId">아이디 찾기</a>
            	<span>|</span>
            <a href="/user/findPwd">비밀번호 찾기</a>
            	<span>|</span>
            <a href="/user/register">회원가입</a>
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