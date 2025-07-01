<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ page import="shop.cart.CartDTO" %>
<%@ page import="shop.cart.CartDAO" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ODEZ</title>
</head>
<body>
	<%
		int gnum = Integer.parseInt(request.getParameter("gnum"));
		System.out.println(gnum);
		
		CartDAO dao = CartDAO.getInstance();
		CartDTO dto = new CartDTO();
		
		dto = dao.getCart(gnum);
		System.out.println(dto);
		
		int result = dao.insertCart(dto);
		System.out.println(result);
	%>
</body>
</html>