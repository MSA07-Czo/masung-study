<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:if test="${not empty loginInfo}">
	<a href="/member/logout">${loginInfo.name}</a>
</c:if>


<h1>게시물 목록</h1>
	<div class="row content">
        <div class="col">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">검색</h5>
                    <form action="/todo/list" method="get" name="searchForm" id="searchForm">
                    	<input type="hidden" name="page" value=1>
                        <div class="mb-3">
                            <select name="size" id="size">
                            	<c:forTokens var="size" items="10,20,30,50,100" delims=",">
                            		<option value="${size}" ${pageRequestDTO.size == size ? 'selected' : '' }>${size}</option>
                            	</c:forTokens>
                            </select>
                        </div>
                    	
                        <div class="mb-3">
                            <input type="checkbox" name="finished" id="finished" value="1" ${pageRequestDTO.finished ? 'checked' : '' }>완료여부
                        </div>
                        <div class="mb-3">
                            <input type="checkbox" name="types" value="title"
                            	<c:forEach var="type" items="${pageRequestDTO.types}">${type == 'title' ? 'checked' : '' }</c:forEach>  
                            >제목
                            <input type="checkbox" name="types" value="writer"
                            	<c:forEach var="type" items="${pageRequestDTO.types}">${type == 'writer' ? 'checked' : '' }</c:forEach> 
                            >작성자
                            <input type="text"  name="keyword" class="form-control" value ='${pageRequestDTO.keyword}' >
                        </div>
                        <div class="input-group mb-3 dueDateDiv">
                            <input type="date" name="from" class="form-control" value="${pageRequestDTO.from}">
                            <input type="date" name="to" class="form-control"  value="${pageRequestDTO.to}">
                        </div>
                        <div class="input-group mb-3">
                            <div class="float-end">
                                <button class="btn btn-primary" type="submit">검색</button>
                                <button class="btn btn-info clearBtn" type="reset">초기화</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

        </div>
    </div>
	<div class="card-body" >
		<h5 class="card-title">Special Title ...</h5>
		<table class="table" style="100%">
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">일자</th>
					<th scope="col">진행상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="todo" items="${pageResponseDTO.list}">
				<tr>
					<td>${todo.id}</td>
					<td><a href="read?id=${todo.id}&${pageRequestDTO.link}">${todo.title}</a></td>
					<td>${todo.uid}</td>
					<td>${todo.dueDate}</td>
					<td>${todo.finishedStr}</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<jsp:include page="/WEB-INF/views/inc/page_nav.jsp"></jsp:include>
	
<a href="insert">등록</a>

<script>
const searchForm = document.getElementById("searchForm");
searchForm.addEventListener("reset", e => {
	e.preventDefault();
	e.stopPropagation();
	searchForm.size.value = 10;
	searchForm.finished.checked = false;
	searchForm.types.forEach(item => item.checked = false);
	searchForm.keyword.value = "";
	searchForm.from.value = "";
	searchForm.to.value = "";
});
</script>
</body>
</html>
