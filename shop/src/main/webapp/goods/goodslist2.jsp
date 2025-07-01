<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="shop.goods.GoodsListDAO"%>
<%@ page import="shop.goods.GoodsListDTO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<%-- goodslist = 전체 상품 주르륵 나오게하기

size 는 distict 로 중복제거 후 다 나오게 하기
color 는 빼고 
	할거하고 시작--%>
<%
request.setCharacterEncoding("UTF-8");
GoodsListDAO dao = GoodsListDAO.getInstance(); // DAO 불러오고

int pageSize = 15; //한 화면에 보여줄 상품 갯수
String pageNum = request.getParameter("pageNum");
if (pageNum == null) {
	pageNum = "1"; //페이지 번호가 없다면 기본값 1
}
int currentPage = Integer.parseInt(pageNum);
int start = (currentPage - 1) * pageSize + 1; //2번 페이지로 갈 경우 11부터 시작
int end = currentPage * pageSize; // 11~20까지
int count = dao.getGoodsCount(); //전체 상품 수
List<GoodsListDTO> goodsList = dao.getGoods(start, end);
int pageCount = (count / pageSize) + (count % pageSize == 0 ? 0 : 1);
int pageBlock = 5; // 한 화면에 보여줄 페이지 링크 수
int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
int endPage = startPage + pageBlock - 1;
if (endPage > pageCount)
	endPage = pageCount;
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="description" content="Male_Fashion Template">
<meta name="keywords" content="Male_Fashion, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>ODEZ</title>
<link rel="stylesheet" href="/shop/resources/css/font.css" />
<link rel="stylesheet" href="/shop/resources/css/bootstrap.min.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/elegant-icons.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/magnific-popup.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/nice-select.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/owl.carousel.min.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/slicknav.min.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/style.css"
	type="text/css">
<body>
	<jsp:include page="/include/header.jsp" />
	<h1>상품목록</h1>
	<h2>전체 상품 목록</h2>
	<div>
		<div class="container">
  			<div class="row">
		<%
		if (goodsList != null && !goodsList.isEmpty()) {
			for (GoodsListDTO dto : goodsList) {
		%>
		 <div class="col-lg-4 col-md-6 col-sm-6 mb-4">
      <div class="card h-100">
        <img src="/shop/upload/<%=dto.getGiname()%>" class="card-img-top" alt="상품 이미지">
        <div class="card-body">
          <h5 class="card-title"><%= dto.getGname() %></h5>
          <p class="card-text"><%= dto.getGprice() %>원</p>
          <div class="rating mb-2">
            <i class="fa fa-star-o"></i>
            <i class="fa fa-star-o"></i>
            <i class="fa fa-star-o"></i>
            <i class="fa fa-star-o"></i>
            <i class="fa fa-star-o"></i>
          </div>
          <a href="#" class="btn btn-outline-primary btn-sm w-100">+ 장바구니 담기</a>
        </div>
      </div>
    </div>
    <%
      }
    %>
    </div>
  </div>
</div>
		<%
		}
		 else {
		%>
		<p>등록된 상품이 없습니다.</p>
		<%
		}
		%>
	</div>
	<div>
		<%
		if (startPage > 1) {
		%>
		<a href="goodslist2.jsp?pageNum=<%=startPage - 1%>">[이전]</a>
		<%
		}
		%>

		<%
		for (int i = startPage; i <= endPage; i++) {
			if (i == currentPage) {
		%>
		<b>[<%=i%>]
		</b>
		<%
		} else {
		%>
		<a href="goodslist2.jsp?pageNum=<%=i%>">[<%=i%>]
		</a>
		<%
		}
		}
		%>

		<%
		if (endPage < pageCount) {
		%>
		<a href="goodslist2.jsp?pageNum=<%=endPage + 1%>">[다음]</a>
		<%
		}
		%>
		<form action="/shop/main/search.jsp" method="get">
			<input type="text" placeholder="검색어 입력">
			<button type="submit">검색</button>
		</form>
	</div>
	<jsp:include page="/include/footer.jsp" />
	<script src="/shop/resources/js/jquery-3.3.1.min.js"></script>
	<script src="/shop/resources/js/bootstrap.min.js"></script>
	<script src="/shop/resources/js/jquery.nice-select.min.js"></script>
	<script src="/shop/resources/js/jquery.nicescroll.min.js"></script>
	<script src="/shop/resources/js/jquery.magnific-popup.min.js"></script>
	<script src="/shop/resources/js/jquery.countdown.min.js"></script>
	<script src="/shop/resources/js/jquery.slicknav.js"></script>
	<script src="/shop/resources/js/mixitup.min.js"></script>
	<script src="/shop/resources/js/owl.carousel.min.js"></script>
	<script src="/shop/resources/js/main.js"></script>

</body>
</html>
