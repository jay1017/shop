<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.admin.MemberDAO" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page</title>
</head>
<body>
	<%
		int mnum = Integer.parseInt(request.getParameter("mnum"));
		MemberDAO dao = MemberDAO.getDAO();
		int result = dao.delete(mnum);
		
		if(result == 0) {%>
			<script>
				alert("삭제를 실패하였습니다.");
				history.go(-1);
			</script>
		<% } else { %>
			<script>
				alert("삭제 완료 하였습니다.");
				location.href="/shop/admin/member.jsp";
			</script>
		<% } %>
	
</body>
</html>