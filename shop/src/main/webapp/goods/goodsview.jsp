<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.goods.GoodsDTO" %>
<%@ page import="shop.goods.GoodsDAO" %>
<%@ page import="shop.goods.OptionDTO" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%
    request.setCharacterEncoding("UTF-8");
    // String sid = (String) session.getAttribute("sid");

    // int gnum = Integer.parseInt(request.getParameter("gnum"));
    int gnum = 140;
    
    GoodsDAO dao = GoodsDAO.getDAO();
    GoodsDTO goods = dao.select(gnum); 
	
    // 포맷팅
    NumberFormat numberFormat = NumberFormat.getNumberInstance(Locale.getDefault());
    String gprice = numberFormat.format(goods.getGprice());
    String discount = numberFormat.format(goods.getDiscount());
    
    List<OptionDTO> list = dao.selectOption(goods.getGname()); 
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Male_Fashion Template">
    <meta name="keywords" content="Male_Fashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Male-Fashion | Template</title>
    <!-- Css Styles -->
    <link rel="stylesheet" href="/shop/resources/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="/shop/resources/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="/shop/resources/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="/shop/resources/css/magnific-popup.css" type="text/css">
    <link rel="stylesheet" href="/shop/resources/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="/shop/resources/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="/shop/resources/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="/shop/resources/css/style.css" type="text/css">
    <link rel="stylesheet" href="/shop/resources/css/font.css">
</head>
<body>
	<jsp:include page="/include/header.jsp"></jsp:include>
    <!-- Shop Details Section Begin -->
    <section class="shop-details">
        <div class="product__details__pic">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="product__details__breadcrumb">
                            <a href="/shop/main/main.jsp">메인</a>
                            <a href="/shop/goods/goodslist.jsp">상품 목록</a>
                            <span>상품 상세</span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-3 col-md-3">
                        <ul class="nav nav-tabs" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" data-toggle="tab" href="#tabs-1" role="tab">
                                    <div class="product__thumb__pic set-bg" data-setbg="/shop/resources/image/<%=goods.getGiname() %>"></div>
                                </a>
                            </li>
                            <% if(goods.getGidetail1() != null) { %>
                            	<li class="nav-item">
	                                <a class="nav-link" data-toggle="tab" href="#tabs-2" role="tab">
	                                    <div class="product__thumb__pic set-bg" data-setbg="/shop/resources/image/<%=goods.getGidetail1() %>"></div>
	                                </a>
	                            </li>
                            <% } %>
                            <% if(goods.getGidetail2() != null) { %>
                            	<li class="nav-item">
	                                <a class="nav-link" data-toggle="tab" href="#tabs-3" role="tab">
	                                    <div class="product__thumb__pic set-bg" data-setbg="/shop/resources/image/<%=goods.getGidetail2() %>"></div>
	                                </a>
	                            </li>
                            <% } %>
                            <% if(goods.getGidetail3() != null) { %>
                            	<li class="nav-item">
	                                <a class="nav-link" data-toggle="tab" href="#tabs-4" role="tab">
	                                    <div class="product__thumb__pic set-bg" data-setbg="/shop/resources/image/<%=goods.getGidetail3() %>"></div>
	                                </a>
	                            </li>
                            <% } %>
                        </ul>
                    </div>
                    <div class="col-lg-6 col-md-9">
                        <div class="tab-content">
                            <div class="tab-pane active" id="tabs-1" role="tabpanel">
                                <div class="product__details__pic__item">
                                    <img src="/shop/resources/image/<%=goods.getGiname() %>" alt="">
                                </div>
                            </div>
                            <div class="tab-pane" id="tabs-2" role="tabpanel">
                                <div class="product__details__pic__item">
                                    <img src="/shop/resources/image/<%=goods.getGidetail1() %>" alt="">
                                </div>
                            </div>
                            <div class="tab-pane" id="tabs-3" role="tabpanel">
                                <div class="product__details__pic__item">
                                    <img src="/shop/resources/image/<%=goods.getGidetail2() %>" alt="">
                                </div>
                            </div>
                            <div class="tab-pane" id="tabs-4" role="tabpanel">
                                <div class="product__details__pic__item">
                                    <img src="/shop/resources/image/<%=goods.getGidetail3() %>" alt="">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="product__details__content">
            <div class="container">
                <div class="row d-flex justify-content-center">
                    <div class="col-lg-8">
                        <div class="product__details__text">
                            <h4><%=goods.getGname() %></h4>
                            <h3>&#8361; <%=discount %> <span><%=gprice %></span></h3>
                            <p><%=goods.getGplot()%></p>
                            <div class="product__details__option">
                                <div class="product__details__option__size">
                                    <span>사이즈:</span>
                                    <% for(OptionDTO dto : list) { %>
                                    <label id="<%=dto.getGosize()%>"><%=dto.getGosize() %>
                                    	<input type="radio" id="<%=dto.getGosize()%>" value="<%=dto.getGonum() %>">
                                    </label>
                                    <% } %>
                                </div>
                            </div>
                            <div class="product__details__cart__option">
                                <div class="quantity">
                                    <div class="pro-qty">
                                        <input type="text" value="1">
                                    </div>
                                </div>
                                <a href="#" class="primary-btn">장바구니 담기</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row" style="margin-bottom: 40px;">
                    <div class="col-lg-12">
                        <div class="product__details__tab">
                            <ul class="nav nav-tabs" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" data-toggle="tab" href="#tabs-5" role="tab">상품 설명</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" data-toggle="tab" href="#tabs-6" role="tab">리뷰</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane active" id="tabs-5" role="tabpanel">
                                    <div class="product__details__tab__content">
                                        <div class="product__details__tab__content__item">
                                            <h5>상품 설명</h5>
                                            <p>
                                            	<% if(goods.getGcontent() != null) { %>
                                          			<%=goods.getGcontent() %>
                                            	<% } %>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane" id="tabs-6" role="tabpanel">
                                    <div class="product__details__tab__content">
                                        <div class="product__details__tab__content__item">
                                            <%-- 여기에 작업 --%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Shop Details Section End -->
    <jsp:include page="/include/footer.jsp"></jsp:include>
</body>
</html>
