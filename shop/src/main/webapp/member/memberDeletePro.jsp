<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mdao" class="shop.member.MemberDAO" />

<%
	request.setCharacterEncoding("UTF-8");
	String sid = (String)session.getAttribute("sid");
	String mid = request.getParameter("mid");
	String mpw = request.getParameter("mpw");
	if(mdao.SelectMember(mid, mpw) == 1 && sid != null && sid.equals(mid)){
		mdao.DeleteMember(mid);
		session.invalidate();
%>
	<script>
		alert("회원탈퇴가 완료되었습니다.");
		opener.location.href="/shop/main/main.jsp";
		window.close();
	</script>
<%
	}else{
%>		<script>
			alert("아이디/비밀번호가 일치하지 않습니다.");
			history.go(-1);
		</script>
	
<%}%>