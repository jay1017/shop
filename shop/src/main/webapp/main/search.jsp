<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="shop.main.MainDAO,shop.main.GoodsDTO,java.util.List"%>
<%@ page import="shop.admin.GoodsImageDTO,shop.admin.GoodsImageDAO" %>



<%
MainDAO dao = MainDAO.getInstance();
String key = request.getParameter("key"); //검색 결과 입력값 가져오기
if(key==null) key="";

GoodsImageDAO idao = GoodsImageDAO.getDAO(); //이미지 dao 

String pageNum=request.getParameter("pageNum");
if(pageNum==null) pageNum="1";

int pageSize=8;
int currentPage = Integer.parseInt(request.getParameter("pageNum") != null ? request.getParameter("pageNum") : "1");
int startRow=(currentPage-1)*pageSize+1;
int endRow=currentPage*pageSize;

List<GoodsDTO> list = dao.search(key,startRow,endRow); //검색된 상품정보를 가져옴
int count=dao.searchCount(key);
%>

<%
System.out.println("검색 키워드: " + key);
System.out.println("현재 페이지: " + currentPage);
System.out.println("startRow = " + startRow + ", endRow = " + endRow);
System.out.println("검색된 상품 수: " + list.size());
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>검색</title>
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
<%--검색된 상품의 목록--%>
</head>
<body>
	<jsp:include page="/include/header.jsp"></jsp:include>
	<%-- <jsp:include page="/include/menu.jsp"></jsp:include> --%> 
	
            <!-- 상품 그리드 시작 -->
    <div class="container">
      <div class="row product__filter">
        <% 
          for (GoodsDTO dto : list) {
              int ginum = dto.getGinum();
              GoodsImageDTO gi = idao.select(ginum); 
              String giname = gi.getGiname();
        %>
          <div class="col-lg-3 col-md-4 col-sm-6 mix popular mb-4">
            <div class="product__item">
              <a href="/shop/goods/goodsview.jsp?gnum=<%= dto.getGnum() %>">
                <div class="product__item__pic set-bg" data-setbg="/shop/resources/image/<%= giname %>">
                  <span class="label">검색결과</span>
                </div>
              </a>
              <div class="product__item__text">
                <h6><%= dto.getGname() %></h6>
                <a href="#" class="add-cart">+ Add To Cart</a>
                <div class="rating">
                  <i class="fa fa-star-o"></i><i class="fa fa-star-o"></i>
                  <i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i>
                </div>
                <h5>&#8361;<%= dto.getGprice() %></h5>
                <div class="product__color__select">
                  <label for="pc-<%= dto.getGnum() %>a"><input type="radio" id="pc-<%= dto.getGnum() %>a"></label>
                  <label class="active black" for="pc-<%= dto.getGnum() %>b"><input type="radio" id="pc-<%= dto.getGnum() %>b"></label>
                  <label class="grey" for="pc-<%= dto.getGnum() %>c"><input type="radio" id="pc-<%= dto.getGnum() %>c"></label>
                </div>
              </div>
            </div>
          </div>
        <% } %>
      </div>
      <%--페이징 처리 --%>
        <%
        int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
        int pageBlock = 5;
        int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
        int endPage = startPage + pageBlock - 1;
        if (endPage > pageCount) endPage = pageCount;
        %>

        <div class="text-center mt-4">
            <% if (startPage > pageBlock) { %>
                <a href="search.jsp?key=<%= key %>&pageNum=<%= startPage - 1 %>">◀ 이전</a>
            <% } %>

            <% for (int i = startPage; i <= endPage; i++) { %>
                <% if (i == currentPage) { %>
                    <strong>[<%= i %>]</strong>
                <% } else { %>
                    <a href="search.jsp?key=<%= key %>&pageNum=<%= i %>">[<%= i %>]</a>
                <% } %>
            <% } %>

            <% if (endPage < pageCount) { %>
                <a href="search.jsp?key=<%= key %>&pageNum=<%= endPage + 1 %>">다음 ▶</a>
            <% } %>
        </div>
    </div>
	
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
	<jsp:include page="/include/footer.jsp"></jsp:include>
</body>


</html>
