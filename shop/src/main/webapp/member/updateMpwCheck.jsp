<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="mdto" class="shop.member.MemberDTO" />
<jsp:setProperty property="*" name="mdto" />
<jsp:useBean id="mdao" class="shop.member.MemberDAO" />
<%
	String sid = (String)session.getAttribute("sid");
%>
<html>
<head>
  <title>ODEZ - 회원정보 확인</title>
  <link rel="stylesheet" href="/shop/resources/css/font.css" />
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f3f2ee;
      margin: 0;
      padding: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    form {
      background-color: #fff;
      padding: 30px 25px;
      border-radius: 12px;
      box-shadow: 0 0 10px rgba(0,0,0,0.05);
      width: 300px;
      text-align: center;
    }

    h3 {
      margin-bottom: 20px;
      font-size: 18px;
      font-weight: bold;
    }

    input[type="password"] {
      width: 100%;
      height: 42px;
      padding: 0 10px;
      font-size: 15px;
      border: 1px solid #ccc;
      border-radius: 8px;
      box-sizing: border-box;
      margin-top: 8px;
    }

    input[type="submit"] {
      width: 100%;
      height: 42px;
      margin-top: 20px;
      background-color: #000;
      color: #fff;
      font-size: 16px;
      font-weight: bold;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    input[type="submit"]:hover {
      background-color: #333;
    }

    .input-group {
      text-align: left;
      font-size: 14px;
      font-weight: 500;
    }
  </style>
</head>
<body>
  <form action="/shop/member/updateMpwCheckTest.jsp" method="post">
    <h3>비밀번호 입력</h3>
    <input type="hidden" name="mid" value="<%=sid%>">
    <div class="input-group">
      비밀번호
      <input type="password" name="mpw" placeholder="비밀번호 입력" />
    </div>
    <input type="submit" value="확인"/>
  </form>
</body>
</html>
