<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Offcanvas Menu Begin -->
<div class="offcanvas-menu-overlay"></div>
<div class="offcanvas-menu-wrapper">
    <div class="offcanvas__option">
        <div class="offcanvas__links">
            <a href="#">로그인</a>
            <a href="#">문의게시판</a>
        </div>
    </div>
    <div class="offcanvas__nav__option">
        <a href="#" class="search-switch"><img src="/shop/resources/img/icon/search.png" alt=""></a>
        <a href="#"><img src="/shop/resources/img/icon/heart.png" alt=""></a>
        <a href="#"><img src="/shop/resources/img/icon/cart.png" alt=""> <span>0</span></a>
    </div>
    <div id="mobile-menu-wrap"></div>
    <div class="offcanvas__text">
        <p>오데즈에 오신 여러분을 환영합니다.</p>
    </div>
</div>
<!-- Offcanvas Menu End -->

<!-- Header Section Begin -->
<header class="header">
    <div class="header__top">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-7">
                    <div class="header__top__left">
                        <p>오데즈에 오신 여러분을 환영합니다.</p> 
                    </div>
                </div>
                <div class="col-lg-6 col-md-5">
                    <div class="header__top__right">
                        <div class="header__top__links">
                            <a href="/shop/member/loginForm.jsp">로그인</a>
                            <a href="#">문의게시판</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-lg-3 col-md-3">
                <div class="header__logo">
                    <a href="/shop/main/main.jsp"><img src="/shop/resources/img/logo.png" alt="" style="width: 110px;"></a>
                </div>
            </div>
            <div class="col-lg-6 col-md-6">
                <nav class="header__menu mobile-menu">
                    <ul>
                        <li><a href="/shop/main/main.jsp">메인</a></li>
                        <li><a href="./shop.html">상품</a>
                        	<ul class="dropdown">
                                <li><a href="/shop/goods/goods.jsp">상품 목록</a></li>
                                <li><a href="/shop/cart/cart.jsp">장바구니</a></li>
                                <li><a href="./checkout.html">주문서</a></li>
                            </ul>
                        </li>
                        <li><a href="#">회사소개</a></li>
                    </ul>
                </nav>
            </div>
            <div class="col-lg-3 col-md-3">
                <div class="header__nav__option">
                    <a href="#" class="search-switch"><img src="/shop/resources/img/icon/search.png" alt=""></a>
                    <a href="#"><img src="/shop/resources/img/icon/heart.png" alt=""></a>
                    <a href="#"><img src="/shop/resources/img/icon/cart.png" alt=""> <span>0</span></a>
                </div>
            </div>
        </div>
        <div class="canvas__open"><i class="fa fa-bars"></i></div>
    </div>
</header>
<!-- Header Section End -->

<!-- Search Begin -->
<div class="search-model">
    <div class="h-100 d-flex align-items-center justify-content-center">
        <div class="search-close-switch">+</div>
        <form action="/shop/main/search.jsp" class="search-model-form">
            <input type="text" name="key" id="search-input" placeholder="Search here.....">
            <input type="submit" value="검색">
        </form>
    </div>
</div>
<!-- Search End -->