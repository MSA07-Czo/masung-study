<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<table class="table">
	<tbody id="pageList">
		<!-- 
		<c:if test="${pageResponseDTO.prev}">
			<li class="page-item"><a class="page-link" href="#"
				data-param="${pageRequestDTO.getParam(pageResponseDTO.begin-1)}">이전</a></li>
		</c:if>
		<c:forEach var="num" begin="${pageResponseDTO.begin}"
			end="${pageResponseDTO.end}">
			<li class="page-item ${pageResponseDTO.page == num ? 'active' : ''}"><a
				class="page-link" href="#"
				data-param="${pageRequestDTO.getParam(num)}">${num}</a></li>
		</c:forEach>
		<c:if test="${pageResponseDTO.next}">
			<li class="page-item"><a class="page-link" href="#"
				data-param="${pageRequestDTO.getParam(pageResponseDTO.end+1)}">다음</a></li>
		</c:if>
		 -->
	</tbody>
</table>

<template id="pageTemplate">
	<tr>
		<td><a href="#" data-param="" class="page-list"></a></td>
	</tr>
</template>

<script>
document.querySelectorAll(".page-list").forEach(item => {
	item.addEventListener('click', e => {
		e.preventDefault();
		e.stopPropagation();
		
		const params = e.target.getAttribute("data-param");
		fetch("/async/board/list?" + params)
	     .then(response => response.json())
	     .then(data => {
	         updatePage(data);
	     })
	     .catch(error => {
	         console.error("비동기 처리 도중 오류발생:", error);
	     });
		
	});
});

function updatePage(data) {
	const template      = document.getElementById("pageTemplate");
    const pageList      = document.getElementById("pageList");
    
    pageList.innerHTML = "";
    
    if (data.list && data.list.length > 0) { 
    	 if(data.prev){
    		 const clone = template.content.cloneNode(true);
    		 
    		 clone.querySelector('.page-list').textContent = "이전";
             clone.querySelector('.page-list').dataset.param = `list?${pageRequestDTO.getParam(data.begin-1)}`;
             
             pageList.appendChild(clone);
    	 }
    	 for(let i=data.begin;i<=data.end;i++){
    		 const clone = template.content.cloneNode(true);
    		 
    		 clone.querySelector('.page-list').textContent = i;
             clone.querySelector('.page-list').dataset.param = `list?${pageRequestDTO.getParam(i)}`;

             pageList.appendChild(clone);
         }
    	 if(data.next){
    		 const clone = template.content.cloneNode(true);
    		 
    		 clone.querySelector('.page-list').textContent = "다음";
             clone.querySelector('.page-list').dataset.param = `list?${pageRequestDTO.getParam(data.end+1)}`;
             
             pageList.appendChild(clone);
    	 }
    } else {
    	pageList.innerHTML = "<tr><td>검색 결과가 없습니다.</td></tr>";
    }
}

</script>