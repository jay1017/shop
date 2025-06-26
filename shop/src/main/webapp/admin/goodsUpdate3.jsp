<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.admin.OptionDAO" %>   
<%@ page import="shop.admin.OptionDTO" %>    
<%@ page import="java.util.List" %>       
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
		int ginum = Integer.parseInt(request.getParameter("ginum"));
		int gnum = Integer.parseInt(request.getParameter("gnum"));
		int gonum = Integer.parseInt(request.getParameter("gonum"));
		
		System.out.println(gonum);
		
		OptionDAO dao = OptionDAO.getDAO();
		OptionDTO dto = dao.select(gonum);
	%>

	<form action="goodsUpdatePro3.jsp" method="post" onsubmit="checkGoods3(event)">
		<input type="hidden" value="<%=canum%>" name="canum"/>
		<input type="hidden" value="<%=ginum%>" name="ginum"/>
		<input type="hidden" value="<%=gnum%>" name="gnum"/>
		<input type="hidden" value="<%=gonum%>" name="gonum"/>
		사이즈 : <input type="text" name="gosize" value="<%= dto.getGosize()%>"/><br />
		색상 : <input type="text" name="gocolor" value="<%=dto.getGocolor()%>"/><br />
		수량 : <input type="text" name="gocount" id="gocount" value="<%=dto.getGocount()%>"/><br />
		<input type="submit" value="저장" />
	</form>
</body>
</html>