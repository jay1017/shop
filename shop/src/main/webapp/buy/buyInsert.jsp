<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>   
<%@ page import="shop.goods.GoodsDTO" %> 
<%@ page import="shop.buy.BuyDAO" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="shop.member.MemberDTO" %>
<%@ page import="shop.member.MemberDAO" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="description" content="Male_Fashion Template">
    <meta name="keywords" content="Male_Fashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>ODEZ</title>
    <!-- Css Styles -->
    <link rel="stylesheet" href="/shop/resources/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="/shop/resources/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="/shop/resources/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="/shop/resources/css/magnific-popup.css" type="text/css">
    <link rel="stylesheet" href="/shop/resources/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="/shop/resources/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="/shop/resources/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="/shop/resources/css/style.css" type="text/css">
    <link rel="stylesheet" href="/shop/resources/css/font.css">
    
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
	<%
		String sid = (String) session.getAttribute("sid");
		if(sid == null) {
	%>
		<script>
			alert("로그인 후 이용 해 주세요.");
			location.href="/shop/member/loginForm.jsp";
		</script>
	<% } else { 
		int ccount = Integer.parseInt(request.getParameter("bcount"));
		String[] gnumArr = request.getParameterValues("gnum");
		
		List<Integer> gnumes = new ArrayList<>();
		
		for(String gnum : gnumArr) {
			gnumes.add(Integer.parseInt(gnum));
		}
		
		// 장바구니에 담기
		// 추후 작업
		
		BuyDAO dao = BuyDAO.getDAO();
		List<GoodsDTO> list = dao.selectGoodsList(gnumes);
		
		MemberDAO mdao = new MemberDAO();
		MemberDTO member = mdao.getInfo(sid);
	%>
	<jsp:include page="/include/header.jsp"></jsp:include>
	<!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__text">
                        <h4>주문서</h4>
                        <div class="breadcrumb__links">
                            <a href="/shop/main/main.jsp">메인</a>
                            <a href="/shop/goods/goodslist.jsp">상품</a>
                            <span>주문서</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->

    <!-- Checkout Section Begin -->
    <section class="checkout spad">
        <div class="container">
            <div class="checkout__form">
                <form action="buyInsertPro.jsp" method="post" onsubmit="checkBuy(event)">
                    <div class="row">
                        <div class="col-lg-8 col-md-6">
                            <h6 class="checkout__title">주문 상세</h6>
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="checkout__input">
                                        <p>이름</p>
                                        <input type="text" readonly value="<%= member.getMname() %>"/>
                                    </div>
                                </div>
                            </div>
                            <div class="checkout__input">
                                <p>주소<span>*</span></p>
                                <input type="text" placeholder="우편번호" name="zip" id="zip">
								<input type="button" onclick="zipFind()" value="우편번호 찾기" class="site-btn"><br>
								<input type="text" placeholder="주소" name="address" id="address"><br>
								<input type="text" placeholder="상세주소" name="address2" id="address2">
								<input type="text" placeholder="참고항목" name="address3" id="address3">
                            </div>
                            <script>
							    function zipFind() {
							    	new daum.Postcode({
							            oncomplete: function(data) {
							                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
							                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							                var addr = ''; // 주소 변수
							                var extraAddr = ''; // 참고항목 변수

							                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
							                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							                    addr = data.roadAddress;
							                } else { // 사용자가 지번 주소를 선택했을 경우(J)
							                    addr = data.jibunAddress;
							                }

							                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
							                if(data.userSelectedType === 'R'){
							                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
							                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
							                        extraAddr += data.bname;
							                    }
							                    // 건물명이 있고, 공동주택일 경우 추가한다.
							                    if(data.buildingName !== '' && data.apartment === 'Y'){
							                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
							                    }
							                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							                    if(extraAddr !== ''){
							                        extraAddr = ' (' + extraAddr + ')';
							                    }
							                    // 조합된 참고항목을 해당 필드에 넣는다.
							                    document.getElementById("address3").value = extraAddr;
							                
							                } else {
							                    document.getElementById("address3").value = '';
							                }

							                // 우편번호와 주소 정보를 해당 필드에 넣는다.
							                document.getElementById('zip').value = data.zonecode;
							                document.getElementById("address").value = addr;
							                // 커서를 상세주소 필드로 이동한다.
							                document.getElementById("address2").focus();
							            }
							        }).open();
							    }
							</script>
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="checkout__input">
                                        <p>휴대폰번호<span>*</span></p>
                                        <input type="text" name="" value="<%=member.getMphone()%>" readonly placeholder="휴대폰번호를 입력하세요.">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                            	<div class="col-lg-12">
                                    <div class="checkout__input">
                                        <p>이메일</p>
                                        <input type="text" value="<%=member.getMemail()%>" readonly placeholder="이메일을 입력하세요.">
                                    </div>
                                </div>
                            </div>
                            <div class="checkout__input">
                                <p>주문 시 메모</p>
                                <input type="text" placeholder="ex) 배송 전 연락 바랍니다." name="note">
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="checkout__order">
                                <h4 class="order__title">주문 내역</h4>
                                <div class="checkout__order__products">상품 <span>가격</span></div>
                                <ul class="checkout__total__products">
                                	<% 
                                		String[] bcountArr = request.getParameter("bcount").split(",");
                                		List<Integer> bcountList = new ArrayList<>();
                                		
                                		for(String b : bcountArr) {
                                			bcountList.add(Integer.parseInt(b));
                                		}
                                		
                                		int total = 0;
                               			String item_name = "";
                               			int totalCnt = list.size();
                                		NumberFormat numberFormat = NumberFormat.getNumberInstance(Locale.getDefault());
                                	%>
                                	<% for(int i = 0; i < list.size(); i++) { 
                                		GoodsDTO goods = list.get(i);
                                		int bcount = bcountList.get(i);
	                                    String gprice = numberFormat.format(goods.getGprice());
	                                    total += goods.getGprice();
	                                    if(i == list.size() - 1) {
	                                    	item_name += goods.getGname();
	                                    } else {
	                                    	item_name += goods.getGname() + ",";
	                                    }
                               		%>
                                		<li>
                                			<%=goods.getGname() %> (<%=bcount %> 개) 
                                			<span>&#8361; <%=gprice %></span>
                                			<input type="hidden" name="gnum" value="<%=goods.getGnum()%>"/>
                                			<input type="hidden" name="bcount" value="<%=bcount %>" />
                                		</li>
                                	<% } %>
                                </ul>
                                <ul class="checkout__total__all">
                                    <li>총 가격 <span>&#8361; <%=numberFormat.format(total) %></span></li>
                                </ul>
                                <div class="checkout__input__checkbox">
                                    <label for="accessOrder">
                                        상품 구매에 동의 하십니까?
                                        <input type="checkbox" id="accessOrder">
                                        <span class="checkmark"></span>
                                    </label>
                                </div>
                                <button type="submit" class="site-btn">주문하기</button>
                            </div>
                        </div>
                    </div>
                    <input type="hidden" name="item_name" id="item_name" value="<%=item_name%>"/>
                    <input type="hidden" name="quantity" id="quantity" value="<%=totalCnt%>"/>
                    <input type="hidden" name="total_amount" id="total_amount" value="<%=total%>"/>
                </form>
            </div>
        </div>
    </section>
    <script>
    	function checkBuy(event) {
    		var address = document.getElementById("address");
    		if(address.value == null || address.value == "") {
    			alert("주소를 입력 하세요");
    			event.preventDefault();
    			return false;
    		}
    		var accessOrder = document.getElementById("accessOrder");
    		if(!accessOrder.checked) {
    			alert("상품 구매에 동의 해 주세요.");
    			event.preventDefault();
    			return false;
    		}
    	}
    </script>
    <!-- Checkout Section End -->
    <jsp:include page="/include/footer.jsp"></jsp:include>
    <% } %>
</body>
</html>