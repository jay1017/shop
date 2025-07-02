<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.buy.BuyDAO" %>
<%@ page import="shop.buy.BuyDTO" %>    
<%@ page import="shop.goods.GoodsDTO" %>
<%@ page import="shop.member.MemberDTO" %>
<%@ page import="shop.member.MemberDAO" %>  
<%@ page import="java.util.List" %> 
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		BuyDAO dao = BuyDAO.getDAO();
		BuyDTO dto = new BuyDTO();
		
		// 회원 번호 조회
		String sid = (String) session.getAttribute("sid"); 
		MemberDAO mdao = new MemberDAO();
		MemberDTO mdto = mdao.getInfo(sid);
		
		// 회원 번호 대입
		dto.setMnum(mdto.getMnum()); 
		
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
		String[] bcountArr = request.getParameterValues("bcount");
		for(String b : bcountArr) {
			bcountes.add(Integer.parseInt(b));
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
		
		// 상품 번호 대입 및 저장
		for(int i = 0; i < gnumes.size(); i++) {
			dto.setGnum(gnumes.get(i));
			dto.setCanum(canumes.get(i));
			dto.setBcount(bcountes.get(i));
			dto.setGinum(ginumes.get(i));
			int result = dao.insert(dto);
			if(result == 0) { %>
				<script>
					alert("구매 중 오류가 발생했습니다.");
					history.go(-1);
				</script>
				<% break; 
			} else { %>
				<script>
					location.href="/shop/buy/buySuccess.jsp";
				</script>
			<% }
		}  
	%>
</body>
</html>