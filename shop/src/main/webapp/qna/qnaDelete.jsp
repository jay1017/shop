<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.qna.QnaDAO, shop.qna.QnaDTO" %>
<%@ page import="shop.member.MemberDAO, shop.member.MemberDTO" %>

<%
    // 로그인 세션 확인
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

    
    
    String qnumStr = request.getParameter("qnum");
    int qnum = (qnumStr != null && !qnumStr.trim().equals("")) ? Integer.parseInt(qnumStr) : 0;
    
    // 로그인 사용자 mnum 가져오기
    MemberDAO mdao = new MemberDAO();
    MemberDTO mdto = mdao.getInfo(sid);
    
    int myMnum = (mdto != null) ? mdto.getMnum() : 0;
    
    QnaDAO dao = QnaDAO.getInstance();
    QnaDTO dto = dao.getQna(qnum);
  
    if (dto == null) {
%>
    <script>
        alert("존재하지 않는 문의입니다.");
        history.back();
    </script>
<%
        return;
    }

    if (dto == null || dto.getMnum() != myMnum) {
    
%>
    <script>
        alert("삭제 권한이 없습니다.");
        history.back();
    </script>
<%
        return;
    }

    // 삭제 실행
    dao.deleteQna(qnum);
%>

<script>
    alert("삭제되었습니다.");
    location.href = "qnaList.jsp";
</script>