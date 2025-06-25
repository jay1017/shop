<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
	<head>
		<meta charset="UTF-8">
		<title>회원 로그인</title>
	</head>
	<body>
	<h1 align="center">로그인</h1>
	<form action="loginPro.jsp" align="center" method="post" onsubmit="return loginCheck()">
		<span>아이디</span><br />
		<div>
			<input type="text" name="mid" oninput="loginIdCheck()"/>
		</div>
		<span>비밀번호</span><br />
		<div>
			<input type="text" name="mpw" oninput="loginPwCheck()"/>
		</div>
		<div>
			<br />
			<input type="submit" value="로그인">
			<input type="button" value="회원가입" onclick="window.location='memberForm.jsp'">
		</div>
	</form>
	</body>
</html>