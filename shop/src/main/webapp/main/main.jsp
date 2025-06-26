<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="shop.main.MainDAO,shop.main.GoodsDTO,java.util.List"%>
<%@ page import="shop.main.CategoryDTO"%> 

<%
String sid = (String) session.getAttribute("sid");
MainDAO dao = MainDAO.getInstance();
List<CategoryDTO> list = dao.getCate();
%>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>사이트 이름</title>
<link rel="stylesheet" href="/shop/resources/css/font.css" />

</head>
<body>
	<%--헤더--%>
	<header>
		<div>
			<a href="">문의하기</a>
		</div>
		<div>
			<h1>사이트 이름</h1>
		</div>
		<%
		if (sid != null) {
		%>
		<div>
			<a href="/shop/member/memberInfo.jsp">마이페이지</a> | <a href="">장바구니</a>
			| <a href="">주문내역</a> | <a href="/shop/member/logoutForm.jsp">로그아웃</a>
		</div>
		<%
		} else {
		%>
		<div>
			<a href="/shop/member/loginForm.jsp">로그인</a> | <a
				href="/shop/member/memberForm.jsp">회원가입</a>
		</div>
		<%
		}
		%>
		<nav>
			<div>
			<a href="categories.jsp">카테고리별 보기</a>
				<%
				for (CategoryDTO dto : list) {
				%> 
				<form action="categories.jsp" method="get">
					 <input type="hidden" name="canum" value="<%=dto.getCanum()%>">
					<button type="submit"><%=dto.getCaname()%></button>
				</form>
			</div>
			<%
			}
			%>
		</nav>
		<div class="search">
			<form action="search.jsp">
				<input type="text" name="key" placeholder="검색어 입력">
				<button type="submit">검색</button>
			</form>
		</div>
	</header>
	<%--헤더--%>

	인기 상품
	<%--조회수로 처리 --%>
	<div></div>
	최신 상품
	<div></div>
</body>
</html>