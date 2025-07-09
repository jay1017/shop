<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="shop.buy.BuyListDAO"%>
<%@ page import="shop.buy.BuyListDTO"%>
<%@ page import="java.util.List"%>
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
BuyListDAO dao = BuyListDAO.getInstance();
int mnum = dao.getMnum(sid);
List<BuyListDTO> buy = dao.getBuybyMnum(mnum);
%>
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
<jsp:include page="/include/sidebar.jsp" />

<title>전체 주문 페이지</title>
</head>
<body>
	<section class="breadcrumb-option">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<h4>주문내역</h4>
					</div>
				</div>
			</div>
		</div>
	</section>
	<%-- 주문내역 페이지로 돌아가는 버튼하나 만들기
buy 테이블에서 전체불러오기(주문 상세내역)
bnum불러오고 상품 이름, 사진, 가격정도만 불러오면 될듯?--%>
	<section class="shopping-cart spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-8">
					<%
					if (buy.isEmpty()) {
					%>
					<p>구매한 상품이 없습니다.</p>
					<%
					} else {
					for (BuyListDTO dto : buy) {

						int discount = dto.getDiscount();
						int bcount = dto.getBcount();
						int price = discount * bcount;
					%>
					<div class="card mb-4">
						<div class="row no-gutters">
							<div
								class="col-md-4 d-flex align-items-center justify-content-center">
								<img src="/shop/resources/image/<%=dto.getGiname()%>"
									alt="상품이미지" width="150">
									</div>
						<div class="col-md-8">
							<div class="card-body">
								<p class="card-text">
									상품명:<%=dto.getGname()%></p>
									<p>
									사이즈:<%=dto.getGosize() %>
									</p>
								<p class="card-text">
									가격: ₩<%=discount%></p>
								<p class="card-text">
									구매수량:<%=bcount%>개
								</p>
								<p class="card-text">
									구매가: ₩<%=price%></p>
									<form method="post" action="/shop/buy/buyInsert.jsp"
									class="d-inline">
									<input type="hidden" name="gnum" value="<%=dto.getGnum()%>">
									<input type="hidden" name="bcount" value="<%=bcount%>">
									<input type="submit" value="재구매하기" class="btn btn-sm btn-dark">
								</form>
							</div>
					</div>
				</div>
			</div>
							<%
							}//for 끝%>
					
			</div>
							<%}//else 끝
							%>
							
				
			</div>
		</div>
	</section>

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