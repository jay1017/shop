<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="mdto" class="shop.member.MemberDTO" />
<jsp:setProperty property="*" name="mdto" />
<jsp:useBean id="mdao" class="shop.member.MemberDAO" />

<%--비밀번호 확인 팝업창 페이지 --%>
<html>
	<head>
		<title>회원정보 확인</title>
		<link rel="stylesheet" href="/shop/resources/css/font.css" />
	</head>
	<form action="/shop/member/updateMpwCheckTest.jsp" method="post">
	<h3>비밀번호 입력</h3>
		<div>
			<input type="hidden" name="mid" value="<%=session.getAttribute("sid") %>">
			비밀번호: <input type="password" name="mpw" placeholder="비밀번호 입력">
		</div>
		<br />
		<input type="submit" value="확인" >
	</form>
</html>