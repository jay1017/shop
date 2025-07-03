<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="shop.goods.GoodsListDAO"%>
<%@ page import="shop.goods.GoodsListDTO"%>
<%@ page import="shop.goods.OptionDAO"%>
<%@ page import="shop.goods.OptionDTO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<%
request.setCharacterEncoding("UTF-8");
GoodsListDAO dao = GoodsListDAO.getInstance(); // DAO 불러오고

int pageSize = 15; //한 화면에 보여줄 상품 갯수
String pageNum = request.getParameter("pageNum");
if (pageNum == null) {
	pageNum = "1"; //페이지 번호가 없다면 기본값 1
}
int currentPage = Integer.parseInt(pageNum);
int start = (currentPage - 1) * pageSize + 1; //2번 페이지로 갈 경우 11부터 시작
int end = currentPage * pageSize; // 11~20까지
int count = dao.getGoodsCount(); //전체 상품 수
//파라미터 받기 카테고리,사이즈,가격
String canumStr = request.getParameter("canum");
String size = request.getParameter("size");
String priceStr = request.getParameter("price");
List<GoodsListDTO> list = null;
//상품 진열 조건
if(canumStr != null){//카테고리별 출력
	int canum = Integer.parseInt(canumStr);
	count = dao.getGoodsCount(canum);
	list = dao.getGoodsByCate(canum,start,end);
}else if(size != null){//사이즈별 출력
	list = dao.getGoodsBySize(size,start,end);
}else if(priceStr != null){//가격별 출력
	int price = Integer.parseInt(priceStr);
	count = dao.getGoodsCountbyprice(price);
	list = dao.getGoodsByPrice(price,start,end);
}else{//기본값(조건 없을때)
list = dao.getGoods(start,end);
}
String para = "";
if(canumStr != null){para += "&canum=" + canumStr;}
if(size != null){para += "&size=" + size;}
if(priceStr != null){para += "&price=" + priceStr;}
int pageCount = (count / pageSize) + (count % pageSize == 0 ? 0 : 1);
int pageBlock = 5; // 한 화면에 보여줄 페이지 링크 수
int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
int endPage = startPage + pageBlock - 1;
if (endPage > pageCount)
	endPage = pageCount;
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
	<div class="col-lg-3">
	<h1>상품목록</h1>
	<h2>전체 상품 목록</h2>
	<input type="button" value="전체 상품 보기" onclick="location.href='goodslist.jsp'">
	</div>
	<div class="container">
		<div class="row">

			<!-- 사이드바 -->
			<div class="col-lg-3">
				<div>
					<%--사이드바  --%>
					<div class="shop__sidebar">
						<div class="shop__sidebar__search">
							<form action="/shop/main/search.jsp">
								<input type="text" placeholder="검색">
								<button type="submit"></button>
							</form>
						</div>
						<div class="shop__sidebar__accordion">
							<div class="accordion" id="accordionExample">
								<div class="card">
									<div class="card-heading">
										<a data-toggle="collapse" data-target="#collapseOne">Categories</a>
									</div>
									<div id="collapseOne" class="collapse show"
										data-parent="#accordionExample">
										<div class="card-body">
											<div class="shop__sidebar__categories">
												<ul class="nice-scroll" tabindex="1"
													style="overflow-y: hidden; outline: none;">
													<li><a href="goodslist.jsp?canum=22">신발</a></li>
													<li><a href="goodslist.jsp?canum=23">쥬얼리</a></li>
													<li><a href="goodslist.jsp?canum=24">가방</a></li>
													<li><a href="goodslist.jsp?canum=1">셔츠</a></li>
													<li><a href="goodslist.jsp?canum=4">티셔츠</a></li>
													<li><a href="goodslist.jsp?canum=5">아우터</a></li>
													<li><a href="goodslist.jsp?canum=6">바지</a></li>
													<li><a href="goodslist.jsp?canum=7">치마</a></li>
												</ul>
											</div>
										</div>
									</div>
								</div>

								<div class="card">
									<div class="card-heading">
										<a data-toggle="collapse" data-target="#collapseThree">Price</a>
									</div>
									<div id="collapseThree" class="collapse show"
										data-parent="#accordionExample">
										<div class="card-body">
											<div class="shop__sidebar__price">
												<ul>
													<li><a href="goodslist.jsp?price=0">~₩500,000</a></li>
													<li><a href="goodslist.jsp?price=500000">₩500000 - ₩1000000</a></li>
													<li><a href="goodslist.jsp?price=1000000">₩1000000 - ₩1500000</a></li>
													<li><a href="goodslist.jsp?price=1500000">₩1500000 - ₩2000000</a></li>
													<li><a href="goodslist.jsp?price=2000000">₩2000000 - ₩2500000</a></li>
												</ul>
											</div>
										</div>
									</div>
								</div>
								<div class="card">
									<div class="card-heading">
										<a data-toggle="collapse" data-target="#collapseFour">Size</a>
									</div>
									<div id="collapseFour" class="collapse show"
										data-parent="#accordionExample">
										<div class="card-body">
											<div class="shop__sidebar__size">
												<%
												OptionDAO odao = OptionDAO.getInstance(); // DAO 객체 생성
												List<String> sizes = odao.getSize(); // 사이즈 리스트 가져오기
												%>

												<%
												for (int i = 0; i < sizes.size(); i++) {
													 size = sizes.get(i);
												%>
												<label for="<%=size%>"> <%=size%>
												<input type="radio" name="gosize" id="<%=size%>" value="<%=size%>" onclick="location.href='goodslist.jsp?size=<%=size %>'">
												</label>
												<%}%>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<%--사이드바 끝 --%>
			</div>
			<!-- 상품 목록 -->
			<div class="col-lg-9">
				<div class="row">
					<%
					if (list != null && !list.isEmpty()) {
						for (GoodsListDTO dto : list) {
					%>
					<div class="col-lg-4 col-md-6 col-sm-6 mb-4">
						<div class="card h-100">
							<a href="/shop/goods/goodsview.jsp?gnum=<%=dto.getGnum()%>">
							<img src="/shop/resources/image/<%=dto.getGiname()%>" class="card-img-top"
								alt="상품 이미지">
							<div class="card-body">
								<h5 class="card-title"><%=dto.getGname()%></h5></a>
								<p class="card-text">
									가격:<%=dto.getGprice()%>원
								</p>
								<p class="card-text">
									판매가:<%=dto.getDiscount()%>원
								</p>
								<form method="post" action="/shop/cart/cartInsertPro.jsp">
								<input type="hidden" name="gnum" value="<%=dto.getGnum()%>">
								수량 : <input type="number" name="ccount" min="1" value="1" class="form-control form-control-sm mb-2" />
								<button type="submit" class="btn btn-outline-primary btn-sm w-100">+장바구니 담기</button>
								</form>
								<a href="/shop/buy/buy.jsp?gnum=<%=dto.getGnum()%>" class="btn btn-outline-primary btn-sm w-100">구매하기</a>
							</div>
						</div>
					</div>
					<%
					}
					} else {
					%>
					<p>등록된 상품이 없습니다.</p>
					<%
					}
					%>
				</div>
				<%--상품 카드 닫음 --%>
			</div>
		</div>
		<%--row 닫기 --%>
	</div>
	<%--container 닫기 --%>
	<div>
		<%
		if (startPage > 1) {
		%>
		<a href="goodslist.jsp?pageNum=<%=startPage - 1%><%=para%>">[이전]</a>
		<%
		}
		%>

		<%
		for (int i = startPage; i <= endPage; i++) {
			if (i == currentPage) {
		%>
		<b>[<%=i%>]
		</b>
		<%
		} else {
		%>
		<a href="goodslist.jsp?pageNum=<%=i%><%=para%>">[<%=i%>]
		</a>
		<%
		}
		}
		%>

		<%
		if (endPage < pageCount) {
		%>
		<a href="goodslist.jsp?pageNum=<%=endPage + 1%><%=para%>">[다음]</a>
		<%
		}
		%>
		<form action="/shop/main/search.jsp" method="get">
			<input type="text" placeholder="검색어 입력">
			<button type="submit">검색</button>
		</form>
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
