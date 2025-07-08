<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:useBean id="mdto" class="shop.member.MemberDTO" />
<jsp:useBean id="mdao" class="shop.member.MemberDAO" />

<%
String sid = (String) session.getAttribute("sid");
mdto = mdao.getInfo(sid); 
String SetGender = mdao.setGender(sid); 
String emailnull = mdto.getMemail(); 
if (emailnull == null) {
	emailnull = "";
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=mdto.getMname()%>님의 정보</title>
<meta name="description" content="Male_Fashion Template">
<meta name="keywords" content="Male_Fashion, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">

<link rel="stylesheet" href="/shop/resources/css/font.css" />
<link rel="stylesheet" href="/shop/resources/css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="/shop/resources/css/font-awesome.min.css" type="text/css">
<link rel="stylesheet" href="/shop/resources/css/elegant-icons.css" type="text/css">
<link rel="stylesheet" href="/shop/resources/css/magnific-popup.css" type="text/css">
<link rel="stylesheet" href="/shop/resources/css/nice-select.css" type="text/css">
<link rel="stylesheet" href="/shop/resources/css/owl.carousel.min.css" type="text/css">
<link rel="stylesheet" href="/shop/resources/css/slicknav.min.css" type="text/css">
<link rel="stylesheet" href="/shop/resources/css/style.css" type="text/css">
</head>
<body class="update-body">
	<jsp:include page="/include/header.jsp"></jsp:include>

	<form action="memberUpdatePro.jsp" method="post" onsubmit="return UpdateMember()">
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
				<input type="button" value="비밀번호 설정" class="update-btn" onclick="updateMpw()">
				<input type="hidden" id="originalmpw" name="originalmpw" value="<%=mdto.getMpw()%>">
				<input type="hidden" id="mpw" name="mpw" value="">
				<div class="update-msg">*비밀번호 변경 시 설정 후 '변경사항 저장' 버튼을 누르세요.</div>
			</div>

			<div class="update-form-row">
				<div class="update-label">이름*</div>
				<input type="text" id="mname" name="mname" class="update-input"
					value="<%=mdto.getMname()%>" placeholder="이름 입력*" oninput="namecheck()">
				<div id="namemsg" class="update-msg"></div>
			</div>

			<div class="update-form-row">
				<div class="update-label">전화번호*</div>
				<input type="text" id="mphone" name="mphone" class="update-input"
					value="<%=mdto.getMphone()%>" placeholder="전화번호 입력*" oninput="phonecheck()">
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
					<label><input type="radio" name="mgender" value="1" <%=mdto.getMgender() == 1 ? "checked" : ""%>> 남</label>
					<label><input type="radio" name="mgender" value="2" <%=mdto.getMgender() == 2 ? "checked" : ""%>> 여</label>
				</div>
			</div>

			<div class="update-actions">
				<input type="submit" value="변경사항 저장" class="update-btn">
				<input type="button" value="회원 탈퇴" class="update-btn" onclick="memberDelete()">
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
	<script src="<%=request.getContextPath()%>/resources/js/memberUpdate.js"></script>
</body>
</html>
