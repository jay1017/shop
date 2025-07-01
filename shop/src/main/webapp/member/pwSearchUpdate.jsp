<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.member.MemberDTO" %>
<%@ page import="shop.member.LoginDAO" %>
<%request.setCharacterEncoding("UTF-8"); %>

<html>
	<head>
		<title>ODEZ - 비밀번호 재설정</title>
		<link rel="stylesheet" href="/shop/resources/css/font.css" />
	</head>
	<body>
		<form action="pwSearchUpdatePro.jsp" method="post" align="center" onsubmit="return pwUpdateCheck()">
			<div>
				<span>비밀번호</span>
				<br />
				<input type="text" id="pw" name="mpw" placeholder="비밀번호 입력" oninput="pwcheck()">
				<br />
				<span>비밀번호 확인</span>
				<br />
				<input type="text" id="pwch" name="mpwcheck" placeholder="비밀번호 확인" oninput="pwcheck()">
				<br />
				<div id="pwmsg" style="margin-top: 5px; font-size: 14px;"></div>
			</div>
			<div>
				<input type="submit" value="비밀번호 재설정">
			</div>
		</form>
	</body>
	<script src="<%=request.getContextPath()%>/resources/js/member.js"></script>
</html>