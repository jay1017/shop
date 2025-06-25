<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:useBean id="ldto" class="shop.member.MemberDTO" />
<jsp:setProperty property="*" name="ldto" />
<jsp:useBean id="ldao" class="shop.member.LoginDAO" />