<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원 가입</h1>
	<form id="iForm" >
		<div>
			<h3>
				<span>아이디 : </span>
				<input type="text" name="uid" id="uid" >
				<input type="button" id="idCheckButton" value="아이디중복">
			</h3>
		</div>
		<div>
			<h3>
				<span>비번: </span>
				<input type="password" name="pwd" id="pwd" >
			</h3>
		</div>
		<div>
			<h3>
				<span>확인비번: </span>
				<input type="password" name="pwd2" id="pwd2" >
			</h3>
		</div>
		<div>
			<h3>
				<span>이름: </span>
				<input type="text" name="name"  id="uname">
			</h3>
		</div>

		<input type="submit" value="등록">
	</form>
	
<script>
	document.querySelector("#idCheckButton").addEventListener("click", async  e => {
		//함수 호출  
		//리턴 되기 까지 3분 소요됨
		//
		//alert("http://localhost:8090/idCheck?uid=" + uid.value);
		const response = await fetch("http://localhost:8090/idCheck?uid=" + uid.value);
		const jsonData = await response.json();
		console.log(jsonData);
		console.log(jsonData.status);
		console.log(jsonData.result);
		if (jsonData.status == 1) {
			if (jsonData.result) {
				alert("["+uid.value+"] 아이디는 사용 불가능 합니다")
			} else {
				alert("["+uid.value+"] 아이디는 사용 가능 합니다")
			}
		} else {
			alert("서버 오류 발생")
		}
		
	});
	
	document.querySelector("#iForm").addEventListener("submit", async  e => {
		e.preventDefault();
		
		//함수 호출  
		//리턴 되기 까지 3분 소요됨
		//
		const data = {
			uid : uid.value,
			pwd : pwd.value,
			name : uname.value
		};
		
		const response = await fetch("http://localhost:8090/member_api/insert", {
	    	method: "POST", // *GET, POST, PUT, DELETE 등
	    	headers: {
	      		"Content-Type": "application/json",
	    	},
		    body: JSON.stringify(data), // body의 데이터 유형은 반드시 "Content-Type" 헤더와 일치해야 함
	  	});		
		const jsonData = await response.json();
		console.log(jsonData);
		console.log(jsonData.status);
		console.log(jsonData.result);
		if (jsonData.status == 1) {
			if (jsonData.result) {
				alert("회원을 축하합니다");
				location = "list";
			} else {
				alert("회원 가입을 실패하였습니다");
			}
		} else {
			alert("서버 오류 발생")
		}
		
	});		
</script>
	
</body>
</html>