<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

  <jsp:useBean id="mdto" class="shop.member.MemberDTO" />
  	<jsp:setProperty property="*" name="mdto" />
  <jsp:useBean id="mdao" class="shop.member.MemberDAO" />
  
  <%
  	//member.js에서 받은 mid값을 메서드를 통해 입력한 값과 db에 있는 mid값을 비교하여
  	//값이 있으면 사용불가를 보여주고 값이 없으면 사용가능을 보여줌
  	mdto=mdao.getMidname(mdto.getMid());
  	if(mdto == null){
  %>	사용가능한 아이디입니다.
  <%}else{ %>
  		이미 가입한 아이디입니다.
  <%} %>
  <input type="button" value="닫기" onclick="self.close();" />