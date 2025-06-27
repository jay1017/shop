<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.admin.OptionDTO" %>
<%@ page import="shop.admin.OptionDAO" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page</title>
<script language="JavaScript" src="/shop/resources/js/admin.js"></script>
</head>
<body>
	<%
		int gonum = Integer.parseInt(request.getParameter("gonum"));
		OptionDAO dao = OptionDAO.getDAO();
		OptionDTO dto = dao.select(gonum); 
	%>
	<h1>옵션 수정</h1>
	<form action="optionUpdatePro.jsp" method="post" onsubmit="checkOption(event)">
		<input type="hidden" name="gonum" value="<%=gonum %>" />
		색상 : <input type="text" value="<%=dto.getGocolor() %>" name="gocolor" id="gocolor" />
		사이즈 : <input type="text" value="<%=dto.getGosize() %>" name="gosize" id="gosize" />
		<input type="submit" value="수정"/>
	</form>
</body>
</html>