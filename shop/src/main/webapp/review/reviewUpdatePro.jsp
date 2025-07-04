<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.member.MemberDAO,shop.member.MemberDTO"%>
<%@ page import="shop.review.ReviewDAO,shop.review.ReviewDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/shop/resources/css/font.css" />
<title>reviewUpdatePro.jsp</title>
<%	
	request.setCharacterEncoding("UTF-8");
	String sid=(String)session.getAttribute("sid");//아이디 체크
	int gnum=Integer.parseInt(request.getParameter("gnum")); //상품번호
	int rnum=Integer.parseInt(request.getParameter("rnum")); //리뷰번호 
	String rcontent=request.getParameter("rcontent"); //리뷰 내용
	
	if(sid!=null) {
	ReviewDTO dto=new ReviewDTO();
	ReviewDAO dao=ReviewDAO.getInstance();
	
	dto.setGnum(gnum);
	dto.setRnum(rnum);
	dto.setRcontent(rcontent);
	
	 
	dao.updateReview(dto); %>
	<script>
	alert('리뷰 수정이 완료되었습니다');
	location.href = "/shop/goods/goodsview.jsp?gnum=<%=dto.getGnum()%>";
	</script>
<%	}else { %>
	<script>
	alert("잘못된 접근입니다");
	history.go(-1);
	</script>	
<% 	}%>	
</head>
<body>
</body>
</html>