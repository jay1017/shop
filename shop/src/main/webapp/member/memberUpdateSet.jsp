<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="mdto" class="shop.member.MemberDTO" />
<jsp:useBean id="mdao" class="shop.member.MemberDAO" />

<%
	String sid = (String)session.getAttribute("sid");
	mdto = mdao.getInfo(sid); //세션에 저장된 아이디에 해당하는 모든 정도를 받음
	String SetGender = mdao.setGender(sid); //gender의 값이 1또는 2이기에 1이면 남성, 2면 여성을 보여줌
	String emailnull = mdto.getMemail(); // email이 null이면 사용자 화면에도 null로 보이기에 없다는 표시를 해줌
	
	if(emailnull == null){
		emailnull = "";
	}
%>
<style>
.info-container {
	width: 800px;
	margin: 50px auto;
	font-family: 'Arial', sans-serif;
}

.info-title {
	font-size: 24px;
	font-weight: bold;
	margin-bottom: 20px;
}

.info-section-title {
	font-size: 18px;
	font-weight: bold;
	margin-top: 40px;
	border-bottom: 2px solid #000;
	padding-bottom: 5px;
}
</style>
<html>
<head>
<meta charset="UTF-8">
<title><%=mdto.getMname()%>님의 정보</title>
<link rel="stylesheet" href="/shop/resources/css/font.css" />
</head>
<body>
	<a href="/shop/main/main.jsp">
		<div>
			메인 페이지
		</div>
	</a>
	<form action="memberUpdatePro.jsp" method="post" onsubmit="return UpdateMember()">
	<div class="info-container">
		<div class="info-title">회원정보 수정</div>
		<br />
		<div class="info-section-title">회원정보</div>
		<div>(*)표시는 필수 입력입니다</div>
		<table>
			<tr>
				<td>아이디*</td>
				<td><%=mdto.getMid() %></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="button" value="비밀번호 설정" onclick="updateMpw()"></td>
				<td style="font-size: 12px; color: red;">비밀번호 변경 시 비밀번호 설정 후 변경사항을 저장해주세요.</td>
				<td><input type="hidden" id="originalmpw" name="originalmpw" value="<%=mdto.getMpw()%>"></td><%--기존 비밀번호 --%>
				<td><input type="hidden" id="mpw" name="mpw" value=""></td><%--수정 비밀번호 --%>
			</tr>
			<tr>
				<td>이름*</td>
				<td><input type="text" id="mname" name="mname" value="<%=mdto.getMname()%>" placeholder="이름 입력*" oninput="namecheck()"></td>
				<td><div id="namemsg" style="margin-top: 5px; font-size: 14px;"></div></td>
			</tr>
			<tr>
				<td>전화번호*</td>
				<td><input type="text" id="mphone" name="mphone" value="<%=mdto.getMphone()%>" placeholder="전화번호 입력*" oninput="phonecheck()"></td>
				<td><div id="phonemsg" style="margin-top: 5px; font-size: 14px;"></div></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><input type="text" id="memail" name="memail" value="<%=emailnull%>" placeholder="이메일 입력" oninput="emailcheck()"></td>
				<td><div id="emailmsg" style="margin-top: 5px; font-size: 14px;"></div></td>
			</tr>
			<tr>
				<td>성별*</td>
				<td>
					<input type="radio" id="gender1" name="mgender" value="1" checked="checked">남
					<input type="radio" id="gender2" name="mgender" value="2">여
				</td>
			</tr>
		</table>
		<div align="right">
			<input type="submit" value="변경사항 저장">
			<input type="button" value="회원 탈퇴" onclick="memberDelete()">
		</div>
	</div>
	</form>
</body>
<script src="<%=request.getContextPath()%>/resources/js/memberUpdate.js"></script>
</html>