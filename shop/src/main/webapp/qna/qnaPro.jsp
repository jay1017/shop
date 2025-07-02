<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="qna.QnaDTO" %>
<%@ page import="qna.QnaDAO" %>

<%
	request.setCharacterEncoding("UTF-8");

    
    String qtitle = request.getParameter("qtitle");
    String qcontent = request.getParameter("qcontent");
    int mnum = 21;
    
    QnaDTO dto = new QnaDTO();
    dto.setMnum(mnum);
    dto.setQtitle(qtitle);
    dto.setQcontent(qcontent);

    QnaDAO dao = new QnaDAO();
    dao.insertQna(dto);
%>

<script>
    alert("문의글이 등록되었습니다.");
    location.href = "qnaList.jsp";
</script>