<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.goods.GoodsDTO" %>
<%@ page import="shop.goods.GoodsDAO" %>
<%@ page import="shop.goods.OptionDTO" %>
<%@ page import="shop.review.ReviewDTO" %>
<%@ page import="shop.review.ReviewDAO" %>
<%@ page import="shop.member.MemberDTO" %>
<%@ page import="shop.member.MemberDAO" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%--상품 상세정보--%>
<%
    request.setCharacterEncoding("UTF-8");
    String sid = (String) session.getAttribute("sid");
    int mnum=0;
    
    if(sid!=null) {
    MemberDAO mdao=new MemberDAO();
    MemberDTO mdto=mdao.getMidname(sid); 
    mnum=mdto.getMnum(); //회원 고유번호 받아오기
    }
    int gnum = Integer.parseInt(request.getParameter("gnum"));
    
    
    GoodsDAO dao = GoodsDAO.getDAO();
    GoodsDTO goods = dao.select(gnum);
    int ginum=goods.getGinum(); //상품 이미지 번호 조회
    int canum=goods.getCanum(); //상품 카테고리 번호 조회
    
   //리뷰 목록 조회
    ReviewDAO rdao=ReviewDAO.getInstance(); //리뷰 DAO
    List<ReviewDTO> rlist=rdao.getReview(gnum);	//gnum인 리뷰목록 조회 
    
    ReviewDTO myReview=null;
    if(sid!=null) {
    	myReview=rdao.getUserReview(gnum,mnum); //본인 리뷰가 있는지 확인
    }
	
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
    <title>ODEZ</title>
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
                                    	<input type="radio" name="gonum" id="<%=dto.getGosize()%>" value="<%=dto.getGonum() %>">
                                    </label>
                                    <% } %>
                                </div>
                            </div>
                            <div class="product__details__cart__option" style="display: flex; justify-content: center;">
                            	<form action="/shop/cart/cartInsertPro.jsp" method="post" onsubmit="checkLogin(event)">
                            		<input type="hidden" value="<%=session.getAttribute("sid") %>" name="sid" />
                            		<input type="hidden" name="gonum" id="gonum1"/>
	                                <div class="quantity">
	                                    <div class="pro-qty">
	                                        <input type="text" value="1" name="ccount" id="ccount">
	                                    </div>
	                                </div>
                                	<input type="hidden" value="<%=goods.getGnum() %>" name="gnum"/>
                                	<input type="submit" value="장바구니 담기" class="primary-btn" style="border: none;"/>
                                </form>
                                <form action="/shop/buy/buyInsert.jsp" method="post" onsubmit="checkLogin(event)" style="margin-left: 20px;">
                                	<input type="hidden" value="<%=session.getAttribute("sid") %>" name="sid" />
                                	<input type="hidden" name="gonum" id="gonum2"/>
                                	<input type="hidden" name="bcount" id="bcount"/>
                                	<input type="hidden" value="<%=goods.getGnum() %>" name="gnum"/>
                                	<input type="submit" value="구매하기" class="primary-btn" style="border: none;"/>
                                </form>
                                <script>
                                	function checkLogin(event) {
                                		var sid = document.getElementById("sid");
                                		var ccount = document.getElementById("ccount");
                                		var bcount = document.getElementById("bcount");
                                		
                                		var gonum = document.getElementsByName("gonum");
                                		var gonum1 = document.getElementById("gonum1");
                                		var gonum2 = document.getElementById("gonum2");
                                		
                                		for(var i = 0; i < gonum.length; i++) {
                                			if(gonum[i].checked) {
                                				gonum1.value = gonum[i].value;
                                				gonum2.value = gonum[i].value;
                                			}
                                		}
                                		
                                		bcount.value = ccount.value;
                                		
                                		if(gonum1.value == null || gonum1.value == "" || gonum2.value == null || gonum2.value == "") {
                                			alert("상품 옵션을 선택 해 주세요.");
                                			event.preventDefault();
                                		}
                                		
                                		if(sid.value.trim() == 'null') {
                                			alert("로그인 이후 가능합니다.");
                                			event.preventDefault();
                                			location.href="/shop/member/loginForm.jsp";
                                		}
                                	}
                                </script>
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
                                            <h5>리뷰 목록</h5>
                                            <%--여기에 작업--%>
                                            	<div>
                                            	<% if(sid!=null) { %>
                                            		<h5><%=(myReview==null ? "리뷰 작성" : "리뷰 수정") %></h5>
                                        			<form action="<%=(myReview==null ? "/shop/review/reviewPro.jsp" :"/shop/review/reviewUpdate.jsp")%>" method="post">
														<input type="hidden" name="sid" value="<%=sid%>"/>
                                        				<input type="hidden" name="gnum" value="<%=gnum%>"/>
                                        				<input type="hidden" name="mnum" value="<%=mnum%>"/>
                                        				<input type="hidden" name="canum" value="<%=canum%>"/> 
                                        				<input type="hidden" name="ginum" value="<%=ginum%>"/>
                                        				<%if(myReview!=null) { %>
                                        					<input type="hidden" name="rnum" value="<%=myReview.getRnum()%>"/>
                                        				<%} %>
                                        				<textarea name="rcontent" rows="4" cols="60" placeholder="리뷰를 입력하세요"><%= (myReview != null) ? myReview.getRcontent() : "" %>
                                        				</textarea><br>
                                        				<input type="submit" value="<%= (myReview == null ? "리뷰 작성" : "리뷰 수정") %>"> <%--여기서 뭘 넘겨야할까? --%>
                                        			</form>
                                        			<%}else{ %>
                                        			<p><a href="/shop/member/loginForm.jsp">로그인</a> 후 리뷰를 작성할 수 있습니다.</p>
                                        			<%} %>
                                        		</div>
                                        		<div>
                                            	<%for(ReviewDTO dto:rlist){	%>
                                            		<%=dto.getRcontent() %>
                                            		<%=dto.getCanum() %>
                                            		<%=dto.getGnum() %>                                          		  
                                            	</div>	                                            	                                        	
                                            <%} %>                                                                       
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
