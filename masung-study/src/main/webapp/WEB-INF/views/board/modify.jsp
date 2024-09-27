<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 수정</title>
</head>
<body>
	<h1>게시물 수정</h1>
	<form action="modify?${pageRequestDTO.link}" method="post">
		<div>
			<h3>
				<span>제목: </span> <input type="text" name="board_title"
					value="${board.board_title}">
			</h3>
		</div>
		<div>
			<h3>
				<textarea id="board_content" name="board_content" rows="10"
					cols="50">${board.board_content}</textarea>
			</h3>
		</div>
		<div>
			<h3>
				<span>카테고리: </span> <select name="board_category_number"
					id="board_category_number">
					<option disabled>카테고리 선택</option>
					<option value="1"  ${board.board_category_number == 1 ? "selected":""} >Java</option>
					<option value="2"  ${board.board_category_number == 2 ? "selected":""} >Python</option>
					<option value="3"  ${board.board_category_number == 3 ? "selected":""} >C/C++</option>
					<option value="99" ${board.board_category_number == 99 ? "selected":""}>ETC</option>
				</select>
			</h3>
		</div>

		<input type="submit" value="수정">
	</form>

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