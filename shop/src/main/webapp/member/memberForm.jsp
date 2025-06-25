<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<h1 align="center">회원가입</h1>
<form action="memberPro.jsp" method="post" onsubmit="return membercheck()">
	<div align="center">
		<input type="text" maxlength="100" id="mid" name="mid"placeholder="아이디 입력"> 
		<input type="button" value="중복확인" onclick="midcheck()" /> <br /> 
		<input type="password"maxlength="100" id="pw" name="mpw" placeholder="비밀번호 입력" oninput="pwcheck()"><br />  
		<input type="password" maxlength="100" id="pwch" name="mpwcheck" placeholder="비밀번호 확인" oninput="pwcheck()"><br />
		<div id="pwmsg" style="margin-top: 5px; font-size: 14px;"></div> 
		<input type="text" maxlength="100" id="nameEl" name="mname" placeholder="이름 입력"><br /> 
		<input type="text" maxlength="1000" id="phoneEl" name="mphone" placeholder="전화번호 입력(-제외)" oninput="phonecheck()"><br />
		<div id="phonemsg" style="margin-top: 5px; font-size: 14px;"></div>
		<input type="text" maxlength="1000" id="emailEl" name="memail" placeholder="이메일 입력" oninput="emailcheck()"><br />
		<div id="emailmsg" style="margin-top: 5px; font-size: 14px;"></div> 
	</div>
	<div align="center">
		성별: <input type="radio" id="gender1" name="mgender" value="1" checked="checked">남
		<input type="radio" id="gender2" name="mgender" value="2">여
	</div>
	<div align="center">
		<input type="submit" value="가입"> 
		<input type="button" value="메인 페이지" onclick="window.location='main.main.jsp'">
	</div>
</form>
</body>
<script src="<%=request.getContextPath()%>/resources/js/member.js"></script>
</html>