<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*, java.io.*" %>
<jsp:useBean id="mdao" class="shop.member.MemberDAO" />

<%
request.setCharacterEncoding("UTF-8");

String sid = (String) session.getAttribute("sid");
String mid = request.getParameter("mid");
String mpw = request.getParameter("mpw");
String access_token = (String) session.getAttribute("access_token");

System.out.println("memberDeletePro.jsp 진입 확인됨");
System.out.println("▶ sid (세션): " + sid);
System.out.println("▶ mid (요청): " + mid);
System.out.println("▶ mpw: " + mpw);
System.out.println("▶ access_token: " + access_token);

boolean valid = false;

if (!"KAKAO".equals(mpw) && !"NAVER".equals(mpw)) {
    if (mdao.SelectMember(mid, mpw) == 1 && sid != null && sid.equals(mid)) {
        valid = true;
    }
} else {
    if (sid != null && sid.equals(mid)) {
        if (access_token == null || access_token.isEmpty()) {
            if ("KAKAO".equals(mpw)) {
                response.sendRedirect("https://kauth.kakao.com/oauth/authorize?response_type=code"
                    + "&client_id=bc8f1248fe973ce8060a5a525c39e1f9"
                    + "&redirect_uri=http://192.168.219.157:8080/shop/member/kakaoReLogin.jsp"
                    + "&prompt=login");
                return;
            } else if ("NAVER".equals(mpw)) {
                response.sendRedirect("https://nid.naver.com/oauth2.0/authorize?response_type=code"
                    + "&client_id=xlKrOZe43aUWrCldbgTq"
                    + "&redirect_uri=http://192.168.219.157:8080/shop/member/naverReLogin.jsp"
                    + "&state=delete");
                return;
            }
        }
        valid = true;
    }
}

String script = "";

if (valid) {
    // 연동 해제
    if ("KAKAO".equals(mpw)) {
        mdao.unlinkKakao(access_token);
    } else if ("NAVER".equals(mpw)) {
        mdao.unlinkNaver(access_token);
    }

    // DB 삭제
    int number = mdao.getMnumByMid(mid);
    System.out.println("▶ mnum 값: " + number);
    int scs = mdao.DeleteMemberFromMnum(number);
    System.out.println("▶ 삭제 결과: " + scs);

    if (scs == 1) {
        session.invalidate();
        script = "<script>alert('회원탈퇴가 완료되었습니다.'); opener.location.href='/shop/main/main.jsp'; window.close();</script>";
    } else {
        script = "<script>alert('회원 탈퇴에 실패했습니다.'); history.back();</script>";
    }
} else {
    script = "<script>alert('아이디 또는 비밀번호가 일치하지 않습니다.'); history.back();</script>";
}

out.print(script);
%>
