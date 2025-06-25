<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:useBean id="ldto" class="shop.member.MemberDTO" />
<jsp:setProperty property="*" name="ldto" />
<jsp:useBean id="ldao" class="shop.member.LoginDAO" />

<%
	boolean result = ldao.LoginCheck(ldto);
	if(result){
		//로그인 성공
		session.setAttribute("sid", ldto.getMid()); //세션에 로그인한 아이디값을 sid로 저장
		response.sendRedirect("/shop/main/main.jsp");
		%>
	<%}else{%>
		<script>
			alert("아이디와 비밀번호를 확인하세요.");
			history.go(-1);
		</script>
	<%}%>