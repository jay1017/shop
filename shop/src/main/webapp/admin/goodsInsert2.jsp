<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.admin.GoodsDAO" %>    
<%@ page import="shop.admin.CategoryDTO" %>   
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
		GoodsDAO dao = GoodsDAO.getDAO();
		List<CategoryDTO> list = dao.selectCategory(); 
		int ginum = Integer.parseInt(request.getParameter("ginum"));
	%>
	<form action="goodsInsertPro2.jsp" method="post" onsubmit="checkGoods2(event)">
		<input type="hidden" value="<%=ginum %>" name="ginum" />
		카테고리 :
		<select name="canum">
		<% for(CategoryDTO dto : list) { %>
			<option value="<%=dto.getCanum()%>"><%=dto.getCaname() %></option>
		<% } %>
		</select><br />
		상품명 : <input type="text" name="gname" id="gname"/><br />
		가격 : <input type="number" name="gprice" id="gprice"/><br />
		상품 설명 : <textarea name="gcontent"></textarea><br />
		할인율 : <input type="number" name="discount"/><br />
		<input type="submit" value="저장하고 다음 화면으로" />
	</form>
</body>
</html>