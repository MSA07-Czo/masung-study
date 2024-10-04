<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<head>
<style>
/* Pagination table styling */
.pagenavTable {
    width: 80%;
    margin: 20px auto;
    border-collapse: collapse;
    background-color: #f4f4f4;
    border: none;
    overflow: hidden;
}

/* Pagination list */
#pageList {
    text-align: center;
    padding: 15px 0;
    margin: 0;
}

/* Pagination links */
.page-list {
    display: inline-block;
    padding: 10px 15px;
    margin: 0 5px;
    
    color: #222;
    border-radius: 5px;
    text-decoration: none;
    transition: background-color 0.3s ease;
    font-weight: bold;
}

.page-list:hover {
    background-color: #666;
    color: #f4f4f4;
}

/* Active page style */
.page-list.active {
    background-color: #222;
    color: #fff;
    cursor: default;
}

/* 'Previous' and 'Next' buttons */
.page-list[data-param*="prev"], .page-list[data-param*="next"] {
    font-weight: bold;
    font-style: italic;
}
</style>
</head>

<div id="pageList" class="pagination-container">
</div>

<table class="pagenavTable">
	<tbody id="pageList">
		<tr>
			<td id="paginationContainer"></td> <!-- This will contain all the pagination buttons in a single row -->
		</tr>
	</tbody>
</table>

<template id="pageTemplate">
	<a href="#" data-param="" class="page-list"></a> <!-- Changed to inline element for horizontal layout -->
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
	  fetch("/async/board/list?" + params)
	    .then(response => {
	      if (!response.ok) {
	        throw new Error("서버 응답 오류");
	      }
	      return response.json();
	    })
	    .then(data => {
	      updatePage(data);
	      updateBoardList(data.pageResponse);
	    })
	    .catch(error => {
	      console.error("데이터 로딩 중 오류 발생:", error);
	    });
}

function getParam(page, pageRequest){
	const params = new URLSearchParams();
	
	params.append("page", page);
    params.append("size", pageRequest.size);
    
    if (pageRequest.searchType) {
        params.append("searchType", pageRequest.searchType);
      }

      if (pageRequest.keyword) {
        params.append('keyword', pageRequest.keyword);
      }

      if (pageRequest.from && pageRequest.from.trim()) {
        params.append('from', pageRequest.from.trim());
      }

      if (pageRequest.to && pageRequest.to.trim()) {
        params.append('to', pageRequest.to.trim());
      }

      const paramString = params.toString();
      return paramString;
}

function updatePage(data) {
	<!-- 수정한 내용 -->
    const pageRequest   = document.getElementById("pageRequestDTO").dataset.param;
	
	const template      = document.getElementById("pageTemplate");
    const pageList      = document.getElementById("pageList");
    
    pageList.innerHTML = "";
    
    if (data.pageResponse.list && data.pageResponse.list.length > 0) { 
    	 if(data.pageResponse.prev){
    		 const clone = template.content.cloneNode(true);
    		 
    		 clone.querySelector('.page-list').textContent = "이전";								<!-- 수정한 내용 -->
             clone.querySelector('.page-list').dataset.param = getParam(data.pageResponse.begin-1, pageRequest);
             
             pageList.appendChild(clone);
    	 }
    	 for(let i=data.pageResponse.begin;i<=data.pageResponse.end;i++){
    		 const clone = template.content.cloneNode(true);
    		 
    		 clone.querySelector('.page-list').textContent = i;			<!-- 수정한 내용 -->
             clone.querySelector('.page-list').dataset.param = getParam(i, pageRequest);
             
             if (data.pageResponse.page == i) {
            	    clone.querySelector('.page-list').classList.add('active');
            }

             pageList.appendChild(clone);
         }
    	 if(data.pageResponse.next){
    		 const clone = template.content.cloneNode(true);
    		 
    		 clone.querySelector('.page-list').textContent = "다음";								<!-- 수정한 내용 -->
             clone.querySelector('.page-list').dataset.param = getParam(data.pageResponse.end+1, pageRequest);
             alert(clone.querySelector('.page-list').dataset.param);
             pageList.appendChild(clone);
    	 }
    } else {
    	pageList.innerHTML = "<div>검색 결과가 없습니다.</div>";
    }
}
fetchPageData("page=1");
</script>