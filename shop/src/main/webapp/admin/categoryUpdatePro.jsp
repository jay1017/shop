<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.admin.CategoryDAO" %>
<%@ page import="shop.admin.CategoryDTO" %>
<% request.setCharacterEncoding("UTF-8"); %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		CategoryDTO dto = new CategoryDTO();
		String caname = request.getParameter("caname");
		int canum = Integer.parseInt(request.getParameter("canum"));
		dto.setCanum(canum);
		dto.setCaname(caname);
		
		CategoryDAO dao = CategoryDAO.getDAO();
		int result = dao.update(dto); 
		if(result == 1) { %>
			<script>
				alert("수정이 완료되었습니다.");
				window.location = "/shop/admin/category.jsp";
			</script>
		<% } else { %>
			<script>
				alret("수정에 실패하였습니다.");
			</script>
		<% } %>
</body>
</html>