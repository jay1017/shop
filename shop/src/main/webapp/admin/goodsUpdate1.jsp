<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.admin.GoodsImageDTO" %>
<%@ page import="shop.admin.GoodsImageDAO" %>    
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
	<%
		GoodsImageDAO dao = GoodsImageDAO.getDAO();
		GoodsImageDTO dto = new GoodsImageDTO();
		
		int ginum = Integer.parseInt(request.getParameter("ginum"));
		int gnum = Integer.parseInt(request.getParameter("gnum"));
		int gonum = Integer.parseInt(request.getParameter("gonum"));
		dto = dao.select(ginum);
	%>
	<div class="wrapper">
		<jsp:include page="/admin/include/sidebar.jsp"></jsp:include>
		<div class="main">
			<main class="content">
				<div class="container-fluid p-0">
					<div class="row">
						<div class="col-12 col-lg-6">
							<div class="card">
								<div class="card-header">
									<h5 class="card-title mb-0">상품 등록</h5>
								</div>
								<div class="card-body">
									<form action="goodsUpdatePro1.jsp" method="post" enctype="multipart/form-data" onsubmit="checkGoods1(event);">
										<input type="hidden" name="ginum" value="<%= ginum%>"/>
										<input type="hidden" name="gonum" value="<%= gonum%>"/>
										<input type="hidden" name="gnum" value="<%= gnum%>"/>
										<div class="mb-3">
											<label class="form-label">대표 이미지</label>
											<input type="file" name="giname" class="form-control form-control-lg"/>
											<% if(dto.getGiname() != null) { %>
												<p class="mt-3">기존이미지</p>
												<img src="/shop/resources/image/<%=dto.getGiname() %>" width="300"/><br />
											<% } %>
										</div>
										<div class="mb-3">
											<label class="form-label">상세 이미지 1</label>
											<input type="file" name="giname" class="form-control form-control-lg"/>
											<% if(dto.getGidetail1() != null) { %>
												<p class="mt-3">기존이미지</p>
												<img src="/shop/resources/image/<%=dto.getGidetail1() %>" width="300"/><br />
											<% } %>
										</div>
										<div class="mb-3">
											<label class="form-label">상세 이미지 2</label>
											<input type="file" name="giname" class="form-control form-control-lg"/>
											<% if(dto.getGidetail2() != null) { %>
												<p class="mt-3">기존이미지</p>
												<img src="/shop/resources/image/<%=dto.getGidetail2() %>" width="300"/><br />
											<% } %>
										</div>
										<div class="mb-3">
											<label class="form-label">상세 이미지 3</label>
											<input type="file" name="giname" class="form-control form-control-lg"/>
											<% if(dto.getGidetail3() != null) { %>
												<p class="mt-3">기존이미지</p>
												<img src="/shop/resources/image/<%=dto.getGidetail3() %>" width="300"/><br />
											<% } %>
										</div>
										<input type="submit" value="저장하고 다음 화면으로" class="btn btn-primary"/>
									</form>
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