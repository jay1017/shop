<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.member.MemberDTO" %>
<%@ page import="shop.member.MemberDAO" %>
<%@ page import="shop.point.pointDAO" %>
<%@ page import="shop.point.pointDTO" %>
<%
	String sid = (String)session.getAttribute("sid");
	MemberDAO mdao = new MemberDAO();
	MemberDTO mdto = mdao.getInfo(sid);
	
	pointDAO pdao = new pointDAO();
	pointDTO pdto = new pointDTO();
	
	int result = 0;
	int PointCount = pdao.getAllPoint(mdto.getMnum());
	
%>
<html>
	<head>
		<title>ODEZ - 포인트 내역</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" href="/shop/resources/css/bootstrap.min.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/font-awesome.min.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/elegant-icons.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/magnific-popup.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/nice-select.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/owl.carousel.min.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/slicknav.min.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/style.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/font.css">
<link rel="stylesheet" href="/shop/resources/css/font-awesome.min.css" type="text/css"/>
	</head>
	<body>
	<jsp:include page="/include/header.jsp" />
		<form align="center">
			<h2><%=mdto.getMname() %>님의 포인트 내역</h2>
			<div>
				<%=mdto.getMname() %>님의 사용가능 포인트: <%=PointCount %>
			</div>
		</form>
	<jsp:include page="/include/footer.jsp" />

	<script src="/shop/resources/js/jquery-3.3.1.min.js"></script>
	<script src="/shop/resources/js/bootstrap.min.js"></script>
	<script src="/shop/resources/js/jquery.nice-select.min.js"></script>
	<script src="/shop/resources/js/jquery.nicescroll.min.js"></script>
	<script src="/shop/resources/js/jquery.magnific-popup.min.js"></script>
	<script src="/shop/resources/js/jquery.countdown.min.js"></script>
	<script src="/shop/resources/js/jquery.slicknav.js"></script>
	<script src="/shop/resources/js/mixitup.min.js"></script>
	<script src="/shop/resources/js/owl.carousel.min.js"></script>
	<script src="/shop/resources/js/main.js"></script>
	</body>
</html>