<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.admin.OptionDTO" %>   
<%@ page import="shop.admin.OptionDAO" %> 
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% 	OptionDTO dto = new OptionDTO();
		String gocolor = request.getParameter("gocolor");
		String gosize = request.getParameter("gosize");
		dto.setGocolor(gocolor);
		dto.setGosize(gosize);
		OptionDAO dao = OptionDAO.getDAO();
		int result = dao.insert(dto); 
		if(result == 1) { %>
			<script>
				alert("등록이 완료 되었습니다.");
				window.location = "/shop/admin/option.jsp";
			</script>
		<% } else { %>
			<script>
				alert("등록이 실패하였습니다.");
			</script>
		<% } %>
</body>
</html>