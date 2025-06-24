<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

  <jsp:useBean id="mdto" class="shop.member.MemberDTO" />
  	<jsp:setProperty property="*" name="mdto" />
  <jsp:useBean id="mdao" class="shop.member.MemberDAO" />
  
  <%
  	mdto=mdao.getMid(mdto.getMid());
  	if(mdto == null){
  %>	사용가능
  <%}else{ %>
  		사용불가
  <%} %>
  <input type="button" value="닫기" onclick="self.close();" />