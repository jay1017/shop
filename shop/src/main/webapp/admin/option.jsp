<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.admin.OptionDTO" %>   
<%@ page import="shop.admin.OptionDAO" %>    
<%@ page import="java.util.List" %> 
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page</title>
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

		List<OptionDTO> list = null;
		OptionDAO dao = OptionDAO.getDAO();
		
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
	<h1>옵션 리스트</h1>
	<button onclick="location.href='/shop/admin/optionInsert.jsp'">옵션 등록</button>
	<table border="1" cellspacing="0" cellpadding="0">
		<% if(count == 0) { %>
			<tr>
				<td>등록된 옵션이 없습니다.</td>
			</tr>
		<% } else { %>
			<tr>	
				<th>번호</th>
				<th>사이즈</th>
				<th>색상</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
		<% for(OptionDTO dto : list) { %>
		<tr> 
			<td><%=number-- %></td>
			<td><%=dto.getGosize() %></td> 
			<td><%=dto.getGocolor() %></td> 
			<td><button onclick="location.href='/shop/admin/optionUpdate.jsp?gonum=<%=dto.getGonum()%>'">수정</button></td>
			<td><button onclick="deleteMsg('<%=dto.getGonum()%>', '/shop/admin/optionDelete.jsp?gonum=');">삭제</button></td>
		</tr>
		<% }
		} %>
	</table>
	<div>
		<%
			if(count > 0) {
				int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
				
				int startPage = (int) (currentPage / 10) * 10 + 1;
				int pageBlock = 10;
				int endPage = startPage + pageBlock - 1;
				if(endPage > pageCount) {
					endPage = pageCount;
				}
				
				if(startPage > 10) { %>
					<a href="option.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
				<% } 
				
				for(int i = startPage; i <= endPage; i++) { %>
					<a href="option.jsp?pageNum=<%= i %>">[<%= i %>]</a>
				<% }
				if(endPage < pageCount) { %>
					<a href="option.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
				<%
				}
			}
		%>
	</div>
</body>
</html>