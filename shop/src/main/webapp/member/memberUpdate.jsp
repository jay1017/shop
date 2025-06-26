<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mdto" class="shop.member.MemberDTO" />
<jsp:useBean id="mdao" class="shop.member.MemberDAO" />
<%
String sid = (String) session.getAttribute("sid");
mdto = mdao.getInfo(sid);
String SetGender = mdao.setGender(sid);
%>

<html>
	<head>
		<meta charset="UTF-8">
		<title><%=mdto.getMname() %>님의 정보</title>
	</head>
	<body>
		<h1>회원정보 확인</h1>
		<form>
			
		</form>
	</body>
</html>