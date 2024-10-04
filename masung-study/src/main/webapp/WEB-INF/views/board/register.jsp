<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 등록</title>

<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f8f9fa;
    margin: 0;
    padding: 20px;
}

.card-body {
    background-color: #ffffff;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    padding: 20px;
    max-width: 600px;
    margin: auto;
    margin-top: 7rem;
}

.input-group {
    display: flex;
    margin-bottom: 15px;
}

.input-group-text {
    background-color: #fff;
    color: #222222;
    border: none;
    padding: 10px 15px;
    border-radius: 5px 0 0 5px;
}

.form-control {
   	width: 85%;
    padding: 10px;
    border: 2px solid #999;
    border-radius: 0 5px 5px 0;
    transition: border-color 0.2s ease-in-out;
}

.form-control:focus {
    border-color: #222;
    outline: none;
    border: 3px solid
}

textarea {
    width: 85%;
    padding: 10px;
    border: 2px solid #999;
    border-radius: 5px;
    resize: vertical;
    transition: border-color 0.2s ease-in-out;
}

textarea:focus {
    border-color: #222;
    outline: none;
    border: 3px solid
}

.btn {
    padding: 10px 15px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.2s ease-in-out;
    position: relative;
    left: 30rem;
}

.btn-primary {
    background-color: #343a40;
    color: white;
}

.btn-primary:hover {
    background-color: #495057;
}

.btn-secondary {
    background-color: #e0e0e0;
    color: black;
}

.btn-secondary:hover {
    background-color: #c0c0c0;
}
</style>

</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/header.jsp"></jsp:include>

	<div class="card-body">
		<form action="register" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
			<div class="input-group mb-3">
				<span class="input-group-text">제목</span> <input name="board_title"
					id="board_title" class="form-control">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">내용</span>
				<textarea id="board_content" name="board_content" rows="10"
					cols="50"></textarea>
			</div>

			<span class="input-group-text">카테고리  </span> <select name="board_category_number"
					id="board_category_number">
					<option disabled selected>카테고리 선택</option>
					<option value="1">Java</option>
					<option value="2">Python</option>
					<option value="3">C/C++</option>
					<option value="99">ETC</option>
				</select>
			
			<div class="input-group mb-3">
				<span class="input-group-text">첨부파일  </span>
				<input type="file" id="file" name="file"><br />
			</div>

			<input type="hidden" name="parent_board_number"
				value="${parent_board_number != null ? parent_board_number : 0}">
			<input type="submit" class="btn btn-primary" value="등록"> <input
				type="reset" class="btn btn-secondary" value="초기화">
		</form>
	</div>

	<script>
		function validateForm() {
			var board_title = document.getElementById("board_title").value;
			var board_content = document.getElementById("board_content").value;
			var board_category_number = document.getElementById("board_category_number").value;
			
			if (board_title == "") {
				alert("제목을 입력해야 합니다.");
				return false;
			} else if (board_content == "") {
				alert("내용을 입력해야 합니다.");
				return false;
			} else if (board_category_number == "카테고리 선택") {
				alert("카테고리를 입력해야 합니다.");
				return false;
			}
			return true;
		}
	</script>
</body>
</html>