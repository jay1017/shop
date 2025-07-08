<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="shop.member.MemberDTO"%>
<%@ page import="shop.member.MemberDAO"%>
<%@ page import="shop.point.pointDAO"%>
<%@ page import="shop.point.pointDTO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
String sid = (String) session.getAttribute("sid");
MemberDAO mdao = new MemberDAO();
MemberDTO mdto = mdao.getInfo(sid);

pointDAO pdao = new pointDAO();
pointDTO pdto = new pointDTO();

int result = 0;
int PointCount = pdao.getAllPoint(mdto.getMnum());

List<pointDTO> plist = pdao.getPointList(mdto.getMnum());

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<html>
<head>
<title>ODEZ - 포인트 내역</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
<link rel="stylesheet" href="/shop/resources/css/font-awesome.min.css"
	type="text/css" />
<style>
body {
	background-color: #f3f2ee; /* 전체 배경색 */
	font-family: 'Noto Sans KR', sans-serif;
	margin: 0;
	padding: 0;
}

.my-page-box {
	max-width: 600px;
	margin: 60px auto;
	background: #fff;
	border-radius: 15px;
	padding: 30px 40px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
}

.my-page-box h2 {
	text-align: center;
	font-weight: 700;
	margin-bottom: 30px;
}

.my-point-summary {
	font-size: 16px;
	font-weight: 500;
	margin-bottom: 20px;
	text-align: center;
}

.point-history {
	border-top: 1px solid #eee;
}

.point-item {
	display: flex;
	justify-content: space-between;
	padding: 15px 0;
	border-bottom: 1px solid #f2f2f2;
	font-size: 15px;
}

.point-item span.label {
	font-weight: 600;
}

.point-item span.status {
	color: #777;
}

.point-item span.date {
	color: #aaa;
	font-size: 13px;
}

.empty-message {
	text-align: center;
	padding: 40px 0;
	color: #999;
}
</style>
</head>
<body>
	<jsp:include page="/include/header.jsp" />
	<form align="center">
		<div class="my-page-box">
			<h2>
				안녕하세요.
				<%=mdto.getMname()%>님
			</h2>

			<div class="my-point-summary">
				사용 가능 포인트: <strong><%=PointCount%>P</strong>
			</div>

			<div class="point-history">
				<%
				if (plist != null && !plist.isEmpty()) {
					for (pointDTO pd : plist) {
				%>
				<div class="point-item">
					<span class="label"><%=pd.getPtype()%> (<%=pd.getPstat() == 1 ? "적립" : "사용"%>)</span>
					<span><%=pd.getPpoint()%>P</span> <span class="date"><%=pd.getPcreate() != null ? sdf.format(pd.getPcreate()) : "-"%></span>
				</div>
				<%
				}
				} else {
				%>
				<div class="empty-message">포인트 내역이 없습니다.</div>
				<%
				}
				%>
			</div>
		</div>
	</form>
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
</body>
</html>