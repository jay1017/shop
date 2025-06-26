<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.admin.GoodsDTO" %>   
<%@ page import="shop.admin.GoodsDAO" %>     
<%@ page import="java.util.List" %> 
<%@ page import="java.util.ArrayList" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script language="JavaScript" src="/shop/resources/js/admin.js"></script>
</head>
<body>
	<%!
		int pageSize = 10;
	%>
	<% 
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) {
			pageNum = "1";
		}

		List<GoodsDTO> list = null;
		GoodsDAO dao = GoodsDAO.getDAO(); 
		
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = currentPage * pageSize;
		int count = 0;
		int number = 0;
		
		count = dao.selectCount(); 
		number = count - (currentPage - 1) * pageSize;
		if(count > 0) {
			list = dao.selectList(startRow, endRow);   
		}
	%>
	<h1>상품 리스트</h1>
	<button onclick="location.href='/shop/admin/goodsInsert1.jsp'">상품 등록</button>

	<table border="1" cellspacing="0" cellpadding="0">
		<% if(count == 0) { %>
			<tr>
				<td>등록된 상품이 없습니다.</td>
			</tr>
		<% } else { %>
			<tr>	
				<th>번호</th>
				<th>상품명</th>
				<th>가격</th>
				<th>색상</th>
				<th>사이즈</th>
				<th>재고</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
		<% for(GoodsDTO dto : list) { %>
		<tr> 
			<td><%=number-- %></td>
			<td><%=dto.getGname() %></td> 
			<td><%=dto.getGprice() %></td> 
			<td><%=dto.getGocolor() %></td> 
			<td><%=dto.getGosize() %></td> 
			<td><%=dto.getGocount() %></td> 
			<td><button onclick="location.href='/shop/admin/goodsUpdate1.jsp?gnum=<%=dto.getGnum()%>&ginum=<%=dto.getGinum()%>&gonum=<%=dto.getGonum()%>'">수정</button></td>
			<td><button onclick="deleteMsg('<%=dto.getGnum()%>', '/shop/admin/goodsDelete.jsp?gnum=');">삭제</button></td> 
		</tr>
		<% }
		} %>
	</table>
</body>
</html>