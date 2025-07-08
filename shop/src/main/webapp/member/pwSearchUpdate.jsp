<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.member.MemberDTO" %>
<%@ page import="shop.member.LoginDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
    <title>ODEZ - 비밀번호 재설정</title>
    <link rel="stylesheet" href="/shop/resources/css/font.css" />
    <link rel="stylesheet" href="/shop/resources/css/style.css" type="text/css">
</head>
<body class="pw-reset-body">
    <form action="pwSearchUpdatePro.jsp" method="post" class="pw-reset-form" onsubmit="return pwUpdateCheck()">
        <h2 class="pw-reset-title">비밀번호 입력</h2>
        <div class="pw-reset-group">
            <label for="pw">비밀번호</label>
            <input type="password" id="pw" name="mpw" placeholder="비밀번호 입력" oninput="pwcheck()">
        </div>
        <div class="pw-reset-group">
            <label for="pwch">비밀번호 확인</label>
            <input type="password" id="pwch" name="mpwcheck" placeholder="비밀번호 확인" oninput="pwcheck()">
        </div>
        <div id="pwmsg" class="pw-reset-msg"></div>
        <input type="submit" value="확인" class="pw-reset-btn">
    </form>
    <script src="<%=request.getContextPath()%>/resources/js/member.js"></script>
</body>
</html>
