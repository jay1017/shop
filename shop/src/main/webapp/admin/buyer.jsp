<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.admin.BuyerDAO" %>    
<%@ page import="shop.admin.BuyerDTO" %>  
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
<body>
	<%!
		int pageSize = 10;
	%>
	<%  
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) {
			pageNum = "1";
		}
	
		List<BuyerDTO> list = new ArrayList<>();
		BuyerDAO dao = BuyerDAO.getDAO(); 
		
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
		
		String admin = (String) session.getAttribute("admin");
		if(admin == null) { %>
		<script>
			alert("로그인 후 이용 해 주세요.");
			location.href="/shop/admin/login.jsp";
		</script>
	<% } else { %>
	<div class="wrapper">
		<jsp:include page="/admin/include/sidebar.jsp"></jsp:include>
		<div class="main">
			<main class="content">
				<div class="container-fluid p-0">
					<div class="row">
						<div class="col-12 col-lg-8 col-xxl-9 d-flex">
							<div class="card flex-fill">
								<div class="card-header">
									<h5 class="card-title mb-0">회원별 주문내역</h5>
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
									<thead>
										<tr>
											<!-- <th>번호</th> -->
											<th>주문번호</th>
											<th>아이디</th>
											<th>이름</th>
											<th>상품명</th>
											<th>상품 갯수</th>
											<th>주소</th>
											<th>배송 메모</th>
											<th>상태</th>
											<th>발송</th>
										</tr>
									</thead>
									<tbody>
										<% for(BuyerDTO dto : list) { %>
											<tr>
												<%-- <td class="ps-3"><%=number-- %></td> --%>
												<td class="ps-3"><%=dto.getBuynum() %></td>
												<td class="ps-3"><%=dto.getMid() %></td>
												<td class="ps-3"><%=dto.getMname() %></td>
												<td class="ps-3"><%=dto.getGname() %></td>
												<td class="ps-3"><%=dto.getBcount() %></td>
												<%
													String address = dto.getAddress();
													if(dto.getAddress2() != null) {
														address += dto.getAddress2();
													}
													
													if(dto.getAddress3() != null) {
														address += dto.getAddress3();
													}
												%>
												<td class="ps-3"><%=address %></td>
												<%
													String note = dto.getNote();
													if(note == null) {
														note = "";
													}
												%>
												<td><%=note %></td>
												<%
													String status = "";
													if(dto.getBstatus() == 0) {
														status = "배송 준비중";
													} else {
														status= "발송 준비중";
													}
												%>
												<td><%=status %></td>
												<td class="ps-0">
													<button class="btn btn-success" onclick="location.href='/shop/admin/buyerUpdate.jsp?bnum=<%=dto.getBnum()%>'">발송</button>
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
												<a href="buyer.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
											<% } 
											
											for(int i = startPage; i <= endPage; i++) { %>
												<a href="buyer.jsp?pageNum=<%= i %>">[<%= i %>]</a>
											<% }
											if(endPage < pageCount) { %>
												<a href="buyer.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
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
	<script src="js/app.js"></script>
	<% } %>
</body>
</html>