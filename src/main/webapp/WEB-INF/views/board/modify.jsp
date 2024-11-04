<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<jsp:include page="../layout/header.jsp" />

<div class="container-md">
<br>
	<h1>Board Modify Page</h1>
	<hr>
	<c:set value="${bdto.bvo }" var="bvo"></c:set>
	<form action="/board/update" method="post" enctype="multipart/form-data">
		<div class="mb-3">
		  	<label for="n" class="form-label">no.</label>
			<input type="hidden" name="bno" value="${bvo.bno }">
		  	<input type="text" class="form-control" id="n" value="${bvo.bno }" readonly>
		</div>
		<div class="mb-3">
		  	<label for="t" class="form-label">title</label>
			<input type="text" class="form-control" name="title" id="t" value="${bvo.title }">
		</div>
		<div class="mb-3">
		  	<label for="w" class="form-label">writer</label>
		  	<input type="text" class="form-control" id="w" value="${bvo.writer }" readonly>
		  	<label for="r" class="badge text-bg-light">regDate ${bvo.regDate }</label>
		</div>
		<div class="mb-3">
		  	<label for="c" class="form-label">content</label>
		  	<textarea class="form-control" name="content" id="c" rows="3" >${bvo.content }</textarea>
		</div>
		<hr>
		
		<!-- 첨부파일 입력 라인 추가 -->
		<div class="mb-3">
		  <label for="file" class="form-label"></label>
		  <input type="file" class="form-control" name="files" id="file" 
		  multiple="multiple" style="display:none">
		  <button type="button" class="btn btn-outline-info btn-sm" id="trigger">FileUpload...</button>
		</div>
		
		<!-- 첨부파일 표시 라인 추가 -->
		<div class="mb-3" id="fileZone">
		</div>
		
		<!-- file upload 표시라인  -->
		<c:set value="${bdto.flist }" var="flist"></c:set>
		<div class="mb-3">
			<ul class="list-group">
				<!-- 파일의 개수만큼 li를 반복하여 파일 표시 타입이 1인 경우만 그림을 표시 -->
				<c:forEach items="${flist }" var="fvo">
					<li class="list-group-item">
						<c:choose>
							<c:when test="${fvo.fileType eq '1'}">
								<div>
									<img alt="" src="/upload/${fvo.saveDir }/${fvo.uuid}_${fvo.fileName}">
								</div>
							</c:when>
							<c:otherwise>
								<!-- 일반파일 : 아이콘 하나 가져와서 다운로드 가능하게 -->
								<a href="/upload/${fvo.saveDir }/${fvo.uuid}_${fvo.fileName}" download=""> 
									<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-file-earmark-arrow-down" viewBox="0 0 16 16">
									  <path d="M8.5 6.5a.5.5 0 0 0-1 0v3.793L6.354 9.146a.5.5 0 1 0-.708.708l2 2a.5.5 0 0 0 .708 0l2-2a.5.5 0 0 0-.708-.708L8.5 10.293z"/>
									  <path d="M14 14V4.5L9.5 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2M9.5 3A1.5 1.5 0 0 0 11 4.5h2V14a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h5.5z"/>
									</svg> 
									File Download
								</a>
							</c:otherwise>
						</c:choose>
						<div class="fw-bold">${fvo.fileName }</div>
						<span class="badge text-bg-light rounded-pill">regDate ${fvo.regDate } / ${fvo.fileSize } Bytes</span>
						<button type="button" data-uuid="${fvo.uuid }" class="btn btn-outline-danger btn-sm fdel">X</button>
					</li>
				</c:forEach>
			</ul>
		</div>
		
		<button type="submit" class="btn btn-secondary" id="regBtn">수정</button>
		<a href="/board/list"><button type="button" class="btn btn-warning">list</button></a>
	</form>
<script type="text/javascript" src="/resources/js/boardModify.js"></script>
<script type="text/javascript" src="/resources/js/boardRegister.js"></script>
</div>

<jsp:include page="../layout/footer.jsp" />