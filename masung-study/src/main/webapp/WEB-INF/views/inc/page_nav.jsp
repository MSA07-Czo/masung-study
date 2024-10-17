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
			<td id="paginationContainer">
				<a href="#" class="page-list prev" id="prev">이전</a>
				<c:forEach var="no" begin="1" end="10">
					<a href="#" class="page-list page-no"></a>
				</c:forEach>
				<a href="#" class="page-list next" id="next">다음</a>
			</td> 
		</tr>
	</tbody>
</table>

<script>
document.querySelectorAll('.page-list').forEach(page => page.addEventListener('click', e => {
    e.preventDefault();
    e.stopPropagation();

	const searchFormPage = document.querySelector("#searchForm > #page");
	searchFormPage.value = page.dataset.pageNo;
	fetchPageData(page.dataset.pageNo);
}));

function fetchPageData(pageNo) {
	  fetch("/async/board/list?" + getParam(pageNo))
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

function getParam(page) {
    const formData = new FormData(searchForm);
    formData.set("page", page);
	return new URLSearchParams(formData).toString();
}

function updatePage(data) {
	<!-- 수정한 내용 -->
	/*
    const pageRequestDTO = document.getElementById("pageRequestDTO").dataset.param;
	alert(pageRequestDTO);
	const template      = document.getElementById("pageTemplate");
    const pageList      = document.getElementById("pageList");
    pageList.innerHTML = "";
    */
    
    const paginationContainer = document.querySelector("#paginationContainer");
    const prev = paginationContainer.querySelector("#prev");
    const pageNos = paginationContainer.querySelectorAll(".page-no");
    const next = paginationContainer.querySelector("#next");
    const page = document.querySelector("#searchForm > #page");
	
    if (data.pageResponse.list && data.pageResponse.list.length > 0) { 
        prev.style.display = data.pageResponse.prev ? "" : "none";
        prev.dataset.pageNo = data.pageResponse.begin-1;
 
    	pageNos.forEach(pageNo => {
    		pageNo.style.display = "none";
    		pageNo.classList.remove("active");
    	});
    	for(let i=data.pageResponse.begin, idx=0;i<=data.pageResponse.end;i++,idx++){
    		if (page.value == i) {
        		pageNos[idx].classList.add("active");
    		}
    		pageNos[idx].textContent = i;
    		pageNos[idx].dataset.pageNo = i;
    		pageNos[idx].style.display = "";
        }

    	next.style.display = data.pageResponse.next ? "" : "none";
    	next.dataset.pageNo = data.pageResponse.end+1;
    } else {
    	pageList.innerHTML = "<div>검색 결과가 없습니다.</div>";
    }
}
fetchPageData(1);
</script>