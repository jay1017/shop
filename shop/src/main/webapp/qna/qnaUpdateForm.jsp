<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="shop.qna.QnaDAO, shop.qna.QnaDTO" %>
<%
    request.setCharacterEncoding("UTF-8");

    // 글 번호 가져오기
    String qnumStr = request.getParameter("qnum");
    int qnum = 0;
    if (qnumStr != null && !qnumStr.trim().equals("")) {
        qnum = Integer.parseInt(qnumStr);
    } else {
%>
    <script>
        alert("잘못된 접근입니다.");
        history.back();
    </script>
<%
        return;
    }

    // 글 정보 조회
    QnaDAO dao = new QnaDAO();
    QnaDTO dto = dao.getQna(qnum);
    if (dto == null) {
%>
    <script>
        alert("존재하지 않는 글입니다.");
        history.back();
    </script>
<%
        return;
    }
%>

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

    <meta charset="UTF-8">
    <title>문의 수정</title>
    <style>
        .form-container {
            width: 600px;
            margin: 50px auto;
            padding: 30px;
            border: 1px solid #ccc;
            border-radius: 10px;
            font-family: Arial;
            background-color: #f9f9f9;
        }
        h2 {
            margin-bottom: 20px;
        }
        input[type=text], textarea {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            border: 1px solid #bbb;
            border-radius: 5px;
            font-size: 16px;
        }
        input[type=submit] {
            padding: 10px 20px;
            margin-top: 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        input[type=submit]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<jsp:include page="/include/header.jsp"></jsp:include>

<div class="form-container">
    <h2>문의 수정</h2>
    <form action="qnaUpdatePro.jsp" method="post">
        <input type="hidden" name="qnum" value="<%= dto.getQnum() %>">

        <label>제목</label>
        <input type="text" name="qtitle" value="<%= dto.getQtitle() %>" required>

        <label>내용</label>
        <textarea name="qcontent" rows="8" required><%= dto.getQcontent() %></textarea>

        <input type="submit" value="수정 완료">
    </form>
</div>

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