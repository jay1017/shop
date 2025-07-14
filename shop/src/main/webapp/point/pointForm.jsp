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
<link rel="stylesheet" href="/shop/resources/css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="/shop/resources/css/font-awesome.min.css" type="text/css">
<link rel="stylesheet" href="/shop/resources/css/elegant-icons.css" type="text/css">
<link rel="stylesheet" href="/shop/resources/css/magnific-popup.css" type="text/css">
<link rel="stylesheet" href="/shop/resources/css/nice-select.css" type="text/css">
<link rel="stylesheet" href="/shop/resources/css/owl.carousel.min.css" type="text/css">
<link rel="stylesheet" href="/shop/resources/css/slicknav.min.css" type="text/css">
<link rel="stylesheet" href="/shop/resources/css/style.css" type="text/css">
<link rel="stylesheet" href="/shop/resources/css/font.css">
</head>
<body class="point-body">
	<jsp:include page="/include/header.jsp" />
	<form align="center">
		<div class="point-box">
			<h2><%=mdto.getMname()%>님의 포인트내역</h2>
			<div class="point-summary">
				사용 가능 포인트: <strong><%=PointCount%>P</strong>
			</div>
			<div class="point-history">
				<%
				if (plist != null && !plist.isEmpty()) {
					for (pointDTO pd : plist) {
				%>
				<div class="point-item">
					<span class="label"><%=pd.getPtype()%> (<%=pd.getPstat() == 1 ? "적립" : "사용"%>)</span>
					<span><%=pd.getPpoint()%>P</span>
					<span class="date">
						<%if(pd.getPcreate() != null){%>
							<span>적립일자: </span><%=pd.getPcreate() != null ? sdf.format(pd.getPcreate()) : "-"%>
						<%}
						  if(pd.getPuse() != null){%>
							  <span>사용일자: </span><%=pd.getPuse() != null ? sdf.format(pd.getPuse()) : "-"%>
						  <%}%>
					</span>
				</div>
				<%
				}
				} else {
				%>
				<div class="point-empty">포인트 내역이 없습니다.</div>
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
