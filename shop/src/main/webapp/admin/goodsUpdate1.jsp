<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.admin.GoodsImageDTO" %>
<%@ page import="shop.admin.GoodsImageDAO" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page</title>
</head>
<body>
	<%
		GoodsImageDAO dao = GoodsImageDAO.getDAO();
		GoodsImageDTO dto = new GoodsImageDTO();
		
		int ginum = Integer.parseInt(request.getParameter("ginum"));
		int gnum = Integer.parseInt(request.getParameter("gnum"));
		int gonum = Integer.parseInt(request.getParameter("gonum"));
		dto = dao.select(ginum);
	%>
	<form action="goodsUpdatePro1.jsp" method="post" enctype="multipart/form-data" onsubmit="checkGoods1(event);">
		<input type="hidden" name="ginum" value="<%= ginum%>"/>
		<input type="hidden" name="gonum" value="<%= gonum%>"/>
		<input type="hidden" name="gnum" value="<%= gnum%>"/>
		대표 이미지 : <input type="file" name="giname"/><br />
		<% if(dto.getGiname() != null) { %>
			기존이미지 <br /> <img src="/shop/resources/image/<%=dto.getGiname() %>" width="300"/><br />
		<% } %>
		상세 이미지 1 : <input type="file" name="gidetail1"/><br />
		<% if(dto.getGidetail1() != null) { %>
			기존이미지 <br /> <img src="/shop/resources/image/<%=dto.getGidetail1() %>" width="300"/><br />
		<% } %>
		상세 이미지 2 : <input type="file" name="gidetail2"/><br />
		<% if(dto.getGidetail2() != null) { %>
			기존이미지 <br /> <img src="/shop/resources/image/<%=dto.getGidetail2() %>" width="300"/><br />
		<% } %>
		상세 이미지 3 : <input type="file" name="gidetail3"/><br />
		<% if(dto.getGidetail3() != null) { %>
			기존이미지 <br /> <img src="/shop/resources/image/<%=dto.getGidetail3() %>" width="300"/><br />
		<% } %>
		<input type="submit" value="저장하고 다음 화면으로" />
	</form>
</body>
</html>