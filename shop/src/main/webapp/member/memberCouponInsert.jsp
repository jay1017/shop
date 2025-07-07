<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.coupon.CouponDTO" %>
<%@ page import="shop.coupon.CouponDAO" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		int mnum = Integer.parseInt(request.getParameter("mnum"));
		int cpnum = Integer.parseInt(request.getParameter("cpnum"));
		
		CouponDAO dao = CouponDAO.getDAO();
		int result = dao.insert(mnum, cpnum); 
		
		if(result == 1) { %>
			<script>
				alert("쿠폰 다운로드가 완료 되었습니다.");
				location.href="/shop/member/memberCoupon.jsp?mnum=" + "<%=mnum%>";
			</script>
		<% } else { %>
			<script>
				alert("쿠폰 다운로드 중 오류가 발생했습니다.");
				location.href="/shop/member/memberCoupon.jsp?mnum=" + "<%=mnum%>";
			</script>
		<% } %>
</body>
</html>