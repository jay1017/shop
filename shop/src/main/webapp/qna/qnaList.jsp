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
    
    // ✅ 페이징 처리 변수
    int pageSize = 10;
    String pageNum = request.getParameter("pageNum");
    if (pageNum == null) pageNum = "1";
    int currentPage = Integer.parseInt(pageNum);
    
    int startRow = (currentPage - 1) * pageSize + 1;
    int endRow = currentPage * pageSize;

    QnaDAO dao = QnaDAO.getInstance();
    List<QnaDTO> list = dao.getQnaList(startRow, endRow);  // 페이징 범위만큼만 가져오기
    int count = dao.getQnaCount();  // 전체 글 개수 가져오기 (페이징 계산용)

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
        
 

  
  
  
   		/* 내 글 제목만 검정색 */      
  		a.my-title {
    		color: black !important;
    		text-decoration: none !important;
    		cursor: pointer;
  			}
  		a.my-title:hover {
    		color: black !important;
    		text-decoration: underline !important;
		}


        /* 사이드바 특정 메뉴(로그아웃, 마이페이지, 문의게시판, FAQ)만 흰색 유지 */
        a.sidebar-menu {
            color: white !important;
            text-decoration: none !important;
        }

        a.sidebar-menu:hover {
            color: white !important;
            text-decoration: underline !important;
        }
        
        .pagination {
    		display: flex;
    		justify-content: center;
    		flex-wrap: wrap;
    		gap: 5px;
    		margin-top: 20px;
		}
        
         /* 페이징 기본 스타일 */
        .pagination a,
        .pagination strong {
            color: black !important;
            text-decoration: none;
            outline: none;
            margin: 0 5px;
            font-weight: normal;
            color: black !important;             /* ✅ 기본 색상 고정 */
        text-decoration: none !important;    /* ✅ 밑줄 제거 고정 */
            cursor: pointer;
        }
        

        /* 마우스 오버 시 밑줄 */
        .pagination a:hover {
            text-decoration: underline;
        }

        /* 현재 페이지 */
        .pagination .current {
            font-weight: bold;
            text-decoration: underline;
            cursor: default;
            pointer-events: none; /* 클릭 방지 */
            color: black !important;             /* ✅ 현재 페이지도 검정색 고정 */
    }
        }

        /* outline 제거로 깜빡임 완화 */
        .pagination a:focus,
        .pagination a:active {
            outline: none;
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
   onmouseover='this.style.textDecoration="underline"'
   onmouseout='this.style.textDecoration="none"'>
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
    <a href="qnaContent.jsp?qnum=<%= dto.getQnum() %>" class="my-title"><%= title %></a>
<%
    } else {
%>
    <a href='#'
   style='color: black; text-decoration: none;' 
   onmouseover="this.style.textDecoration='underline'" 
   onmouseout="this.style.textDecoration='none'" 
   onclick="alert('비공개 글입니다.'); return false;">
   <%= dto.getQtitle() %>
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
    
 <!-- 페이징 영역 -->
    <div class="pagination">
    <%
        int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
        int pageBlock = 5;  // 한 번에 보여줄 페이지 번호 개수
        int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
        int endPage = startPage + pageBlock - 1;
        if (endPage > pageCount) endPage = pageCount;

        if (startPage > 1) {
    %>
        <a href="qnaList.jsp?pageNum=<%= startPage - 1 %>">[이전]</a>
    <%
        }

        for (int i = startPage; i <= endPage; i++) {
            if (i == currentPage) {
    %>
        <a href="#" class="current">[<%= i %>]</a>
    <%
            } else {
    %>
        <a href="qnaList.jsp?pageNum=<%= i %>">[<%= i %>]</a>
    <%
            }
        }

        if (endPage < pageCount) {
    %>
        <a href="qnaList.jsp?pageNum=<%= endPage + 1 %>">[다음]</a>
    <%
        }
    %>
    </div>

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
   
   
   <!-- 특정 링크 텍스트만 흰색으로 유지 -->
<script>
  window.addEventListener("DOMContentLoaded", function () {
    const whiteLinks = ["로그아웃", "마이페이지", "문의게시판", "FAQ"];
    document.querySelectorAll("a").forEach(function (aTag) {
      if (whiteLinks.includes(aTag.textContent.trim())) {
        aTag.classList.add("sidebar-menu");
      }
    });
  });
</script>


</body>
</html>