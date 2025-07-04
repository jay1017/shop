<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <style>
.sidebar {
	position: fixed; /* ← 핵심 */
	top: 200px; /* 화면 위에서 떨어진 거리 */
	right: 20px; /* 오른쪽에 고정 */
	width: 120px; /* 원하는 너비로 조정 */
	padding: 1em;
	background: #e4e4e4;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
	display: flex;
    flex-direction: column; /* ← 세로정렬! */
    gap: 10px;               
}
</style>
    
<div class="sidebar">
	<input type="button" value="홈" onclick="location.href='/shop/main/main.jsp'"> 
	<input type="button" value="검색" onclick="location.href='/shop/main/search.jsp'"> 
	<input type="button" value="장바구니" onclick="location.href='/shop/cart/cart.jsp'">
	<input type="button" value="구매내역" onclick="location.href='/shop/buy/buy.jsp'">
	<input type="button" value="⇧" onclick="window.scrollTo(0,0)">
	<input type="button" value="⇩" onclick="window.scrollTo(0,document.body.scrollHeight)">
	<input type="button" value="고객센터" onclick="location.href='ascenter.jsp'">
</div>