<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %> 
<%@ page import="shop.coupon.CouponDTO" %>
<%@ page import="shop.coupon.CouponDAO" %> 
<%@ page import="java.text.SimpleDateFormat" %>
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
</head>
<body>
	<jsp:include page="/include/header.jsp" />
	
	<%
		int mnum = Integer.parseInt(request.getParameter("mnum"));
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		CouponDAO dao = CouponDAO.getDAO();
		List<CouponDTO> list = dao.selectList(mnum); 
		int cpcount = dao.selectCount(mnum);
		List<CouponDTO> nList = dao.selectNList(mnum); 
		int cpNcount = dao.selectNCount(mnum);
	%>
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="tab-container2">
					<div class="tab-header">
						<div class="tab-button active" onclick="showTab(0)">보유 쿠폰 (<%=cpcount %>장)</div>
						<div class="tab-button" onclick="showTab(1)">쿠폰 받기 (<%=cpNcount %>장)</div>
					</div>
					<div class="tab-content2 active">
						<% for(CouponDTO dto : list) { %>
							<div class="coupon-box clearfix">
								<span class="coupon-type">구매 쿠폰</span>
								<div class="coupon-title"><a href="#"><%=dto.getCpname() %></a></div>
								<div class="coupon-expiry"><%=sdf.format(dto.getCpdate()) %> 까지</div>
							</div>
						<% } %>
					</div>
					<div class="tab-content2">
						<% for(CouponDTO dto : nList) { %>
							<div class="coupon-box clearfix">
								<span class="coupon-type">구매 쿠폰</span>
								<button class="btn-receive" onclick="location.href='/shop/member/memberCouponInsert.jsp?cpnum=<%=dto.getCpnum()%>&mnum=<%=mnum%>'"><i class="fa fa-download" aria-hidden="true"></i> 쿠폰 받기</button>
								<div class="coupon-title"><a href="#"><%=dto.getCpname() %></a></div>
								<div class="coupon-expiry"><%=sdf.format(dto.getCpdate()) %> 까지</div>
							</div>
						<% } %>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<jsp:include page="/include/footer.jsp" />
	
	<script>
	function showTab(index) {
		const buttons = document.querySelectorAll('.tab-button');
		const contents = document.querySelectorAll('.tab-content2');
	
		buttons.forEach((btn, i) => {
			btn.classList.toggle('active', i === index);
		});
	
		contents.forEach((content, i) => {
			content.classList.toggle('active', i === index);
		});
	}
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
</body>
</html>