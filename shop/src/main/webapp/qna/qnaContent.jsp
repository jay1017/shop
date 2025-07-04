<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="qna.QnaDAO, qna.QnaDTO" %>
<%@ page import="shop.member.MemberDAO, shop.member.MemberDTO" %>

<%
    // 글 번호 파라미터 확인
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

    // 글 데이터 조회
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

    // 로그인 확인
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

    // 로그인한 사용자의 정보
    MemberDAO mdao = new MemberDAO();
    MemberDTO mdto = mdao.getInfo(sid);
    if (mdto == null || dto.getMnum() != mdto.getMnum()) {
%>
    <script>
        alert("자신의 글만 열람할 수 있습니다.");
        history.back();
    </script>
<%
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>문의 상세 보기</title>
    <link rel="stylesheet" href="/shop/resources/css/bootstrap.min.css" />
    <style>
        .detail-container {
            width: 700px;
            margin: 40px auto;
            padding: 25px;
            border: 1px solid #ccc;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
            font-family: Arial, sans-serif;
        }
        h2 {
            font-size: 24px;
            margin-bottom: 20px;
        }
        .qna-info {
            font-size: 14px;
            color: #666;
            margin-bottom: 20px;
        }
        .qna-content {
            font-size: 16px;
            white-space: pre-wrap;
            border-top: 1px solid #ddd;
            padding-top: 20px;
        }
        .back-button {
            display: inline-block;
            margin-top: 30px;
            text-decoration: none;
            color: #007bff;
            margin-right: 10px;
        }
        .back-button:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="detail-container">
    <h2><%= dto.getQtitle() != null ? dto.getQtitle() : "(제목 없음)" %></h2>
    <div class="qna-info">
        문의 번호: <%= dto.getQnum() %> |
        회원 번호: <%= dto.getMnum() %>
    </div>
    <div class="qna-content">
        <%= dto.getQcontent() != null ? dto.getQcontent() : "(내용 없음)" %>
    </div>

    <a href="qnaList.jsp" class="back-button">← 목록으로 돌아가기</a>

    <%-- 수정 버튼: 작성자일 경우만 보임 --%>
    <% if (dto.getMnum() == mdto.getMnum()) { %>
        <a href="qnaUpdateForm.jsp?qnum=<%= dto.getQnum() %>" class="back-button">✏️ 수정</a>
    <% } %>
</div>

</body>
</html>