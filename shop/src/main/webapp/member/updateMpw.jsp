<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>ODEZ - 비밀번호 변경</title>
<link rel="stylesheet" href="/shop/resources/css/font.css" />
<link rel="stylesheet" href="/shop/resources/css/style.css" type="text/css">
</head>
<body class="pwUpdate-body">
	<form class="pwUpdate-form" onsubmit="return sendMpw()">
		<h2 class="pwUpdate-title">비밀번호 변경</h2>
		<input type="password" id="newPw" maxlength="100"
			placeholder="비밀번호 입력" class="pwUpdate-input" oninput="newPwCheck()" />
		<input type="password" id="newPwCh" maxlength="100"
			placeholder="비밀번호 확인" class="pwUpdate-input" oninput="newPwCheck()" />
		<div id="pwmsg"></div>
		<input type="submit" value="설정 확인" class="pwUpdate-submit" />
	</form>
	<script src="<%=request.getContextPath()%>/resources/js/memberUpdate.js"></script>
</body>
</html>
