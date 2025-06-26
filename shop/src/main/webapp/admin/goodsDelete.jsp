<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.admin.GoodsDAO" %>
<%@ page import="shop.admin.GoodsImageDAO" %>  
<%@ page import="shop.admin.OptionDAO" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page</title>
</head>
<body>
	<%
		OptionDAO dao1 = OptionDAO.getDAO();
		GoodsDAO dao2 = GoodsDAO.getDAO();
		GoodsImageDAO dao3 = GoodsImageDAO.getDAO();
		
		int gonum = Integer.parseInt(request.getParameter("gonum"));
		int gnum = Integer.parseInt(request.getParameter("gnum"));
		int ginum = Integer.parseInt(request.getParameter("ginum"));
		
		int result1 = dao1.delete(gonum); 
		System.out.println(result1);
		int result2 = dao2.delete(gnum); 
		System.out.println(result2);
		int result3 = dao3.delete(ginum);
		System.out.println(result3);
		
		if(result1 == 1 && result2 == 1 && result3 == 1) { %>
			<script>
				alert("삭제가 완료되었습니다.");
				location.href="/shop/admin/goods.jsp";
			</script>
		<% } else { %>
			<script>
				alert("삭제를 실패하였습니다.");
				location.href="/shop/admin/goods.jsp";
			</script>
		<% } %>
</body>
</html>