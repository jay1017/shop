<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="shop.goods.GoodsDTO"%>
<%@ page import="shop.goods.GoodsDAO"%>
<%@ page import="shop.goods.OptionDTO"%>
<%@ page import="shop.review.ReviewDTO"%>
<%@ page import="shop.review.ReviewDAO"%>
<%@ page import="shop.member.MemberDTO"%>
<%@ page import="shop.member.MemberDAO"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.Locale"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="shop.buy.BuyDTO" %>
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
    
    int rcount=rdao.reviewCount(gnum); //리뷰의 개수 출력하는 메소드
    
	boolean reviewCheck=rdao.reviewCheck(mnum,gnum); //리뷰 작성 가능한 bnum인지 체크
	
	BuyDTO bdto=rdao.buyCheck(mnum, gnum);
	int bnum=bdto.getBnum(); //bnum출력
    int gonum=bdto.getGonum();  //gonum출력
    
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
<link rel="stylesheet" href="/shop/resources/css/elegant-icons.css" type="text/css">
<link rel="stylesheet" href="/shop/resources/css/magnific-popup.css" type="text/css">
<link rel="stylesheet" href="/shop/resources/css/nice-select.css" type="text/css">
<link rel="stylesheet" href="/shop/resources/css/owl.carousel.min.css" type="text/css">
<link rel="stylesheet" href="/shop/resources/css/slicknav.min.css" type="text/css">
<link rel="stylesheet" href="/shop/resources/css/font-awesome.min.css" type="text/css">
<link rel="stylesheet" href="/shop/resources/css/style.css" type="text/css">
</head>
<body>
	<jsp:include page="/include/header.jsp" />
	<jsp:include page="/include/sidebar.jsp" />
   <!-- Shop Details Section Begin -->
   <section class="shop-details">
      <div class="product__details__pic">
         <div class="container">
            <div class="row">
               <div class="col-lg-12">
                  <div class="product__details__breadcrumb">
                     <a href="/shop/main/main.jsp">메인</a> <a
                        href="/shop/goods/goodslist.jsp">상품 목록</a> <span>상품 상세</span>
                  </div>
               </div>
            </div>
            <div class="row">
               <div class="col-lg-3 col-md-3">
                  <ul class="nav nav-tabs" role="tablist">
                     <li class="nav-item"><a class="nav-link active"
                        data-toggle="tab" href="#tabs-1" role="tab">
                           <div class="product__thumb__pic set-bg"
                              data-setbg="/shop/resources/image/<%=goods.getGiname()%>"></div>
                     </a></li>
                     <%
                     if (goods.getGidetail1() != null) {
                     %>
                     <li class="nav-item"><a class="nav-link" data-toggle="tab"
                        href="#tabs-2" role="tab">
                           <div class="product__thumb__pic set-bg"
                              data-setbg="/shop/resources/image/<%=goods.getGidetail1()%>"></div>
                     </a></li>
                     <%
                     }
                     %>
                     <%
                     if (goods.getGidetail2() != null) {
                     %>
                     <li class="nav-item"><a class="nav-link" data-toggle="tab"
                        href="#tabs-3" role="tab">
                           <div class="product__thumb__pic set-bg"
                              data-setbg="/shop/resources/image/<%=goods.getGidetail2()%>"></div>
                     </a></li>
                     <%
                     }
                     %>
                     <%
                     if (goods.getGidetail3() != null) {
                     %>
                     <li class="nav-item"><a class="nav-link" data-toggle="tab"
                        href="#tabs-4" role="tab">
                           <div class="product__thumb__pic set-bg"
                              data-setbg="/shop/resources/image/<%=goods.getGidetail3()%>"></div>
                     </a></li>
                     <%
                     }
                     %>
                  </ul>
               </div>
               <div class="col-lg-6 col-md-9">
                  <div class="tab-content">
                     <div class="tab-pane active" id="tabs-1" role="tabpanel">
                        <div class="product__details__pic__item">
                           <img src="/shop/resources/image/<%=goods.getGiname()%>" alt="">
                        </div>
                     </div>
                     <div class="tab-pane" id="tabs-2" role="tabpanel">
                        <div class="product__details__pic__item">
                           <img src="/shop/resources/image/<%=goods.getGidetail1()%>"
                              alt="">
                        </div>
                     </div>
                     <div class="tab-pane" id="tabs-3" role="tabpanel">
                        <div class="product__details__pic__item">
                           <img src="/shop/resources/image/<%=goods.getGidetail2()%>"
                              alt="">
                        </div>
                     </div>
                     <div class="tab-pane" id="tabs-4" role="tabpanel">
                        <div class="product__details__pic__item">
                           <img src="/shop/resources/image/<%=goods.getGidetail3()%>"
                              alt="">
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
                     <h4><%=goods.getGname()%></h4>
                     <h3>
                        &#8361;
                        <%=discount%>
                        <span><%=gprice%></span>
                     </h3>
                     <p><%=goods.getGplot()%></p>
                     <div class="product__details__option">
                        <div class="product__details__option__size">
                           <span>사이즈:</span>
                           <%
                           for (OptionDTO dto : list) {
                           %>
                           <label id="<%=dto.getGosize()%>"><%=dto.getGosize()%> <input
                              type="radio" name="gonumRadio" id="<%=dto.getGosize()%>"
                              value="<%=dto.getGonum()%>" onclick="selectRadio(this.value)">
                           </label>
                           <%
                           }
                           %>
                        </div>
                     </div>
                     <div class="product__details__cart__option"
                        style="display: flex; justify-content: center;">
                        <form action="/shop/cart/cartInsertPro.jsp" method="post"
                           onsubmit="checkLogin(event)">
                           <input type="hidden" value="<%=session.getAttribute("sid")%>"
                              name="sid" /> <input type="hidden" name="gonum" id="gonum1" />
                           <div class="quantity">
                              <div class="pro-qty">
                                 <input type="text" value="1" name="ccount" id="ccount">
                              </div>
                           </div>
                           <input type="hidden" value="<%=goods.getGnum()%>" name="gnum" />
                           
                           <input type="submit" value="장바구니 담기" class="primary-btn"
                              style="border: none;" />
                        </form>
                        <form action="/shop/buy/buyInsert.jsp" method="post"
                           onsubmit="checkLogin(event)" style="margin-left: 20px;">
                           <input type="hidden" value="<%=session.getAttribute("sid")%>"
                              name="sid" /> <input type="hidden" name="gonum" id="gonum2" />
                           <input type="hidden" name="bcount" id="bcount" /> <input
                              type="hidden" value="<%=goods.getGnum()%>" name="gnum" /> <input
                              type="submit" value="구매하기" class="primary-btn"
                              style="border: none;" />
                        </form>
                        <script>
	                         
                             
                         </script>
                     </div>
                  </div>
               </div>
            </div>
            <div class="row" style="margin-bottom: 40px;">
               <div class="col-lg-12">
                  <div class="product__details__tab">
                     <ul class="nav nav-tabs" role="tablist">
                        <li class="nav-item"><a class="nav-link active"
                           data-toggle="tab" href="#tabs-5" role="tab">상품 설명</a></li>
                        <li class="nav-item"><a class="nav-link" data-toggle="tab"
                           href="#tabs-6" role="tab">리뷰(<%=rcount%>)
                        </a></li>
                     </ul>
                     <div class="tab-content">
                        <div class="tab-pane active" id="tabs-5" role="tabpanel">
                           <div class="product__details__tab__content">
                              <div class="product__details__tab__content__item">
                                 <h5>상품 설명</h5>
                                 <p>
                                    <%
                                    if (goods.getGcontent() != null) {
                                    %>
                                    <%=goods.getGcontent()%>
                                    <%
                                    }
                                    %>
                                 </p>
                              </div>
                           </div>
                        </div>
                        <!-- 리뷰 출력 -->
                        <!-- 리뷰 탭 내용 부분 (기존 코드 수정) -->
                        <div class="tab-pane" id="tabs-6" role="tabpanel">
                           <div class="product__details__tab__content">
                              <div class="product__details__tab__content__item">
                                 <h5>리뷰 목록</h5>

                                 <!-- 리뷰 작성 버튼 및 폼 -->
                                 <%
                                 if (sid != null) {
                                 %>
                                 <% if(reviewCheck){%>
                                 <div class="review-write-section"
                                    style="margin-bottom: 30px; padding: 20px; border: 1px solid #e0e0e0; border-radius: 5px;">
                                    <div class="review-write-header"
                                       style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px;">
                                       <h6>리뷰 작성</h6>
                                       <button type="button" class="btn btn-primary btn-sm"
                                          onclick="toggleReviewForm()" id="reviewToggleBtn">
                                          리뷰 작성하기</button>
                                    </div>

                                    <div id="reviewForm" style="display: none;">
                                       <form action="/shop/review/reviewPro.jsp" method="post">
                                          <input type="hidden" name="gnum" value="<%=gnum%>">
                                          <input type="hidden" name="mnum" value="<%=mnum%>">
                                          <input type="hidden" name="canum" value="<%=canum%>">
                                          <input type="hidden" name="ginum" value="<%=ginum%>">
                                          <input type="hidden" name="bnum" value="<%=bnum%>">
                                          <input type="hidden" name="gonum" value="<%=gonum%>">

                                          <div class="form-group">
                                             <label for="rcontent">리뷰 내용</label>
                                             <textarea class="form-control" name="rcontent"
                                                id="rcontent" rows="4" placeholder="상품에 대한 리뷰를 작성해주세요."
                                                required></textarea>
                                          </div>

                                          <div class="form-group"
                                             style="text-align: right; margin-top: 15px;">
                                             <button type="button" class="btn btn-secondary btn-sm"
                                                onclick="cancelReviewForm()">취소</button>
                                             <button type="submit" class="btn btn-primary btn-sm"
                                                style="margin-left: 10px;">리뷰 등록</button>
                                          </div>
                                       </form>
                                    </div>
                                 </div>
                                 <%}
                                 } else {
                                 %>
                                 <div class="login-notice"
                                    style="margin-bottom: 20px; padding: 15px; background-color: #f8f9fa; border-radius: 5px;">
                                    <p style="margin: 0; color: #6c757d;">
                                       <i class="fa fa-user"></i> 리뷰를 작성하려면 <a
                                          href="/shop/member/loginForm.jsp" style="color: #007bff;">로그인</a>이
                                       필요합니다.
                                    </p>
                                 </div>
                                 <%
                                 }
                                 %>

                                 <!-- Ajax 기반 리뷰 목록 영역 -->
                                 <div id="reviewContainer">로딩 중...</div>

                                    
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
	<jsp:include page="/include/footer.jsp" />
	<!-- 기존 스크립트 태그들 앞에 추가 -->
	<script>
    // JSP에서 JavaScript로 변수 전달
    window.currentGnum = <%= gnum %>;
	</script>	
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
	<script src="/shop/goods.js/goodsview.js"></script>
</body>
</html>