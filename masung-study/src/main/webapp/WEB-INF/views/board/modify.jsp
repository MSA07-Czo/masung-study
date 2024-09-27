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
			<span>제목: </span>
			<input type="text" name="board_title" value="${board.board_title}" >
		</h3>
	</div>
	<div>
		<h3>
			<textarea id="board_content" name="board_content" rows="10" cols="50">${board.board_content}</textarea>
		</h3>
	</div>
	<div>
		<h3>
			<span>카테고리: </span>
			<input type="radio" id="board_category_number_1"  name="board_category_number" value="1"  ${board.board_category_number ==1  ? "checked='checked'" : ""}> <label for="board_category_number_1" >Java</label> 
			<input type="radio" id="board_category_number_2"  name="board_category_number" value="2"  ${board.board_category_number ==2  ? "checked='checked'" : ""}> <label for="board_category_number_2" >Python</label> 
			<input type="radio" id="board_category_number_3"  name="board_category_number" value="3"  ${board.board_category_number ==3  ? "checked='checked'" : ""}> <label for="board_category_number_3" >C/C++</label> 
			<input type="radio" id="board_category_number_99" name="board_category_number" value="99" ${board.board_category_number ==99 ? "checked='checked'" : ""}> <label for="board_category_number_99">ETC</label> 
		</h3>
	</div>
	
	<input type="submit" value="수정">
</form>
</body>
</html>