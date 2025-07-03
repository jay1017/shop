<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="shop.admin.GoodsDAO" %>
<%@ page import="shop.member.MemberDAO" %>	
<%@ page import="shop.admin.BuyerDAO" %>
<%@ page import="shop.admin.MainDAO" %>
<%@ page import="shop.admin.CategoryGoodsDTO" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="Responsive Admin &amp; Dashboard Template based on Bootstrap 5">
<meta name="author" content="AdminKit">
<meta name="keywords" content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="canonical" href="https://demo-basic.adminkit.io/" />
<title>Admin Page</title>
<link href="/shop/resources/css/app.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/shop/resources/css/font.css" />
<script language="JavaScript" src="/shop/resources/js/admin.js"></script>
</head>
<body>
	<% String admin = (String) session.getAttribute("admin"); %>
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
					<h1 class="h3 mb-3">
						<strong>쇼핑몰</strong> 대시보드
					</h1>
					<div class="row">
						<div class="col-xl-6 col-xxl-6 d-flex">
							<div class="w-100">
								<div class="row">
									<div class="col-sm-6">
										<div class="card">
											<div class="card-body">
												<div class="row">
													<%
														NumberFormat numberFormat = NumberFormat.getNumberInstance(Locale.getDefault());
														BuyerDAO bdao = BuyerDAO.getDAO();
														String amount = numberFormat.format(bdao.selectAmount());
													%>
													<div class="col mt-0">
														<h5 class="card-title">총 판매 금액</h5>
													</div>
													<div class="col-auto">
														<div class="stat text-primary">
															<i class="align-middle" data-feather="truck"></i>
														</div>
													</div>
												</div>
												<h1 class="mt-1 mb-3"><%=amount %></h1>
												<div class="mb-0">
													<span class="text-muted">Latest today</span>
												</div>
											</div>
										</div>
										<div class="card">
											<div class="card-body">
												<div class="row">
													<div class="col mt-0">
														<h5 class="card-title">총 회원 수</h5>
													</div>
													<div class="col-auto">
														<div class="stat text-primary">
															<i class="align-middle" data-feather="users"></i>
														</div>
													</div>
												</div>
												<%
													MemberDAO mdao = new MemberDAO();
													int mcount = mdao.selectCount();	
												%>
												<h1 class="mt-1 mb-3"><%=mcount %></h1>
												<div class="mb-0">
													<span class="text-muted">Latest today</span>
												</div>
											</div>
										</div>
									</div>
									<div class="col-sm-6">
										<div class="card">
											<div class="card-body">
												<div class="row">
													<%
														int bcount = bdao.selectCount();
													%>
													<div class="col mt-0">
														<h5 class="card-title">총 주문 건수</h5>
													</div>
													<div class="col-auto">
														<div class="stat text-primary">
															<i class="align-middle" data-feather="dollar-sign"></i>
														</div>
													</div>
												</div>
												<h1 class="mt-1 mb-3"><%=bcount %></h1>
												<div class="mb-0">
													<span class="text-muted">Latest today</span>
												</div>
											</div>
										</div>
										<div class="card">
											<div class="card-body">
												<div class="row">
													<div class="col mt-0">
														<h5 class="card-title">총 상품 갯수</h5>
													</div>
													<div class="col-auto">
														<div class="stat text-primary">
															<i class="align-middle" data-feather="shopping-cart"></i>
														</div>
													</div>
												</div>
												<%
													GoodsDAO dao = GoodsDAO.getDAO();
													int count = dao.selectCount();
												%>
												<h1 class="mt-1 mb-3"><%=count %></h1>
												<div class="mb-0">
													<span class="text-muted">Latest today</span>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-12 col-md-6 col-xxl-6 d-flex order-2 order-xxl-3">
							<div class="card flex-fill w-100">
								<%
									List<CategoryGoodsDTO> cglist = new ArrayList<>();
									MainDAO mainDAO = MainDAO.getDAO();
									cglist = mainDAO.selectCateGoods();
								%>
								<div class="card-header">
									<h5 class="card-title mb-0">카테고리별 상품</h5>
								</div>
								<div class="card-body d-flex">
									<div class="align-self-center w-100">
										<div class="d-flex">
											<div class="chart chart-xs">
												<canvas id="chartjs-dashboard-pie"></canvas>
											</div>
											<table class="table mb-0">
												<tbody>
													<% for(CategoryGoodsDTO cg : cglist) { %>
													<tr>
														<td style="padding:5px;"><span class="caname"><%= cg.getCaname() %></span></td>
														<td style="padding:5px;" class="text-end"><span class="gcount"><%=cg.getGcount() %></span></td>
													</tr>
													<% } %>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</main>
		</div>
	</div>

	<script src="/shop/resources/js/app.js"></script>
	<script>
		var canames = document.getElementsByClassName("caname");
		var gcounts = document.getElementsByClassName("gcount");
		var caname = [];
		var gcount = [];
		
		for(i = 0; i < canames.length; i++) {
			caname.push(canames[i].innerHTML);
		}
		
		for(i = 0; i < gcounts.length; i++) {
			gcount.push(gcounts[i].innerHTML);
		}
		
		document.addEventListener("DOMContentLoaded", function() {
			// Pie chart
			new Chart(document.getElementById("chartjs-dashboard-pie"), {
				type: "pie",
				data: {
					labels: caname,
					datasets: [{
						data: gcount,
						backgroundColor: [
							window.theme.primary,
							window.theme.warning,
							window.theme.danger,
							window.theme.success,
							window.theme.primary,
							window.theme.warning,
							window.theme.danger,
							window.theme.success,
						],
						borderWidth: 5
					}]
				},
				options: {
					responsive: !window.MSInputMethodContext,
					maintainAspectRatio: false,
					legend: {
						display: false
					},
					cutoutPercentage: 75
				}
			});
		});
	</script>
	<% } %>
</body>

</html>