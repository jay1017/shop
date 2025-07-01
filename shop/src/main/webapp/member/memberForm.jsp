<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link rel="stylesheet" href="/shop/resources/css/font.css" />
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f8f8f8;
            margin: 0;
            padding: 0;
        }

        .join-container {
            width: 400px;
            margin: 50px auto;
            padding: 40px;
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 10px;
        }

        .join-container h2 {
            text-align: center;
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .join-container h5 {
            text-align: right;
            font-size: 13px;
            color: #666;
            margin-top: -10px;
            margin-bottom: 20px;
        }

        .join-input {
            width: 100%;
            padding: 12px;
            margin-bottom: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .msg {
            font-size: 12px;
            color: red;
            margin-bottom: 10px;
        }

        .btn-inline {
            display: flex;
            gap: 8px;
            margin-bottom: 10px;
        }

        .btn-inline input[type="text"] {
            flex: 1;
        }

        .radio-group {
            margin-top: 10px;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .submit-button {
            width: 100%;
            padding: 14px;
            font-size: 15px;
            background-color: black;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .submit-button:hover {
            background-color: #333;
        }
    </style>
</head>
<body>
    <div class="join-container">
        <h2>회원가입</h2>
        <h5>(*)은 필수 항목입니다</h5>
        <form action="memberPro.jsp" method="post" onsubmit="return membercheck()">
            <div class="btn-inline">
                <input type="text" maxlength="100" id="mid" name="mid" placeholder="아이디 입력*" class="join-input">
                <input type="button" value="중복확인" onclick="midCheck()" />
            </div>
            <input type="hidden" id="butcheck" name="butcheck" value="false">

            <input type="password" maxlength="100" id="pw" name="mpw" placeholder="비밀번호 입력*" class="join-input" oninput="pwcheck()">
            <input type="password" maxlength="100" id="pwch" name="mpwcheck" placeholder="비밀번호 확인*" class="join-input" oninput="pwcheck()">
            <div id="pwmsg" class="msg"></div>

            <input type="text" maxlength="100" id="nameEl" name="mname" placeholder="이름 입력*" class="join-input" oninput="namecheck()">
            <div id="namemsg" class="msg"></div>

            <input type="text" maxlength="1000" id="phoneEl" name="mphone" placeholder="전화번호 입력(-제외)*" class="join-input" oninput="phonecheck()">
            <div id="phonemsg" class="msg"></div>

            <input type="text" maxlength="1000" id="emailEl" name="memail" placeholder="이메일 입력" class="join-input" oninput="emailcheck()">
            <div id="emailmsg" class="msg"></div>

            <div class="radio-group">
                성별:
                <label><input type="radio" id="gender1" name="mgender" value="1" checked> 남</label>
                <label><input type="radio" id="gender2" name="mgender" value="2"> 여</label>
            </div>

            <button type="submit" class="submit-button">가입</button>
        </form>
    </div>
    <script src="<%=request.getContextPath()%>/resources/js/member.js"></script>
</body>
</html>
