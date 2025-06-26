<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.admin.CategoryDTO" %>   
<%@ page import="shop.admin.CategoryDAO" %>    
<%@ page import="java.util.List" %> 
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page</title>
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
<link href="https://demos.creative-tim.com/argon-dashboard-pro/assets/css/nucleo-icons.css" rel="stylesheet" />
<link href="https://demos.creative-tim.com/argon-dashboard-pro/assets/css/nucleo-svg.css" rel="stylesheet" />
<link id="pagestyle" href="/shop/resources/assets/css/argon-dashboard.css?v=2.1.0" rel="stylesheet" />
<script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
<script language="JavaScript" src="/shop/resources/js/admin.js"></script>
</head>
<body>
	<%-- <jsp:include page="/admin/include/sidebar.jsp"></jsp:include> --%>
	<%!
		int pageSize = 10;
	%>
	<% 
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) {
			pageNum = "1";
		}

		List<CategoryDTO> list = null;
		CategoryDAO dao = CategoryDAO.getDAO();
		
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
	<h1>카테고리 리스트</h1>
	<button onclick="location.href='/shop/admin/categoryInsert.jsp'">카테고리 등록</button>
	<table border="1" cellspacing="0" cellpadding="0">
		<% if(count == 0) { %>
			<tr>
				<td>등록된 카테고리가 없습니다.</td>
			</tr>
		<% } else { %>
			<tr>	
				<th>번호</th>
				<th>카테고리명</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
		<% for(CategoryDTO dto : list) { %>
		<tr> 
			<td><%=number-- %></td>
			<td><%=dto.getCaname() %></td> 
			<td><button onclick="location.href='/shop/admin/categoryUpdate.jsp?canum=<%=dto.getCanum()%>'">수정</button></td>
			<td><button onclick="deleteMsg('<%=dto.getCanum()%>', '/shop/admin/categoryDelete.jsp?canum=');">삭제</button></td>
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
					<a href="category.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
				<% } 
				
				for(int i = startPage; i <= endPage; i++) { %>
					<a href="category.jsp?pageNum=<%= i %>">[<%= i %>]</a>
				<% }
				if(endPage < pageCount) { %>
					<a href="category.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
				<%
				}
			}
		%>
	</div>
</body>
</html>