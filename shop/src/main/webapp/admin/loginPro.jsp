<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.admin.LoginDTO" %>
<%@ page import="shop.admin.LoginDAO" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String mid = request.getParameter("mid");
		String mpw = request.getParameter("mpw");
		
		LoginDAO dao = LoginDAO.getDAO();
		LoginDTO dto = new LoginDTO();
		dto.setMid(mid);
		dto.setMpw(mpw);
		
		int result = dao.login(dto); 
		if(result == 1) { %>
			<script>
				alert("관리자님 환영합니다.");
				location.href="/shop/admin/main.jsp";
			</script>
			<% session.setAttribute("admin", mid); %>
		<% } else { %>
			<script>
				alert("아이디나 비밀번호가 틀렸습니다.");
				history.go(-1);
			</script>
		<% } %>
	
	
</body>
</html>