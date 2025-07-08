<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="mdto" class="shop.member.MemberDTO" />
<jsp:setProperty property="*" name="mdto" />
<jsp:useBean id="mdao" class="shop.member.MemberDAO" />
<%
	String sid = (String)session.getAttribute("sid");
%>
<html>
<head>
  <title>ODEZ - 회원정보 확인</title>
  <link rel="stylesheet" href="/shop/resources/css/font.css" />
  <link rel="stylesheet" href="/shop/resources/css/style.css" type="text/css">
</head>
<body class="pwCheck-body">
  <form class="pwCheck-form" action="/shop/member/updateMpwCheckTest.jsp" method="post">
    <h3 class="pwCheck-title">비밀번호 입력</h3>
    <input type="hidden" name="mid" value="<%=sid%>">
    <div class="pwCheck-group">
      비밀번호
      <input type="password" name="mpw" class="pwCheck-input" placeholder="비밀번호 입력" />
    </div>
    <input type="submit" value="확인" class="pwCheck-submit"/>
  </form>
</body>
</html>
