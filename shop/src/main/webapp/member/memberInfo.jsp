<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mdto" class="shop.member.MemberDTO" />
<jsp:useBean id="mdao" class="shop.member.MemberDAO" />
<%
String sid = (String) session.getAttribute("sid");
mdto = mdao.getInfo(sid);
String SetGender = mdao.setGender(sid);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>ODEZ - 회원 정보</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
<body class="memberInfo-body">
	<jsp:include page="/include/header.jsp" />

	<section class="memberInfo-section">
		<h2>
			안녕하세요. <%=mdto.getMname()%>님
		</h2>
		<ul class="memberInfo-menu">
			<li>
				<a href="memberUpdate.jsp">
					<div class="memberInfo-text">
						<strong>내 정보 확인 및 변경</strong>
					</div>
					<span class="memberInfo-arrow">&gt;</span>
				</a>
			</li>
			<li>
				<a href="memberCoupon.jsp?mnum=<%=mdto.getMnum()%>">
					<div class="memberInfo-text">
						<strong>쿠폰 내역</strong>
					</div>
					<span class="memberInfo-arrow">&gt;</span>
				</a>
			</li>
			<li>
				<a href="/shop/point/pointForm.jsp">
					<div class="memberInfo-text">
						<strong>포인트 내역</strong>
					</div>
					<span class="memberInfo-arrow">&gt;</span>
				</a>
			</li>
		</ul>
	</section>

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
