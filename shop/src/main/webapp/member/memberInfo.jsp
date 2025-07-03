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
<link rel="stylesheet" href="/shop/resources/css/bootstrap.min.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/font-awesome.min.css"
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
<link rel="stylesheet" href="/shop/resources/css/font.css">
<style>
.member-section {
	max-width: 720px;
	margin: 80px auto;
	padding: 40px 30px;
	background-color: #fff;
	box-shadow: 0 5px 30px rgba(0, 0, 0, 0.05);
	border-radius: 10px;
	text-align: center;
}

.member-section h2 {
	font-size: 24px;
	margin-bottom: 30px;
	font-weight: 700;
	color: #111;
}

.member-section a.button {
	display: inline-block;
	margin-top: 20px;
	padding: 12px 28px;
	background-color: #111;
	color: #fff;
	font-size: 15px;
	font-weight: 600;
	border-radius: 8px;
	text-decoration: none;
	transition: 0.3s;
}

.member-section a.button:hover {
	background-color: #333;
}

body {
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #f3f2ee;
	margin: 0;
	padding: 0;
}

.mypage-menu {
	list-style: none;
	padding: 0;
	margin: 40px 0 0 0;
}

.mypage-menu li {
	border-bottom: 1px solid #eee;
}

.mypage-menu li a {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 18px 12px;
	text-decoration: none;
	color: #111;
	font-size: 15px;
	transition: background-color 0.2s;
}

.mypage-menu li a:hover {
	background-color: #f9f9f9;
}

.menu-text {
	display: flex;
	flex-direction: column;
}

.menu-text strong {
	font-size: 15px;
	font-weight: 600;
	color: #111;
}

.menu-text p {
	font-size: 13px;
	color: #888;
	margin: 4px 0 0 0;
}

.arrow {
	font-size: 16px;
	color: #aaa;
}
</style>
</head>
<body>
	<jsp:include page="/include/header.jsp" />

	<section class="member-section">
		
		<h2>
			안녕하세요.<%=mdto.getMname()%>님
		</h2>
		<ul class="mypage-menu">
			<li><a href="memberUpdate.jsp">
					<div class="menu-text">
						<strong>내 정보 확인 및 변경</strong>
					</div> <span class="arrow">&gt;</span>
			</a></li>
			<li><a href="">
					<div class="menu-text">
						<strong>주문 내역</strong>
					</div> <span class="arrow">&gt;</span>
			</a></li>
			<li><a href="#">
					<div class="menu-text">
						<strong>1:1 문의 내역</strong>
					</div> <span class="arrow">&gt;</span>
			</a></li>
			<li><a href="#">
					<div class="menu-text">
						<strong>FAQ</strong>
					</div> <span class="arrow">&gt;</span>
			</a></li>
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
