<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // 로그인 세션 확인
    String sid = (String) session.getAttribute("sid");
    if (sid == null) {
%>
    <script>
        alert("로그인 후 이용해주세요.");
        location.href = "/shop/member/loginForm.jsp"; // 로그인 페이지 경로 맞게 설정
    </script>
<%
        return;
    }
%>

<html>
<head>
    <title>문의 작성</title>
</head>
<body>  
    <center><b>글쓰기</b></center>

    <input type="button" value="목록" onclick="window.location='qnaList.jsp'">
    <br>

    <form method="post" action="qnaPro.jsp">
        <input type="hidden" name="mid" value="<%= sid %>">
        제목: <input type="text" name="qtitle"><br>
        내용: <textarea name="qcontent"></textarea><br>
        <input type="submit" value="등록">
    </form>
</body>
</html>