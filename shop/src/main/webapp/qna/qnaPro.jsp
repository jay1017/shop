<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.qna.QnaDTO" %>
<%@ page import="shop.qna.QnaDAO" %>
<%@ page import="shop.member.MemberDAO" %>
<%@ page import="shop.member.MemberDTO" %>

<%
    request.setCharacterEncoding("UTF-8");

    // 1. 파라미터 받기
    String mid = request.getParameter("mid");
    String qtitle = request.getParameter("qtitle");
    String qcontent = request.getParameter("qcontent");

    // 2. mid로 mnum 조회
    MemberDAO mdao = new MemberDAO();
    MemberDTO mdto = mdao.getInfo(mid);

    int mnum = 0;
    if (mdto != null) {
        mnum = mdto.getMnum();
    } else {
%>
    <script>
        alert("회원 정보를 찾을 수 없습니다.");
        history.back();
    </script>
<%
        return;
    }

    // 3. QnaDTO에 값 설정
    QnaDTO dto = new QnaDTO();
    dto.setMnum(mnum);
    dto.setQtitle(qtitle);
    dto.setQcontent(qcontent);

    // 4. DB에 저장
    QnaDAO dao = new QnaDAO();
    dao.insertQna(dto);
%>

<script>
    alert("문의글이 등록되었습니다.");
    location.href = "qnaList.jsp";
</script>