<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.admin.CategoryDTO" %>   
<%@ page import="shop.admin.CategoryDAO" %> 
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% 	CategoryDTO dto = new CategoryDTO();
		String caname = request.getParameter("caname");
		dto.setCaname(caname);
		CategoryDAO dao = CategoryDAO.getDAO();
		int result = dao.insert(dto);
		if(result == 1) { %>
			<script>
				alert("등록이 완료 되었습니다.");
				window.location = "/shop/admin/category.jsp";
			</script>
		<% } else { %>
			<script>
				alert("등록이 실패하였습니다.");
			</script>
		<% } %>
</body>
</html>