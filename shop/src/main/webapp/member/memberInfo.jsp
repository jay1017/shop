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
<title>회원 정보</title>
</head>
<body align="center">
	<a href="../main/main.jsp" align="left">
		<div>메인 페이지</div>
	</a>
	<h2>
		안녕하세요. <%=mdto.getMname()%>님
	</h2>
	<form>
		<div>
			<a href="memberUpdate.jsp">내 정보확인 및 수정</a>
		</div>
		
	</form>
</body>
</html>

