<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>게시물 보기</title>
</head>
<body>
	<div>
		<h1>
			<span>제목: </span> <span>${board.board_title}</span>
		</h1>
	</div>
	<div>
		<h4>
			<span>작성자: </span> <span>${board.user_name} </span> <span>조회수: </span>
			<span>${board.board_viewcnt}</span>
		</h4>
	</div>
	<div>
		<h5>
			<span>작성일자: </span> <span>${board.board_reg_date}</span>
		</h5>
	</div>
	<div>
		<h3>
			<span>카테고리: </span> <span>${board.board_category_name}</span>
		</h3>
	</div>
	<div>
		<span>내용: </span> <span>${board.board_content}</span>
	</div>
	<div>
		<h4>
			<span>좋아요: </span> <span></span> 
			<span>싫어요: </span> <span></span> 
			<span>댓글수: </span> <span></span>
		</h4>
	</div>
	<div>
		<span>댓글 목록</span> <span></span>
	</div>

	<div class="mt-3">

		<c:if test="${loginInfo.user_id eq board.user_id}">
			<a	href="modify?board_number=${param.board_number}&${pageRequestDTO.link}"
				class="btn btn-primary me-2">수정</a>
			<a	href="remove?board_number=${param.board_number}&${pageRequestDTO.link}"
				class="btn btn-danger me-2" onclick="return confirmDelete();">삭제</a>
		</c:if>

		<a href="list?${pageRequestDTO.link}" class="btn btn-secondary">목록</a>
		<a href="answerRegister?parent_board_number=${board.board_number}">답변 게시글 작성</a>
	</div>
	
	<script>
        function confirmDelete() {
            return confirm("정말 삭제하시겠습니까?");
        }
    </script>
	
</body>
</html>