<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.goods.GoodsListDAO" %>
<%@ page import="shop.goods.GoodsListDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%-- goodslist = 전체 상품 주르륵 나오게하기

size 는 distict 로 중복제거 후 다 나오게 하기
color 는 빼고 
	할거하고 시작--%>
	<% 
	request.setCharacterEncoding("UTF-8");
	  GoodsListDAO dao = GoodsListDAO.getInstance(); // DAO 불러오고
   
    int pageSize = 15; //한 화면에 보여줄 상품 갯수
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1"; //페이지 번호가 없다면 기본값 1
	}
	int currentPage = Integer.parseInt(pageNum);
	int start = (currentPage - 1) * pageSize + 1; //2번 페이지로 갈 경우 11부터 시작
	int end = currentPage * pageSize; // 11~20까지
	int count = dao.getGoodsCount(); //전체 상품 수
	List<GoodsListDTO> goodsList = dao.getGoods(start, end); 
	int pageCount = (count/pageSize) + (count % pageSize == 0 ? 0 : 1);
	int pageBlock = 5; // 한 화면에 보여줄 페이지 링크 수
	int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
	int endPage = startPage + pageBlock - 1;
	if(endPage > pageCount) endPage = pageCount;
	%> 
<html>
<title>상품 전체 목록</title>

<body>
<jsp:include page="/include/header.jsp" />
<h1>상품목록</h1>
<h2>전체 상품 목록</h2>
    <div>
        <%
            if (goodsList != null && !goodsList.isEmpty()) {
                for (GoodsListDTO dto : goodsList) {
        %>
                    <div>
                       <a href="/shop/goods/goodsview.jsp?gnum=<%=dto.getGnum()%>"> <h3><%= dto.getGname() %></h3></a>
                        <img src="<%=dto.getGiname() %>" alt="상품 이미지">
                        <p>가격: <%= dto.getGprice() %>원</p>
                        <p>판매가 :<%=dto.getDiscount() %>원</p> 
                        <input type="hidden" name="gnum" value="<%=dto.getGnum()%>">
                    	<input type="hidden" name="ginum" value="<%=dto.getGinum() %>">
                    </div>
        <%
                }
            } else {
        %>
                <p>등록된 상품이 없습니다.</p>
        <%
            }
        %>
        </div>
        <div >
			 <% if (startPage > 1) { %>
        <a href="goodslist.jsp?pageNum=<%= startPage - 1 %>">[이전]</a>
    <% } %>

    <% for (int i = startPage; i <= endPage; i++) {
           if (i == currentPage) { %>
               <b>[<%= i %>]</b>
        <% } else { %>
               <a href="goodslist.jsp?pageNum=<%= i %>">[<%= i %>]</a>
        <% }
       } %>

    <% if (endPage < pageCount) { %>
        <a href="goodslist.jsp?pageNum=<%= endPage + 1 %>">[다음]</a>
    <% } %>
			<form action="/shop/main/search.jsp" method="get">
  <input type="text" placeholder="검색어 입력">
  <button type="submit">검색</button>
</form>
		</div>
		<jsp:include page="/include/footer.jsp" />
</body>
</html>
		