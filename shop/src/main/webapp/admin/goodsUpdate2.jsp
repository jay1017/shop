<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.admin.GoodsDAO" %> 
<%@ page import="shop.admin.GoodsDTO" %>    
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
		int gnum = Integer.parseInt(request.getParameter("gnum"));
		int gonum = Integer.parseInt(request.getParameter("gonum"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		
		GoodsDTO dto = new GoodsDTO();
		dto = dao.select(gnum);
		
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
									<h5 class="card-title mb-0">상품 등록</h5>
								</div>
								<div class="card-body">
									<form action="goodsUpdatePro2.jsp" method="post" onsubmit="checkGoods2(event)">
										<input type="hidden" value="<%=dto.getCanum() %>" name="canum" />
										<input type="hidden" value="<%=gnum %>" name="gnum" />
										<input type="hidden" value="<%=gonum %>" name="gonum" />
										<input type="hidden" value="<%=ginum %>" name="ginum" />
										<input type="hidden" value="<%=pageNum %>" name="pageNum" />
										<div class="mb-3">
											<label class="form-label">카테고리</label>
											<select name="canum" class="form-select">
											<% for(CategoryDTO category : list) { %>
												<% if(category.getCanum() == dto.getCanum()) { %>
													<option value="<%=dto.getCanum()%>" selected><%=category.getCaname() %></option>
												<% } else { %>
													<option value="<%=dto.getCanum()%>"><%=category.getCaname() %></option>
												<% } %>
											<% } %>
											</select>
										</div>
										<div class="mb-3">
											<label class="form-label">상품명</label>
											<input type="text" name="gname" id="gname" value="<%=dto.getGname()%>" class="form-control form-control-lg"/>
										</div>
										<div class="mb-3">
											<label class="form-label">가격</label>
											<input type="number" name="gprice" id="gprice" value="<%=dto.getGprice()%>" class="form-control form-control-lg"/>
										</div>
										<div class="mb-3">
											<label class="form-label">브랜드 설명</label>
											<%
												String gplot = dto.getGplot();
												if(gplot == null) { %>
											<textarea name="gplot" class="form-control"></textarea>
												<% } else { %>
											<textarea name="gplot" class="form-control"><%=gplot %></textarea>
												<% } %>
										</div>
										<div class="mb-3">
											<label class="form-label">상품 설명</label>
											<% String gcontent = dto.getGcontent();
												if(gcontent != null) { %>
												<textarea name="gcontent"  class="form-control"><%=gcontent %></textarea>
											<% } else { %>
												<textarea name="gcontent"  class="form-control"></textarea>
											<% } %>
										</div>
										<div class="mb-3">
											<label class="form-label">할인율</label>
											<input type="number" name="discount" value="<%=dto.getDiscount()%>" class="form-control form-control-lg"/>
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
	<% } %>
</body>
</html>