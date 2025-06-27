<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.admin.OptionDAO" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		int gonum = Integer.parseInt(request.getParameter("gonum"));
		OptionDAO dao = OptionDAO.getDAO();
		int result = dao.delete(gonum);
		if(result == 1) { %>
			<script>
				alert("삭제가 완료 되었습니다.");
				window.location="/shop/admin/option.jsp";
			</script>
		<% } else {  %>
			<script>
				alert("삭제에 실패하였습니다.");
			</script>
		<% } %>
</body>
</html>