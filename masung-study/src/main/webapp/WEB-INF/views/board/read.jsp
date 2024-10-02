<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>게시물 보기</title>
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
			<span>작성자: </span> <span>${board.user_name} </span> 
			<span>조회수: </span> <span>${board.board_viewcnt}</span>
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
					<span>첨부파일: </span>
					<span><a href="download/${boardFile.file_number}">${boardFile.file_originalname}</a></span>
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
			<span>좋아요: </span> <span></span> 
			<span>싫어요: </span> <span></span> 
		</h4>
	</div>
	<div>
		<span id="orderByRegDate">등록순/</span>
		<span id="orderByRecent">최신순</span>
		<span id="refresh"> 새로고침</span>
		<span id="commentListTotal"> 댓글수: </span>
	</div>
	<table class="commentTable">
		<tbody id="commentList">
		</tbody>
	</table>
	
	<template id="commentTemplate">
		<tr>
			<td><a href="/user/read?uid=" class="comment-writer"></a></td>
			<td class="comment-content"></td>
			<td class="comment-date"></td>
		</tr>
	</template>

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
	<div id="board_number" data-bno="${board.board_number}"></div>
	
<script>
function confirmDelete() {
    return confirm("정말 삭제하시겠습니까?");
}

<!-- 댓글 비동기처리 -->
function getComment(){
	const board_number = document.getElementById('board_number').dataset.bno;
    const params = "board_number=" + board_number;
	
	fetch("/async/board/comment?" + params)
    .then(response => response.json())
    .then(data => {
    	updateCommentList(data);
       
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
            clone.querySelector('.comment-writer').href = "/user/mypage?user_id=" + comment.user_id;
            clone.querySelector('.comment-content').textContent = comment.comment_content;
            clone.querySelector('.comment-date').textContent = comment.comment_reg_date;

            commentList.appendChild(clone);
        });
    } else {
    	commentList.innerHTML = "<tr><td>검색 결과가 없습니다.</td></tr>";
    }
}
getComment();
</script>
</body>
</html>