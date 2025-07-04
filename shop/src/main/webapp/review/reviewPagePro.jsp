<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//msg라는 파라미터명으로 전달되는 문자열을 읽어온다.
	String gnum=request.getParameter("gnum");
	String currentPage=request.getParameter("page");
	//콘솔창에 출력하기
	System.out.println(gnum);
	System.out.println(currentPage);
	//응답!
	
%>
{"isSuccess":true}
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/shop/resources/css/font.css" />
<title>reviewPagePro.jsp</title>
</head>
<body>

</body>
</html>
