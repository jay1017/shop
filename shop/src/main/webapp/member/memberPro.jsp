<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="mdto" class="shop.member.MemberDTO" />
<jsp:setProperty property="*" name="mdto" />
<jsp:useBean id="mdao" class="shop.member.MemberDAO" />

<%
	mdao.InputMember(mdto); //memberform에서 받은 값을 db에 저장
%>
<script>
	alert("가입하셨습니다.");
	window.location="/shop/member/loginform.jsp";
</script>

