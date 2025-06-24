<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="shop.main.MainDAO,shop.main.GoodsDTO,java.util.List"%>
 



<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>사이트 이름</title>

</head>
<body>

	<header>
		<div>
			<a href="">문의하기</a>
		</div>
		<div>
			<h1>사이트 이름</h1>
		</div>
		<div>
			<a href="">마이페이지</a> | <a href="/member/loginForm.jsp">로그인</a> | <a href="/member/memberForm.jsp">회원가입</a>
			| <a href="">장바구니</a> | <a href="">주문내역</a> | <a href="">로그아웃</a>
		</div>
	</header>

	<nav>
		<div>
			<a href="categories.jsp">카테고리별보기</a>
			<button>상의</button>
			<button>하의</button>
			<button>자켓</button>
			<button>스커트</button>
			<button>악세사리</button>
		</div>
	</nav>

	<div class="search">
		<input type="text" placeholder="검색어 입력">
		<button>검색</button>
		
		
	</div>
	인기 상품
	<div>
		
			
	</div>
	오늘의 상품
	<div>
	
	
	</div>

	
</body>
</html>