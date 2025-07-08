<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.buy.KakaoPayReadyServlet" %>  
<%@ page import="shop.buy.BuyDAO" %>
<%@ page import="shop.buy.BuyDTO" %>  
<%@ page import="shop.coupon.CouponDAO" %>
<%@ page import="shop.coupon.CouponDTO" %>   
<%@ page import="shop.goods.GoodsDTO" %>
<%@ page import="shop.member.MemberDTO" %>
<%@ page import="shop.member.MemberDAO" %>  
<%@ page import="java.util.List" %> 
<%@ page import="java.util.ArrayList" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		KakaoPayReadyServlet kakao = new KakaoPayReadyServlet();
		kakao.doPost(request, response);
	%>
</body>
</html>