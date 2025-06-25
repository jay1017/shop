<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
	<head>
		<meta charset="UTF-8">
		<title>회원 로그인</title>
	</head>
	<body>
	<h1 align="center">로그인</h1>
	<form action="loginPro.jsp" align="center" method="post">
		<span>아이디</span><br />
		<div>
			<input type="text" id="loginmid" name="mid" oninput="loginIdCheck()"/>
			<div id="loginmidmsg" style="margin-top: 5px; font-size: 14px;"></div>
		</div>
		<span>비밀번호</span><br />
		<div>
			<input type="password" id="loginpw" name="mpw" oninput="loginPwCheck()"/>
			<div id="loginmpwmsg" style="margin-top: 5px; font-size: 14px;"></div>
		</div>
		<div>
			<br />
			<input type="submit" value="로그인">
			<input type="button" value="회원가입" onclick="window.location='memberForm.jsp'">
		</div>
	</form>
	</body>
	<script src="<%=request.getContextPath()%>/resources/js/login.js"></script>
</html>