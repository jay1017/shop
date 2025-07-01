<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.member.LoginDAO" %>
<%request.setCharacterEncoding("UTF-8"); %>
<%
	String id = request.getParameter("mid");
	String phone = request.getParameter("mphone");
	String eid = request.getParameter("emid");
	String email = request.getParameter("memail");
	
	if(id == null)id = "";
	if(phone == null)phone = "";
	if(eid == null)eid = "";
	if(email == null)email = "";
	
	LoginDAO ldao = LoginDAO.getInstance();
	String epw = ldao.getPwByEmail(eid, email);
	//입력한 아이디와 이메일이 일치하는 비밀번호 저장
	String pw = ldao.getPwByPhone(id, phone);
	
	boolean hasEpw = (epw != null && !epw.equals(""));
	boolean hasPw = (pw != null && !pw.equals(""));
	if(hasEpw || hasPw){
		if(hasEpw){//비밀번호 재설정을 위해 별도로 세션에 받은 id값 저장 (아이디와 전화번호 또는 이메일이 일치하는 정보가 있을때만)
			int mnum = ldao.getMnumById(eid);
			session.setAttribute("resetMnum", mnum); 
		}else{
			int mnum = ldao.getMnumById(id);
			session.setAttribute("resetMnum", mnum);
		}%>
		<script>
			window.location = "pwSearchUpdate.jsp";
		</script>
	<%}else{%>
		<script>
			alert("일치하는 정보가 없습니다.");
			history.go(-1);
		</script>
	<%}%>
