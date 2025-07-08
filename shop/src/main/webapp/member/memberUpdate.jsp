<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="shop.member.MemberDTO"%>
<%@ page import="shop.member.MemberDAO"%>
<%
MemberDTO mdto = new MemberDTO();
MemberDAO mdao = new MemberDAO();
String sid = (String) session.getAttribute("sid");
mdto = mdao.getInfo(sid);
String SetGender = mdao.setGender(sid);
%>

<%! 
	// 아이디 마스킹
	public String maskId(String id) {
		if (id == null || id.trim().isEmpty()) return "";
		int length = id.length();
		if (length <= 2) {
			return id.charAt(0) + "*";
		} else if (length <= 4) {
			return id.substring(0, 2) + "*".repeat(length - 2);
		} else {
			int visible = 3;
			StringBuilder sb = new StringBuilder();
			sb.append(id.substring(0, visible));
			for (int i = 0; i < length - visible; i++) sb.append("*");
			return sb.toString();
		}
	}
	// 이름 마스킹
	public String maskName(String name) {
		if (name == null || name.trim().isEmpty()) return "";
		int length = name.length();
		if (length == 1) return "*";
		else if (length == 2) return name.charAt(0) + "*";
		else {
			StringBuilder sb = new StringBuilder();
			sb.append(name.charAt(0));
			for (int i = 1; i < length - 1; i++) sb.append("*");
			sb.append(name.charAt(length - 1));
			return sb.toString();
		}
	}
	// 전화번호 마스킹
	public String maskPhone(String phone) {
		if (phone == null || phone.length() < 10) return phone;
		return phone.substring(0, 3) + "-****-" + phone.substring(phone.length() - 4);
	}
	// 이메일 마스킹
	public String maskEmail(String email) {
		if (email == null || !email.contains("@")) return "없음";
		int index = email.indexOf("@");
		String id = email.substring(0, index);
		if (id.length() <= 2) return id.charAt(0) + "*****" + email.substring(index);
		return id.substring(0, 2) + "*****" + email.substring(index);
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=mdto.getMname()%>님의 정보</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
<body class="profile-body">
	<jsp:include page="/include/header.jsp" />

	<div class="profile-container">
		<h2 class="profile-title"><%=mdto.getMname()%>님의 회원정보</h2>
		<ul class="profile-list">
			<li>아이디<span><%=maskId(mdto.getMid())%></span></li>
			<li>성별<span><%=SetGender%></span></li>
			<li>전화번호<span><%=maskPhone(mdto.getMphone())%></span></li>
			<li>이메일<span><%=maskEmail(mdto.getMemail())%></span></li>
		</ul>
		<button class="profile-btn" onclick="updateMpwCheck()">회원정보 수정</button>
	</div>

	<jsp:include page="/include/footer.jsp" />

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
	<script src="<%=request.getContextPath()%>/resources/js/member.js"></script>
</body>
</html>
