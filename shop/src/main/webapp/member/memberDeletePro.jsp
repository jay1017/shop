<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.net.*, java.io.*" %>
<jsp:useBean id="mdao" class="shop.member.MemberDAO" />

<%
request.setCharacterEncoding("UTF-8");
String sid = (String) session.getAttribute("sid");  // 현재 로그인된 사용자 ID
String mid = request.getParameter("mid");           // 입력된 ID (삭제 대상)
String mpw = request.getParameter("mpw");           // 입력된 PW 또는 로그인 유형
String access_token = (String) session.getAttribute("access_token");

boolean valid = false;

// [1] 일반 로그인 회원 탈퇴
if (!"KAKAO".equals(mpw) && !"NAVER".equals(mpw)) {
    if (mdao.SelectMember(mid, mpw) == 1 && sid != null && sid.equals(mid)) {
        valid = true;
    }
}
// [2] 카카오 / 네이버 연동 로그인 회원 탈퇴
else {
    if (sid != null && sid.equals(mid)) {
        if (access_token == null || access_token.isEmpty()) {
            // access_token이 없으면 재인증 필요
            if ("KAKAO".equals(mpw)) {
%>
                <script>
                    alert("카카오 인증이 필요합니다.");
                    location.href = "https://kauth.kakao.com/oauth/authorize?response_type=code"
                        + "&client_id=bc8f1248fe973ce8060a5a525c39e1f9"
                        + "&redirect_uri=http://localhost:8080/shop/member/kakaoReLogin.jsp"
                        + "&prompt=login";
                </script>
<%
            } else if ("NAVER".equals(mpw)) {
%>
                <script>
                    alert("네이버 인증이 필요합니다.");
                    location.href = "https://nid.naver.com/oauth2.0/authorize?response_type=code"
                        + "&client_id=xlKrOZe43aUWrCldbgTq"
                        + "&redirect_uri=http://localhost:8080/shop/member/naverReLogin.jsp"
                        + "&state=delete"
                        + "&prompt=login";
                </script>
<%
            }
            return;
        }
        valid = true;
    }
}

if (valid) {
    // [3] 연동 해제 처리
    if ("KAKAO".equals(mpw)) {
        mdao.unlinkKakao(access_token);
    } else if ("NAVER".equals(mpw)) {
        mdao.unlinkNaver(access_token);
    }

    // [4] DB에서 회원 삭제
    mdao.DeleteMember(mid);
    session.invalidate();
%>
    <script>
        alert("회원탈퇴가 완료되었습니다.");
        opener.location.href = "/shop/main/main.jsp";
        window.close();
    </script>
<%
} else {
%>
    <script>
        alert("아이디 또는 비밀번호가 일치하지 않습니다.");
        history.go(-1);
    </script>
<%
}
%>
