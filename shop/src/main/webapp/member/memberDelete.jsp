<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="shop.member.MemberDTO"%>
<%@ page import="shop.member.MemberDAO"%>

<%
String sid = (String) session.getAttribute("sid");
MemberDAO mdao = new MemberDAO();
MemberDTO mdto = mdao.getInfo(sid);
%>

<html>
<head>
<title>ODEZ - 회원 탈퇴</title>
<link rel="stylesheet" href="/shop/resources/css/font.css" />
<link rel="stylesheet" href="/shop/resources/css/style.css" type="text/css">
</head>
<body class="memberDelete-body">
	<form class="memberDelete-form" action="memberDeletePro.jsp" method="post">
		<h2 class="memberDelete-title">회원 탈퇴</h2>

		<input type="text" id="mid" name="mid" placeholder="아이디 입력"
			class="memberDelete-input" oninput="midCheck()" />
		<div id="midmsg" class="memberDelete-msg"></div>

		<input type="hidden" id="Orimid" name="Orimid" value="<%=mdto.getMid()%>" />

		<input type="password" id="mpw" name="mpw" placeholder="비밀번호 입력"
			class="memberDelete-input" oninput="mpwCheck()" />
		<div id="mpwmsg" class="memberDelete-msg"></div>

		<input type="hidden" id="Orimpw" name="Orimpw" value="<%=mdto.getMpw()%>" />
		<input type="submit" value="확인" class="memberDelete-submit" />
	</form>

	<script src="<%=request.getContextPath()%>/resources/js/memberDelete.js"></script>
</body>
</html>
