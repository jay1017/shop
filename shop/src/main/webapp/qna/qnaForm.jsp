<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="shop.member.MemberDAO" %>
	<%@ page import="shop.member.MemberDTO" %>
    

<%
    // 로그인 세션 확인
    String sid = (String) session.getAttribute("sid");
    if (sid == null) {
%>
    <script>
        alert("로그인 후 이용해주세요.");
        location.href = "/shop/member/loginForm.jsp"; // 로그인 페이지 경로 맞게 설정
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
    
    <title>문의 작성</title>
     <link rel="stylesheet" href="/shop/resources/css/bootstrap.min.css">
    <style>
        .form-container {
            width: 700px;
            margin: 40px auto;
            padding: 25px;
            border: 1px solid #ccc;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
            font-family: Arial, sans-serif;
        }
        table {
            width: 100%;
        }
        td {
            padding: 10px;
            font-size: 16px;
        }
        textarea {
            width: 100%;
        }
        .btn-box {
            margin-top: 20px;
            text-align: right;
        }
    </style>
    
</head>
<body>  

<jsp:include page="/include/header.jsp"></jsp:include>

    <div class="form-container">
    <h2 class="text-center mb-4">문의 작성</h2>
    
    <form action="qnaPro.jsp" method="post">
        <input type="hidden" name="mid" value="<%= sid %>"> <%-- 로그인한 아이디 전달 --%>

        <div class="form-group">
            <label for="qtitle">제목</label>
            <input type="text" name="qtitle" id="qtitle" class="form-control" required>
        </div>

        <div class="form-group">
            <label for="qcontent">내용</label>
            <textarea name="qcontent" id="qcontent" rows="10" class="form-control" required></textarea>
        </div>

        <div class="btn-box text-center">
            <input type="submit" value="등록" class="btn btn-primary">
            <input type="button" value="취소" class="btn btn-secondary" onclick="history.back();">
            <input type="button" value="목록" class="btn btn-light" onclick="window.location='qnaList.jsp'">
        </div>
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