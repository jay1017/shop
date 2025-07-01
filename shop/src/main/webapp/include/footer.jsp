<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.category.CategoryDTO" %>
<%@ page import="shop.category.CategoryDAO" %>
<%@ page import="java.util.List" %>    
<!-- Footer Section Begin -->
<footer class="footer">
    <div class="container">
        <div class="row">
            <div class="col-lg-3 col-md-6 col-sm-6">
                <div class="footer__about">
                    <div class="footer__logo">
                        <a href="/shop/main/main.jsp"><img src="/shop/resources/img/logo.png" alt="" style="width: 110px;"></a>
                    </div>
                    <p>취업을 향한 열정으로 모인 다섯 명, <br /> 그 열기로 완성한 우리만의 스타일 플랫폼.</p>
                </div>
            </div>
            <div class="col-lg-2 offset-lg-1 col-md-3 col-sm-6">
                <div class="footer__widget">
                    <h6>상품</h6>
                    <%
                		CategoryDAO dao = CategoryDAO.getDAO();
                		List<CategoryDTO> list = dao.selectList(); 
                	%>
                    <ul>
                        <% for(CategoryDTO dto : list) { %>
                   			<li><a href="/shop/goods/goodslist.jsp?canum=<%=dto.getCanum()%>"><%=dto.getCaname() %></a></li>
                   		<% } %>
                    </ul>
                </div>
            </div>
            <div class="col-lg-2 col-md-3 col-sm-6">
                <div class="footer__widget">
                    <h6>회사소개</h6>
                    <ul>
                        <li><a href="#">회사소개</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="footer__copyright__text">
                    <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                    <p>Copyright ©
                        <script>
                            document.write(new Date().getFullYear());
                        </script>2025
                        All rights reserved <i class="fa fa-heart-o"
                        aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">team02</a>
                    </p>
                    <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                </div>
            </div>
        </div>
    </div>
</footer>
<!-- Footer Section End -->

<!-- Js Plugins -->
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