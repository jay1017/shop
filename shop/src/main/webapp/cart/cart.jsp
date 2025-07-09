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
<link rel="stylesheet" href="/shop/resources/css/font-awesome.min.css"
	type="text/css" />
<jsp:include page="/include/header.jsp" />
<title>장바구니</title>
</head>
<body>

	<section class="breadcrumb-option">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<h4>Shopping Cart</h4>
						<div class="breadcrumb__links">
							<span>장바구니</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<section class="shopping-cart spad">
	<div class="container">
		<div class="row">
			<div class="col-lg-8">
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
					int count = dto.getCcount();
					
					total += discount*count;
				%>

				<!-- 카드 하나 시작 -->
				<div class="card mb-4">
					<div class="row no-gutters">
						<div
							class="col-md-4 d-flex align-items-center justify-content-center">
							<img src="/shop/resources/image/<%=dto.getGiname()%>"
								class="card-img" alt="상품 이미지"
								style="max-width: 100%; padding: 10px;">
						</div>
						<div class="col-md-8">
							<div class="card-body">
								<h5 class="card-title">
									상품명:
									<%=dto.getGname()%></h5>
								<p class="card-text">
									사이즈:
									<%=dto.getGosize()%></p>
								<p class="card-text">
									가격: ₩<%=dto.getGprice()%></p>
								<p class="card-text">
									할인가: ₩<%=dto.getDiscount()%></p>
								<p class="card-text">
									수량:
									<%=dto.getCcount()%>개
								</p>

								<form method="post" action="/shop/buy/buyInsert.jsp"
									class="d-inline">
									<input type="hidden" name="gnum" value="<%=dto.getGnum()%>">
									<input type="hidden" name="bcount" value="<%=dto.getCcount()%>">
									<input type="hidden" name="gonum" value="<%=dto.getGonum()%>">
									<input type="submit" value="구매하기" class="btn btn-sm btn-dark">
								</form>

								<form method="post" action="cartUpdate.jsp"
									class="d-inline ml-2">
									<input type="hidden" name="gnum" value="<%=dto.getGnum()%>">
									<input type="number" name="ccount" min="1"
										value="<%=dto.getCcount()%>"
										class="form-control form-control-sm d-inline-block"
										style="width: 60px;">
									<button type="submit" class="btn btn-sm btn-secondary">수정</button>
								</form>

								<form method="post" action="cartDelete.jsp"
									class="d-inline ml-2">
									<input type="hidden" name="gnum" value="<%=dto.getGnum()%>">
									<button type="submit" class="btn btn-sm btn-danger">삭제</button>
								</form>
							</div>
						</div>
					</div>
				</div>
				<!-- 카드 하나 끝 -->

				<%
				} // for
				%>
			</div>
			<!-- col-lg-8 -->
			<div class="col-lg-4">
				<div class="cart__discount">
					<h6>쿠폰 입력</h6>
					<form action="#">
						<input type="text" placeholder="Coupon code">
						<button type="submit">등록</button>
					</form>
				</div>
				<div class="cart__total">
					<h6>합계</h6>
					<ul>
						<li>총 액<span>₩<%=total%></span></li>
					</ul>
					<form method="post" action="/shop/buy/buyInsert.jsp">
						<%
						for (CartDTO dto : cart) {
						%>
						<input type="hidden" name="gnum" value="<%=dto.getGnum()%>">
						<input type="hidden" name="bcount" value="<%=dto.getCcount()%>">
						<input type="hidden" name="gonum" value="<%=dto.getGonum()%>">
						<%
						}
						%>
						<input type="submit" value="모두 구매" class="primary-btn">
					</form>
					<%
					} //else
					%>
				</div>
			</div>
		</div>
		<!-- row -->
	</div>
	<!-- container -->
	</section>
	
	<jsp:include page="/include/sidebar.jsp" />
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
