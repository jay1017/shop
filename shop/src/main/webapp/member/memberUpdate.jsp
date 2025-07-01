<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="shop.member.MemberDTO"%>
<%@ page import="shop.member.MemberDAO"%>
<%
MemberDTO mdto = new MemberDTO();
MemberDAO mdao = new MemberDAO();
String sid = (String) session.getAttribute("sid");
mdto = mdao.getInfo(sid);
String SetGender = mdao.setGender(sid); //해당 성별 번호를 남성 및 여성으로 보여주기 위해 별도의 메서드 사용
%>

<%!//선언문 메서드를 만들기위해 !사용

	//아이디 마스킹 처리
	public String maskId(String id) {
		if (id == null || id.trim().isEmpty())
			return ""; //값이 없으면 공백 처리
		int length = id.length(); //해당 아이디의 길이 저장
		if (length <= 2) { //길이가 2이하라면
			return id.charAt(0) + "*"; // id의 인덱스번호0 즉 첫번째 글자는 추출하고 뒷자리는 *표시
		} else if (length <= 4) { //길이가 3이상 4이하라면
			return id.substring(0, 2) + "*".repeat(length - 2); //앞 2글자만 표시하고 나머지는 *표시
		} else {
			int visible = 3; //앞 3글자 지정하기 위한 번호
			StringBuilder sb = new StringBuilder();
			sb.append(id.substring(0, visible)); //문자열의 인덱스번호 0~3까지는 기본값 지정
			for (int i = 0; i < length - visible; i++) { //문자열의 전체 길이에서 3만큼 뺀 나머지 뒷자리를 *로 표시
				sb.append("*");
			}
			return sb.toString();
		}
	}

	//이름 마스킹 처리
	public String maskName(String name) {
		if (name == null || name.trim().isEmpty())
			return ""; //값이 없다면 빈 공백
		int length = name.length(); //이름의 길이 지정 변수
		if (length == 1) { //만약 이름이 한글자라면 *로 표시
			return "*";
		} else if (length == 2) { //이름이 두글자라면 첫글자를 제외한 한글자를 *로 표시
			return name.charAt(0) + "*";
		} else {
			StringBuilder sb = new StringBuilder();
			sb.append(name.charAt(0)); // 이름의 첫번째 글자는 기본값 지정
			for (int i = 1; i < length - 1; i++) { //이름의 첫 글자를 제외한 값에 *표시
				sb.append("*");
			}
			sb.append(name.charAt(length - 1)); //이름의 마지막 글자는 기본값 지정
			//만약 이름이 홍길동전 이라면 홍**전 표시
			return sb.toString();
		}
	}

	//전화번호 마스킹 처리
	public String maskPhone(String phone) {
		if (phone == null || phone.length() < 10)
			return phone; //만약 전화번호가 없거나 전화번호의 전체 길이가 10보다 작다면 원래의 값을 전달
		//10으로 한 이유 010은 11자리 이지만 017이나 011등은 10자리로 지정되어 있기 때문
		return phone.substring(0, 3) + "-****-" + phone.substring(phone.length() - 4);
		//번호의 첫 3자리와 마지막 4자리는 기본값으로 표시하고 가운데 번호는 -****-로 표시
	}

	//이메일 마스킹 처리
	public String maskEmail(String email) {
		if (email == null || !email.contains("@"))
			return "없음"; //이메일이 없거나 @가 포함된 값이 아니라면 없음 반환
		int index = email.indexOf("@"); //@가 들어간 자리의 인덱스번호 저장
		String id = email.substring(0, index); //이메일의 첫 글자부터 @가 위치하기 전까지의 값 지정
		if (id.length() <= 2) //아이디에 해당하는 길이가 2이하라면
			return id.charAt(0) + "*****" + email.substring(index);
		// 첫글자를 제외한 나머지 값에 *****표시후 @부터 뒷자리까지 표시
		return id.substring(0, 2) + "*****" + email.substring(index);
		// 두번째 글자까지 기본값 출력
	}%>
<style>
body {
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #f3f2ee !important;
	margin: 0;
	padding: 0;
}

.profile-container {
	max-width: 600px;
	margin: 80px auto;
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
	padding: 40px 30px;
}

.profile-container h2 {
	text-align: center;
	font-size: 22px;
	font-weight: bold;
	margin-bottom: 30px;
}

.profile-list {
	list-style: none;
	padding: 0;
	margin: 0;
	border-top: 1px solid #eee;
}

.profile-list li {
	padding: 18px 0;
	border-bottom: 1px solid #eee;
	font-size: 15px;
	font-weight: 500;
	color: #111;
}

.profile-list li span {
	display: block;
	margin-top: 5px;
	color: #888;
	font-size: 14px;
}

.black-btn {
	margin-top: 20px;
	width: 100%;
	background-color: #000;
	color: #fff;
	padding: 12px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
	transition: 0.3s;
}

.black-btn:hover {
	background-color: #333;
}
</style>
<html>
<head>
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
	<div class="profile-container">
		<h2>
			<%=mdto.getMname()%>님의 회원정보
		</h2>
		<ul class="profile-list">
			<li>아이디<span><%=maskId(mdto.getMid())%></span></li>
			<li>성별<span><%=SetGender%></span></li>
			<li>전화번호<span><%=maskPhone(mdto.getMphone())%></span></li>
			<li>이메일<span><%=maskEmail(mdto.getMemail())%></span></li>
		</ul>
		<button class="black-btn" onclick="updateMpwCheck()">회원정보 수정</button>
	</div>
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
<script src="<%=request.getContextPath()%>/resources/js/member.js"></script>
</html>