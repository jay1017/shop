<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:useBean id="mdto" class="shop.member.MemberDTO" />
<jsp:useBean id="mdao" class="shop.member.MemberDAO" />

<%
String sid = (String) session.getAttribute("sid");
mdto = mdao.getInfo(sid); //세션에 저장된 아이디에 해당하는 모든 정도를 받음
String SetGender = mdao.setGender(sid); //gender의 값이 1또는 2이기에 1이면 남성, 2면 여성을 보여줌
String emailnull = mdto.getMemail(); // email이 null이면 사용자 화면에도 null로 보이기에 없다는 표시를 해줌

if (emailnull == null) {
	emailnull = "";
}
%>
<style>
body {
	margin: 0;
	padding: 0;
	background-color: #f3f2ee !important;
	font-family: 'Arial', sans-serif;
}

.update-container {
	max-width: 600px;
	margin: 60px auto;
	background: #fff;
	border-radius: 12px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
	padding: 40px;
	box-sizing: border-box;
}

.update-title {
	font-size: 20px;
	font-weight: 700;
	text-align: center;
	margin-bottom: 40px;
}

.update-form-row {
	border-bottom: 1px solid #eee;
	padding: 16px 0;
}

.update-form-row:last-child {
	border-bottom: none;
}

.update-label {
	display: block;
	font-size: 14px;
	color: #333;
	margin-bottom: 6px;
}

.update-input, .update-radio-group {
	font-size: 14px;
	color: #555;
	width: 100%;
	padding: 8px 0;
	border: none;
	background: none;
	outline: none;
}

.update-radio-group label {
	margin-right: 20px;
}

.update-msg {
	font-size: 12px;
	color: red;
	margin-top: 4px;
}

.update-actions {
	margin-top: 30px;
	display: flex;
	flex-direction: column;
	gap: 10px;
}

.black-btn {
	background-color: #000;
	color: #fff;
	font-size: 14px;
	padding: 12px;
	border: none;
	border-radius: 6px;
	cursor: pointer;
	transition: background-color 0.3s ease;
	text-align: center;
}

.black-btn:hover {
	background-color: #333;
}
</style>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="Male_Fashion Template">
<meta name="keywords" content="Male_Fashion, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title><%=mdto.getMname()%>님의 정보</title>
<link rel="stylesheet" href="/shop/resources/css/font.css" />
<link rel="stylesheet" href="/shop/resources/css/bootstrap.min.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/font-awesome.min.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/elegant-icons.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/magnific-popup.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/nice-select.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/owl.carousel.min.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/slicknav.min.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/style.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/font.css">
</head>
<body>
	<jsp:include page="/include/header.jsp"></jsp:include>
	<form action="memberUpdatePro.jsp" method="post"
		onsubmit="return UpdateMember()">
		<div class="update-container">
			<div class="update-title">
				<%=mdto.getMname()%>님의 회원정보 수정
			</div>

			<div class="update-form-row">
				<div class="update-label">아이디*</div>
				<div class="update-input"><%=mdto.getMid()%></div>
			</div>

			<div class="update-form-row">
				<div class="update-label">비밀번호</div>
				<input type="button" value="비밀번호 설정" class="black-btn"
					onclick="updateMpw()"> <input type="hidden"
					id="originalmpw" name="originalmpw" value="<%=mdto.getMpw()%>">
				<input type="hidden" id="mpw" name="mpw" value="">
				<div class="update-msg">*비밀번호 변경 시 설정 후 '변경사항 저장' 버튼을 누르세요.</div>
			</div>

			<div class="update-form-row">
				<div class="update-label">이름*</div>
				<input type="text" id="mname" name="mname" class="update-input"
					value="<%=mdto.getMname()%>" placeholder="이름 입력*"
					oninput="namecheck()">
				<div id="namemsg" class="update-msg"></div>
			</div>

			<div class="update-form-row">
				<div class="update-label">전화번호*</div>
				<input type="text" id="mphone" name="mphone" class="update-input"
					value="<%=mdto.getMphone()%>" placeholder="전화번호 입력*"
					oninput="phonecheck()">
				<div id="phonemsg" class="update-msg"></div>
			</div>

			<div class="update-form-row">
				<div class="update-label">이메일</div>
				<input type="text" id="memail" name="memail" class="update-input"
					value="<%=emailnull%>" placeholder="이메일 입력" oninput="emailcheck()">
				<div id="emailmsg" class="update-msg"></div>
			</div>

			<div class="update-form-row">
				<div class="update-label">성별*</div>
				<div class="update-radio-group">
					<label><input type="radio" name="mgender" value="1"
						<%=mdto.getMgender() == 1 ? "checked" : ""%>> 남</label> <label><input
						type="radio" name="mgender" value="2"
						<%=mdto.getMgender() == 2 ? "checked" : ""%>> 여</label>
				</div>
			</div>

			<div class="update-actions">
				<input type="submit" value="변경사항 저장" class="black-btn"> <input
					type="button" value="회원 탈퇴" class="black-btn"
					onclick="memberDelete()">
			</div>
		</div>

	</form>
	<jsp:include page="/include/footer.jsp"></jsp:include>
	<script src="/shop/resources/js/jquery-3.3.1.min.js"></script>
	<script src="/shop/resources/js/bootstrap.min.js"></script>
	<script src="/shop/resources/js/jquery.nice-select.min.js"></script>
	<script src="/shop/resources/js/jquery.nicescroll.min.js"></script>
	<script src="/shop/resources/js/jquery.magnific-popup.min.js"></script>
	<script src="/shop/resources/js/jquery.countdown.min.js"></script>
	<script src="/shop/resources/js/jquery.slicknav.js"></script>
	<script src="/shop/resources/js/mixitup.min.js"></script>
	<script src="/shop/resources/js/owl.carousel.min.js"></script>
	<script src="/shop/resources/js/main.js"></script>
</body>
<script src="<%=request.getContextPath()%>/resources/js/memberUpdate.js"></script>
</html>