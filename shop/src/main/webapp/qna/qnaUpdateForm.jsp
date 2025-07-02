<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="qna.QnaDAO, qna.QnaDTO" %>

<%
    int qnum = Integer.parseInt(request.getParameter("qnum"));
    QnaDAO dao = new QnaDAO();
    QnaDTO dto = dao.getQna(qnum);
%>

<h2>문의 수정</h2>
<form action="qnaUpdatePro.jsp" method="post">
    <input type="hidden" name="qnum" value="<%= dto.getQnum() %>">
    제목: <input type="text" name="qtitle" value="<%= dto.getQtitle() %>"><br>
    내용: <textarea name="qcontent"><%= dto.getQcontent() %></textarea><br>
    <input type="submit" value="수정 완료">
</form>
