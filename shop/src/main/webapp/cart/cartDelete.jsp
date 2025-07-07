<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="shop.cart.CartDAO"%>
<%@ page import="shop.cart.CartDTO"%>

<%
CartDTO dto = new CartDTO();
CartDAO dao = CartDAO.getInstance();
int gnum = Integer.parseInt(request.getParameter("gnum"));
String sid = (String) session.getAttribute("sid");
int mnum = dao.getMnum(sid);

int result = dao.deleteCart(gnum, mnum);
if (result == 1) {
%>
<script>
	alert("삭제되었습니다.");
	window.location.href = document.referrer;
</script>
<%
} else {
%>
<script>
	alert("삭제 중 오류가 발생하였습니다.");
	history.go(-1);
</script>
<%
}
%>