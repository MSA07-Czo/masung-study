<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>게시물 보기</title>
<style type="text/css">
.pagination-container {
	display: flex; /* 가로 배치 */
	gap: 10px; /* 페이지들 간의 간격 설정 */
	justify-content: center; /* 페이지 중앙 정렬 */
	margin: 20px 0;
}

.page-list {
	padding: 5px 10px; /* 비활성 페이지에도 패딩 적용 */
	text-decoration: none; /* 밑줄 제거 */
	color: #007bff; /* 기본 글자 색상 */
	border: 1px solid #007bff; /* 테두리 추가 */
	border-radius: 5px; /* 둥근 모서리 */
	transition: background-color 0.3s ease, color 0.3s ease; /* 애니메이션 */
}

.page-list:hover {
	background-color: #007bff; /* 호버 시 배경색 */
	color: #ffffff; /* 호버 시 글자색 */
}

.page-list.active {
	font-weight: bold;
	color: #ffffff; /* 활성화 상태에서 글자색 */
	background-color: #007bff; /* 활성화 상태에서 배경색 */
	border-color: #0056b3; /* 활성화 상태에서 테두리 색상 */
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 그림자 추가 */
}

.comment-section {
	width: 100%;
	max-width: 600px;
	margin: 20px auto;
	padding: 20px;
	border: 1px solid #ddd;
	border-radius: 8px;
	background-color: #f9f9f9;
}

.form-group {
	margin-bottom: 15px;
}

textarea {
	width: 100%;
	padding: 10px;
	border-radius: 5px;
	border: 1px solid #ccc;
	font-size: 14px;
	resize: none;
}

textarea:focus {
	outline: none;
	border-color: #007bff;
	box-shadow: 0 0 5px rgba(0, 123, 255, 0.2);
}

.submit-btn {
	padding: 10px 20px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.submit-btn:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/header.jsp"></jsp:include>
	<div>
		<h1>
			<span>제목: </span> <span>${board.board_title}</span>
		</h1>
	</div>
	<div>
		<h4>
			<span>작성자: </span> <span>${board.user_name} </span> <span>조회수:
			</span> <span>${board.board_viewcnt}</span>
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
		<c:if test="${not empty board.boardFileDTOList}">
			<c:forEach var="boardFile" items="${board.boardFileDTOList}">
				<div>
					<h3>
						<span>첨부파일: </span> <span><a
							href="download/${boardFile.file_number}">${boardFile.file_originalname}</a></span>
					</h3>
				</div>
			</c:forEach>

			<c:forEach var="boardFile" items="${board.boardFileDTOList}">
				<div>
					<h3>
						<img src="download/${boardFile.file_number}" />
					</h3>
				</div>
			</c:forEach>
		</c:if>
	</div>

	<div>
		<span>내용: </span> <span>${board.board_content}</span>
	</div>
	<div>
		<h4>
			<span>좋아요: </span> <span></span> <span>싫어요: </span> <span></span>
		</h4>
	</div>
	<div>
		<span id="orderByRegDate">등록순/</span> <span id="orderByRecent">최신순</span>
		<span id="refresh"> 새로고침</span> <span id="commentListTotal">
			댓글수: </span>
	</div>
	<table class="commentTable">
		<tbody id="commentList">
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/inc/comment_page_nav.jsp"></jsp:include>

	<div class="comment-section">
		<form id="commentForm" action="/async/board/comment/register"
			method="post">
			<div class="form-group">
				<textarea id="comment" name="comment" rows="4"
					placeholder="댓글을 입력해주세요" required></textarea>
			</div>
			<div class="form-group">
				<button type="submit" class="submit-btn">등록</button>
			</div>
		</form>
	</div>

	<div class="mt-3">

		<c:if test="${loginInfo.user_id eq board.user_id}">
			<a
				href="modify?board_number=${param.board_number}&${pageRequestDTO.link}"
				class="btn btn-primary me-2">수정</a>
			<a
				href="remove?board_number=${param.board_number}&${pageRequestDTO.link}"
				class="btn btn-danger me-2" onclick="return confirmDelete();">삭제</a>
		</c:if>

		<a href="list?${pageRequestDTO.link}" class="btn btn-secondary">목록</a>
		<a href="answerRegister?parent_board_number=${board.board_number}">답변
			게시글 작성</a>
	</div>

	<div id="board_number" data-bno="${board.board_number}"></div>
	<template id="commentTemplate">
		<tr>
			<td><a href="/user/read?uid=" class="comment-writer"></a></td>
			<td class="comment-content"></td>
			<td class="comment-date"></td>
		</tr>
	</template>

	<script>
function confirmDelete() {
    return confirm("정말 삭제하시겠습니까?");
}

<!-- 댓글 목록 비동기처리 -->
function getComment(){
	const board_number = document.getElementById('board_number').dataset.bno;
    const params = "board_number=" + board_number;
	
	fetch("/async/board/comment?" + params)
    .then(response => response.json())
    .then(data => {
    	updateCommentList(data);
        fetchPageData(getParam(1, data.commentPageRequest));
    })
    .catch(error => {
        console.error("비동기 처리 도중 오류발생:", error);
    });
}

function updateCommentList(data){
	const template         = document.getElementById("commentTemplate");
	const commentList      = document.getElementById("commentList");
    const commentListTotal = document.getElementById("commentListTotal");
    
    commentListTotal.textContent = "댓글수: " + data.comment.total;
    commentList.innerHTML = "";
    
    if (data.comment.list && data.comment.list.length > 0) {
        data.comment.list.forEach(comment => {
            const clone = template.content.cloneNode(true);
            
            clone.querySelector('.comment-writer').textContent = comment.user_name;
            clone.querySelector('.comment-writer').href = "/user/read?uid=" + comment.user_id;
            clone.querySelector('.comment-content').textContent = comment.comment_content;
            clone.querySelector('.comment-date').textContent = comment.comment_reg_date;

            commentList.appendChild(clone);
        });
    } else {
    	commentList.innerHTML = "<tr><td>검색 결과가 없습니다.</td></tr>";
    }
}

<!-- 댓글 등록 -->
function registerComment() {
    const board_number    = document.getElementById('board_number').dataset.bno;
    const comment_content = document.getElementById('comment').value;

    const data = {
        board_number: board_number,
        comment_content: comment_content
    };
    
    fetch("/async/board/comment/register", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(data)
    })
    .then(response => response.json())
    .then(data => {
        alert(data.message);
        initCommentPage();
    })
    .catch(error => {
        console.error("비동기 처리 도중 오류 발생:", error);
    });
}

document.getElementById('commentForm').addEventListener("submit", e => {
	e.preventDefault();
	e.stopPropagation();
	registerComment();
});
</script>
</body>
</html>