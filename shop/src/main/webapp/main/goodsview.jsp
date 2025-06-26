<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@	page import="shop.main.GoodsDTO,shop.main.MainDAO,java.util.List"%>

<%
String sid = (String) session.getAttribute("sid");
int gnum = Integer.parseInt(request.getParameter("gnum"));
MainDAO dao = MainDAO.getInstance();
List<GoodsDTO> list = dao.getGoods(gnum);
%>
<!doctype html>
<html lang="ko">
<meta charset="UTF-8">
<head>
<title>상품상세화면</title>
</head>
<body>
	<%
	for (GoodsDTO dto : list) {
	%>
	<div>상품대표사진(나중에)</div>
	<div><%=dto.getGname()%>
			<%=dto.getGprice()%>
		<%--여기는 구입버튼링크 --%>
	</div>
	<div>상품에대한설명</div>
	<%
	}
	%>

	<div>리뷰</div>
</body>
</html>
