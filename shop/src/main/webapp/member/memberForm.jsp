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
<title>ODEZ - 회원가입</title>
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

.join-container {
	width: 400px;
	margin: 50px auto;
	padding: 40px;
	background-color: white;
	border: 1px solid #ddd;
	border-radius: 10px;
}

.join-container h2 {
	text-align: center;
	font-size: 22px;
	font-weight: bold;
	margin-bottom: 20px;
}

.join-container h5 {
	text-align: right;
	font-size: 13px;
	color: #666;
	margin-top: -10px;
	margin-bottom: 20px;
}

.join-input {
	width: 100%;
	padding: 12px;
	margin-bottom: 10px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 6px;
}

.msg {
	font-size: 12px;
	color: red;
	margin-bottom: 10px;
}

.btn-inline {
	display: flex;
	gap: 8px;
	margin-bottom: 10px;
}

.btn-inline input[type="text"] {
	flex: 1;
}

.radio-group {
	margin-top: 10px;
	margin-bottom: 20px;
	font-size: 14px;
}

.submit-button {
	width: 100%;
	padding: 14px;
	font-size: 15px;
	background-color: black;
	color: white;
	border: none;
	border-radius: 6px;
	cursor: pointer;
}

.submit-button:hover {
	background-color: #333;
}

.check-btn {
	background-color: #000;
	color: #fff;
	font-size: 14px;
	font-weight: 500;
	padding: 10px 16px;
	border: none;
	border-radius: 6px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.check-btn:hover {
	background-color: #333;
}

.input-row {
	display: flex;
	gap: 8px;
	margin-bottom: 15px;
}

.input-row input[type="text"] {
	flex: 1;
	height: 42px;
	padding: 0 10px;
	border: 1px solid #ccc;
	border-radius: 8px;
	font-size: 15px;
	box-sizing: border-box;
}
</style>
</head>
<body>
	<jsp:include page="/include/header.jsp"></jsp:include>
	<div class="join-container">
		<h2>회원가입</h2>
		<h5>(*)은 필수 항목입니다</h5>
		<form action="memberPro.jsp" method="post"
			onsubmit="return membercheck()">
			<div class="btn-inline">
				<input type="text" maxlength="100" id="mid" name="mid"
					placeholder="아이디 입력*" class="join-input" style="margin-bottom: 0;">
				<input type="button" value="중복확인" onclick="midCheck()" class="check-btn" />
			</div>
			<input type="hidden" id="butcheck" name="butcheck" value="false">

			<input type="password" maxlength="100" id="pw" name="mpw"
				placeholder="비밀번호 입력*" class="join-input" oninput="pwcheck()">
			<input type="password" maxlength="100" id="pwch" name="mpwcheck"
				placeholder="비밀번호 확인*" class="join-input" oninput="pwcheck()">
			<div id="pwmsg" class="msg"></div>

			<input type="text" maxlength="100" id="nameEl" name="mname"
				placeholder="이름 입력*" class="join-input" oninput="namecheck()">
			<div id="namemsg" class="msg"></div>

			<input type="text" maxlength="1000" id="phoneEl" name="mphone"
				placeholder="전화번호 입력(-제외)*" class="join-input"
				oninput="phonecheck()">
			<div id="phonemsg" class="msg"></div>

			<input type="text" maxlength="1000" id="emailEl" name="memail"
				placeholder="이메일 입력" class="join-input" oninput="emailcheck()">
			<div id="emailmsg" class="msg"></div>

			<div class="radio-group">
				성별: <label><input type="radio" id="gender1" name="mgender"
					value="1" checked> 남</label> <label><input type="radio"
					id="gender2" name="mgender" value="2"> 여</label>
			</div>
			<button type="submit" class="submit-button">가입</button>
		</form>
	</div>
	<script src="<%=request.getContextPath()%>/resources/js/member.js"></script>
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
