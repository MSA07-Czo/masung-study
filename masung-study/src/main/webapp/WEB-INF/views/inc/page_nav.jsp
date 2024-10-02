<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<table class="table">
	<tbody id="pageList">
	</tbody>
</table>

<template id="pageTemplate">
	<tr>
		<td><a href="#" data-param="" class="page-list"></a></td>
	</tr>
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
	const template      = document.getElementById("pageTemplate");
    const pageList      = document.getElementById("pageList");
    
    pageList.innerHTML = "";
    
    if (data.pageResponse.list && data.pageResponse.list.length > 0) { 
    	 if(data.pageResponse.prev){
    		 const clone = template.content.cloneNode(true);
    		 
    		 clone.querySelector('.page-list').textContent = "이전";
             clone.querySelector('.page-list').dataset.param = getParam(data.pageResponse.begin-1, data.pageRequest);
             
             pageList.appendChild(clone);
    	 }
    	 for(let i=data.pageResponse.begin;i<=data.pageResponse.end;i++){
    		 const clone = template.content.cloneNode(true);
    		 
    		 clone.querySelector('.page-list').textContent = i;
             clone.querySelector('.page-list').dataset.param = getParam(i, data.pageRequest);
             if (data.pageResponse.page == i) {
            	    clone.querySelector('.page-list').classList.add('active');
            }

             pageList.appendChild(clone);
         }
    	 if(data.pageResponse.next){
    		 const clone = template.content.cloneNode(true);
    		 
    		 clone.querySelector('.page-list').textContent = "다음";
             clone.querySelector('.page-list').dataset.param = getParam(data.pageResponse.end+1, data.pageRequest);
             
             pageList.appendChild(clone);
    	 }
    } else {
    	pageList.innerHTML = "<tr><td>검색 결과가 없습니다.</td></tr>";
    }
}
fetchPageData("page=1");
</script>