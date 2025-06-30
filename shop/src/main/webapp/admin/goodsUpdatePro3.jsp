<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.admin.OptionDTO" %>
<%@ page import="shop.admin.OptionDAO" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page</title>
</head>
<body>
	<%
		OptionDAO dao = OptionDAO.getDAO();
		OptionDTO dto = new OptionDTO();
		
		int gocount = Integer.parseInt(request.getParameter("gocount"));
		int canum = Integer.parseInt(request.getParameter("canum"));
		int ginum = Integer.parseInt(request.getParameter("ginum"));
		int gnum = Integer.parseInt(request.getParameter("gnum"));
		int gonum = Integer.parseInt(request.getParameter("gonum"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		
		dto.setGocolor(request.getParameter("gocolor"));
		dto.setGosize(request.getParameter("gosize"));
		dto.setGocount(gocount);
		dto.setCanum(canum);
		dto.setGinum(ginum);
		dto.setGnum(gnum);
		dto.setGonum(gonum);
		
		int result = dao.update(dto);
		if(result == 1) { %>
			<script>
				alert("상품 수정이 완료 되었습니다.");
				window.location="/shop/admin/goods.jsp?pageNum=<%=pageNum%>";
			</script>
		<% } else { %>
			<script>
				alert("상품 수정 중 오류가 발생했습니다.");
				history.go(-1);
			</script>
		<% } %>
</body>
</html>