<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.category.CategoryDTO" %>
<%@ page import="shop.category.CategoryDAO" %>
<%@ page import="shop.chat.ChatCateDTO" %>
<%@ page import="shop.chat.ChatBotDAO" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<!-- Offcanvas Menu Begin -->
<div class="offcanvas-menu-overlay"></div>
<div class="offcanvas-menu-wrapper">
    <div class="offcanvas__option">
        <div class="offcanvas__links">
            <a href="#">로그인</a>
            <a href="#">문의게시판</a>
        </div>
    </div>
    <div class="offcanvas__nav__option">
        <a href="#" class="search-switch"><img src="/shop/resources/img/icon/search.png" alt=""></a>
        <a href="#"><img src="/shop/resources/img/icon/heart.png" alt=""></a>
        <a href="#"><img src="/shop/resources/img/icon/cart.png" alt=""> <span>0</span></a>
    </div>
    <div id="mobile-menu-wrap"></div>
    <div class="offcanvas__text">
        <p>오데즈에 오신 여러분을 환영합니다.</p>
    </div>
</div>
<!-- Offcanvas Menu End -->

<!-- Header Section Begin -->
<header class="header">
    <div class="header__top">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-7">
                    <div class="header__top__left">
                        <p>오데즈에 오신 여러분을 환영합니다.</p> 
                    </div>
                </div>
                <div class="col-lg-6 col-md-5">
                    <div class="header__top__right">
                        <div class="header__top__links">
                        	<%
                        		String sid = (String)session.getAttribute("sid");
                        		if(sid != null) {%>
                        			<a href="/shop/member/logoutForm.jsp">로그아웃</a>
                        			<a href="/shop/member/memberInfo.jsp">마이페이지</a>
                        		<% } else { %>
                        			<a href="/shop/member/loginForm.jsp">로그인</a>
                        		<% } %>
                            <a href="/shop/qna/qnaList.jsp">문의게시판</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-lg-3 col-md-3">
                <div class="header__logo">
                    <a href="/shop/main/main.jsp"><img src="/shop/resources/img/logo.png" alt="" style="width: 110px;"></a>
                </div>
            </div>
            <div class="col-lg-6 col-md-6">
                <nav class="header__menu mobile-menu">
                	<%
                		CategoryDAO dao = CategoryDAO.getDAO();
                		List<CategoryDTO> list = dao.selectList(); 
                	%>
                    <ul>
                        <li><a href="/shop/main/main.jsp">메인</a></li>
                        <li><a href="/shop/goods/goodslist.jsp">상품</a>
                        	<ul class="dropdown">
                        		<% for(CategoryDTO dto : list) { %>
                        			<li><a href="/shop/goods/goodslist.jsp?canum=<%=dto.getCanum()%>"><%=dto.getCaname() %></a></li>
                        		<% } %>
                                <li><a href="/shop/goods/goods.jsp">상품 목록</a></li>
                                <li><a href="/shop/cart/cart.jsp">장바구니</a></li>
                                <li><a href="./checkout.html">주문서</a></li>
                            </ul>
                        </li>
                        <li><a href="/shop/about/about.jsp">회사 소개</a></li>
                    </ul>
                </nav>
            </div>
            <div class="col-lg-3 col-md-3">
                <div class="header__nav__option">
                    <a href="#" class="search-switch"><img src="/shop/resources/img/icon/search.png" alt=""></a>
                    <a href="#"><img src="/shop/resources/img/icon/heart.png" alt=""></a>
                    <a href="#"><img src="/shop/resources/img/icon/cart.png" alt=""> <span>0</span></a>
                </div>
            </div>
        </div>
        <div class="canvas__open"><i class="fa fa-bars"></i></div>
        <div class="chatbot-wrap">
        	<a href="#" id="chatBot"><i class="fa fa-commenting-o"></i></a>
	        <!-- ChatBot display -->
			<div id="chatBotBox" class="chat-container">
				<div class="chat-box" id="chat-box">
					<div class="bot-message">안녕하세요. 무엇을 도와드릴까요?</div>
					<div id="msgType">
						<button onclick="findQuestion('배송', this)" class="primary-btn chatbotBtn mr-2">배송</button>
						<button onclick="findQuestion('반품', this)" class="primary-btn chatbotBtn mr-2">반품</button>
					</div>
					<script>
						// 전역 변수 생성
						let idx = 0;
						let idx2 = 0;
						let idx3 = 0;
						
						// 질문을 찾아주는 메소드
						function findQuestion(cate, button){
							// 사용자가 클릭한 내용 출력
							const chatbox = document.getElementById("chat-box");
							const user = document.createElement("div");
							const category = cate;
							user.classList.add('user-message');
							user.innerHTML = category;
							chatbox.appendChild(user);
							
							// 사용자가 누르면 버튼 비활성화
							const msg = document.getElementById("msgType");
							const mc = msg.childNodes;
							for(let i = 0; i < mc.length; i++) {
								button.classList.add('hide');
								button.nextElementSibling.classList.add('hide');
							}
							
							// 사용자가 클릭한 내용을 토대로 조회
							setTimeout(function(){
								fetch('/shop/chat/findQuestion.jsp?type=' + encodeURIComponent(category))
							    .then(res => res.json())
							    .then(data => {
							    	// 감싸주는 div 생성
							    	const msgType = document.createElement("div");
							    	msgType.id = "msgType" + idx;
							    	chatbox.appendChild(msgType);
							    	
							    	const div = document.getElementById("msgType" + idx);
							    	// 돌아가기 버튼 생성
							    	const back = document.createElement("button");
						    		back.innerHTML = "처음 메뉴로 돌아가기";
						    		back.classList.add('primary-btn');
						    		back.classList.add('chatbotBtn');
						    		back.classList.add('mr-2');
						    		back.onclick = () => backMenu(back);
						    		div.appendChild(back);
						    		
							    	// btn 생성
							    	for(let i = 0; i < data.length; i++) {
							    		const btn = document.createElement("button");
							    		const question = data[i].question;
							    		btn.innerHTML = question;
							    		btn.onclick = () => findAnswer(question, category);
							    		btn.classList.add('primary-btn');
							    		btn.classList.add('chatbotBtn');
							    		btn.classList.add('mr-2');
							    		div.appendChild(btn);
							    	}
							    	
							    	idx++;
							    })
							    .catch(err => {
							        alert("데이터를 불러오지 못했습니다.");
							        console.error(err);
							    });
							}, 500);
							
							setTimeout(function(){
								chatbox.scrollTop = chatbox.scrollHeight;	
							}, 1000);
						}
						
						// 처음으로 돌아가는 버튼
						function backMenu(back) {
							const chatbox = document.getElementById("chat-box");
							const msgType = document.getElementById("msgType");
							const backMenu = back.innerHTML;
							
							// 보낸 내용 대입
							setTimeout(function(){
								const sendMsg = document.createElement("div");
								sendMsg.classList.add("user-message");
								sendMsg.innerHTML = backMenu;
								chatbox.appendChild(sendMsg);
							}, 500);
							
							setTimeout(function(){
								// 원래 메뉴 대입
								const div = document.createElement("div");
								div.id = "backMenu" + idx3;
								let child = msgType.childNodes;
								for(let i = 0; i < child.length; i++) {
									div.appendChild(child[i].cloneNode(true));
								}
								chatbox.appendChild(div);
								
								// 사용자의 버튼 활성화
								const backMenu = document.getElementById("backMenu" + idx3);
								const backBtn = backMenu.querySelectorAll('.hide');
								for(let i = 0; i < backBtn.length; i++) {
									backBtn[i].classList.remove('hide');
								}
								idx3++;
							}, 1000);
						}
						
						// 답변을 찾아주는 함수
						function findAnswer(question, category) {
							// 사용자가 클릭한 내용 출력
							const chatbox = document.getElementById("chat-box");
							const user = document.createElement("div");
							user.classList.add('user-message');
							user.innerHTML = question;
							chatbox.appendChild(user);
							
							// 사용자가 누르면 버튼 비활성화
							const msg = document.getElementById("msgType" + (idx - 1));
							const mc = msg.childNodes;
							for(let i = 0; i < mc.length - 1; i++) {
								mc[i].classList.add('hide');
								mc[i].nextElementSibling.classList.add('hide');
							}
							
							// 사용자가 클릭한 내용을 토대로 조회
							setTimeout(function(){
								fetch('/shop/chat/findAnswer.jsp?question=' + encodeURIComponent(question) + '&type=' + encodeURIComponent(category))
							    .then(res => res.json())
							    .then(data => {
							    	// 감싸주는 div 생성
							    	const msgType = document.createElement("div");
							    	msgType.id = "msgTypes" + idx2;
							    	chatbox.appendChild(msgType);
							    	const div = document.getElementById("msgTypes" + idx2);
							    	
							    	// btn 생성
							    	for(let i = 0; i < data.length; i++) {
							    		const ans = document.createElement("div");
							    		const answer = data[i].answer;
							    		ans.innerHTML = answer;
							    		ans.classList.add("bot-message");
							    		div.appendChild(ans);
							    	}
							    	
							    	// 돌아가기 버튼 생성
							    	const back = document.createElement("button");
						    		back.innerHTML = "처음 메뉴로 돌아가기";
						    		back.classList.add('primary-btn');
						    		back.classList.add('chatbotBtn');
						    		back.classList.add('mr-2');
						    		back.onclick = () => backMenu(back);
						    		div.appendChild(back);
						    		
							    	idx2++;
							    })
							    .catch(err => {
							        alert("데이터를 불러오지 못했습니다.");
							        console.error(err);
							    });
							}, 500);
							
							setTimeout(function(){
								chatbox.scrollTop = chatbox.scrollHeight;	
							}, 1000);
						}
					</script>
				</div>
			</div>
        </div>
        <script>
			const toggleBtn = document.getElementById('chatBot');
			const chatContainer = document.getElementById('chatBotBox');
			
			toggleBtn.addEventListener('click', () => {
				const isVisible = chatContainer.style.display === 'block';
				chatContainer.style.display = isVisible ? 'none' : 'block';
				toggleBtn.innerHTML = isVisible ? "챗봇" : "닫기";
			});
		</script>
    </div>
</header>
<!-- Header Section End -->

<!-- Search Begin -->
<div class="search-model">
    <div class="h-100 d-flex align-items-center justify-content-center">
        <div class="search-close-switch">+</div>
        <form action="/shop/main/search.jsp" class="search-model-form">
            <input type="text" name="key" id="search-input" placeholder="Search here.....">
            <input type="submit" value="검색">
        </form>
    </div>
</div>
<!-- Search End -->