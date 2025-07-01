<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="shop.member.LoginDAO" %>
<%
	request.setCharacterEncoding("UTF-8");
	String ename = request.getParameter("emname");
	String email = request.getParameter("memail");
	String phone = request.getParameter("mphone");
	String pname = request.getParameter("mname");
	
	if (ename == null) ename = "";
	if (email == null) email = "";
	if (phone == null) phone = "";
	if (pname == null) pname = "";
	
	LoginDAO ldao = LoginDAO.getInstance();
	String eid = ldao.getIdByEmail(ename,email); //입력한 이름과 이메일이 일치하는 mid를 eid변수에 저장
	String pid = ldao.getIdByPhone(pname,phone);
	
	boolean hasEid = (eid != null && !eid.equals(""));
	boolean hasPid = (pid != null && !pid.equals(""));
	if(hasEid && !hasPid){%>		
		<script>
			alert("회원님의 아이디는: <%=eid%>입니다.");
			self.close();
		</script>
	<%}else if(!hasEid && hasPid){%>
		<script>
			alert("회원님의 아이디는: <%=pid%>입니다.");
			self.close();
		</script>
	<%}else{%>
		<script>
			alert("일치하는 정보가 없습니다.");
			history.go(-1);
		</script>
	<%}%>