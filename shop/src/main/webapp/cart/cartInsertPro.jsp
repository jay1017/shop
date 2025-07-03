<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.cart.CartDTO" %> 
<%@ page import="shop.cart.CartDAO" %> 
<%@ page import="shop.goods.GoodsDTO" %>
<%@ page import="shop.goods.GoodsDAO" %> 
<%@ page import="shop.member.MemberDAO" %>
<%@ page import="shop.member.MemberDTO" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		// 카트 객체 생성
		CartDTO cart = new CartDTO();
	
		int gnum = Integer.parseInt(request.getParameter("gnum"));
		String sid = (String) session.getAttribute("sid");
		int ccount = Integer.parseInt(request.getParameter("ccount"));
		int gonum = Integer.parseInt(request.getParameter("gonum"));

		cart.setCcount(ccount);
		
		// 굿즈 조회
		GoodsDAO gdao = GoodsDAO.getDAO();
		GoodsDTO gdto = gdao.select(gnum); 
		
		cart.setCanum(gdto.getCanum());
		cart.setGnum(gdto.getGnum());
		cart.setGinum(gdto.getGinum());
		cart.setGonum(gonum);
		
		// 회원 조회
		MemberDAO mdao = new MemberDAO();
		MemberDTO mdto = mdao.getInfo(sid);
		
		cart.setMnum(mdto.getMnum());
		
		CartDAO cdao = CartDAO.getInstance();
		int result = cdao.insertCart(cart);
		
		if(result == 1) { %>
			<script>
				alert("장바구니에 상품이 담겼습니다.");
				var confirm = confirm("장바구니로 이동 하시겠습니까?");
				if(confirm == true) {
					location.href="/shop/cart/cart.jsp";
				} else {
					location.href="/shop/goods/goodslist.jsp";
				}
			</script>
		<% } else {  %>
			<script>
				alert("장바구니에 상품이 담기지 않았습니다.");
				location.href="/shop/goods/goodslist.jsp";
			</script>
		<% } %>
</body>
</html>