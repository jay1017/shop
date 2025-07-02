<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("id") == null) {
%>
    <script>
        alert("로그인 후 이용해주세요");
        history.go(-1);
    </script>
<%
        return; 
    }
%>

<html>
<head>
<title>게시판</title>
</head>
<body>  
<center><b>글쓰기</b>

<input type="button" value="목록" onclick="window.location='qnaList.jsp'">
<br>

<form method="post" action="qnaPro.jsp">
  제목: <input type="text" name="qtitle"><br>
  내용: <textarea name="qcontent"></textarea><br>
  <input type="submit" value="등록">

</form>
</body>
</html>      