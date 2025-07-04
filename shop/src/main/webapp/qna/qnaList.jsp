<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, qna.QnaDAO, qna.QnaDTO" %>
<%@ page import="shop.member.MemberDAO" %>
<%@ page import="shop.member.MemberDTO" %>

<%
    String sid = (String) session.getAttribute("sid");
    if (sid == null) {
%>
    <script>
        alert("로그인 후 이용해주세요.");
        location.href = "/shop/member/loginForm.jsp";
    </script>
<%
        return;
    }

    MemberDAO mdao = new MemberDAO();
    MemberDTO mdto = mdao.getInfo(sid);
    int myMnum = 0;
    if (mdto != null) {
        myMnum = mdto.getMnum();
    }
%>

<html>
<head>
    <title>문의 목록</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/shop/resources/css/bootstrap.min.css">
    <style>
        .body-container {
            width: 700px;
            margin: 40px auto;
            padding: 20px;
            border: 1px solid #ccc;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
            background-color: #fafafa;
            border-radius: 8px;
        }
        h2 {
            text-align: center;
            margin-bottom: 30px;
        }
        a {
            text-decoration: none;
            color: #007bff;
        }
        a:hover {
            text-decoration: underline;
        }
        table.qnaTable {
            width: 100%;
            border-collapse: collapse;
            font-size: 16px;
        }
        table.qnaTable th, table.qnaTable td {
            border: 1px solid #ddd;
            padding: 12px 15px;
            text-align: center;
        }
        table.qnaTable th {
            background-color: #f2f2f2;
            font-weight: bold;
        }
    </style>
</head>
<body>

<jsp:include page="/include/header.jsp"></jsp:include>

<div class="body-container">
    <h2>문의 목록 (<%= sid %>)</h2>
    <a href="qnaForm.jsp">[문의 작성]</a>

    <%
        QnaDAO dao = new QnaDAO();
        List<QnaDTO> list = dao.getQnaList();

        if (list.isEmpty()) {
    %>
        <p>등록된 문의가 없습니다.</p>
    <%
        } else {
    %>
    <table class="qnaTable">
        <tr>
            <th>번호</th>
            <th>회원번호</th>
            <th>제목</th>
        </tr>
    <%
        for (QnaDTO dto : list) {
            String title = dto.getQtitle();
            if (title == null || title.trim().equals("")) {
                title = "(제목 없음)";
            }
    %>
        <tr>
            <td><%= dto.getQnum() %></td>
            <td><%= dto.getMnum() %></td>
            <td>
                <% if (dto.getMnum() == myMnum) { %>
                    <a href="qnaContent.jsp?qnum=<%= dto.getQnum() %>"><%= title %></a>
                <% } else { %>
                    <%= title %>
                <% } %>
            </td>
        </tr>
    <%
        }
    %>
    </table>
    <%
        }
    %>
</div>

<jsp:include page="/include/footer.jsp"></jsp:include>
<script src="/shop/resources/js/jquery-3.3.1.min.js"></script>
<script src="/shop/resources/js/bootstrap.min.js"></script>
</body>
</html>