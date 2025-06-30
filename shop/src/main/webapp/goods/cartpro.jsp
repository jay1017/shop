<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="shop.goods.categoryDTO"%>
<%@ page import="shop.cart.cartDAO" %>
<%@ page import="shop.cart.cartDTO" %>
<%@ page import="shop.member.MemberDAO" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%--장바구니 담기 기능 페이지 --%>
<%
//로그인 확인
String sid = (String) session.getAttribute("sid");
int gnum = Integer.parseInt(request.getParameter("gnum"));
cartDAO dao = cartDAO.getInstance();
cartDTO dto = dao.getCartAdd(gnum);

if (dto == null) {
%>
<script>
    alert("해당 상품이 존재하지 않습니다.");
    history.back();
</script>
<%
    return;
}
int mnum = dao.getMnum(sid);
dto.setMnum(mnum);

// 장바구니에 상품 추가
dto.setCcount(1);//기본수량1
dao.insertCart(dto);
%>

<script>
	alert("장바구니에 추가되었습니다.")
	history.go(-1);
</script>