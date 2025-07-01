<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.member.MemberDTO" %>
<%@ page import="shop.member.MemberDAO" %>
<%request.setCharacterEncoding("UTF-8");%>
<%
	int resetmnum = (Integer)session.getAttribute("resetMnum");
	String pw = request.getParameter("mpw");

	MemberDAO mdao = new MemberDAO();
	mdao.PwUpdateMember(resetmnum,pw);
	
	session.removeAttribute("resetMnum");
%>
<script>
	alert("비밀번호가 변경되었습니다.");
	if(window.opener && !window.opener.closed){
		window.opener.location.reload(); //부모창 새로고침
	}
	window.close();
</script>