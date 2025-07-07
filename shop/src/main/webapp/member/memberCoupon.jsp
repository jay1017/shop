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
    
    <style>
	    .coupon-box {
	      border: 1px solid #ddd;
	      border-radius: 5px;
	      padding: 15px;
	      margin: 15px 0;
	      font-family: sans-serif;
	      position: relative;
	    }
	
	    .coupon-header {
	      font-size: 18px;
	      font-weight: bold;
	    }
	
	    .coupon-type {
	      display: inline-block;
	      background-color: #f5f5f5;
	      color: #888;
	      font-size: 12px;
	      padding: 2px 6px;
	      border-radius: 2px;
	      margin-right: 10px;
	    }
	
	    .coupon-title {
	      font-size: 15px;
	      margin: 10px 0 5px;
	    }
	
	    .coupon-title a {
	      color: #1a0dab;
	      font-weight: bold;
	      text-decoration: none;
	    }
	
	    .coupon-desc {
	      font-size: 14px;
	      color: #555;
	      margin-bottom: 5px;
	    }
	
	    .coupon-expiry {
	      font-size: 13px;
	      color: #999;
	    }
	    
	    .btn-receive {
		  position: absolute;
		  right: 15px;
		  top: 15px;
		  border: 1px solid #ccc;
		  background-color: #fff;
		  padding: 5px 10px;
		  font-size: 13px;
		  border-radius: 3px;
		  cursor: pointer;
		}
	
	    .clearfix::after {
	      content: "";
	      display: block;
	      clear: both;
	    }
	    
	    .tab-container {
		  background-color: white;
		  padding: 20px;
		  border-radius: 6px;
		  border: 1px solid #e0e0e0;
		  width: 600px;
		  margin:30px auto;
		}
		
		.tab-header {
		  display: flex;
		  align-items: center;
		  border-bottom: 1px solid #ccc;
		  padding-bottom: 10px;
		  margin-bottom: 10px;
		}
		
		.tab-button {
		  font-size: 15px;
		  color: #999;
		  margin-right: 20px;
		  cursor: pointer;
		  padding-bottom: 5px;
		  border-bottom: 2px solid transparent;
		}
		
		.tab-button.active {
		  color: #000;
		  font-weight: bold;
		  border-bottom: 2px solid #000;
		}
		
		.tab-content {
		  display: none;
		  font-size: 14px;
		}
		
		.tab-content.active {
		  display: block;
		}
	</style>
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
				<div class="tab-container">
					<div class="tab-header">
						<div class="tab-button active" onclick="showTab(0)">보유 쿠폰 (<%=cpcount %>장)</div>
						<div class="tab-button" onclick="showTab(1)">쿠폰 받기 (<%=cpNcount %>장)</div>
					</div>
					<div class="tab-content active">
						<% for(CouponDTO dto : list) { %>
							<div class="coupon-box clearfix">
								<span class="coupon-type">구매 쿠폰</span>
								<div class="coupon-title"><a href="#"><%=dto.getCpname() %></a></div>
								<div class="coupon-expiry"><%=sdf.format(dto.getCpdate()) %> 까지</div>
							</div>
						<% } %>
					</div>
					<div class="tab-content">
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
		const contents = document.querySelectorAll('.tab-content');
	
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