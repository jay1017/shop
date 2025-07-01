<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.member.LoginDAO" %>
<%
	String ename = request.getParameter("ename");
	String email = request.getParameter("memail");
	String phone = request.getParameter("mphone");
	String pname = request.getParameter("pname");
	
	LoginDAO ldao = LoginDAO.getInstance();
	String eid = ldao.getIdEmail(ename,email); //입력한 이름과 이메일이 일치하는 mid를 id변수에 저장
	String pid = ldao.getIdPw(pname,phone);
	if(eid == null || eid == "" && pid == null || pid == ""){
	%>	
		<script>
			alert("일치하는 아이디가 없습니다.");
			history.go(-1);
		</script>
	<%}else if(eid != null || eid != "" && pid == null || pid == ""){%>
		<script>
			alert("회원님의 아이디는: <%=eid%>입니다.");
			self.close();
		</script>
	<%}else{%>
		<script>
			alert("회원님의 아이디는: <%=pid%>입니다.");
			self.close();
		</script>
	<%}%>