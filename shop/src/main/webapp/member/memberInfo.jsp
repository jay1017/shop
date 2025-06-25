<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mdto" class="shop.member.MemberDTO" />
<jsp:useBean id="mdao" class="shop.member.MemberDAO" />
<%
	String sid = (String)session.getAttribute("sid");
	mdto = mdao.getInfo(sid);
%>

<html>
	<head>
		<meta charset="UTF-8"> 
		<title>[<%=sid %>]님의 회원정보</title>
	</head>
	<body align="center">
	<h2>[<%=sid %>]님의 회원정보</h2>
		<form>
			<div>
				<h3>이름 : <%=mdto.getMname() %></h3>
				<h3>전화번호 : <%=mdto.getMphone() %></h3>
				<h3>이메일 : <%=mdto.getMemail() %></h3>
				<h3>성별 : <%=mdto.getMgender() %></h3> <%--dao에서 메서드 생성하여 남자,여자로 나오도록 변경 --%>
			</div>
			<div>
				<input type="button" value="메인 페이지" onclick="window.location='../main/main.jsp'">
				<input type="button" value="장바구니" onclick="window.location='../cart/cart.jsp'"><%--회원 장바구니 페이지 연결 --%>
				<input type="button" value="구매 내역" onclick="window.location='../cart/but.jsp'"><%--회원 구매내역 페이지 연결 --%>
			</div>
		</form>
	</body>
</html>

