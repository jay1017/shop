<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="shop.cart.cartDAO"%>
<%@page import="shop.cart.cartDTO"%>
<%@page import="java.util.List"%>
<%
request.setCharacterEncoding("UTF-8");
cartDAO dao = cartDAO.getInstance();
int gnum = Integer.parseInt(request.getParameter("gnum"));
List<cartDTO> list = dao.getCart(gnum);
String sid = (String) session.getAttribute("sid");
%>
<style>
.sidebar {
	flex: 1;
	padding: 1em;
	background: #e4e4e4;
}
</style>
<%
if (sid != null) {
%>
<header>
	<h1>장바구니</h1>
</header>
<div>
	<%-- 장바구니--%>
	<%
	if (list != null) {
		for (cartDTO dto : list) {
	%>
	<div>
		<img src="img/<%=dto.getGiname()%>" alt="상품 이미지">
		<div>
			<p>상품명:<%=dto.getGname()%></p>
			<p>가 격 : ₩<%=dto.getGprice()%></p>
			<p>판매가 : ₩<%=dto.getDisprice()%></p>
			<input type="button" value="구매"
				onclick="location.href='cash.jsp?gnum=<%=dto.getGnum()%>'">
		</div>
		<%
		}
		} else {
		%>
		<p>장바구니에 담긴 상품이 없습니다.</p>
		<%
		}
		%>
	</div>
</div>

<div class="sidebar">
	<input type="button" value="홈" onclick="location.href='home.jsp'">
	<input type="button" value="검색" onclick="location.href='search.jsp'">
	<input type="button" value="구매내역" onclick="location.href='buy.jsp'">
	<input type="button" value="⇧" onclick="window.scrollTo(0,0)">
	<input type="button" value="⇩" onclick="window.scrollTo(0,document.body.scrollHeight)"> 
		<input type="button" value="고객센터" onclick="location.href='ascenter.jsp'">
</div>
<%} else {%>
<script>
	alert("로그인 후 이용해주세요");
	history.go(-1);
</script>
<%}%>

