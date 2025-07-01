<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.admin.CategoryDAO" %>    
<%@ page import="shop.admin.CategoryDTO" %>
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
		int canum = Integer.parseInt(request.getParameter("canum"));
		CategoryDAO dao = CategoryDAO.getDAO();
		CategoryDTO dto = dao.select(canum); 
		String admin = (String) session.getAttribute("admin");
	%>
	<% if(admin == null) { %>
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
						<div class="col-12 col-lg-6">
							<div class="card">
								<div class="card-header">
									<h5 class="card-title mb-0">카테고리 등록</h5>
								</div>
								<div class="card-body">
									<p>카테고리 이름</p>
									<form action="categoryUpdatePro.jsp" method="post" onsubmit="checkCategory(event)">
										<input type="hidden" name="canum" value="<%=dto.getCanum() %>" />
										<input type="text" name="caname" class="form-control"  id="caname" value="<%=dto.getCaname() %>" />
										<input type="submit" value="수정" class="btn btn-primary mt-3"/>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</main>
		</div>
	</div>
	<% } %>
</body>
</html>