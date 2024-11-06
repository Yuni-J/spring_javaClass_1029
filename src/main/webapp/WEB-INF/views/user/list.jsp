<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<jsp:include page="../layout/header.jsp" />

<div class="container-md">
<br>
	<h1>User List Page</h1>
	<hr>
	<div class="row row-cols-1 row-cols-md-3 g-4">
		<c:forEach items="${userList }" var="uvo">
  			<div class="col">
				<div class="card" style="width: 18rem;">
					<img src="/resources/image/pngwing.com.png" class="card-img-top" alt="...">
					<div class="card-body">
						<h5 class="card-title">${uvo.email }(${uvo.nickName })</h5>
						<p class="card-text">가입일 : ${uvo.regDate } / 최근 로그인 : ${uvo.lastLogin }</p>
						<c:forEach items="${uvo.authList }" var="avo">
							<a href="#" class="btn btn-primary">${avo.auth }</a>
						</c:forEach>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>

<jsp:include page="../layout/footer.jsp" />