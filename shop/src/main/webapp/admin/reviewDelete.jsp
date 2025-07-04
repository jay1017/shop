<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.admin.ReviewDAO" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		int rnum = Integer.parseInt(request.getParameter("rnum"));
		ReviewDAO dao = ReviewDAO.getDAO();
		int result = dao.delete(rnum);
		if(result == 1) { %>
			<script>
				alert("삭제가 완료 되었습니다.");
				location.href="/shop/admin/review.jsp";
			</script>	
		<% } else { %>
			<script>
				alert("삭제 중 오류가 발생했습니다.");
				location.href="/shop/admin/review.jsp";
			</script>
		<% } %>
</body>
</html>