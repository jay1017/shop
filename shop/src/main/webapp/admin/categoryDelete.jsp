<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.admin.CategoryDAO" %>
<%@ page import="shop.admin.CategoryDTO" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page</title>
</head>
<body>
	<%
		int canum = Integer.parseInt(request.getParameter("canum"));
		CategoryDAO dao = CategoryDAO.getDAO();
		int result = dao.delete(canum); 
		if(result == 1) { %>
			<script>
				alert("삭제가 완료 되었습니다.");
				window.location="/shop/admin/category.jsp";
			</script>
		<% } else {  %>
			<script>
				alert("삭제에 실패하였습니다.");
			</script>
		<% } %>
</body>
</html>