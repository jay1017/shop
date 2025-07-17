<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.qna.QnaDAO, shop.qna.QnaDTO" %>

<%
    request.setCharacterEncoding("UTF-8");

    int qnum = Integer.parseInt(request.getParameter("qnum"));
    String qtitle = request.getParameter("qtitle");
    String qcontent = request.getParameter("qcontent");

    
 	// 세션에서 로그인 아이디 받아오기
    String mid = (String) session.getAttribute("sid");
    if(mid == null) {
%>
    <script>
        alert("로그인 후 이용해주세요.");
        location.href = "/shop/member/loginForm.jsp";
    </script>
<%
        return;
    }
    
    
    QnaDTO dto = new QnaDTO();
    dto.setQnum(qnum);
    dto.setQtitle(qtitle);
    dto.setQcontent(qcontent);
    dto.setMid(mid);

    QnaDAO dao = QnaDAO.getInstance();   
    dao.updateQna(dto);
%>

<script>
    alert("수정이 완료되었습니다.");
    location.href = "qnaContent.jsp?qnum=<%= qnum %>";
</script>