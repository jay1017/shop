<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.admin.CouponDAO" %>
<%@ page import="shop.admin.CouponDTO" %>    
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
		String admin = (String) session.getAttribute("admin"); 
		int cpnum = Integer.parseInt(request.getParameter("cpnum"));
		CouponDAO dao = CouponDAO.getDAO();
		CouponDTO dto = dao.select(cpnum);
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
									<h5 class="card-title mb-0">쿠폰 수정</h5>
								</div>
								<div class="card-body">
									<form action="couponUpdatePro.jsp" method="post">
										<input type="hidden" value="<%=cpnum %>" name="cpnum"/>
										<div class="mb-3">
											<label class="form-label"> 할인 방식 </label><br />
											<%
												String cptype = dto.getCptype();
												if(cptype.equals("할인율")) {
											%>
											<label class="form-check form-check-inline">
           										<input class="form-check-input" type="radio" name="cptype" value="할인율" checked>
            									<span class="form-check-label">할인율</span>
          									</label>
          									<label class="form-check form-check-inline">
           										<input class="form-check-input" type="radio" name="cptype" value="할인금액">
            									<span class="form-check-label">할인금액</span>
          									</label>
          									<% } else { %>
          									<label class="form-check form-check-inline">
           										<input class="form-check-input" type="radio" name="cptype" value="할인율">
            									<span class="form-check-label">할인율</span>
          									</label>
          									<label class="form-check form-check-inline">
           										<input class="form-check-input" type="radio" name="cptype" value="할인금액" checked>
            									<span class="form-check-label">할인금액</span>
          									</label>
          									<% } %>
										</div>
										<div class="mb-3">
											<label class="form-label">할인 금액 또는 할인율</label>
											<input type="number" name="cpvalue" value="<%=dto.getCpvalue() %>" class="form-control form-control-lg"/>
										</div>
										<div class="mb-3">
											<label class="form-label">쿠폰명</label>
											<input type="text" name="cpname" value="<%=dto.getCpname() %>" class="form-control form-control-lg"/>
										</div>
										<div class="mb-3">
											<label class="form-label">최소 주문 금액</label>
											<input type="number" name="cpmop" value="<%=dto.getCpmop() %>" class="form-control form-control-lg"/>
										</div>
										<div class="mb-3">
											<label class="form-label">발급일 기준 유효일</label>
											<input type="number" name="cpdate" value="<%=dto.getCpdate() %>" class="form-control form-control-lg"/>
										</div>
										<input type="submit" value="저장" class="btn btn-primary mt-3"/>
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