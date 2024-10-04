<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="pageList" class="pagination-container">
</div>

<template id="pageTemplate">
	<a href="#" data-param="" class="page-list">Page</a>
</template>

<script>
document.getElementById('pageList').addEventListener('click', e => {
	  if (e.target.classList.contains('page-list')) {
	    e.preventDefault();
	    e.stopPropagation();

	    const params = e.target.getAttribute("data-param");
	    fetchPageData(params);
	  }
});

function fetchPageData(params) {
	  fetch("/async/board/comment?" + params)
	    .then(response => {
	      if (!response.ok) {
	        throw new Error("서버 응답 오류");
	      }
	      return response.json();
	    })
	    .then(data => {
	      updatePage(data);
	      updateCommentList(data);
	    })
	    .catch(error => {
	      console.error("데이터 로딩 중 오류 발생:", error);
	    });
}

function getParam(page, commentPageRequest){
	const params = new URLSearchParams();
	
	params.append("page", page);
    params.append("size", commentPageRequest.size);
    params.append("board_number", commentPageRequest.board_number);

      const paramString = params.toString();
      return paramString;
}

function updatePage(data) {
	const template      = document.getElementById("pageTemplate");
    const pageList      = document.getElementById("pageList");
    
    pageList.innerHTML = "";
    
    if (data.comment.list && data.comment.list.length > 0) { 
    	 if(data.comment.prev){
    		 const clone = template.content.cloneNode(true);
    		 
    		 clone.querySelector('.page-list').textContent = "이전";
             clone.querySelector('.page-list').dataset.param = getParam(data.comment.begin-1, data.commentPageRequest);
             
             pageList.appendChild(clone);
    	 }
    	 for(let i=data.comment.begin;i<=data.comment.end;i++){
    		 const clone = template.content.cloneNode(true);
    		 
    		 clone.querySelector('.page-list').textContent = i;
             clone.querySelector('.page-list').dataset.param = getParam(i, data.commentPageRequest);

             if (data.comment.page == i) {
            	    clone.querySelector('.page-list').classList.add('active');
            }

             pageList.appendChild(clone);
         }
    	 if(data.comment.next){
    		 const clone = template.content.cloneNode(true);
    		 
    		 clone.querySelector('.page-list').textContent = "다음";
             clone.querySelector('.page-list').dataset.param = getParam(data.comment.end+1, data.commentPageRequest);
             
             pageList.appendChild(clone);
    	 }
    } else {
    	pageList.innerHTML = "<div>검색 결과가 없습니다.</div>";
    }
}

function initCommentPage(){
	const urlParams = new URLSearchParams(window.location.search);
	const board_number = urlParams.get("board_number");
	fetchPageData("page=1&size=50&board_number=" + board_number);
}
initCommentPage();
</script>