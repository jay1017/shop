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
<link rel="stylesheet" href="/shop/resources/css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="/shop/resources/css/font-awesome.min.css" type="text/css">
<link rel="stylesheet" href="/shop/resources/css/elegant-icons.css" type="text/css">
<link rel="stylesheet" href="/shop/resources/css/magnific-popup.css" type="text/css">
<link rel="stylesheet" href="/shop/resources/css/nice-select.css" type="text/css">
<link rel="stylesheet" href="/shop/resources/css/owl.carousel.min.css" type="text/css">
<link rel="stylesheet" href="/shop/resources/css/slicknav.min.css" type="text/css">
<link rel="stylesheet" href="/shop/resources/css/style.css" type="text/css">
<link rel="stylesheet" href="/shop/resources/css/font-awesome.min.css" type="text/css"/>
<%
    String clientId = "xlKrOZe43aUWrCldbgTq";
    String redirectURI = java.net.URLEncoder.encode("http://192.168.219.157:8080/shop/member/naverLogin.jsp", "UTF-8");
    String state = "RANDOM_STATE"; // CSRF 방지를 위한 임의의 문자열

    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code"
        + "&client_id=" + clientId
        + "&redirect_uri=" + redirectURI
        + "&state=" + state;
%>
</head>
<body class="login-body">
	<jsp:include page="/include/header.jsp"></jsp:include>
	<div class="login-container">
		<h2 class="login-title">로그인/회원가입</h2>
		<form action="loginPro.jsp" method="post">
			<input type="text" id="loginmid" name="mid" placeholder="아이디"
				class="login-input" oninput="loginIdCheck()" />
			<div id="loginmidmsg" class="login-midmsg"></div>

			<input type="password" id="loginpw" name="mpw" placeholder="비밀번호"
				class="login-input" oninput="loginPwCheck()" />
			<div id="loginmpwmsg" class="login-pwmsg"></div>

			<button type="submit" class="login-button">로그인</button>

			<div class="login-links">
				<a href="javascript:void(0)" onclick="idSearch()" class="login-link-gray">아이디찾기</a> 
				<a href="javascript:void(0)" onclick="pwSearch()" class="login-link-gray">비밀번호 찾기</a>
			</div>
		</form>

		<div style="text-align: center; margin-top: 20px;">
    		<a href="https://kauth.kakao.com/oauth/authorize?client_id=bc8f1248fe973ce8060a5a525c39e1f9&redirect_uri=http://192.168.219.157:8080/shop/member/kakaoLogin.jsp&response_type=code">
      			<img src="/shop/resources/img/kakaoLogin/kakao_login.png" alt="카카오 로그인" />
    		</a>
    		<a href="<%=apiURL %>">
    			<img class="login-naver-btn" src="https://static.nid.naver.com/oauth/big_g.PNG" alt="네이버 로그인 버튼" />
			</a>	
  		</div>

  		<div class="login-signup-section">
			ODEZ의 신규 회원이 되어보세요!
			<button type="button" class="login-signup-button"
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
