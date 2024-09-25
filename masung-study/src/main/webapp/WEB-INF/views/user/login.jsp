<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>로그인</h1>
	<form action="login"  method="post">
		<div>
			<h3>
				<span>아이디 : </span>
				<input type="text" name="user_id" id="user_id">
			</h3>
		</div>
		<div>
			<h3>
				<span>비번: </span>
				<input type="password" name="user_pwd"  >
			</h3>
		</div>
		<div>
			<h3>
				<input type="checkbox" name="auto_login" id="auto_login" value="1">
				<label for="auto_login">자동 로그인</label>
			</h3>
		</div>
		<input type="submit" value="로그인">
	</form>
	
<script>
	var error = "${param.error}";
	if (error != "") {
		alert("아이디 또는 비밀번호가 잘못되었습니다.");
		uid.focus();
	}
</script>	
</body>
</html>