<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../layout/header.jsp" />

<div class="container-md">
<br>
	<h1>Board Register Page</h1>
	<hr>
	<form action="/board/insert" method="post">
		<div class="mb-3">
		  <label for="t" class="form-label">title</label>
		  <input type="text" class="form-control" name="title" id="t" placeholder="title...">
		</div>
		<div class="mb-3">
		  <label for="w" class="form-label">writer</label>
		  <input type="text" class="form-control" name="writer" id="w" placeholder="title...">
		</div>
		<div class="mb-3">
		  <label for="c" class="form-label">content</label>
		  <textarea class="form-control" name="content" id="c" rows="3"></textarea>
		</div>
		<button type="submit" class="btn btn-primary">버튼</button>
	</form>
</div>

<jsp:include page="../layout/footer.jsp" />