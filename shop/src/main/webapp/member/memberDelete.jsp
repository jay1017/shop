<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.member.MemberDTO" %>
<%@ page import="shop.member.MemberDAO" %>

<%
	String sid = (String)session.getAttribute("sid");
	MemberDAO mdao = new MemberDAO();
	MemberDTO mdto = mdao.getInfo(sid);
%>

<html>
	<head>
		<title>회원 탈퇴</title>
		<link rel="stylesheet" href="/shop/resources/css/font.css" />
	</head>
	<body>
		<form action="memberDeletePro.jsp" method="post">
			<div>
				<input type="text" id="mid" name="mid" placeholder="아이디 입력" oninput="midCheck()">
				<div id="midmsg" style="margin-top: 5px; font-size: 14px;"></div>
				<input type="hidden" id="Orimid" name="Orimid" value="<%=mdto.getMid() %>">
				<input type="password" name="mpw" placeholder="비밀번호 입력" oninput="mpwCheck()">
				<div id="mpwmsg" style="margin-top: 5px; font-size: 14px;"></div>
				<input type="hidden" id="Orimpw" name="Orimpw" value="<%=mdto.getMpw() %>">
			</div>
			<div>
				<input type="submit" value="확인">
			</div>
		</form>
	</body>
	<script src="<%=request.getContextPath()%>/resources/js/memberDelete.js"></script>
</html>