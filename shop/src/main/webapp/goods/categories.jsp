<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.goods.CategoryDTO" %>
<%@ page import="shop.goods.CategoryDAO" %>
<%@ page import="shop.cart.CartDAO" %>
<%@ page import="shop.cart.CartDTO" %>
<%@ page import="java.util.List" %>

<%
request.setCharacterEncoding("UTF-8");
CategoryDAO dao = CategoryDAO.getInstance();
CartDAO cdao = CartDAO.getInstance();
int canum = Integer.parseInt(request.getParameter("canum"));

    List<CategoryDTO> list = null;
    if (canum!=0) {
        list = dao.getGoodsList(canum);
    } else{
    	list = dao.getGoodsList();
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="description" content="Male_Fashion Template">
<meta name="keywords" content="Male_Fashion, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>ODEZ</title>
<link rel="stylesheet" href="/shop/resources/css/font.css" />
<link rel="stylesheet" href="/shop/resources/css/bootstrap.min.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/elegant-icons.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/magnific-popup.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/nice-select.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/owl.carousel.min.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/slicknav.min.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/style.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/font-awesome.min.css" type="text/css"/>
<script type="text/javascript" src="/shop/resources/js/header.js"></script>	
</head>
	
<title>카테고리 별 상품</title>
<body>
<jsp:include page="/include/header.jsp" />
	<jsp:include page="/include/sidebar.jsp" />
<h1><%=dao.getCaname(canum) %></h1>
<input type="button" value="홈" onclick="location.href='/shop/main/main.jsp'">
<input type="button" value="장바구니" onclick="location.href='/shop/cart/cart.jsp'">



<h2>상품 목록</h2>

<div>
<%  	if (list != null && !list.isEmpty()) {
        for (CategoryDTO dto : list) {
        	int gprice = dto.getGprice();
			int discount = dto.getDiscount();
			int disprice;
			if (discount != 0) {
				disprice = gprice - (gprice * discount / 100);
			}else{
				 disprice = gprice;
			}
%> <%--상품상세로 가는 a태그로 가두기 상품명에  --%>
    <div >
        <img src="image/<%=dto.getGiname() %>" alt="상품 이미지">
        <h3><a href="goodsview.jsp?gnum=<%=dto.getGnum()%>"><%= dto.getGname() %></a></h3>
        <p>가격: <%= dto.getGprice() %>원</p> 
        <p>할인가: <%=disprice %>원</p>
        <a href="/shop/buy/cash.jsp?gnum=<%= dto.getGnum() %>">구매하기</a>
        <input type="hidden" name="gnum" value="<%=dto.getGnum()%>">
    <form action="/shop/goods/cartpro.jsp" method="post">
    	<input type="hidden" name="gnum" value="<%=dto.getGnum()%>">
    	<input type="submit" value="장바구니에 담기"> 
	</form>
    </div>
<%}
    } else {%>
    <p>해당 카테고리에 상품이 없습니다.</p>
<%}%>
</div>
	<jsp:include page="/include/footer.jsp" />
</body>

<
