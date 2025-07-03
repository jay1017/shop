<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="Male_Fashion Template">
<meta name="keywords" content="Male_Fashion, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>ODEZ - 회원 로그인</title>
<link rel="stylesheet" href="/shop/resources/css/font.css" />
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
* {
	box-sizing: border-box;
}

body {
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #f3f2ee;
	margin: 0;
	padding: 0;
}

.login-container {
	width: 360px;
	margin: 80px auto;
	padding: 40px;
	background-color: white;
	border: 1px solid #ddd;
	border-radius: 10px;
}

.login-container h2 {
	text-align: center;
	margin-bottom: 30px;
	font-size: 20px;
	font-weight: bold;
}

.login-input {
	width: 100%;
	padding: 12px;
	margin-top: 10px;
	margin-bottom: 10px;
	border: 1px solid #ccc;
	border-radius: 6px;
	font-size: 14px;
}

.login-button {
	width: 100%;
	padding: 14px;
	margin-top: 20px;
	background-color: black;
	color: white;
	border: none;
	border-radius: 6px;
	font-size: 16px;
	cursor: pointer;
}

.login-button:hover {
	background-color: #333;
}

.login-links {
	display: flex;
	justify-content: space-between;
	margin-top: 10px;
	font-size: 13px;
	color: #888;
}

.login-checkbox {
	margin-top: 10px;
	font-size: 13px;
}

.signup-section {
	text-align: center;
	margin-top: 30px;
	font-size: 14px;
}

.signup-button {
	margin-left: 10px;
	padding: 6px 10px;
	font-size: 13px;
	border: 1px solid #ccc;
	background-color: white;
	border-radius: 4px;
	cursor: pointer;
}

#loginmidmsg, #loginmpwmsg {
	font-size: 12px;
	color: red;
	margin-top: 4px;
}

.link-gray {
	color: #888; /* 회색 */
	text-decoration: none; /* 밑줄 제거 */
	font-size: 13px;
	margin-right: 10px;
}

.link-gray:hover {
	color: #555; /* 마우스 올렸을 때 좀 더 진한 회색 */
	text-decoration: underline; /* 선택사항: 호버 시 밑줄 표시 */
}
</style>
</head>
<body>
	<jsp:include page="/include/header.jsp"></jsp:include>
	<div class="login-container">
		<h2>로그인/회원가입</h2>
		<form action="loginPro.jsp" method="post">
			<input type="text" id="loginmid" name="mid" placeholder="아이디"
				class="login-input" oninput="loginIdCheck()" />
			<div id="loginmidmsg"></div>

			<input type="password" id="loginpw" name="mpw" placeholder="비밀번호"
				class="login-input" oninput="loginPwCheck()" />
			<div id="loginmpwmsg"></div>

			<button type="submit" class="login-button">로그인</button>

			<div class="login-links">
				<a href="javascript:void(0)" onclick="idSearch()" class="link-gray">아이디찾기</a> 
				<a href="javascript:void(0)" onclick="pwSearch()" class="link-gray">비밀번호 찾기</a>
			</div>
		</form>
		<div style="text-align: center; margin-top: 20px;">
    		<a href="https://kauth.kakao.com/oauth/authorize?client_id=bc8f1248fe973ce8060a5a525c39e1f9&redirect_uri=http://localhost:8080/shop/member/kakaoLogin.jsp&response_type=code">
      		<img src="/shop/resources/img/kakaoLogin/kakao_login.png" alt="카카오 로그인" />
    		</a>
  		</div>
  		<div class="signup-section">
				ODEZ의 신규 회원이 되어보세요!
				<button type="button" class="signup-button"
					onclick="window.location='memberForm.jsp'">회원가입</button>
		</div>
	</div>

	<script src="<%=request.getContextPath()%>/resources/js/login.js"></script>
	<jsp:include page="/include/footer.jsp"></jsp:include>
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
