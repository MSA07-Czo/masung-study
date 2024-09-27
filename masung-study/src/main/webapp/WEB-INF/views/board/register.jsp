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
				<span>카테고리: </span> <select name="board_category_number"
					id="board_category_number">
					<option value="1"
						${board.board_category_number == 1 ? "selected" : ""}>Java</option>
					<option value="2"
						${board.board_category_number == 2 ? "selected" : ""}>Python</option>
					<option value="3"
						${board.board_category_number == 3 ? "selected" : ""}>C/C++</option>
					<option value="99"
						${board.board_category_number == 99 ? "selected" : ""}>ETC</option>
				</select>
			</h3>

			<input type="hidden" name="parent_board_number"	value="${parent_board_number}"> 
			<input type="submit" class="btn btn-primary" value="등록"> 
			<input type="reset"  class="btn btn-secondary" value="초기화">
		</form>
	</div>
</body>
</html>