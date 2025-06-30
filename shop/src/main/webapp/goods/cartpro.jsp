<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="shop.goods.categoryDTO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%--장바구니 담기 기능 페이지 --%>
<%
//로그인 확인
String sid = (String) session.getAttribute("sid");
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
	alert("장바구니에 추가되었습니다.")
	history.go(-1);
</script>