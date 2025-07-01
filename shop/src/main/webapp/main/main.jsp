<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="shop.main.MainDAO,shop.main.GoodsDTO,java.util.List"%>
<%@ page import="shop.main.CategoryDTO"%>
<%@ page import="shop.admin.GoodsImageDAO,shop.admin.GoodsImageDTO"%>

<%
String sid = (String) session.getAttribute("sid");
MainDAO dao = MainDAO.getInstance();
GoodsImageDAO idao = GoodsImageDAO.getDAO();

List<CategoryDTO> list = dao.getCate();
List<GoodsDTO> list2 = dao.getGoods(); //모든 상품의 정보를 출력
List<GoodsDTO> tlist = dao.getTrendGoods(); //인기상품 정보 출력
List<GoodsDTO> slist = dao.getSaleGoods();//세일중인 상품 리스트 출력
%>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="description" content="Male_Fashion Template">
<meta name="keywords" content="Male_Fashion, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>사이트 이름</title>
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

</head>
<body>
	<jsp:include page="/include/header.jsp"></jsp:include>
	<%--헤더--%>
	<section class="hero">
		<div class="hero__slider owl-carousel">
			<div class="hero__items set-bg"
				data-setbg="/shop/resources/img/main1.jpg">
				<div class="container">
					<div class="row">
						<div class="col-xl-5 col-lg-7 col-md-8">
							<div class="hero__text">
								<h6>지금 가장 힙한 스타일</h6>
								<h2>2024 S/S 판매 1위</h2>
								<p>고급스러운 블랙 무드의 유니크한 스트랩 디테일의 오프숄더 탑이<br/>
									세련되면서도 감각적인 스타일을 완성해 줍니다.<br/> 
									도시적인 분위기와 트렌디한 무드를 동시에 갖춘 <br/>
									이번 시즌 머스트해브 아이템!<br/>
									자크뮈스 르 시에라 티셔츠를 지금 만나보세요.</p>
								<a href="/shop/goods/goodsview.jsp?gnum=22" class="primary-btn">Shop now <span
									class="arrow_right"></span></a>
								<%--shop now누르면 해당 상품의 상세화면으로이동하도록 만들기 --%>
								<div class="hero__social">
									<a href="#"><i class="fa fa-facebook"></i></a> <a href="#"><i
										class="fa fa-twitter"></i></a> <a href="#"><i
										class="fa fa-pinterest"></i></a> <a href="#"><i
										class="fa fa-instagram"></i></a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="hero__items set-bg"
				data-setbg="/shop/resources/img/main2.jpg">
				<div class="container">
					<div class="row">
						<div class="col-xl-5 col-lg-7 col-md-8">
							<div class="hero__text">
								<h6>클래식한 무드, 트렌디한 감성</h6>
								<h2>2024 S/W 판매 1위</h2>
								<p>스포티한 감성과 모던한 실루엣의 조화. <br/>
								스트라이프 포인트가 돋보이는 바시티 <br/>
								자켓은 어디에나 매치해도 스타일을 살려주는 아이템입니다.<br/>
								간절기부터 겨울까지 쭉 활용 가능한 머스트해브 아우터!<br/>
								생로랑 클래식 테디 재킷을 지금 만나보세요.</p>
								<a href="/shop/goods/goodsview.jsp?gnum=22" class="primary-btn">Shop now <span
									class="arrow_right"></span></a>
								<div class="hero__social">
									<a href="#"><i class="fa fa-facebook"></i></a> <a href="#"><i
										class="fa fa-twitter"></i></a> <a href="#"><i
										class="fa fa-pinterest"></i></a> <a href="#"><i
										class="fa fa-instagram"></i></a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<%--여기까지가 배너--%>
	<!-- Hero Section End -->
	
	<!-- Banner Section Begin -->
    <section class="banner spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-7 offset-lg-4">
                    <div class="banner__item">
                        <div class="banner__item__pic">
                            <img src="/shop/resources/img/outer.jpg" alt="">
                        </div>
                        <div class="banner__item__text">
                            <h2>Clothing Collections 2030</h2>
                            <a href="/shop/goods/categories.jsp?canum=1">Shop now</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-5">
                    <div class="banner__item banner__item--middle">
                        <div class="banner__item__pic">
                            <img src="/shop/resources/img/acc.jpg" alt="">
                        </div>
                        <div class="banner__item__text">
                            <h2>Accessories</h2>
                            <a href="/shop/goods/categories.jsp?canum=23">Shop now</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-7">
                    <div class="banner__item banner__item--last">
                        <div class="banner__item__pic">
                            <img src="/shop/resources/img/shoose.jpg" alt="">
                        </div>
                        <div class="banner__item__text">
                            <h2>Shoes Spring 2030</h2>
                            <a href="/shop/goods/categories.jsp?canum=22">Shop now</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
	<!-- Banner Section End -->

	<!-- Product Section Begin -->
<section class="product spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <ul class="filter__controls">
                    <li class="active" data-filter="*">전체 보기</li>
                    <li data-filter=".popular">인기 상품</li>
                    <li data-filter=".sale">할인 상품</li>
                </ul>
            </div>
        </div>

        <div class="row product__filter">

            <%-- 인기 상품 출력 --%>
            <%
                int count = 0;
                for (GoodsDTO dto : tlist) {
                    int ginum = dto.getGinum();
                    GoodsImageDTO gi = idao.select(ginum);
                    String giname = gi.getGiname();
                    if (count >= 8) break;
                    count++;
            %>
            <div class="col-lg-3 col-md-6 col-sm-6 mix popular">
                <div class="product__item">
                    <a href="/shop/goods/goodsview.jsp?gnum=<%= dto.getGnum() %>&ginum=<%= dto.getGinum() %>">
                        <div class="product__item__pic set-bg" data-setbg="/shop/resources/image/<%= giname %>">
                            <span class="label">Hot</span>
                            <ul class="product__hover">
                                <li><a href="#"><img src="/shop/resources/img/icon/heart.png" alt=""></a></li>
                                <li><a href="#"><img src="/shop/resources/img/icon/compare.png" alt=""> <span>Compare</span></a></li>
                                <li><a href="#"><img src="/shop/resources/img/icon/search.png" alt=""></a></li>
                            </ul>
                        </div>
                    </a>
                    <div class="product__item__text">
                        <h6><%= dto.getGname() %></h6>
                        <a href="#" class="add-cart">+ Add To Cart</a>
                        <div class="rating">
                            <i class="fa fa-star-o"></i><i class="fa fa-star-o"></i>
                            <i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i>
                        </div>
                        <h5>&#8361;<%= dto.getGprice() %></h5>
                        <div class="product__color__select">
                            <label for="pc-<%= dto.getGnum() %>a"><input type="radio" id="pc-<%= dto.getGnum() %>a"></label>
                            <label class="active black" for="pc-<%= dto.getGnum() %>b"><input type="radio" id="pc-<%= dto.getGnum() %>b"></label>
                            <label class="grey" for="pc-<%= dto.getGnum() %>c"><input type="radio" id="pc-<%= dto.getGnum() %>c"></label>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>

            <%-- 할인 상품 출력 --%>
            <%
                for (GoodsDTO dto : slist) {
                    int ginum = dto.getGinum();
                    GoodsImageDTO gi = idao.select(ginum);
                    String giname = gi.getGiname();
                    if (count > 8) break;
                    count++;
            %>
            <div class="col-lg-3 col-md-6 col-sm-6 mix sale">
                <div class="product__item">
                    <a href="/shop/goods/goodsview.jsp?gnum=<%= dto.getGnum() %>&ginum=<%= dto.getGinum() %>">
                        <div class="product__item__pic set-bg" data-setbg="/shop/resources/image/<%= giname %>">
                            <span class="label">Sale</span>
                            <ul class="product__hover">
                                <li><a href="#"><img src="/shop/resources/img/icon/heart.png" alt=""></a></li>
                                <li><a href="#"><img src="/shop/resources/img/icon/compare.png" alt=""> <span>Compare</span></a></li>
                                <li><a href="#"><img src="/shop/resources/img/icon/search.png" alt=""></a></li>
                            </ul>
                        </div>
                    </a>
                    <div class="product__item__text">
                        <h6><%= dto.getGname() %></h6>
                        <a href="#" class="add-cart">+ Add To Cart</a>
                        <div class="rating">
                            <i class="fa fa-star-o"></i><i class="fa fa-star-o"></i>
                            <i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i>
                        </div>
                        <h5>
                            <del>&#8361;<%= dto.getGprice() %></del>
                            <%= dto.getDiscount() %>
                        </h5>
                        <div class="product__color__select">
                            <label for="pc-<%= dto.getGnum() %>a"><input type="radio" id="pc-<%= dto.getGnum() %>a"></label>
                            <label class="active black" for="pc-<%= dto.getGnum() %>b"><input type="radio" id="pc-<%= dto.getGnum() %>b"></label>
                            <label class="grey" for="pc-<%= dto.getGnum() %>c"><input type="radio" id="pc-<%= dto.getGnum() %>c"></label>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>

        </div>
    </div>
</section>
<jsp:include page="/include/footer.jsp"></jsp:include>

<!-- Product Section End -->
	
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