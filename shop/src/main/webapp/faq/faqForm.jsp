<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="shop.faq.faqDAO"%>
<%@ page import="shop.faq.faqDTO"%>
<%@ page import="java.util.List"%>
<%
faqDAO fdao = new faqDAO();
List<faqDTO> faqlist = fdao.getFAQList();
%>
<html>
<head>
<meta name="description" content="Male_Fashion Template">
<meta name="keywords" content="Male_Fashion, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>ODEZ - FAQ</title>
<link rel="stylesheet" href="/shop/resources/css/font.css" />
<link rel="stylesheet" href="/shop/resources/css/bootstrap.min.css"
	type="text/css">
<link rel="stylesheet" href="/shop/resources/css/font-awesome.min.css"
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
<link rel="stylesheet" href="/shop/resources/css/font.css">
<link rel="stylesheet" href="/shop/resources/css/font-awesome.min.css"
	type="text/css" />

<style>
body {
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #f3f2ee;
	margin: 0;
	padding: 0;
}

.faq-container {
	width: 1000px;
	margin: 50px auto;
	background-color: #fff;
	border-radius: 12px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
	padding: 40px;
}

.faq-tabs {
	display: flex;
	gap: 40px;
	justify-content: center;
	margin-bottom: 30px;
	flex-wrap: nowrap;
	overflow-x: auto;
}

.faq-tabs button {
	background: none;
	border: none;
	font-size: 16px;
	font-weight: bold;
	padding: 10px 20px;
	cursor: pointer;
	color: #777;
	border-bottom: 2px solid transparent;
	transition: 0.3s;
	white-space: nowrap;
}

.faq-tabs button.active {
	color: #000;
	border-bottom: 2px solid #000;
}

.faq-list {
	display: flex;
	flex-direction: column;
	gap: 15px;
}

.faq-item {
	border-bottom: 1px solid #eee;
	cursor: pointer;
}

.faq-question {
	padding: 15px 20px;
	font-size: 15px;
	font-weight: 500;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.faq-question::after {
	content: "▼";
	font-size: 13px;
	color: #aaa;
	transition: transform 0.3s ease;
}

.faq-item.active .faq-question::after {
	transform: rotate(180deg);
}

.faq-answer {
	padding: 15px 20px;
	display: none;
	font-size: 14px;
	color: #444;
	line-height: 1.6;
	background-color: #fafafa;
	border-top: 1px solid #eee;
}

.faq-item.active .faq-answer {
	display: block;
}

.hidden {
	display: none;
}
</style>
</head>
<body>
	<jsp:include page="/include/header.jsp"></jsp:include>
	<div class="faq-container">
		<h3 align="center">FAQ</h3>
		<br />
		<div class="faq-tabs">
			<button class="active" data-category="all">전체</button>
			<button data-category="1">배송</button>
			<button data-category="2">교환/반품</button>
			<button data-category="3">서비스</button>
			<button data-category="4">주문/결제</button>
			<button data-category="5">상품확인</button>
			<button data-category="6">회원정보</button>
		</div>


		<!-- FAQ 리스트 -->
		<div class="faq-list">
			<%
			for (faqDTO f : faqlist) {
			%>
			<div class="faq-item" data-category="<%=f.getFcnum()%>">
				<div class="faq-question"><%=f.getFquestion()%></div>
				<div class="faq-answer"><%=f.getFanswer()%></div>
			</div>
			<%
			}
			%>
		</div>
	</div>

	<!-- 스크립트 -->
	<script>
    const tabButtons = document.querySelectorAll(".faq-tabs button");
    const faqItems = document.querySelectorAll(".faq-item");

    // 카테고리 필터링
    tabButtons.forEach(button => {
        button.addEventListener("click", () => {
            tabButtons.forEach(btn => btn.classList.remove("active"));
            button.classList.add("active");

            const selected = button.dataset.category;
            faqItems.forEach(item => {
                const itemCat = item.dataset.category;
                if (selected === "all" || selected === itemCat) {
                    item.classList.remove("hidden");
                } else {
                    item.classList.add("hidden");
                }
            });
        });
    });

    // 질문 클릭 시 답변 열기/닫기
    document.querySelectorAll(".faq-question").forEach(question => {
        question.addEventListener("click", () => {
            const parent = question.parentElement;
            parent.classList.toggle("active");
        });
    });
</script>
	<jsp:include page="/include/footer.jsp"></jsp:include>
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
</body>
</html>