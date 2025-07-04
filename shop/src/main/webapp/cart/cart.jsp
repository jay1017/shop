<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,shop.cart.CartDAO,shop.cart.CartDTO"%>
<%
request.setCharacterEncoding("UTF-8");

// 로그인 여부 확인
String sid = (String) session.getAttribute("sid");
if (sid == null) {
%>
<script>
	alert("로그인 후 이용해주세요.");
	window.location.href = '/shop/member/loginForm.jsp'
</script>
<%
return;
}
// 장바구니 목록 세션에서 !!부르지말고 dao에서 부르기
CartDAO dao = CartDAO.getInstance();
int mnum = dao.getMnum(sid);
List<CartDTO> cart = dao.getCartByMnum(mnum);
List<CartDTO> fullCartItems = new ArrayList<>();

for (CartDTO cdto : cart) {
CartDTO goods = dao.getCartGoods(cdto.getGnum());
if (goods != null) {
	goods.setCcount(cdto.getCcount()); // 수량 세팅
	fullCartItems.add(goods);
}
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="description" content="Male_Fashion Template">
<meta name="keywords" content="Male_Fashion, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>ODEZ</title>
<link rel="stylesheet" href="/shop/resources/css/font.css" />
<link rel="stylesheet" href="/shop/resources/css/bootstrap.min.css"
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
<body>
	<jsp:include page="/include/header.jsp" />
	<title>장바구니</title>
	<style>
.sidebar {
	position: fixed; /* ← 핵심 */
	top: 200px; /* 화면 위에서 떨어진 거리 */
	right: 20px; /* 오른쪽에 고정 */
	width: 120px; /* 원하는 너비로 조정 */
	padding: 1em;
	background: #e4e4e4;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
	display: flex;
    flex-direction: column; /* ← 세로정렬! */
    gap: 10px;               
}
</style>
</head>

<h1>장바구니</h1>


<%
if (cart.isEmpty()) {
%>
<p>장바구니에 담긴 상품이 없습니다.</p>
<%
} else {
int total = 0;
for (CartDTO dto : cart) {

	int gprice = dto.getGprice();
	int discount = dto.getDiscount();

	total += discount;
%>
<div class="item">
	<img src="/resources/image/<%=dto.getGiname()%>" alt="상품 이미지"
		width="150">
	<div>
		<p>
			상품명:
			<%=dto.getGname()%></p>
		<p>
			가격: ₩<%=gprice%></p>
		<p>
			할인가: ₩<%=discount%></p>
		<p>
			수량:<%=dto.getCcount()%>개
		</p>
		<input type="button" value="구매하기"
			onclick="location.href='/shop/buy/cash.jsp?gnum=<%=dto.getGnum()%>'">
	</div>
</div>
<%
}
%>

<h3>
	총 합계: ₩<%=total%></h3>
<a href="cash.jsp">전체 결제하기</a>

<%
}
%>

<div class="sidebar">
	<input type="button" value="홈"
		onclick="location.href='/shop/main/main.jsp'"> <input
		type="button" value="검색"
		onclick="location.href='/shop/main/search.jsp'"> <input
		type="button" value="구매내역" onclick="location.href='/shop/buy/buy.jsp'">
	<input type="button" value="⇧" onclick="window.scrollTo(0,0)">
	<input type="button" value="⇩"
		onclick="window.scrollTo(0,document.body.scrollHeight)"> <input
		type="button" value="고객센터" onclick="location.href='ascenter.jsp'">
</div>
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
