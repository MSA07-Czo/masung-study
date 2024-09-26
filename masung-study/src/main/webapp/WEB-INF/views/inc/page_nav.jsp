<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="d-flex justify-content-center">
	<ul class="pagination flex-wrap">
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
	</ul>
</div>

<script>
document.querySelectorAll(".page-link").forEach(item => {
	item.addEventListener('click', e => {
		e.preventDefault();
		e.stopPropagation();
		
		const param = e.target.getAttribute("data-param");
		self.location = "list?" + param;
	});
});
</script>