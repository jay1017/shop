<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.admin.GoodsDAO" %> 
<%@ page import="shop.admin.GoodsDTO" %>    
<%@ page import="shop.admin.CategoryDTO" %>   
<%@ page import="java.util.List" %>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page</title>
</head>
<body>
	<%
		GoodsDAO dao = GoodsDAO.getDAO();
		List<CategoryDTO> list = dao.selectCategory(); 
		int ginum = Integer.parseInt(request.getParameter("ginum"));
		int gnum = Integer.parseInt(request.getParameter("gnum"));
		int gonum = Integer.parseInt(request.getParameter("gonum"));
		
		GoodsDTO dto = new GoodsDTO();
		dto = dao.select(gnum);
		
	%>
	<form action="goodsUpdatePro2.jsp" method="post" onsubmit="checkGoods2(event)">
		<input type="hidden" value="<%=dto.getCanum() %>" name="canum" />
		<input type="hidden" value="<%=gnum %>" name="gnum" />
		<input type="hidden" value="<%=gonum %>" name="gonum" />
		<input type="hidden" value="<%=ginum %>" name="ginum" />
		카테고리 :
		<select name="canum">
		<% for(CategoryDTO category : list) { %>
			<% if(category.getCanum() == dto.getCanum()) { %>
				<option value="<%=dto.getCanum()%>" selected><%=category.getCaname() %></option>
			<% } else { %>
				<option value="<%=dto.getCanum()%>"><%=category.getCaname() %></option>
			<% } %>
		<% } %>
		</select><br />
		상품명 : <input type="text" name="gname" id="gname" value="<%=dto.getGname()%>"/><br />
		가격 : <input type="number" name="gprice" id="gprice" value="<%=dto.getGprice()%>"/><br />
		상품 설명 : <textarea name="gcontent"><%=dto.getGcontent()%></textarea><br />
		할인율 : <input type="number" name="discount" value="<%=dto.getDiscount()%>"/><br />
		<input type="submit" value="저장하고 다음 화면으로" />
	</form>
</body>
</html>