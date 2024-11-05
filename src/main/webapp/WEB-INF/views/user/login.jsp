<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<jsp:include page="../layout/header.jsp" />

<div class="container-md">
<br>
	<h1>User Login Page</h1>
	<hr>
	<form action="/user/login" method="post" enctype="multipart/form-data">
	<div class="mb-3">
		 <label for="e" class="form-label">email</label>
		 <input type="text" class="form-control" name="email" id="e" placeholder="email...">
	</div>
	<div class="mb-3">
		 <label for="p" class="form-label">password</label>
		 <input type="text" class="form-control" name="pwd" id="p" placeholder="Password...">
	</div>
	
	<!-- 로그인 실패시 errMessage 출력 -->
	<c:if test="${param.errMsg ne null }">
		<div class="text-danger">${param.errMsg }</div>
	</c:if>
	<button type="submit" class="btn btn-primary">Login</button>
	</form>

</div>

<jsp:include page="../layout/footer.jsp" />