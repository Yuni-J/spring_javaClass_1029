<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../layout/header.jsp" />

<div class="container-md">
	<br>
	<h1>Board List Page</h1>
	<hr>
	<!-- search line -->
	<div class="container-fluid">
		<form action="/board/list" method="get" class="d-flex" role="search">
			<select class="form-select" name="type" id="inputGroupSelect01">
			    <option ${ph.pgvo.type == null ? 'selected' : '' }>Choose...</option>
			    <option value="t" ${ph.pgvo.type eq 't' ? 'selected' : '' }>title</option>
			    <option value="w" ${ph.pgvo.type eq 'w' ? 'selected' : '' }>writer</option>
			    <option value="c" ${ph.pgvo.type eq 'c' ? 'selected' : '' }>content</option>
			    <option value="tw" ${ph.pgvo.type eq 'tw' ? 'selected' : '' }>title+writer</option>
			    <option value="wc" ${ph.pgvo.type eq 'wc' ? 'selected' : '' }>writer+content</option>
			    <option value="tc" ${ph.pgvo.type eq 'tc' ? 'selected' : '' }>title+content</option>
			    <option value="twc" ${ph.pgvo.type eq 'twc' ? 'selected' : '' }>all</option>
		  	</select>
	        <input class="form-control me-2" name="keyword" type="search" placeholder="Search" value="${ph.pgvo.keyword }" aria-label="Search">
	        <input type="hidden" name="pageNo" value="1">
	        <input type="hidden" name="qty" value="${ph.pgvo.qty }">
	    	<%-- <button class="btn btn-outline-success" type="submit">Search
	    	<span class="badge rounded-pill text-bg-warning">${ph.totalCount }</span>
	    	</button> --%>
	    	<button type="submit" class="btn btn-success position-relative">
			  search
			  <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-primary">
			    ${ph.totalCount }
			    <span class="visually-hidden">unread messages</span>
			  </span>
			</button>
	    </form>
	    <%-- ${ph } --%>
	</div>
	<br>
	<table class="table table-hover">
		<thead>
		 	  <tr>
		  	 	<th scope="col">#</th>
		   		 <th scope="col">title</th>
		    	<th scope="col">writer</th>
		    	<th scope="col">regDate</th>
		    	<th scope="col">readCount</th>
		    	<th scope="col">cmtQty</th>
		    	
		  	 </tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="bvo">
		  		<tr>
		  			<td>${bvo.bno } </td>
		  			<td style="position: relative;">
					    <a href="/board/detail?bno=${bvo.bno}">${bvo.title}</a>
					    <span class="position-absolute top-0 start-20 badge rounded-pill bg-secondary">${bvo.hasFile }</span>
					</td>
		  			<td>${bvo.writer }</td>
		  			<td>${bvo.regDate }</td>
		  			<td>${bvo.readCount }</td>
		  			<td>${bvo.cmtQty }</td>		  			
		  		</tr>	
		  	</c:forEach>
		</tbody>
	</table>
	
	<!-- pagination line -->
	<!-- <<  >> : 값이 false 면 disabled -->
	<nav aria-label="Page navigation example">
	  <ul class="pagination justify-content-center">
	    <li class="page-item ${ph.prev eq false ? 'disabled' : '' }">
	      <a class="page-link" href="/board/list?pageNo=${ph.startPage - 1}&aty=${pg.pgvo.qty}&type=${ph.pgvo.type }&keyword=${ph.pgvo.keyword}" aria-label="Previous">
	        <span aria-hidden="true">&laquo;</span>
	      </a>
	    </li>
	    <c:forEach begin="${ph.startPage }" end="${ph.endPage }"  var="i">
		    <li class="page-item ${ph.pgvo.pageNo eq i ? 'active' : '' }"><a class="page-link" href="/board/list?pageNo=${i }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type }&keyword=${ph.pgvo.keyword}">${i }</a></li>	    
	    </c:forEach>
	    
	    <li class="page-item ${ph.next eq false ? 'disabled' : '' }">
	      <a class="page-link" href="/board/list?pageNo=${ph.endPage + 1}&qty=${ph.pgvo.qty}&type=${ph.pgvo.type }&keyword=${ph.pgvo.keyword}" aria-label="Next">
	        <span aria-hidden="true">&raquo;</span>
	      </a>
	    </li>
	  </ul>
	</nav>
	<a href="/"><button type="button" class="btn btn-success">index</button></a>
</div>

<jsp:include page="../layout/footer.jsp" />