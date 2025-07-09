<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>   
<%@ page import="shop.goods.GoodsDTO" %> 
<%@ page import="shop.buy.BuyDAO" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="shop.member.MemberDTO" %>
<%@ page import="shop.member.MemberDAO" %>
<%@ page import="shop.coupon.CouponDTO" %>
<%@ page import="shop.coupon.CouponDAO" %>
<!DOCTYPE html>
<html>
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
    
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script type="text/javascript" src="/shop/resources/js/buy.js"></script>
</head>
<body>
	<%
		String sid = (String) session.getAttribute("sid");
		if(sid == null) {
	%>
		<script>
			alert("로그인 후 이용 해 주세요.");
			location.href="/shop/member/loginForm.jsp";
		</script>
	<% } else { 
		String[] gnumArr = request.getParameterValues("gnum");
		
		List<Integer> gnumes = new ArrayList<>();
		
		for(String gnum : gnumArr) {
			gnumes.add(Integer.parseInt(gnum));
		}
		
		// 장바구니에 담기
		// 추후 작업
		
		BuyDAO dao = BuyDAO.getDAO();
		List<GoodsDTO> list = dao.selectGoodsList(gnumes);
		
		MemberDAO mdao = new MemberDAO();
		MemberDTO member = mdao.getInfo(sid);
	%>
	<jsp:include page="/include/header.jsp"></jsp:include>
	<!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__text">
                        <h4>주문서</h4>
                        <div class="breadcrumb__links">
                            <a href="/shop/main/main.jsp">메인</a>
                            <a href="/shop/goods/goodslist.jsp">상품</a>
                            <span>주문서</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->

    <!-- Checkout Section Begin -->
    <section class="checkout spad">
        <div class="container">
            <div class="checkout__form">
                <form action="buyInsertPro.jsp" method="post" onsubmit="checkBuy(event)">
                    <div class="row">
                        <div class="col-lg-8 col-md-6">
                            <h6 class="checkout__title">주문 상세</h6>
                            <div class="row mb-4">
                            	<div class="col-lg-12">
		                            <div class="checkout__input">
		                                <p>쿠폰</p>
		                                <%
                                			int mnum = member.getMnum();
                                			CouponDAO cdao = CouponDAO.getDAO();
                                			List<CouponDTO> clist = cdao.selectList(mnum);
                                		%>
                                		<select id="cpnum" name="cpnum" onchange="cpnumChange()">
                                			<option value="0">-선택-</option>
	                               			<% for(CouponDTO dto : clist) { %>
	                                			<option value="<%=dto.getCpnum() %>"><%=dto.getCpname() %></option>
	                                		<% } %>
                                		</select>
		                            </div>
		                        </div>
		                    </div>
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="checkout__input">
                                        <p>이름</p>
                                        <input type="text" readonly value="<%= member.getMname() %>"/>
                                    </div>
                                </div>
                            </div>
                            <div class="checkout__input">
                                <p>주소<span>*</span></p>
                                <input type="text" placeholder="우편번호" name="zip" id="zip">
								<input type="button" onclick="zipFind()" value="우편번호 찾기" class="site-btn"><br>
								<input type="text" placeholder="주소" name="address" id="address"><br>
								<input type="text" placeholder="상세주소" name="address2" id="address2">
								<input type="text" placeholder="참고항목" name="address3" id="address3">
                            </div>
                            <script> 
							    
							</script>
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="checkout__input">
                                        <p>휴대폰번호<span>*</span></p>
                                        <input type="text" value="<%=member.getMphone()%>" readonly placeholder="휴대폰번호를 입력하세요.">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                            	<div class="col-lg-12">
                                    <div class="checkout__input">
                                        <p>이메일</p>
                                        <input type="text" value="<%=member.getMemail()%>" readonly placeholder="이메일을 입력하세요.">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                            	<div class="col-lg-12">
		                            <div class="checkout__input">
		                                <p>주문 시 메모</p>
		                                <input type="text" placeholder="ex) 배송 전 연락 바랍니다." name="note">
		                            </div>
		                        </div>
		                    </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="checkout__order">
                                <h4 class="order__title">주문 내역</h4>
                                <div class="checkout__order__products">상품 <span>가격</span></div>
                                <ul class="checkout__total__products">
                                	<% 
                                		// 수량 배열 list 타입으로 변환
                                		String[] bcountArr = request.getParameterValues("bcount");
                                		List<Integer> bcountList = new ArrayList<>();
                                		
                                		for(String b : bcountArr) {
                                			bcountList.add(Integer.parseInt(b));
                                		}
                                		
                                		// 옵션 번호 배열 list 타입으로 변환
                                		String[] gonumArr = request.getParameterValues("gonum");
                                		List<Integer> gonumList = new ArrayList<>();
                                		
                                		for(String g : gonumArr) {
                                			gonumList.add(Integer.parseInt(g));
                                		}
                                		
                                		int total = 0;
                               			String item_name = "";
                               			int totalCnt = list.size();
                                		NumberFormat numberFormat = NumberFormat.getNumberInstance(Locale.getDefault());
                                	%>
                                	<% for(int i = 0; i < list.size(); i++) { 
                                		GoodsDTO goods = list.get(i);
                                		int bcount = bcountList.get(i);
                                		int gonum = gonumList.get(i);
	                                    String gprice = numberFormat.format(goods.getGprice());
	                                    total += goods.getGprice();
	                                    if(i == list.size() - 1) {
	                                    	item_name += goods.getGname();
	                                    } else {
	                                    	item_name += goods.getGname() + ",";
	                                    }
                               		%>
                                		<li>
                                			<%=goods.getGname() %> (<%=bcount %> 개) 
                                			<span>&#8361; <%=gprice %></span>
                                			<input type="hidden" name="gnum" value="<%=goods.getGnum()%>"/>
                                			<input type="hidden" name="bcount" value="<%=bcount %>" />
                                			<input type="hidden" name="gonum" value="<%=gonum%>"/>
                                		</li>
                                	<% } %>
                                </ul>
                                <ul class="checkout__total__all">
                                    <li>총 가격 
                                    	<span>&#8361; 
                                    		<span id="after_total_amount"></span>
                                    		<span id="before_total_amount"><%=numberFormat.format(total) %></span>
                                    	</span>
                                    </li>
                                    <%
                                    	session.setAttribute("totalprice", numberFormat.format(total));
                                    	// 총 구매 가격을 세션에 저장하여 포인트 계산시에 활용함
                                    %>
                                </ul>
                                <div class="checkout__input__checkbox">
                                    <label for="accessOrder">
                                        상품 구매에 동의 하십니까?
                                        <input type="checkbox" id="accessOrder">
                                        <span class="checkmark"></span>
                                    </label>
                                </div>
                                <button type="submit" class="site-btn">주문하기</button>
                            </div>
                        </div>
                    </div>
                    <input type="hidden" name="item_name" id="item_name" value="<%=item_name%>"/>
                    <input type="hidden" name="quantity" id="quantity" value="<%=totalCnt%>"/>
                    <input type="hidden" name="total_amount" id="total_amount" value="<%=total%>"/>
                    <input type="hidden" name="before_price" id="before_price" value="<%=total%>"/>
                </form>
            </div>
        </div>
    </section>
    <!-- Checkout Section End -->
    <jsp:include page="/include/footer.jsp"></jsp:include>
    <% } %>
</body>
</html>