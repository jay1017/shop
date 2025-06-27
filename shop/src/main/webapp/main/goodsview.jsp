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
        <img src="<%= request.getContextPath() %>/resources/image/<%= idto.getGiname() %>" width="300" />
    
    </div>

    <%--상품의 가격을 표시,할인된 가격이 있다면 원가에 취소선을 긋고 할인된 가격을 표시 --%>
    <div>
        <h2><%=dto.getGname()%></h2>
        <% if (discount != 0) { %>		
            <span style="text-decoration: line-through;"><%=gprice%>원</span><br>
            <strong><%=disprice%>원</strong>
        <% } else { %>  
            <strong><%=gprice%>원</strong>
        <% } %>
    </div>

    <%--옵션 선택 칸,select를 이용해서 옵션을 한번에 출력합니다 --%>
    <div>
        <label>옵션 선택:</label>
        <select id="optionSelect" onchange="setOptionValues()">
            <% for (GoodsOptionDTO odto : olist) { %>	<%-- --%>
                <option value="<%=odto.getGonum()%>,<%=odto.getGocolor()%>,<%=odto.getGosize()%>"> 
                <%--원래 value 에는 하나의 문자열만이 들어갑니다 그래서
                ,를 써서 odto.getGonum(),odto.getGocolor(),odto.getGosize()를 하나의 문자열로 변환합니다 이는 나중에 스크립트에서 다시 ,를 기준으로
                분할됩니다 --%>
                    <%=odto.getGosize()%> / <%=odto.getGocolor()%> / 재고: <%=odto.getGocount()%> <%--여기는 화면상에 표시되는 값입니다 --%>
                </option>
            <% } %>
        </select>
    </div>

    <%--장바구니로 값을 넘기는 폼입니다 --%>
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

        <%-- 옵션값 에 대한 처리입니다  --%>
        <input type="hidden" name="gonum" id="cartGonum">
        <input type="hidden" name="gocolor" id="cartGocolor">
        <input type="hidden" name="gosize" id="cartGosize">

        <input type="submit" value="장바구니">
    </form>

        <%--  구매페이지로 값을 넘깁니다  --%>
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

        <%-- 여기도 옵션값 에 대한 처리입니다  --%>
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
   
	<img src="<%= request.getContextPath() %>/resources/image/<%= idto.getGidetail1() %>" />
	<img src="<%= request.getContextPath() %>/resources/image/<%= idto.getGidetail2() %>" />
	<img src="<%= request.getContextPath() %>/resources/image/<%= idto.getGidetail3() %>" />
    

<% } %>

<!-- JavaScript: 옵션 선택 시 hidden 값 설정 -->
<script>
function setOptionValues() {
    const selected = document.getElementById("optionSelect").value; //위에서 합친 문자열을 받아옵니다 id=optionSelect인 value를 가져온다는 뜻입니다
    const [gonum, gocolor, gosize] = selected.split(",");  //여기서 위에서 합친 문자열을 다시 ,를 기준으로 분리합니다
    //여기서 selected는 선택한 <option>의 value 값을 문자열로 받는건데 이 값은 한 번만 읽고 끝나는 용도니까  이후에 selected의 값을 바꿀 필요가 없습니다.

    // 장바구니용 hidden
    document.getElementById("cartGonum").value = gonum;	//id가 "cartGonum"인 것의 값에 gonum을 대입한다는 뜻입니다 밑에는 다 같은의미
    document.getElementById("cartGocolor").value = gocolor;
    document.getElementById("cartGosize").value = gosize;

    // 구매용 hidden
    document.getElementById("purchaseGonum").value = gonum;
    document.getElementById("purchaseGocolor").value = gocolor;
    document.getElementById("purchaseGosize").value = gosize;
}

// 페이지가 처음로드될때 setOptionValues함수가 자동으로 실행됩니다
window.onload = setOptionValues;
</script>

</body>
</html>
