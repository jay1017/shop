<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    int qna_id = 0;
    String qtitle = "", mname = "", qcontent = "";
    Date reg_date = null;

    try {
        String qnaIdStr = request.getParameter("qna_id");
        if (qnaIdStr == null || qnaIdStr.trim().equals("")) {
%>
            <script> 
                alert("잘못된 접근입니다.");
                location.href = "qnaList.jsp";
            </script>
<%
        } else {
            qna_id = Integer.parseInt(qnaIdStr);

            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.219.198:1521:orcl", "team02", "1234");

            String sql = "SELECT * FROM qna WHERE qna_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, qna_id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                qtitle = rs.getString("qtitle");
                mname = rs.getString("mname");
                qcontent = rs.getString("qcontent");
                reg_date = rs.getDate("reg_date");
            } else {
%>
                <script>
                    alert("해당 글이 존재하지 않습니다.");
                    location.href = "qnaList.jsp";
                </script>
<%
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
        <script>
            alert("에러 발생: <%= e.getMessage() %>");
            location.href = "qnaList.jsp";
        </script>
<%
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>

<html>
<head>
    <title>Q&A 상세 보기</title>
</head>
<body>
    <h2 align="center">문의 상세 내용</h2>
    <table border="1" align="center" width="600">
        <tr><th>글 번호</th>
            <td><%= (qna_id == 0) ? "NULL" : qna_id %></td></tr>
        <tr><th>제목</th>
            <td><%= (qtitle == null || qtitle.trim().equals("")) ? "제목 없음" : qtitle %></td></tr>
        <tr><th>작성자</th>
            <td><%= (mname == null || mname.trim().equals("")) ? "작성자 없음" : mname %></td></tr>
        <tr><th>작성일</th>
            <td><%= (reg_date == null) ? "NULL" : reg_date %></td></tr>
        <tr><th>내용</th>
            <td><pre><%= (qcontent == null || qcontent.trim().equals("")) ? "내용 없음" : qcontent %></pre></td></tr>  
    </table>
    
     <div align="center" style="margin-top:10px;">
        <button onclick="location.href='qnaUpdateForm.jsp?qna_id=<%= qna_id %>'">수정</button>
        <button onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='qnaDeletePro.jsp?qna_id=<%= qna_id %>'">삭제</button>
        <button onclick="location.href='qnaList.jsp'">목록</button>
    </div>
</body>
</html>
