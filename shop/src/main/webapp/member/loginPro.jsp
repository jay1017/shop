<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import = "shop.member.MemberDTO" %>
<%@ page import = "shop.member.LoginDAO" %>

<%
	//사용자의 입력값 받음
	String mid = request.getParameter("mid");
	String mpw = request.getParameter("mpw");

	//해당 입력값을 DTO에 저장
	MemberDTO ldto = new MemberDTO();
	ldto.setMid(mid);
	ldto.setMpw(mpw);
	
	//DAO의 객체를 생성하여 result에 로그인이 성공했을때 1 실패했을때 0을 반환
	LoginDAO ldao = LoginDAO.getInstance();
	int result = ldao.LoginCheck(ldto);
	System.out.println("Mid:"+mid);
	System.out.println("Pw:"+mpw);
	if(result == 1){
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