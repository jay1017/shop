<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.goods.categoryDTO" %>
<%@ page import="shop.goods.categoryDAO" %>
<%@ page import="java.util.List" %>

<%
request.setCharacterEncoding("UTF-8");
categoryDAO dao = categoryDAO.getInstance();
int canum = Integer.parseInt(request.getParameter("canum"));

    List<categoryDTO> list = null;
    if (canum!=0) {
        list = dao.getGoodsList(canum);
    } else{
    	list = dao.getGoodsList();
    }
%>

<title>카테고리 별 상품</title>
<header>
<h1><%=dao.getCaname(canum) %></h1>
<input type="button" value="홈" onclick="location.href='/shop/main/main.jsp'">
<input type="button" value="장바구니" onclick="location.href='/shop/cart/cart.jsp'">
</header>


<h2>상품 목록</h2>

<div>
<%  	if (list != null && !list.isEmpty()) {
        for (categoryDTO dto : list) {
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

