<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, qna.QnaDAO, qna.QnaDTO" %>
<%@ page import="shop.member.MemberDAO" %>
<%@ page import="shop.member.MemberDTO" %>

<%
    // 로그인 체크
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

    // 로그인한 아이디로 mnum 가져오기
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
    <style>
        #modalOverlay {
            display: none;
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background-color: rgba(0, 0, 0, 0.5);
        }
        #deleteModal {
            background: #fff;
            padding: 20px;
            width: 300px;
            margin: 200px auto;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 0 10px #333;
        }
        button {
            margin: 5px;
            padding: 8px 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn-confirm { background-color: #d9534f; color: white; }
        .btn-cancel { background-color: #5bc0de; color: white; }
    </style>
</head>
<body>
    <h2>문의 목록 (<%= sid %>)</h2>
    <a href="qnaForm.jsp">[문의 작성]</a>
    <br><br>

<%
    QnaDAO dao = new QnaDAO();
    List<QnaDTO> list = dao.getQnaList();

    boolean hasMyPost = false;
    for (QnaDTO dto : list) {
        if (dto.getMnum() == myMnum) {
            hasMyPost = true;
            break;
        }
    }

    if (!hasMyPost) {
%>
    <p>등록된 문의가 없습니다.</p>
<%
    } else {
%>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>번호</th>
            <th>회원번호</th>
            <th>제목</th>
            <th>내용</th>
            <th>관리</th>
        </tr>
<%
        for (QnaDTO dto : list) {
            if (dto.getMnum() != myMnum) continue;
%>
        <tr>
            <td><%= dto.getQnum() %></td>
            <td><%= dto.getMnum() %></td>
            <td><%= dto.getQtitle() %></td>
            <td><%= dto.getQcontent() %></td>
            <td>
                <a href="qnaUpdateForm.jsp?qnum=<%= dto.getQnum() %>">수정</a> |
                <a href="javascript:openDeleteModal(<%= dto.getQnum() %>)">삭제</a>
            </td>
        </tr>
<%
        }
%>
    </table>
<%
    }
%>

    <!-- 삭제 확인 모달 -->
    <div id="modalOverlay">
        <div id="deleteModal">
            <p><strong>정말로 삭제하시겠습니까?</strong></p>
            <button class="btn-confirm" onclick="confirmDelete()">확인</button>
            <button class="btn-cancel" onclick="closeDeleteModal()">취소</button>
        </div>
    </div>

    <script>
        let deleteQnum = 0;

        function openDeleteModal(qnum) {
            deleteQnum = qnum;
            document.getElementById('modalOverlay').style.display = 'block';
        }

        function closeDeleteModal() {
            document.getElementById('modalOverlay').style.display = 'none';
        }

        function confirmDelete() {
            location.href = 'qnaDelete.jsp?qnum=' + deleteQnum;
        }
    </script>
</body>
</html>