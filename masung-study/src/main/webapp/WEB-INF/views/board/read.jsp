<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>게시물 보기</title>
<style>
body {
	font-family: 'Noto Sans KR', Arial, sans-serif;
	background-color: #f8f9fa;
	color: #333333;
	margin: 0;
	padding: 20px;
	line-height: 1.6;
}

.container {
	max-width: 900px;
	margin: 20px auto;
	background: #fff;
	border-radius: 12px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	padding: 30px;
}

.post-header {
	border-bottom: 2px solid #eee;
	padding-bottom: 20px;
	margin-bottom: 25px;
}

.post-title {
	font-size: 2em;
	color: #1a1a1a;
	margin-bottom: 15px;
	font-weight: 600;
}

.post-meta {
	display: flex;
	justify-content: space-between;
	flex-wrap: wrap;
	color: #666;
	font-size: 0.95rem;
	margin-bottom: 15px;
}

.post-meta-item {
	display: flex;
	align-items: center;
	margin-right: 20px;
}

.post-meta-item span:first-child {
	font-weight: 500;
	margin-right: 8px;
	color: #444;
}

.post-category {
	display: inline-block;
	background-color: #f0f2f5;
	padding: 5px 12px;
	border-radius: 20px;
	font-size: 0.9rem;
	color: #555;
	margin: 10px 0;
}

.post-content {
	background-color: #fff;
	padding: 25px;
	border-radius: 8px;
	margin: 20px 0;
	line-height: 1.8;
}

.post-files {
	margin: 20px 0;
}

.file-item {
	background-color: #f8f9fa;
	padding: 12px 15px;
	border-radius: 6px;
	margin-bottom: 10px;
	display: flex;
	align-items: center;
}

.file-item a {
	color: #0066cc;
	text-decoration: none;
	display: flex;
	align-items: center;
}

.file-item a:hover {
	text-decoration: underline;
}

.post-images {
	margin: 20px 0;
}

.post-images img {
	max-width: 100%;
	border-radius: 8px;
	margin: 10px 0;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.post-reactions {
	display: flex;
	gap: 20px;
	padding: 15px 0;
	border-top: 1px solid #eee;
	border-bottom: 1px solid #eee;
	margin: 20px 0;
}

.reaction-item {
	display: flex;
	align-items: center;
	gap: 8px;
	color: #666;
}

.btn {
    padding: 10px 20px;
    border-radius: 6px;
    font-weight: 500;
    transition: all 0.3s ease;
    text-decoration: none; /* 밑줄 제거 */
    display: inline-block; /* 링크의 패딩과 마진을 제대로 적용하기 위해 */
}

/* 상세 버튼 스타일 */
.btn-primary {
    background-color: #0066cc;
    color: white;
    border: none;
}

.btn-primary:hover {
    background-color: #0052a3;
    color: white;
    text-decoration: none; /* 호버 시에도 밑줄 제거 */
}

.btn-danger {
    background-color: #dc3545;
    color: white;
    border: none;
}

.btn-danger:hover {
    background-color: #bb2d3b;
    text-decoration: none;
}

.btn-secondary {
    background-color: #6c757d;
    color: white;
    border: none;
}

.btn-secondary:hover {
    background-color: #5a6268;
    text-decoration: none;
}

#commentListTotal {
	font-weight: bold; /* Bold font for comment count */
}

/* Additional styles for better alignment */
h1, h3, h4, h5 {
	text-align: left; /* Left align headings */
}

.card-body div {
	margin-bottom: 15px; /* Space between elements in the card body */
}

input[type="text"], input[type="file"], textarea, select {
	width: 100%; /* Full width for form controls */
	padding: 10px;
	border: 1px solid #e0e0e0;
	border-radius: 4px; /* Rounded corners */
	margin-top: 5px; /* Space above inputs */
}

input[type="submit"], input[type="reset"] {
	width: auto; /* Auto width for buttons */
}

.pagination-container {
	display: flex; /* 가로 배치 */
	gap: 8px; /* 페이지들 간의 간격 설정 */
	justify-content: center; /* 페이지 중앙 정렬 */
	margin: 16px 0;
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
.comment-container {
    position: relative;
    padding: 15px;
    width: 100%;
}

.comment-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 10px;
}

.comment-info {
    display: flex;
    gap: 15px;
    align-items: center;
}

.comment-writer {
    font-weight: 500;
    color: #333;
    text-decoration: none;
}

.comment-date {
    color: #666;
    font-size: 0.9em;
}

.comment-actions {
    display: flex;
    gap: 8px;
}

.btn-edit-comment,
.btn-delete-comment,
.btn-save-edit,
.btn-cancel-edit {
    padding: 4px 8px;
    border: none;
    border-radius: 4px;
    font-size: 0.85em;
    cursor: pointer;
    transition: background-color 0.2s;
    text-decoration: none;
}

.btn-edit-comment {
    background-color: #e9ecef;
    color: #495057;
}

.btn-delete-comment {
    background-color: #f8d7da;
    color: #dc3545;
}

.btn-save-edit {
    background-color: #0066cc;
    color: white;
}

.btn-cancel-edit {
    background-color: #6c757d;
    color: white;
}

.btn-edit-comment:hover {
    background-color: #dee2e6;
}

.btn-delete-comment:hover {
    background-color: #f5c2c7;
}

.comment-edit-form {
    margin-top: 10px;
}

.edit-comment-textarea {
    width: 100%;
    min-height: 60px;
    padding: 8px;
    border: 1px solid #ced4da;
    border-radius: 4px;
    margin-bottom: 8px;
    resize: vertical;
}

.edit-buttons {
    display: flex;
    gap: 8px;
    justify-content: flex-end;
}

.comment-content {
    white-space: pre-wrap;
    word-break: break-word;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/header.jsp"></jsp:include>
	<div class="container">
		<div class="post-header">
			<h1 class="post-title">${board.board_title}</h1>
			<div class="post-meta">
				<div class="post-meta-item">
					<span>작성자</span> <span>${board.user_name}</span>
				</div>
				<div class="post-meta-item">
					<span>조회수</span> <span>${board.board_viewcnt}</span>
				</div>
				<div class="post-meta-item">
					<span>작성일</span> <span>${board.board_reg_date}</span>
				</div>
			</div>
			<div class="post-category">${board.board_category_name}</div>
		</div>

		<div class="post-files">
			<c:if test="${not empty board.boardFileDTOList}">
				<c:forEach var="boardFile" items="${board.boardFileDTOList}">
					<div class="file-item">
						<a href="download/${boardFile.file_number}"> 📎
							${boardFile.file_originalname} </a>
					</div>
				</c:forEach>
			</c:if>
		</div>

		<div class="post-content">${board.board_content}</div>

		<div class="post-images">
			<c:if test="${not empty board.boardFileDTOList}">
				<c:forEach var="boardFile" items="${board.boardFileDTOList}">
					<img src="download/${boardFile.file_number}" alt="첨부 이미지" />
				</c:forEach>
			</c:if>
		</div>

		<div class="post-reactions">
			<div class="reaction-item">
				<span>👍 좋아요</span> <span>0</span>
			</div>
			<div class="reaction-item">
				<span>👎 싫어요</span> <span>0</span>
			</div>
		</div>
		<div>
			<span id="orderByRegDate">등록순/</span> <span id="orderByRecent">최신순</span>
			<span id="refresh">새로고침</span> <span id="commentListTotal">댓글수:
			</span>
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
					<button type="submit" class="submit-btn">댓글 등록</button>
				</div>
			</form>
		</div><br>

		<div class="action-buttons mt-3">
			<c:if test="${loginInfo.user_id eq board.user_id}">
				<a
					href="modify?board_number=${param.board_number}&${pageRequestDTO.link}"
					class="btn btn-primary">수정</a>
				<a
					href="remove?board_number=${param.board_number}&${pageRequestDTO.link}"
					class="btn btn-danger" onclick="return confirmDelete();">삭제</a>
			</c:if>
			<a href="list?${pageRequestDTO.link}" class="btn btn-secondary">목록</a>
			<a href="answerRegister?parent_board_number=${board.board_number}"
				class="btn btn-secondary">답변 게시글 작성</a>
		</div>
	</div>

	<div id="board_number" data-bno="${board.board_number}"></div>
	<template id="commentTemplate">
    <tr class="comment-row">
        <td class="comment-container">
            <div class="comment-header">
                <div class="comment-info">
                    <a href="/user/read?uid=" class="comment-writer"></a>
                    <span class="comment-date"></span>
                </div>
                <div class="comment-actions">
                    <button class="btn-edit-comment" style="display: none;">수정</button>
                    <button class="btn-delete-comment" style="display: none;">삭제</button>
                </div>
            </div>
            <div class="comment-body">
                <div class="comment-content"></div>
                <div class="comment-edit-form" style="display: none;">
                    <textarea class="edit-comment-textarea"></textarea>
                    <div class="edit-buttons">
                        <button class="btn-save-edit">저장</button>
                        <button class="btn-cancel-edit">취소</button>
                    </div>
                </div>
            </div>
        </td>
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
        initCommentPage();
        document.getElementById("comment").value = "";
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