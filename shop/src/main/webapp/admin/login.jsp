<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<main class="d-flex w-100">
		<div class="container d-flex flex-column">
			<div class="row vh-100">
				<div class="col-sm-10 col-md-8 col-lg-6 mx-auto d-table h-100">
					<div class="d-table-cell align-middle">
						<div class="text-center mt-4">
							<h1 class="h2">어드민 페이지</h1>
							<p class="lead">
								관리자로 로그인을 진행 해 주세요.
							</p>
						</div>
						<div class="card">
							<div class="card-body">
								<div class="m-sm-4">
									<div class="text-center">
										<img src="/shop/resources/img/login.jpg" alt="Charles Hall" class="img-fluid" width="132" height="132" />
									</div>
									<form action="loginPro.jsp" method="post" onsubmit="checkLogin(event)">
										<div class="mb-3">
											<label class="form-label">아이디</label>
											<input class="form-control form-control-lg" type="text" name="mid" id="mid" placeholder="아이디를 입력하세요." />
										</div>
										<div class="mb-3">
											<label class="form-label">비밀번호</label>
											<input class="form-control form-control-lg" type="password" name="mpw" id="mpw" placeholder="비밀번호를 입력하세요." />
										</div>
										<div class="text-center mt-3">
											<input type="submit" value="로그인" class="btn btn-lg btn-primary">
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
</body>
</html>