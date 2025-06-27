<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.admin.OptionDAO" %>   
<%@ page import="shop.admin.OptionDTO" %>    
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
		int canum = Integer.parseInt(request.getParameter("canum"));
		int ginum = Integer.parseInt(request.getParameter("ginum"));
		int gnum = Integer.parseInt(request.getParameter("gnum"));
		int gonum = Integer.parseInt(request.getParameter("gonum"));
		
		System.out.println(gonum);
		
		OptionDAO dao = OptionDAO.getDAO();
		OptionDTO dto = dao.select(gonum);
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
									<form action="goodsUpdatePro3.jsp" method="post" onsubmit="checkGoods3(event)">
										<input type="hidden" value="<%=canum%>" name="canum"/>
										<input type="hidden" value="<%=ginum%>" name="ginum"/>
										<input type="hidden" value="<%=gnum%>" name="gnum"/>
										<input type="hidden" value="<%=gonum%>" name="gonum"/>
										<div class="mb-3">
											<label class="form-label">사이즈</label>
											<input type="text" name="gosize" id="gosize" value="<%= dto.getGosize()%>" class="form-control form-control-lg"/>
										</div>
										<div class="mb-3">
											<label class="form-label">색상</label>
											<input type="text" name="gocolor" id="gocolor"  value="<%=dto.getGocolor()%>" class="form-control form-control-lg"/>
										</div>
										<div class="mb-3">
											<label class="form-label">수량</label>
											<input type="number" name="gocount" id="gocount"  value="<%=dto.getGocount()%>" class="form-control form-control-lg"/>
										</div>
										<input type="submit" value="저장"  class="btn btn-primary mt-3"/>
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