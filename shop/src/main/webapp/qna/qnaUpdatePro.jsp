<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.qna.QnaDAO, shop.qna.QnaDTO" %>

<%
    request.setCharacterEncoding("UTF-8");

    int qnum = Integer.parseInt(request.getParameter("qnum"));
    String qtitle = request.getParameter("qtitle");
    String qcontent = request.getParameter("qcontent");

    QnaDTO dto = new QnaDTO();
    dto.setQnum(qnum);
    dto.setQtitle(qtitle);
    dto.setQcontent(qcontent);

    QnaDAO dao = new QnaDAO();
    dao.updateQna(dto);
%>

<script>
    alert("수정이 완료되었습니다.");
    location.href = "qnaContent.jsp?qnum=<%= qnum %>";
</script>