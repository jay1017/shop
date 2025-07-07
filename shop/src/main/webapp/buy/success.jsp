<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.buy.BuyDAO" %>
<%@ page import="shop.buy.BuyDTO" %>     
<%@ page import="shop.goods.GoodsDTO" %>
<%@ page import="shop.member.MemberDTO" %>
<%@ page import="shop.member.MemberDAO" %>  
<%@ page import="java.util.List" %> 
<%@ page import="java.util.ArrayList" %>    
<%@ page import="shop.point.pointDTO" %>
<%@ page import="shop.point.pointDAO" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String pg_token = request.getParameter("pg_token");
		String sid = (String) session.getAttribute("sid"); 
		
		if(pg_token != null) { %>
			<script>
				alert("결제를 완료 하였습니다.");
				<%
				
				//카카오페이 결제 후 저장해야 하기에 success페이지에서 제작
				String tp = (String) session.getAttribute("totalprice");
				String totalprice = tp; //세션에 저장할땐 콤마가 포함된 문자열로 전송했기에
				String cleanPrice = totalprice.replace(",", ""); // 콤마 삭제후
				int totalpri = Integer.parseInt(cleanPrice); // int형변환
				int point = totalpri / 100;
				String pname = "구매 적립포인트";

				pointDAO pdao = new pointDAO();
				pointDTO pdto = new pointDTO();
				
				
				MemberDAO mdao = new MemberDAO();
				MemberDTO mdto = mdao.getInfo(sid);
				
				pdto.setMnum(mdto.getMnum());
				pdto.setPpoint(point);
				pdto.setPtype(pname);
				pdto.setPstat(1); 
				//사용상태는 사용 or 미사용이기에 미사용일때 1, 사용했을때 0으로 저장하기 위해
				//적립만 했을 시엔 1로 기본값 저장
				pdao.InsertPoint(pdto);
				%>
				location.href="/shop/main/main.jsp";
			</script>
		<% } else { %>
			<script>
				alert("결제를 실패하였습니다.");
				history.go(-3);
			</script>
		<% }
	%>
</body>
</html>