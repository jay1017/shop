<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.buy.BuyDAO" %>
<%@ page import="shop.buy.BuyDTO" %>     
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
		String pg_token = request.getParameter("pg_token");
		if(pg_token != null) { %>
			<script>
				alert("결제를 완료 하였습니다.");
				location.href="/shop/main/main.jsp";
			</script>
		<% } else { %>
			<script>
				alert("결제를 실패하였습니다.");
				history.go(-3);
			</script>
		<% }
	%>
</body>
</html>