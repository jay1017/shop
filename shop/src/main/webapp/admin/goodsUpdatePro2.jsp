<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.admin.GoodsDTO" %>
<%@ page import="shop.admin.GoodsDAO" %>   
<%@ page import="java.util.List" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		GoodsDTO dto = new GoodsDTO();
		GoodsDAO dao = GoodsDAO.getDAO();
		
		int canum = Integer.parseInt(request.getParameter("canum"));
		int gprice = Integer.parseInt(request.getParameter("gprice"));
		int discount = Integer.parseInt(request.getParameter("discount"));
		int ginum = Integer.parseInt(request.getParameter("ginum"));
		int gnum = Integer.parseInt(request.getParameter("gnum"));
		int gonum = Integer.parseInt(request.getParameter("gonum"));
		
		dto.setCanum(canum);
		dto.setGinum(ginum);
		dto.setGname(request.getParameter("gname"));
		dto.setGprice(gprice);
		dto.setGcontent(request.getParameter("gcontent"));
		dto.setDiscount(discount);
		dto.setGnum(gnum);
		
		int result = dao.update(dto);  
		if(result == 1) { %>
			<script>
				alert("정상적으로 저장 되었습니다.");
				location.href="/shop/admin/goodsUpdate3.jsp?canum=<%=canum%>&ginum=<%=ginum%>&gnum=<%=gnum%>&gonum=<%=gonum%>";
			</script>
		<% } else { %>
			<script>
				alert("페이지에서 오류가 발생했습니다.");
				history.go(-1);
			</script>
		<% } %>
</body>
</html>