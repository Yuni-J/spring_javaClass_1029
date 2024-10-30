<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<jsp:include page="../layout/header.jsp" />

<div class="container-md">
<br>
	<h1>Board Detail Page</h1>
	<hr>
		<div class="mb-3">
		  <label for="n" class="form-label">no.</label>
		  <input type="text" class="form-control" id="n" value="${bvo.bno }" readonly>
		</div>
		<div class="mb-3">
		  <label for="t" class="form-label">title</label>
		  <input type="text" class="form-control" id="t" value="${bvo.title }" readonly>
		</div>
		<div class="mb-3">
		  <label for="w" class="form-label">writer</label>
		  <input type="text" class="form-control" id="w" value="${bvo.writer }" readonly>
		  <label for="r" class="badge text-bg-light">regDate ${bvo.regDate }</label>
		</div>
		<div class="mb-3">
		  <label for="c" class="form-label">content</label>
		  <textarea class="form-control" id="c" rows="3" value="${bvo.content }" readonly>${bvo.content }</textarea>
		</div>
		<a href="/board/modify?bno=${bvo.bno }"><button type="button" class="btn btn-secondary">수정</button></a>
		<a href="/board/delete?bno=${bvo.bno }"><button type="button" class="btn btn-danger">삭제</button></a>
</div>

<jsp:include page="../layout/footer.jsp" />