<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mdto" class="shop.member.MemberDTO" />
<jsp:setProperty property="*" name="mdto" />
<jsp:useBean id="mdao" class="shop.member.MemberDAO" />

<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/shop/resources/css/font.css" />
<title>아이디 중복 확인</title>
<style>
body {
	margin: 0;
	padding: 0;
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #f3f2ee;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.popup-container {
	background-color: #fff;
	padding: 30px 40px;
	border-radius: 10px;
	box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
	width: 340px;
	text-align: center;
}

.popup-message {
	font-size: 16px;
	margin-bottom: 20px;
	color: #333;
}

.close-btn {
	background-color: #000;
	color: #fff;
	border: none;
	padding: 10px 0;
	width: 100%;
	border-radius: 6px;
	font-size: 15px;
	font-weight: bold;
	cursor: pointer;
	transition: background-color 0.3s;
}

.close-btn:hover {
	background-color: #333;
}
</style>
</head>
<body>
	<div class="popup-container">
		<div class="popup-message">
			<%
			mdto = mdao.getMidname(mdto.getMid());
			if (mdto == null) {
				out.print("사용 가능한 아이디입니다.");
			} else {
				out.print("이미 가입한 아이디입니다.");
			}
			%>
		</div>
		<input type="button" value="닫기" class="close-btn"
			onclick="self.close();" />
	</div>
</body>
</html>
