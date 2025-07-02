<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, qna.QnaDAO, qna.QnaDTO" %>

<html>
<head>
    <title>문의 목록</title>
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
                    <a href="javascript:void(0);" onclick="openDeleteModal(<%= dto.getQnum() %>)">[삭제]</a>
                </td>
            </tr>
            <%
                }
            %>
        </table>
    <%
        }
    %>
    
    <!-- 경고창 모달 -->
    <div id="modalOverlay">
        <div id="warningModal">
            <p><strong>정말로 삭제하시겠습니까?</strong></p>
            <button class="btn-confirm" onclick="confirmDelete()">확인</button>
            <button class="btn-cancel" onclick="closeDeleteModal()">취소</button>
        </div>
    </div>
</body>
</html>