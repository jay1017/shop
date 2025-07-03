<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.review.ReviewDTO,shop.review.ReviewDAO" %>
<%--리뷰 삭제 및 수정하는 페이지 --%>

<%
	request.setCharacterEncoding("UTF-8");
	String sid=(String)session.getAttribute("sid");
	int gnum=Integer.parseInt(request.getParameter("gnum")); //상품번호
	int mnum=Integer.parseInt(request.getParameter("mnum")); //회원번호
	int rnum=Integer.parseInt(request.getParameter("rnum")); //리뷰 번호
	
	
	ReviewDAO dao=ReviewDAO.getInstance();
%>
<%	if(sid!=null) { 
		dao.reviewDelete(gnum,mnum,rnum); %>
		<script>
			alert('리뷰가 삭제되었습니다');
			location.href = "/shop/goods/goodsview.jsp?gnum=<%=gnum%>";
		</script>	
<%	}else{%>
		<script>
			alert('잘못된 접근입니다');
			historygo(-1);
		</script>
<%	}%>