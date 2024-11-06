<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
    
<jsp:include page="../layout/header.jsp" />

<div class="container-md">
	<br>
	<h1>User Modify Page</h1>
	<hr>
	<sec:authentication property="principal.uvo" var="uvo"/>
	<form action="/user/modify" method="post">
		<div class="card" style="width: 18rem;">
			<img src="/resources/image/pngwing.com.png" class="card-img-top" alt="...">
		 	<div class="card-body">
		    <h5 class="card-title">
		    	<input type="hidden" name="email" value="${uvo.email }" >
		    	<input type="text" name="nickName" class="from-contrl" value="${uvo.nickName }" >
				<input type="text" name="pwd" class="from-contrl" >
		    </h5>
		    <p class="card-text">${uvo.email }(${uvo.regDate })</p>
		    <p class="card-text"><small class="text-body-secondart">Last Login : ${uvo.lastLogin }</small> </p>
			<c:forEach items="${uvo.authList }" var="auths">
				<span class="badge rounded-pill text-bg-success"> ${auths.auth }</span>
			</c:forEach>
		    <button type="submit" class="btn btn-primary">modify</button>
		    <a href="/user/remove"><button type="button" class="btn btn-danger">remove</button></a>
		  </div>
		</div>
	</form>
</div>

<jsp:include page="../layout/footer.jsp" />