<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.admin.BuyerDAO" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		BuyerDAO dao = BuyerDAO.getDAO();
		int result = dao.update(bnum); 
		
		if(result == 1) { %>
			<script>
				alert("발송이 완료 되었습니다.");
				history.go(-1);
			</script>
		<% } else { %>
			<script>
				alert("발송을 하지 못하였습니다.");
				history.go(-1);
			</script>
		<% } %>
	
</body>
</html>