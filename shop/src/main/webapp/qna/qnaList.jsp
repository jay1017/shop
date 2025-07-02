<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, qna.QnaDAO, qna.QnaDTO" %>

<html>
<head>
    <title>문의 목록</title>
    <style>
        #modalOverlay {
            display: none;
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(0, 0, 0, 0.4);
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        #modalOverlay.show {
            display: flex;
        }

        #warningModal {
            background: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 0 10px rgba(0,0,0,0.3);
        }

        .btn-confirm, .btn-cancel {
            margin: 10px;
            padding: 8px 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn-confirm {
            background-color: #dc3545;
            color: white;
        }

        .btn-cancel {
            background-color: #6c757d;
            color: white;
        }
    </style>
</head>

<body>
    <h2>문의 목록</h2>

    <a href="qnaForm.jsp">[문의 작성]</a>
    <br><br>

    <%
        QnaDAO dao = new QnaDAO();
        List<QnaDTO> list = dao.getQnaList();
        
        if (list.isEmpty()) {
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
            %>
            <tr>
                <td><%= dto.getQnum() %></td>
                <td><%= dto.getMnum() %></td>
                <td><%= dto.getQtitle() %></td>
                <td><%= dto.getQcontent() %></td>
                <td>
                    <a href="qnaUpdateForm.jsp?qnum=<%= dto.getQnum() %>">수정</a> |
                    <a href="javascript:void(0);" onclick="openDeleteModal(<%= dto.getQnum() %>)">삭제</a>
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
        <div id="warningModal">
            <p><strong>정말로 삭제하시겠습니까?</strong></p>
            <button class="btn-confirm" onclick="confirmDelete()">확인</button>
            <button class="btn-cancel" onclick="closeDeleteModal()">취소</button>
        </div>
    </div>

    <script>
        let selectedQnum = null;

        function openDeleteModal(qnum) {
            selectedQnum = qnum;
            document.getElementById("modalOverlay").classList.add("show");
        }

        function closeDeleteModal() {
            selectedQnum = null;
            document.getElementById("modalOverlay").classList.remove("show");
        }

        function confirmDelete() {
            if (selectedQnum !== null) {
                window.location.href = "qnaDelete.jsp?qnum=" + selectedQnum;
            }
        }
    </script>
</body>
</html>