<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.member.MemberDTO" %>
<%@ page import="shop.member.MemberDAO" %>

<%
	request.setCharacterEncoding("UTF-8");

	MemberDAO dao = new MemberDAO();
%>
<title>구매내역 페이지</title>    
<header>
<h1>구매내역</h1>
<%--최근구매 3개까지만 나오게하기 최신뉴스 참조--%>
<input type="button" value="전체 구매내역" onclick=>
<input type="button" value="장바구니" onclick="location.href='cart.jsp'">
<input type="button" value="고객센터" onclick="location.href='as.jsp'">
</header>


