<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.admin.GoodsDAO" %>    
<%@ page import="shop.admin.CategoryDTO" %>   
<%@ page import="java.util.List" %>       
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
		GoodsDAO dao = GoodsDAO.getDAO();
		List<CategoryDTO> list = dao.selectCategory(); 
		int ginum = Integer.parseInt(request.getParameter("ginum"));
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
									<form action="goodsInsertPro2.jsp" method="post" onsubmit="checkGoods2(event)">
										<input type="hidden" name="ginum" value="<%=ginum%>"/>
										<div class="mb-3">
											<label class="form-label">카테고리</label>
											<select name="canum" class="form-select">
											<% for(CategoryDTO dto : list) { %>
												<option value="<%=dto.getCanum()%>"><%=dto.getCaname() %></option>
											<% } %>
											</select>
										</div>
										<div class="mb-3">
											<label class="form-label">상품명</label>
											<input type="text" name="gname" class="form-control form-control-lg"/>
										</div>
										<div class="mb-3">
											<label class="form-label">가격</label>
											<input type="number" name="gprice" class="form-control form-control-lg"/>
										</div>
										<div class="mb-3">
											<label class="form-label">상품 설명</label>
											<textarea name="gcontent" class="form-control"></textarea>
										</div>
										<div class="mb-3">
											<label class="form-label">할인율</label>
											<input type="number" name="discount" class="form-control form-control-lg"/>
										</div>
										<input type="submit" value="저장하고 다음 화면으로" class="btn btn-primary mt-3"/>
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