<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.goods.GoodsDTO" %>
<%@ page import="shop.goods.GoodsDAO" %>
<%@ page import="shop.goods.OptionDTO" %>
<%@ page import="shop.review.ReviewDTO" %>
<%@ page import="shop.review.ReviewDAO" %>
<%@ page import="shop.member.MemberDTO" %>
<%@ page import="shop.member.MemberDAO" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%--상품 상세정보--%>
<%
    request.setCharacterEncoding("UTF-8");
    String sid = (String) session.getAttribute("sid");
    int mnum=0;
    
    if(sid!=null) {
    MemberDAO mdao=new MemberDAO();
    MemberDTO mdto=mdao.getMidname(sid); 
    mnum=mdto.getMnum(); //회원 고유번호 받아오기
    }
    int gnum = Integer.parseInt(request.getParameter("gnum"));
    
    
    GoodsDAO dao = GoodsDAO.getDAO();
    GoodsDTO goods = dao.select(gnum);
    int ginum=goods.getGinum(); //상품 이미지 번호 조회
    int canum=goods.getCanum(); //상품 카테고리 번호 조회
    
   //리뷰 목록 조회
     //상품 리뷰 개수 가져오기
    
    String pageNum=request.getParameter("pageNum");
    if(pageNum==null) pageNum="1";

    int pageSize=8;
    int currentPage = Integer.parseInt(request.getParameter("pageNum") != null ? request.getParameter("pageNum") : "1");
    int startRow=(currentPage-1)*pageSize+1;
    int endRow=currentPage*pageSize;

    ReviewDAO rdao=ReviewDAO.getInstance(); //리뷰 DAO
    List<ReviewDTO> rlist=rdao.getReview(gnum,startRow,endRow);	//gnum인 리뷰목록 조회 
    int rcount=rdao.reviewCount(gnum); //리뷰의 개수 출력하는 메소드
   	

    
    System.out.println("상품번호: " + gnum);
    System.out.println("현재 페이지: " + currentPage);
    System.out.println("startRow = " + startRow + ", endRow = " + endRow);
    System.out.println("리뷰개수: " + rcount);
    
    
    
    ReviewDTO myReview=null;
    if(sid!=null) {
    	myReview=rdao.getUserReview(gnum,mnum); //본인 리뷰가 있는지 확인
    }
	
    // 포맷팅
    NumberFormat numberFormat = NumberFormat.getNumberInstance(Locale.getDefault());
    String gprice = numberFormat.format(goods.getGprice());
    String discount = numberFormat.format(goods.getDiscount());
    
    List<OptionDTO> list = dao.selectOption(goods.getGname()); 
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
    <link rel="stylesheet" href="/shop/resources/css/font-awesome.min.css" type="text/css"/>
</head>
<body>
	<jsp:include page="/include/header.jsp"></jsp:include>
    <!-- Shop Details Section Begin -->
    <section class="shop-details">
        <div class="product__details__pic">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="product__details__breadcrumb">
                            <a href="/shop/main/main.jsp">메인</a>
                            <a href="/shop/goods/goodslist.jsp">상품 목록</a>
                            <span>상품 상세</span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-3 col-md-3">
                        <ul class="nav nav-tabs" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" data-toggle="tab" href="#tabs-1" role="tab">
                                    <div class="product__thumb__pic set-bg" data-setbg="/shop/resources/image/<%=goods.getGiname() %>"></div>
                                </a>
                            </li>
                            <% if(goods.getGidetail1() != null) { %>
                            	<li class="nav-item">
	                                <a class="nav-link" data-toggle="tab" href="#tabs-2" role="tab">
	                                    <div class="product__thumb__pic set-bg" data-setbg="/shop/resources/image/<%=goods.getGidetail1() %>"></div>
	                                </a>
	                            </li>
                            <% } %>
                            <% if(goods.getGidetail2() != null) { %>
                            	<li class="nav-item">
	                                <a class="nav-link" data-toggle="tab" href="#tabs-3" role="tab">
	                                    <div class="product__thumb__pic set-bg" data-setbg="/shop/resources/image/<%=goods.getGidetail2() %>"></div>
	                                </a>
	                            </li>
                            <% } %>
                            <% if(goods.getGidetail3() != null) { %>
                            	<li class="nav-item">
	                                <a class="nav-link" data-toggle="tab" href="#tabs-4" role="tab">
	                                    <div class="product__thumb__pic set-bg" data-setbg="/shop/resources/image/<%=goods.getGidetail3() %>"></div>
	                                </a>
	                            </li>
                            <% } %>
                        </ul>
                    </div>
                    <div class="col-lg-6 col-md-9">
                        <div class="tab-content">
                            <div class="tab-pane active" id="tabs-1" role="tabpanel">
                                <div class="product__details__pic__item">
                                    <img src="/shop/resources/image/<%=goods.getGiname() %>" alt="">
                                </div>
                            </div>
                            <div class="tab-pane" id="tabs-2" role="tabpanel">
                                <div class="product__details__pic__item">
                                    <img src="/shop/resources/image/<%=goods.getGidetail1() %>" alt="">
                                </div>
                            </div>
                            <div class="tab-pane" id="tabs-3" role="tabpanel">
                                <div class="product__details__pic__item">
                                    <img src="/shop/resources/image/<%=goods.getGidetail2() %>" alt="">
                                </div>
                            </div>
                            <div class="tab-pane" id="tabs-4" role="tabpanel">
                                <div class="product__details__pic__item">
                                    <img src="/shop/resources/image/<%=goods.getGidetail3() %>" alt="">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="product__details__content">
            <div class="container">
                <div class="row d-flex justify-content-center">
                    <div class="col-lg-8">
                        <div class="product__details__text">
                            <h4><%=goods.getGname()%></h4>
                            <h3>&#8361; <%=discount %> <span><%=gprice %></span></h3>
                            <p><%=goods.getGplot()%></p>
                            <div class="product__details__option">
                                <div class="product__details__option__size">
                                    <span>사이즈:</span>
                                    <% for(OptionDTO dto : list) { %>
                                    <label id="<%=dto.getGosize()%>"><%=dto.getGosize() %>
                                    	<input type="radio" name="gonum" id="<%=dto.getGosize()%>" value="<%=dto.getGonum() %>">
                                    </label>
                                    <% } %>
                                </div>
                            </div>
                            <div class="product__details__cart__option" style="display: flex; justify-content: center;">
                            	<form action="/shop/cart/cartInsertPro.jsp" method="post" onsubmit="checkLogin(event)">
                            		<input type="hidden" value="<%=session.getAttribute("sid") %>" name="sid" />
                            		<input type="hidden" name="gonum" id="gonum1"/>
	                                <div class="quantity">
	                                    <div class="pro-qty">
	                                        <input type="text" value="1" name="ccount" id="ccount">
	                                    </div>
	                                </div>
                                	<input type="hidden" value="<%=goods.getGnum() %>" name="gnum"/>
                                	<input type="submit" value="장바구니 담기" class="primary-btn" style="border: none;"/>
                                </form>
                                <form action="/shop/buy/buyInsert.jsp" method="post" onsubmit="checkLogin(event)" style="margin-left: 20px;">
                                	<input type="hidden" value="<%=session.getAttribute("sid") %>" name="sid" />
                                	<input type="hidden" name="gonum" id="gonum2"/>
                                	<input type="hidden" name="bcount" id="bcount"/>
                                	<input type="hidden" value="<%=goods.getGnum() %>" name="gnum"/>
                                	<input type="submit" value="구매하기" class="primary-btn" style="border: none;"/>
                                </form>
                                <script>
                                	function checkLogin(event) {
                                		var sid = document.getElementById("sid");
                                		var ccount = document.getElementById("ccount");
                                		var bcount = document.getElementById("bcount");
                                		
                                		var gonum = document.getElementsByName("gonum");
                                		var gonum1 = document.getElementById("gonum1");
                                		var gonum2 = document.getElementById("gonum2");
                                		
                                		for(var i = 0; i < gonum.length; i++) {
                                			if(gonum[i].checked) {
                                				gonum1.value = gonum[i].value;
                                				gonum2.value = gonum[i].value;
                                			}
                                		}
                                		
                                		bcount.value = ccount.value;
                                		
                                		if(gonum1.value == null || gonum1.value == "" || gonum2.value == null || gonum2.value == "") {
                                			alert("상품 옵션을 선택 해 주세요.");
                                			event.preventDefault();
                                		}
                                		
                                		if(sid.value.trim() == 'null') {
                                			alert("로그인 이후 가능합니다.");
                                			event.preventDefault();
                                			location.href="/shop/member/loginForm.jsp";
                                		}
                                	}
                                </script>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row" style="margin-bottom: 40px;">
                    <div class="col-lg-12">
                        <div class="product__details__tab">
                            <ul class="nav nav-tabs" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" data-toggle="tab" href="#tabs-5" role="tab">상품 설명</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" data-toggle="tab" href="#tabs-6" role="tab">리뷰(<%=rcount%>)</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane active" id="tabs-5" role="tabpanel">
                                    <div class="product__details__tab__content">
                                        <div class="product__details__tab__content__item">
                                            <h5>상품 설명</h5>
                                            <p>
                                            	<% if(goods.getGcontent() != null) { %>
                                          			<%=goods.getGcontent() %>
                                            	<% } %>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane" id="tabs-6" role="tabpanel">
                                    <div class="product__details__tab__content">
                                        <div class="product__details__tab__content__item">
                                            <h5>리뷰 목록</h5>
                                            <%--여기에 작업--%>
                                            	<div>
                                            	<% if(sid!=null) { %>
                                            		<h5>리뷰 작성</h5>	
                                        			<form action="/shop/review/reviewPro.jsp" method="post">
														<input type="hidden" name="sid" value="<%=sid%>"/>
                                        				<input type="hidden" name="gnum" value="<%=gnum%>"/>
                                        				<input type="hidden" name="mnum" value="<%=mnum%>"/>
                                        				<input type="hidden" name="canum" value="<%=canum%>"/> 
                                        				<input type="hidden" name="ginum" value="<%=ginum%>"/>
                                        				<textarea name="rcontent" rows="4" cols="60" placeholder="리뷰를 입력하세요"></textarea><br> 
                                        				<input type="submit" value="작 성" class="primary-btn" style="border: none;"> 
                                        			</form>
                                        			<%}else{ %>
                                        			<p><a href="/shop/member/loginForm.jsp">로그인</a> 후 리뷰를 작성할 수 있습니다.</p> <%--로그인 안되있으면 내 리뷰뜨는 공간에 로그인 링크뜹니다 --%>
                                        			<%} %>
                                        		</div>
											<% if(rlist != null && !rlist.isEmpty()) {
											        for(ReviewDTO dto : rlist){
											            int rnum = dto.getRnum();         // 리뷰 번호
											            String mname = dto.getMname();   // 작성자 이름
											%>
											    <div id="review-<%= rnum %>">
											        <!-- 작성자 이름과 리뷰 내용 출력 -->
											        
											            <strong><%= mname %></strong><br>
											            <div id="rcontent-<%= rnum %>" 
											            style="white-space: pre-wrap; padding: 10px; border: 1px solid #ccc; font-size: 16px;"><p><%= dto.getRcontent() %></p></div>
											        <% 
											            // 세션에 로그인된 사용자 ID와 리뷰 작성자 ID가 같은 경우에만 버튼 출력
											            if(sid != null && sid.equals(dto.getMid())) { 
											        %>
											            <!-- 수정 버튼 (자바스크립트로 이 리뷰 블록을 수정폼으로 바꿈) -->
											            <button onclick="enableEdit(<%= rnum %>,'<%=mname%>')" class="primary-btn" style="border: none;">수 정</button>
											
											            <!-- 삭제 버튼 (폼 submit 방식) -->
											            <form method="post">
											                <input type="hidden" name="mnum" value="<%= dto.getMnum() %>">
											                <input type="hidden" name="rnum" value="<%= dto.getRnum() %>">
											                <input type="hidden" name="gnum" value="<%= dto.getGnum() %>">
											                <input type="hidden" name="ginum" value="<%= dto.getGinum() %>">
											                <input type="hidden" name="rcontent" value="<%= dto.getRcontent() %>">
											                <input type="submit" name="delete" value="삭 제" 
											                       formaction="/shop/review/reviewDelete.jsp" 
											                       class="primary-btn" style="border: none;">
											            </form>
											        <% } %>
											    </div>
											<% 
											        }
											    } else { 
											%>
											    <p>등록된 리뷰가 없습니다</p>
											<% } %>
                                            									
										</div>
                                    </div>
                                    <%
							        int pageCount = rcount / pageSize + (rcount % pageSize == 0 ? 0 : 1);
							        int pageBlock = 5;
							        int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
							        int endPage = startPage + pageBlock - 1;
							        if (endPage > pageCount) endPage = pageCount;
							        %>
							
							        <div id="reviewSection" class="text-center mt-4">
							            <% if (startPage > pageBlock) { %>
							                <a href="javascript:review('<%=gnum %>', '<%= startPage - 1 %>');">◀ 이전</a>
							            <% } %>
							
							            <% for (int i = startPage; i <= endPage; i++) { %>
							                <% if (i == currentPage) { %>
							                    <strong>[<%= i %>]</strong>
							                <% } else { %>
							                    <a href="javascript:review('<%=gnum %>','<%=i %>')">[<%= i %>]</a>
							                <% } %>
							            <% } %>
							
							            <% if (endPage < pageCount) { %>
							                <a href="javascript:review('<%=gnum %>','<%=endPage + 1 %>')">다음 ▶</a>
							            <% } %>
							        </div>
							        <script>
							        	function review (gnum,page) {
							        		fetch(`/shop/review/reviewPagePro.jsp?gnum=${gnum}&page=${page}`);
							        		.then(function(response){
							        			return response.json();
							        		})
							        		.then(function(data){
							        			console.log(data);
							        			//document.getElementById("reviewSection").innerHTML=data;
							        		});
							        	}
							        </script>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%--페이징 처리 --%>
        </div>
    </section>
    <!-- Shop Details Section End -->
    <%--${}의 의미는 스크립트에서 변수를 출력하는것 자바에서 <%=%>랑 같다--%>
    <jsp:include page="/include/footer.jsp"></jsp:include>
	<script src="/shop/resources/js/jquery.nice-select.min.js"></script>
	<script src="/shop/resources/js/jquery.nicescroll.min.js"></script>
	<script src="/shop/resources/js/jquery.magnific-popup.min.js"></script>
	<script src="/shop/resources/js/jquery.countdown.min.js"></script>
	<script src="/shop/resources/js/jquery.slicknav.js"></script>
	<script src="/shop/resources/js/mixitup.min.js"></script>
	<script src="/shop/resources/js/owl.carousel.min.js"></script>
	<script src="/shop/resources/js/main.js"></script>
    <script src="/shop/resources/js/review.js"></script>
    <script src="/shop/resources/js/jquery-3.3.1.min.js"></script>
	<script src="/shop/resources/js/bootstrap.min.js"></script>
</body>
</html>
