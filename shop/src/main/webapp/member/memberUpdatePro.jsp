<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.member.MemberDTO" %>
<%@ page import="shop.member.MemberDAO" %>

<%!
//수정한 비밀번호가 널이 아니고 값이 비어있지 않다면 수정한 값이 되므로
//해당 결과가 참이면 수정한 값을 비밀번호로 저장
//거짓이면 기존 비밀번호 저장
public boolean notEmpty(String str){
	return str != null && !str.trim().isEmpty();
}
%>

<%
	request.setCharacterEncoding("UTF-8");

	String sid = (String)session.getAttribute("sid");
	
	String mpw = request.getParameter("mpw");
	String originalmpw = request.getParameter("originalmpw");
	String mname = request.getParameter("mname");
	String mphone = request.getParameter("mphone");
	String memail = request.getParameter("memail");
	String mgender = request.getParameter("mgender");
	
	//비밀번호 처리 바뀐 정보가 있다면 바뀐값 없다면 기존값 세팅
	String finalPw;
	if(notEmpty(mpw)){
		finalPw = mpw;
	}else{
		finalPw = originalmpw;
	}
	
	MemberDTO mdto = new MemberDTO();
	mdto.setMid(sid);
	mdto.setMpw(finalPw);
	mdto.setMname(mname);
	mdto.setMphone(mphone);
	mdto.setMemail(memail);
	mdto.setMgender(mgender);
	
	MemberDAO mdao = new MemberDAO();
	mdao.updateMember(mdto);
	
	response.sendRedirect("memberUpdate.jsp");
%>





