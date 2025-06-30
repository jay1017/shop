<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.member.MemberDAO,shop.member.MemberDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/shop/resources/css/font.css" />
<title>리뷰를 작성하는 페이지입니다</title>
<%	
	String sid=(String)session.getAttribute("sid"); //아이디 체크
	int gnum=Integer.parseInt(request.getParameter("gnum")); //상품번호
	int mnum=Integer.parseInt(request.getParameter("mnum"));	//회원번호
	int canum=Integer.parseInt(request.getParameter("canum"));	//카테고리번호
	int ginum=Integer.parseInt(request.getParameter("ginum"));	//상품대표이미지번호 
%>
</head>
<body>
	<div>
	<form action="reviewPro.jsp" method="post">
	<input type="text" name="rcontent">
	<input type="hidden" name="gnum" value="<%=gnum%>"/>	
	<input type="hidden" name="mnum" value="<%=mnum%>"/>
	<input type="hidden" name="canum" value="<%=canum%>"/>	
	<input type="hidden" name="ginum" value="<%=ginum%>"/>
	<input type="hidden" name="rnum" value="<%=rnum%>"/>		
	<input type="submit" value="버튼"/>
	</form> 
	</div>
	
</body>
</html> 