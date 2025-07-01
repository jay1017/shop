<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>ODEZ - 비밀번호 변경</title>
<link rel="stylesheet" href="/shop/resources/css/font.css" />
<style>
body {
	margin: 0;
	padding: 0;
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #f3f2ee;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

form {
	background-color: #fff;
	padding: 30px 25px;
	border-radius: 12px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
	width: 300px;
	box-sizing: border-box;
	text-align: center;
}

h2 {
	font-size: 20px;
	margin-bottom: 20px;
	font-weight: bold;
}

input[type="password"] {
	width: 100%;
	height: 42px;
	padding: 0 12px;
	font-size: 15px;
	border: 1px solid #ccc;
	border-radius: 8px;
	box-sizing: border-box;
	margin-bottom: 10px;
}

input[type="submit"] {
	width: 100%;
	height: 42px;
	background-color: #000;
	color: #fff;
	font-size: 16px;
	font-weight: bold;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	transition: background-color 0.3s;
}

input[type="submit"]:hover {
	background-color: #333;
}

#pwmsg {
	font-size: 13px;
	color: red;
	margin-bottom: 10px;
}
</style>
</head>
<body>
	<form onsubmit="return sendMpw()">
		<h2>비밀번호 변경</h2>
		<input type="password" id="newPw" maxlength="100"
			placeholder="비밀번호 입력" oninput="newPwCheck()" /> <input
			type="password" id="newPwCh" maxlength="100" placeholder="비밀번호 확인"
			oninput="newPwCheck()" />
		<div id="pwmsg"></div>
		<input type="submit" value="설정 확인" />
	</form>
	<script
		src="<%=request.getContextPath()%>/resources/js/memberUpdate.js"></script>
</body>
</html>
