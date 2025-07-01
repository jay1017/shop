<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>ODEZ - 비밀번호 찾기</title>
<link rel="stylesheet" href="/shop/resources/css/font.css" />
<style>
body {
	font-family: 'Noto Sans KR', sans-serif;
	background: #fff;
	margin: 0;
	padding: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

form {
	width: 320px;
	padding: 30px 20px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	background-color: white;
	text-align: center;
}

form div {
	margin-bottom: 20px;
}

label {
	margin-right: 20px;
	font-weight: 500;
	cursor: pointer;
	font-size: 14px;
}

input[type="text"] {
	width: 100%;
	height: 42px;
	padding: 0 15px;
	border: 1px solid #ccc;
	border-radius: 8px;
	box-sizing: border-box;
	font-size: 15px;
	font-weight: 500;
	outline: none;
	transition: border-color 0.3s;
}

input[type="text"]:focus {
	border-color: #000;
}

input[type="submit"] {
	width: 100%;
	height: 42px;
	background-color: #000;
	color: #fff;
	font-weight: 600;
	font-size: 16px;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	transition: background-color 0.3s;
}

input[type="submit"]:hover {
	background-color: #333;
}

input[type="radio"] {
	accent-color: #000;
	width: 16px;
	height: 16px;
	vertical-align: middle;
	margin-right: 6px;
}
</style>
</head>
<body>
	<form action="pwSearchPro.jsp" method="post">
		<div>
			<label><input type="radio" name="searchType" value="phone"
				checked onclick="toggleSearch()">휴대전화</label> <label><input
				type="radio" name="searchType" value="email"
				onclick="toggleSearch()">이메일</label>
		</div>
		<div id="phoneForm">
			<input type="text" name="mid" placeholder="아이디"> <br /> <input
				type="text" name="mphone" placeholder="휴대전화(-없이)">
		</div>
		<div id="emailForm" style="display: none;">
			<input type="text" name="emid" placeholder="아이디"> <br /> <input
				type="text" name="memail" placeholder="이메일">
		</div>
		<div>
			<input type="submit" value="비밀번호 찾기">
		</div>
	</form>

	<script src="<%=request.getContextPath()%>/resources/js/login.js"></script>
</body>
</html>
