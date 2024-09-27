<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 등록</title>
</head>
<body>
	<div class="card-body">
		<form action="register" method="post">
			<div class="input-group mb-3">
				<span class="input-group-text">제목</span> <input name="board_title"
					class="form-control">
			</div>
			<div class="input-group mb-3">
				<textarea id="board_content" name="board_content" rows="10"
					cols="50"></textarea>
			</div>

			<h3>
				<span>카테고리: </span> <input type="radio" id="board_category_number_1"
					name="board_category_number" value="1"
					${board.board_category_number ==1  ? "checked='checked'" : ""}>
				<label for="board_category_number_1">Java</label> <input
					type="radio" id="board_category_number_2"
					name="board_category_number" value="2"
					${board.board_category_number ==2  ? "checked='checked'" : ""}>
				<label for="board_category_number_2">Python</label> <input
					type="radio" id="board_category_number_3"
					name="board_category_number" value="3"
					${board.board_category_number ==3  ? "checked='checked'" : ""}>
				<label for="board_category_number_3">C/C++</label> <input
					type="radio" id="board_category_number_99"
					name="board_category_number" value="99"
					${board.board_category_number ==99 ? "checked='checked'" : ""}>
				<label for="board_category_number_99">ETC</label>
			</h3>
			
			<input type="hidden" name="parent_board_number" value="${parent_board_number}">

			<input type="submit" class="btn btn-primary" value="등록"> <input
				type="reset" class="btn btn-secondary" value="초기화">
		</form>
	</div>
</body>
</html>