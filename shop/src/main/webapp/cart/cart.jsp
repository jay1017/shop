<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="basket.BasketDAO"%>
<%@page import="basket.BasketDTO"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<style>
.sidebar {
	flex: 1;
	padding: 1em;
	background: #e4e4e4;
}
</style>
<h1>장바구니</h1>
<div>
	<%-- 장바구니--%>
	<div>
		<img src="img/product1.jpg" alt="상품 이미지">
		<div>
			<p>상품명: 나이키 모자</p>
			<p>판매자: 나이키</p>
			<p>가 격 : ₩50000</p>
		</div>
	</div>
</div>

<div class="sidebar">
	<input type="button" value="홈" onclick="location.href='home.jsp'">
	<input type="button" value="검색" onclick="location.href='search.jsp'">
	<input type="button" value="⇧" onclick="window.scrollTo(0,0)"> 
	<input type="button" value="⇩" onclick="window.scrollTo(0,document.body.scrollHeight)">
	<input type="button" value="고객센터" onclick="location.href='ascenter.jsp'">
</div>