<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
	session.invalidate(); //세션 전체삭제
%>
<script>
	alert("로그아웃 되었습니다.");
	response.sendRedirect("/shop/main/main.jsp");
</script>

