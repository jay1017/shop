<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.goods.categoryDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%//상품 장바구니로 넣기
    int gnum = Integer.parseInt(request.getParameter("gnum"));

    // 기존 장바구니 불러오기
    List<Integer> cart = (List<Integer>) session.getAttribute("cart");
    if (cart == null) {
        cart = new ArrayList<>();
    }

    // 장바구니에 상품 추가
    cart.add(gnum);
    session.setAttribute("cart", cart);
%>
<script>
	history.go(-1);
</script>