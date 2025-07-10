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
<%@ page import="shop.coupon.CouponDAO" %> 
<%@ page import="shop.coupon.CouponDTO" %>    
<%@ page import="shop.cart.CartDAO" %>
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
		int bprice = Integer.parseInt(request.getParameter("bprice"));
		System.out.println("전체가격: "+ bprice);
		CartDAO cadao = CartDAO.getInstance();
		if(pg_token != null) { 
			request.setCharacterEncoding("UTF-8");
			
			//카카오페이 결제 후 저장해야 하기에 success페이지에서 제작
			int point = bprice / 100;
			String pname = "구매 적립포인트";

			pointDAO pdao = new pointDAO();
			pointDTO pdto = new pointDTO();
			
			pdto.setPpoint(point);
			pdto.setPtype(pname);
			pdto.setPstat(1);
			
			//사용상태는 사용 or 미사용이기에 미사용일때 1, 사용했을때 0으로 저장하기 위해
			//적립만 했을 시엔 1로 기본값 저장
			

			BuyDAO dao = BuyDAO.getDAO();
			BuyDTO dto = new BuyDTO();
			
			// 회원 번호 조회
			MemberDAO mdao = new MemberDAO();
			MemberDTO mdto = mdao.getInfo(sid);
			
			// 회원 번호 대입
			dto.setMnum(mdto.getMnum()); 
			pdto.setMnum(mdto.getMnum());
			
			// 상품 번호 배열로 정리
			String[] gnumArr = request.getParameter("gnum").split(",");
			List<Integer> gnumes = new ArrayList<>();
			for(String num : gnumArr) {
				int gnum = Integer.parseInt(num);
				gnumes.add(gnum);
			}
			
			// 상품 카테고리 번호 배열에 저장 및 구매한 상품 이미지 번호 대입
			List<Integer> canumes = new ArrayList<>();
			List<Integer> ginumes = new ArrayList<>();
			
			List<GoodsDTO> goodsList = dao.selectGoodsList(gnumes);
			for(GoodsDTO goods : goodsList) {
				canumes.add(goods.getCanum());
				ginumes.add(goods.getGinum());
			}
			
			// 구매 수량 배열로 변환
			List<Integer> bcountes = new ArrayList<>();
			String[] bcountArr = request.getParameter("bcount").split(",");
			for(String b : bcountArr) {
				bcountes.add(Integer.parseInt(b));
			}
			
			// 옵션 번호 배열로 변환
			List<Integer> gonumes = new ArrayList<>();
			String[] gonumArr = request.getParameter("gonum").split(",");
			for(String g : gonumArr) {
				gonumes.add(Integer.parseInt(g));
			}
			
			// 받아온 값 대입 
			int zip = Integer.parseInt(request.getParameter("zip"));
			String address = request.getParameter("address");
			String address2 = request.getParameter("address2");
			String address3 = request.getParameter("address3");
			String note = request.getParameter("note");
			
			dto.setZip(zip);
			dto.setAddress(address);
			dto.setAddress2(address2);
			dto.setAddress3(address3);
			dto.setNote(note);
			
			// 기존 넘버 조회(그 다음 번호로 들어가야 하기 때문에)후 대입
			int num = dao.selectNumber();
			dto.setBuynum(num);
			
			// 금액 대입 및 쿠폰 소진(쿠폰 삭제)
			
			int before_price = Integer.parseInt(request.getParameter("before_price"));
			int cpnum = Integer.parseInt(request.getParameter("cpnum"));
			CouponDAO cdao = CouponDAO.getDAO();
			
			if(bprice != before_price) {
				int result = cdao.delete(cpnum, mdto.getMnum()); 
				if(result == 0) { %>
					<script>
						alert("쿠폰 사용 중 오류가 발생했습니다.");
						location.href="/shop/goods/goodsview.jsp?gnum=" + gnumes.get(i);
					</script>
				<% }
			}
			
			dto.setBprice(bprice);
			
			// 상품 번호 대입 및 저장
			for(int i = 0; i < gnumes.size(); i++) {
				dto.setGnum(gnumes.get(i));
				dto.setCanum(canumes.get(i));
				dto.setBcount(bcountes.get(i));
				dto.setGinum(ginumes.get(i));
				dto.setGonum(gonumes.get(i));
				int result = dao.insert(dto);
				if(result == 0) { %>
					<script>
						alert("구매 중 오류가 발생했습니다.");
						location.href="/shop/goods/goodsview.jsp?gnum=" + gnumes.get(i);
					</script>
				<% } else { %>
					<script>
						alert("정상 결제 되었습니다.");
						location.href="/shop/main/main.jsp";
					</script>
					<%pdao.InsertPoint(pdto);
					cadao.deleteByBuy(gnumes.get(i),mdto.getMnum()); %>
				<% }
			} 
		} else { %>
			<script>
				alert("결제를 실패하였습니다.");
				history.go(-3);
			</script>
		<% }
	%>
</body>
</html>