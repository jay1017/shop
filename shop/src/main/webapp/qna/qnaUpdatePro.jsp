<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="qna.QnaDAO, qna.QnaDTO" %>
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

    response.sendRedirect("qnaList.jsp");
%>