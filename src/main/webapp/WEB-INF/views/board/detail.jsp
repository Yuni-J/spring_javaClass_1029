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
		<a href="/board/modify?bno=${bvo.bno }"><button type="button" class="btn btn-success">수정</button></a>
		<a href="/board/delete?bno=${bvo.bno }"><button type="button" class="btn btn-danger">삭제</button></a>
		<br>
		<hr>
		<!-- comment line -->
		<!-- comment post -->
		<div class="input-group mb-3">
			<span class="input-group-text" id="cmtWriter">tester1@tester.com</span>
			<input type="text" id="cmtText" class="form-control" placeholder="Add Comment..." aria-label="Username" aria-describedy="basic-addon1">
			<button type="button" id="cmtAddBtn" class="btn btn-outline-secondary">post</button>
		</div>
		
		<!-- comment print -->
		<ul class="list-group" id="cmtListArea">
		  <li class="list-group-item">
		  	<div class="list-group-item">
		  		<div class="fw-bold">writer</div>
			      Content
		  	</div>			      
			<span class="badge text-bg-light rounded-pill">regDate ${cvo.regDate }</span>
		  </li>
		</ul>
		
		<!-- 댓글 더보기 버튼 -->
		<div>
			<button type="button" id="moreBtn" date-page="1" class="btn btn-dark" style="visibility:hidden">More +</button>
		</div>
		
		
		<!-- modal line -->
		<div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="cmtWriterMod">Writer</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		      	<input type="text" class="form-control" id="cmtTextMod">
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
		        <button type="button" id="cmtModBtn" class="btn btn-primary">Changes</button>
		      </div>
		    </div>
		  </div>
		</div>
		
		
		<script type="text/javascript">
			let bnoVal = `<c:out value="${bvo.bno }" />`;
			console.log(bnoVal);
		</script>

		<script src="/resources/js/boardDetailComment.js"></script>

		<script type="text/javascript">
			spreadCommentList(bnoVal);
		</script>

</div>

<jsp:include page="../layout/footer.jsp" />
