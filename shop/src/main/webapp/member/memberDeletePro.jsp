<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:useBean id="mdao" class="shop.member.MemberDAO" />

<%
request.setCharacterEncoding("UTF-8");
String sid = (String) session.getAttribute("sid");
String mid = request.getParameter("mid");
String mpw = request.getParameter("mpw");

boolean valid = false;

// 1. 일반 로그인
if (!"KAKAO".equals(mpw)) {
    if (mdao.SelectMember(mid, mpw) == 1 && sid != null && sid.equals(mid)) {
        valid = true;
    }
} else {
    // 2. 카카오 인증 후 넘어온 경우
    if (sid != null && sid.equals(mid)) {
        valid = true;
    }
}

if (valid) {
    String access_token = (String) session.getAttribute("access_token");

    if (access_token == null || access_token.isEmpty()) {
%>
    <script>
        alert("카카오 인증이 필요합니다.");
        location.href = "https://kauth.kakao.com/oauth/authorize?response_type=code"
            + "&client_id=bc8f1248fe973ce8060a5a525c39e1f9"
            + "&redirect_uri=http://localhost:8080/shop/member/kakaoReLogin.jsp"
            + "&prompt=login";
    </script>
<%
        return;
    } else {
        mdao.unlinkKakao(access_token);
    }

    mdao.DeleteMember(mid);
    session.invalidate();
%>
    <script>
        alert("회원탈퇴가 완료되었습니다.");
        opener.location.href="/shop/main/main.jsp";
        window.close();
    </script>
<%
} else {
%>
    <script>
        alert("아이디/비밀번호가 일치하지 않습니다.");
        history.go(-1);
    </script>
<%
}
%>
