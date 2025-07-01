<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
	<head>
		<title>ODEZ - 비밀번호 찾기</title>
		<link rel="stylesheet" href="/shop/resources/css/font.css" />
	</head>
	<body>
		<form action="pwSearchPro.jsp" method="post" align="center">
			<div>
				<label><input type="radio" name="searchType" value="phone" checked onclick="toggleSearch()">휴대전화</label>
				<label><input type="radio" name="searchType" value="email" onclick="toggleSearch()">이메일</label>
			</div>
			<div id="phoneForm">
				<input type="text" name="mid" placeholder="아이디">
				<br />
				<input type="text" name="mphone" placeholder="휴대전화(-없이)">
			</div>
			<div id="emailForm" style="display: none;">
				<input type="text" name="emid" placeholder="아이디">
				<br />
				<input type="text" name="memail" placeholder="이메일">
			</div>
			<div>
				<input type="submit" value="비밀번호 찾기">
			</div>
		</form>
	</body>
	<script src="<%=request.getContextPath()%>/resources/js/login.js"></script>
</html>