<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.admin.OptionDTO" %>
<%@ page import="shop.admin.OptionDAO" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page</title>
</head>
<body>
	<%
		OptionDTO dto = new OptionDTO();
		int gonum = Integer.parseInt(request.getParameter("gonum"));
		dto.setGonum(gonum);
		dto.setGosize(request.getParameter("gosize"));
		dto.setGocolor(request.getParameter("gocolor"));
		
		OptionDAO dao = OptionDAO.getDAO();
		int result = dao.update(dto);
		if(result == 1) { %>
		<script>
			alert("수정이 완료되었습니다.");
			window.location = "/shop/admin/option.jsp";
		</script>
	<% } else { %>
		<script>
			alret("수정에 실패하였습니다.");
		</script>
	<% } %>
</body>
</html>