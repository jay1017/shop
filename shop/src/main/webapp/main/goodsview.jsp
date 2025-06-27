<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.main.GoodsDTO,shop.main.MainDAO,java.util.List" %>
<%@ page import="shop.main.GoodsOptionDTO" %>
<%@ page import="shop.admin.GoodsImageDAO,shop.admin.GoodsImageDTO" %>

<%
    request.setCharacterEncoding("UTF-8");
    String sid = (String) session.getAttribute("sid");

    int gnum = Integer.parseInt(request.getParameter("gnum"));
    int ginum = Integer.parseInt(request.getParameter("ginum"));

    MainDAO dao = MainDAO.getInstance();
    GoodsImageDAO idao = GoodsImageDAO.getDAO();

    dao.increaseGread(gnum);

    List<GoodsDTO> list = dao.getGoods(gnum);
    List<GoodsOptionDTO> olist = dao.getGoodsOption(gnum);
    GoodsImageDTO idto = idao.select(ginum);

    int mnum = dao.getMnum(sid);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>상품 상세 페이지</title>
    <link rel="stylesheet" href="/shop/resources/css/font.css">
</head>
<body>

<%
for (GoodsDTO dto : list) {
    int gprice = dto.getGprice();
    int discount = dto.getDiscount();
    int disprice = gprice;
    if (discount != 0) {
        disprice = gprice - (gprice * discount / 100);
    }
%>

    <!-- 상품 이미지 -->
    <div>
        <img src="/shop/resources/image/<%=idto.getGiname()%>" width="300">
    </div>

    <!-- 상품명 + 가격 -->
    <div>
        <h2><%=dto.getGname()%></h2>
        <% if (discount != 0) { %>		<%--취소선 나옴 --%>
            <span style="text-decoration: line-through;"><%=gprice%>원</span><br>
            <strong><%=disprice%>원</strong>
        <% } else { %>  
            <strong><%=gprice%>원</strong>
        <% } %>
    </div>

    <!-- 옵션 선택 -->
    <div>
        <label>옵션 선택:</label>
        <select id="optionSelect" onchange="setOptionValues()">
            <% for (GoodsOptionDTO odto : olist) { %>
                <option value="<%=odto.getGonum()%>,<%=odto.getGocolor()%>,<%=odto.getGosize()%>">
                    <%=odto.getGosize()%> / <%=odto.getGocolor()%> / 재고: <%=odto.getGocount()%>
                </option>
            <% } %>
        </select>
    </div>

    <!-- 장바구니 폼 -->
    <form action="cart.jsp" method="post" id="cartForm">
        <input type="hidden" name="mnum" value="<%=mnum%>">
        <input type="hidden" name="gnum" value="<%=dto.getGnum()%>">
        <input type="hidden" name="canum" value="<%=dto.getCanum()%>">
        <input type="hidden" name="ginum" value="<%=dto.getGinum()%>">
        <% if (discount != 0) { %>
            <input type="hidden" name="gprice" value="<%=disprice%>">
        <% } else { %>
            <input type="hidden" name="gprice" value="<%=dto.getGprice()%>">
        <% } %>

        <!-- 옵션 정보 -->
        <input type="hidden" name="gonum" id="cartGonum">
        <input type="hidden" name="gocolor" id="cartGocolor">
        <input type="hidden" name="gosize" id="cartGosize">

        <input type="submit" value="장바구니">
    </form>

    <!-- 구매 폼 -->
    <form action="purchase.jsp" method="post" id="purchaseForm">
        <input type="hidden" name="mnum" value="<%=mnum%>">
        <input type="hidden" name="gnum" value="<%=dto.getGnum()%>">
        <input type="hidden" name="canum" value="<%=dto.getCanum()%>">
        <input type="hidden" name="ginum" value="<%=dto.getGinum()%>">
        <% if (discount != 0) { %>
            <input type="hidden" name="gprice" value="<%=disprice%>">
        <% } else { %>
            <input type="hidden" name="gprice" value="<%=dto.getGprice()%>">
        <% } %>

        <!-- 옵션 정보 -->
        <input type="hidden" name="gonum" id="purchaseGonum">
        <input type="hidden" name="gocolor" id="purchaseGocolor">
        <input type="hidden" name="gosize" id="purchaseGosize">

        <input type="submit" value="구매하기">
    </form>

    <!-- 상품 설명 -->
    <div>
        <%=dto.getGcontent()%>
    </div>

    <!-- 상세 이미지들 -->
    <div><img src="/shop/resources/image/<%=idto.getGidetail1()%>" width="300"></div>
    <div><img src="/shop/resources/image/<%=idto.getGidetail2()%>" width="300"></div>
    <div><img src="/shop/resources/image/<%=idto.getGidetail3()%>" width="300"></div>

<% } %>

<!-- JavaScript: 옵션 선택 시 hidden 값 설정 -->
<script>
function setOptionValues() {
    const selected = document.getElementById("optionSelect").value;
    const [gonum, gocolor, gosize] = selected.split(",");

    // 장바구니용 hidden
    document.getElementById("cartGonum").value = gonum;
    document.getElementById("cartGocolor").value = gocolor;
    document.getElementById("cartGosize").value = gosize;

    // 구매용 hidden
    document.getElementById("purchaseGonum").value = gonum;
    document.getElementById("purchaseGocolor").value = gocolor;
    document.getElementById("purchaseGosize").value = gosize;
}

// 페이지 로드 시 기본 옵션 적용
window.onload = setOptionValues;
</script>

</body>
</html>
