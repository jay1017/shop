<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.admin.CategoryDAO" %>    
<%@ page import="shop.admin.CategoryDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page</title>
<script language="JavaScript" src="/shop/resources/js/admin.js"></script>
</head>
<body>
	<%
		int canum = Integer.parseInt(request.getParameter("canum"));
		CategoryDAO dao = CategoryDAO.getDAO();
		CategoryDTO dto = dao.select(canum); 
	%>
	<h1>카테고리 수정</h1>
	<form action="categoryUpdatePro.jsp" method="post" onsubmit="checkCategory(event)">
		<input type="hidden" name="canum" value="<%=dto.getCanum() %>" />
		카테고리명 : <input type="text" name="caname"  id="caname" value="<%=dto.getCaname() %>" />
		<input type="submit" value="수정" />
	</form>
</body>
</html>