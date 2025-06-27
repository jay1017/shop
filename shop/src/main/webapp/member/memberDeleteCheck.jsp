<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="shop.member.LoginDAO" %>
<%@page import="shop.member.MemberDTO" %>



<html>
	<head>
		<title>회원탈퇴 확인</title>
		<link rel="stylesheet" href="/shop/resources/css/font.css" />
		<script>
			function confirmDelete(){
				const result = confirm("정말 탈퇴하시겠습니까?");
				if(result){
					window.location.href="memberDelete.jsp";
				}else{
					self.close();
				}
			}
		</script>
	</head>
	<body onload="confirmDelete()">
		<p>잠시만 기다려주세요...</p>
	</body>
</html>