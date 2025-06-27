<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<nav id="sidebar" class="sidebar js-sidebar">
	<div class="sidebar-content js-simplebar">
		<a class="sidebar-brand" href="index.html"> 
			<span class="align-middle">AdminKit</span>
		</a>
		<ul class="sidebar-nav">
			<li class="sidebar-header">메인</li>
			<li class="sidebar-item">
				<a class="sidebar-link" href="/shop/admin/main.jsp"> 
					<span class="align-middle">메인</span>
				</a>
			</li>
			<li class="sidebar-item">
				<%
					String mid = (String) session.getAttribute("admin");
					if(mid == null) { %>
						<a class="sidebar-link" href="/shop/admin/login.jsp">
							<span class="align-middle">로그인</span>
						</a>
					<% } else { %>
						<a class="sidebar-link" href="/shop/admin/logout.jsp">
							<span class="align-middle">로그아웃</span>
						</a>
					<% } %>
			</li>
			<li class="sidebar-header">목록</li>
			<li class="sidebar-item">
				<a class="sidebar-link" href="/shop/admin/category.jsp">
					<span class="align-middle">카테고리</span>
				</a>
			</li>
			<li class="sidebar-item">
				<a class="sidebar-link" href="/shop/admin/goods.jsp">
					<span class="align-middle">상품</span>
				</a>
			</li>
			<li class="sidebar-item">
				<a class="sidebar-link" href="/shop/admin/member.jsp">
					<span class="align-middle">회원</span>
				</a>
			</li>
		</ul>
	</div>
</nav>