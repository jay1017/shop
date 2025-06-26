<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
	<head>
		<title>비밀번호 변경</title>
	</head>
	<body>
		<h2>비밀번호 변경</h2>
		<form onsubmit="return sendMpw()">
			비밀번호: <input type="password" id="newPw" maxlength="100" placeholder="비밀번호 입력" oninput="newPwCheck()">
			<br />
			비밀번호 확인: <input type="password" id="newPwCh" maxlength="100" placeholder="비밀번호 확인" oninput="newPwCheck()">
			<div id="pwmsg" style="margin-top: 5px; font-size: 14px;"></div>
			<br />
			<input type="submit" value="설정 확인">
		</form>
	</body>
	<script src="<%=request.getContextPath()%>/resources/js/memberUpdate.js"></script>
</html>