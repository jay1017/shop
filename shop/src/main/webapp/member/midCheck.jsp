<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mdto" class="shop.member.MemberDTO" />
<jsp:setProperty property="*" name="mdto" />
<jsp:useBean id="mdao" class="shop.member.MemberDAO" />

<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복 확인</title>
<link rel="stylesheet" href="/shop/resources/css/font.css" />
<link rel="stylesheet" href="/shop/resources/css/style.css" type="text/css">
</head>
<body class="midCheck-body">
	<div class="midCheck-container">
		<div class="midCheck-message">
			<%
			mdto = mdao.getMidname(mdto.getMid());
			if (mdto == null) {
				out.print("사용 가능한 아이디입니다.");
			} else {
				out.print("이미 가입한 아이디입니다.");
			}
			%>
		</div>
		<input type="button" value="닫기" class="midCheck-close-btn" onclick="self.close();" />
	</div>
</body>
</html>
