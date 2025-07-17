<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, shop.qna.QnaDAO, shop.qna.QnaDTO" %>
<%@ page import="shop.member.MemberDAO" %>
<%@ page import="shop.member.MemberDTO" %>

<%
	request.setCharacterEncoding("UTF-8");
    
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
 
    MemberDAO mdao = new MemberDAO();
    MemberDTO mdto = mdao.getInfo(sid);
    int myMnum = 0;
    if (mdto != null) {
        myMnum = mdto.getMnum();
    }
    
    QnaDAO dao = QnaDAO.getInstance();
    List<QnaDTO> list = dao.getQnaList();
%>

<!DOCTYPE html>
<html>
<head>

 <meta charset="UTF-8">
    <meta name="description" content="Male_Fashion Template">
    <meta name="keywords" content="Male_Fashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>ODEZ</title>
    <!-- Css Styles -->
    <link rel="stylesheet" href="/shop/resources/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="/shop/resources/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="/shop/resources/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="/shop/resources/css/magnific-popup.css" type="text/css">
    <link rel="stylesheet" href="/shop/resources/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="/shop/resources/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="/shop/resources/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="/shop/resources/css/style.css" type="text/css">
    <link rel="stylesheet" href="/shop/resources/css/font.css">
    
    <title>문의 목록</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/shop/resources/css/bootstrap.min.css">
    <style>
        .body-container {
            width: 700px;
            margin: 40px auto;
            padding: 20px;
            border: 1px solid #ccc;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
            background-color: #fafafa;
            border-radius: 8px;
        }
        h2 {
            text-align: center;
            margin-bottom: 30px;
        }
        a {
            text-decoration: none;
            color: #007bff;
        }
        a:hover {
            text-decoration: underline;
        }
        a:focus {
            outline: none;
        }
        table.qnaTable {
            width: 100%;
            border-collapse: collapse;
            font-size: 16px;
        }
        table.qnaTable th, table.qnaTable td {
            border: 1px solid #ddd;
            padding: 12px 15px;
            text-align: center;
        }
        table.qnaTable th {
            background-color: #f2f2f2;
            font-weight: bold;
        }
        
        
        
        
        a {
    color: white !important;           /* 평상시 글자색 흰색 */
    text-decoration: none !important; /* 밑줄 없애기 */
}

a:hover {
    color: white !important;           /* 마우스 올려도 흰색 유지 */
    text-decoration: none !important; /* 밑줄 안 보이게 */
}

a:visited, a:focus, a:active {
    color: white !important;
    text-decoration: none !important;
}
        
        
        
        
        
    </style>
    
    <link rel="stylesheet" href="/shop/resources/css/font-awesome.min.css" type="text/css"/>







</head>
<body>


<jsp:include page="/include/sidebar.jsp"></jsp:include>
<jsp:include page="/include/header.jsp"></jsp:include>

<div class="body-container">
    <h2>문의 목록 (<%= sid %>)</h2>
    <a href="qnaForm.jsp" style="color: black; text-decoration: none;"
   onmouseover="this.style.textDecoration='underline'"
   onmouseout="this.style.textDecoration='none'">
   [문의 작성]
</a>
    

    <%
        if (list.isEmpty()) {
    %>
        <p>등록된 문의가 없습니다.</p>
    <%
        } else {
    %>
    <table class="qnaTable">
    <tr>
        <th>번호</th>
        <th>회원 아이디</th>
        <th>제목</th>
    </tr>
<%
    for (QnaDTO dto : list) {
        String title = dto.getQtitle();
        if (title == null || title.trim().equals("")) {
            title = "(제목 없음)";
        }
%>
    <tr>
        <td><%= dto.getQnum() %></td>

        <!-- 회원 아이디 출력 부분 -->
        <td>
        <%
            if (sid.equals(dto.getMid())) {
                out.print(sid);  // 내가 쓴 글이면 로그인한 아이디 표시
            } else {
                out.print(dto.getMid());  // 남이 쓴 글이면 DB에서 가져온 mid 표시
            }
        %>
        </td>

     <!-- 제목 출력 부분 -->
<td>
<%
    if (sid.equals(dto.getMid())) {
%>
    <a href="qnaContent.jsp?qnum=<%= dto.getQnum() %>" 
   style="color: black; text-decoration: none;"
   onmouseover="this.style.textDecoration='underline'" 
   onmouseout="this.style.textDecoration='none'">
   <%= title %>
</a>
    
<%
    } else {
%>
    <a href="#" style="color: black; text-decoration: none;" 
       onmouseover="this.style.textDecoration='underline'" 
       onmouseout="this.style.textDecoration='none'" 
       onclick="alert('비공개 글입니다.'); return false;">
       <%= title %>
    </a>
<%
    }
%>
</td>
        
    </tr>
<%
    }
%>
</table>
    
    <%
        }
    %>
</div>

<jsp:include page="/include/footer.jsp"></jsp:include>
   
   <script src="/shop/resources/js/jquery-3.3.1.min.js"></script>
   <script src="/shop/resources/js/bootstrap.min.js"></script>
   <script src="/shop/resources/js/jquery.nice-select.min.js"></script>
   <script src="/shop/resources/js/jquery.nicescroll.min.js"></script>
   <script src="/shop/resources/js/jquery.magnific-popup.min.js"></script>
   <script src="/shop/resources/js/jquery.countdown.min.js"></script>
   <script src="/shop/resources/js/jquery.slicknav.js"></script>
   <script src="/shop/resources/js/mixitup.min.js"></script>
   <script src="/shop/resources/js/owl.carousel.min.js"></script>
   <script src="/shop/resources/js/main.js"></script>
   
</body>
</html>