<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 등록</title>
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
				<textarea id="board_content" name="board_content" rows="10"
					cols="50"></textarea>
			</div>

			<h3>
				<span>카테고리: </span> <select name="board_category_number"
					id="board_category_number">
					<option disabled selected>카테고리 선택</option>
					<option value="1">Java</option>
					<option value="2">Python</option>
					<option value="3">C/C++</option>
					<option value="99">ETC</option>
				</select>
			</h3>
			
			<div class="input-group mb-3">
				<span class="input-group-text">첨부파일</span>
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