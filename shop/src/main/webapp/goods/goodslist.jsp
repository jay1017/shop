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
	  GoodsListDAO dao = GoodsListDAO.getInstance(); // DAO 객체 생성
    List<GoodsListDTO> goodsList = dao.getGoods(); // 전체 상품 목록 가져오기
	%>
    <header>
<title>상품 전체 목록</title>
</header>

<h1>상품목록</h1>
<h2>전체 상품 목록</h2>
    <div>
        <%
            if (goodsList != null && !goodsList.isEmpty()) {
                for (GoodsListDTO dto : goodsList) {
                	int gprice = dto.getGprice();
        			int discount = dto.getDiscount();
        			int disprice;
        			if (discount != 0) {
        				disprice = gprice - (gprice * discount / 100);
        			}else{
        				 disprice = gprice;
        			}
        %>
                    <div>
                        <h3><%= dto.getGname() %></h3>
                        <p>가격: <%= dto.getGprice() %>원</p>
                        <p>할인: <%= dto.getDiscount() %>%</p>
                        <p>판매가 :<%=disprice %> 
                        <p>설명: <%= dto.getGplot() %></p>
                        <!-- 필요시 이미지 번호(dto.getGinum())로 이미지 불러오기 -->
                    </div>
        <%
                }
            } else {
        %>
                <p>등록된 상품이 없습니다.</p>
        <%
            }
        %>