<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.admin.CouponDTO" %>
<%@ page import="shop.admin.CouponDAO" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String cptype = request.getParameter("cptype");
		int cpvalue = Integer.parseInt(request.getParameter("cpvalue"));
		String cpname = request.getParameter("cpname");
		int cpmop = Integer.parseInt(request.getParameter("cpmop"));
		int cpdate = Integer.parseInt(request.getParameter("cpdate"));
		int cpnum = Integer.parseInt(request.getParameter("cpnum"));
		
		CouponDTO dto = new CouponDTO();
		dto.setCptype(cptype);
		dto.setCpvalue(cpvalue);
		dto.setCpname(cpname);
		dto.setCpmop(cpmop);
		dto.setCpdate(cpdate);
		dto.setCpnum(cpnum);
		
		CouponDAO dao = CouponDAO.getDAO();
		int result = dao.update(dto); 
	%>
	<% if(result == 1) { %>
		<script>
			alert("수정을 완료 되었습니다.");
			location.href="/shop/admin/coupon.jsp";
		</script>
	<% } else { %>
		<script>
			alert("수정을 실패하였습니다.");
			location.href="/shop/admin/coupon.jsp";
		</script>
	<% } %>
</body>
</html>