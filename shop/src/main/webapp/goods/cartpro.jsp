<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="shop.goods.categoryDTO"%>
<%@ page import="shop.cart.cartDAO" %>
<%@ page import="shop.cart.cartDTO" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%--장바구니 담기 기능 페이지 --%>
<%
//로그인 확인
String sid = (String) session.getAttribute("sid");
int gnum = Integer.parseInt(request.getParameter("gnum"));
cartDAO dao = cartDAO.getInstance();
cartDTO dto = dao.getCartAdd(gnum);
int count = 0;

// 장바구니에 상품 추가
dao.insertCart(dto);
dto.setCcount(count++);
%>

<script>
	alert("장바구니에 추가되었습니다.")
	history.go(-1);
</script>