<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@	page import="shop.main.GoodsDTO,shop.main.MainDAO,java.util.List"%>
<%@ page import="shop.main.GoodsOptionDTO"%>
<%@ page import="shop.admin.GoodsImageDAO,shop.admin.GoodsImageDTO" %>
<%request.setCharacterEncoding("UTF-8"); %>
<%
String sid = (String) session.getAttribute("sid");

int gnum = Integer.parseInt(request.getParameter("gnum"));

MainDAO dao = MainDAO.getInstance(); //메인 dao

GoodsImageDAO idao =GoodsImageDAO.getDAO(); //상품 이미지 dao

dao.increaseGread(gnum); //조회수 증가

List<GoodsDTO> list = dao.getGoods(gnum); //상품정보 가져오기

List<GoodsOptionDTO> olist = dao.getGoodsOption(); //상품 옵션정보 가져오기

int ginum=Integer.parseInt(request.getParameter("ginum")); //상품 이미지 파일 조회

GoodsImageDTO idto=idao.select(ginum); //상품 이미지 파일명 불러오기
%>
<!doctype html>
<html lang="ko">
<meta charset="UTF-8">
<head>
<title>상품상세화면</title>
<link rel="stylesheet" href="/shop/resources/css/font.css" />
</head>
<body>
	<form action="">
		<%
		for (GoodsDTO dto : list) {
			int gprice = dto.getGprice();
			int discount = dto.getDiscount();
			int disprice = gprice; //할인된 가격 
			
			out.println(dto);
		%>
		<div></div>

		<div><%=dto.getGname()%> <%--할인율에따른 가격표시 --%>
			<br />
			<%
			if (discount != 0) {
				disprice = gprice - (gprice * discount / 100);
			%>
			<%=dto.getGprice()%> <br/>
			<%=disprice %>
			<input type="hidden" name="gprice" value="<%=disprice%>">
		</div>
		<%
		} else {
		%>
		<div>
			<%=dto.getGprice()%>
			<input type="hidden" name="gprice" value="<%=dto.getGprice()%>">
		</div>
		<%
		}
		%>
		<%
		for (GoodsOptionDTO dto2 : olist) { //옵션선택
		%>
		<input type="checkbox" name="gonum" value="<%=dto2.getGonum()%>" /> <span><%=dto2.getGocolor()%></span>
		<span><%=dto2.getGosize()%></span> <input type="submit" value="구매" />
		<%
		}
		%>
		<%

		%><div><%=dto.getGcontent()%></div>
		<%
		} 
		%>
	</form>



	<div>리뷰</div>
</body>
</html>
