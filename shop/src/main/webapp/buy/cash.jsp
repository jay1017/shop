<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script>
    function onCash(){
    	alert("구매 완료");
    	history.go(-1);
    }
    </script>
<title>구매 페이지</title>
<h1>구매,결제</h1>
<%--구매버튼 누르면 해당상품 나오게하기
cart 에서 누르면 안에 상품들 다 나오게 하기
구매된 상품들은 cart.jsp 에서 삭제되게 하기--%>
<%--총 결제금액 + 버튼--%>

<input type="button" value="결제" onclick="onCash()">

