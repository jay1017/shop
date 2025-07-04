<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="qna.QnaDAO" %>

<%
    String qnumStr = request.getParameter("qnum");
    if (qnumStr != null) {
        int qnum = Integer.parseInt(qnumStr);
        QnaDAO dao = new QnaDAO();
        dao.deleteQna(qnum);
    }
    response.sendRedirect("qnaList.jsp");
%>