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
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="Responsive Admin &amp; Dashboard Template based on Bootstrap 5">
	<meta name="author" content="AdminKit">
	<meta name="keywords" content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link rel="shortcut icon" href="img/icons/icon-48x48.png" />
	<link rel="canonical" href="https://demo-basic.adminkit.io/" />
	<title>Admin Page</title>
	<link href="/shop/resources/css/app.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="/shop/resources/css/font.css" />
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
		
		System.out.println("startRow : " + startRow);
		System.out.println("endRow : " + endRow);
	%>
	
	<div class="wrapper">
		<jsp:include page="/admin/include/sidebar.jsp"></jsp:include>
		<div class="main">
			<main class="content">
				<div class="container-fluid p-0">
					<div class="row">
						<div class="col-12 col-lg-8 col-xxl-9 d-flex">
							<div class="card flex-fill">
								<div class="card-header">
									<h5 class="card-title mb-0">상품 리스트</h5>
									<button class="btn btn-primary mt-3" onclick="location.href='/shop/admin/goodsInsert1.jsp'">상품 등록</button>
								</div>
								<% if(count == 0) { %>
								<table class="table table-hover my-0">
									<thead>
										<tr>
											<th colspan="4">등록된 카테고리가 없습니다.</th>
										</tr>
									</thead>
								</table>
								<% } else { %>
								<table class="table table-hover my-0">
									<colgroup>
										<col width="10%" />
										<col width="30%" />
										<col width="10%" />
										<col width="10%" />
										<col width="10%" />
										<col width="10%" />
										<col width="10%" />
										<col width="10%" />
									</colgroup>
									<thead>
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
									</thead>
									<tbody>
										<% for(GoodsDTO dto : list) { %>
											<tr>
												<td class="ps-3"><%=number-- %></td>
												<td><%=dto.getGname() %></td> 
												<td><%=dto.getGprice() %></td> 
												<td><%=dto.getGocolor() %></td> 
												<td><%=dto.getGosize() %></td> 
												<td><%=dto.getGocount() %></td> 
												<td>
													<button class="btn btn-success" onclick="location.href='/shop/admin/goodsUpdate1.jsp?gnum=<%=dto.getGnum()%>&ginum=<%=dto.getGinum()%>&gonum=<%=dto.getGonum()%>'">수정</button>
												</td>
												<td>
													<button class="btn btn-warning" onclick="deleteGoods('<%=dto.getGnum()%>', '<%=dto.getGinum()%>', '<%=dto.getGonum()%>', '/shop/admin/goodsDelete.jsp?gnum=', '&ginum=', '&gonum=');">삭제</button>
												</td>
											</tr>
										<% }
									} %>	
									</tbody>
								</table>
								<div class="text-center mt-3 mb-3">
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
											<a href="goods.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
										<% } 
										
										for(int i = startPage; i <= endPage; i++) { %>
											<a href="goods.jsp?pageNum=<%= i %>">[<%= i %>]</a>
										<% }
										if(endPage < pageCount) { %>
											<a href="goods.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
										<%
										}
									}
								%>
							</div>
							</div>
						</div>
					</div>
				</div>
			</main>
		</div>
	</div>
</body>
</html>