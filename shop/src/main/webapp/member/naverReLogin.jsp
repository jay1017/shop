<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="shop.member.MemberDTO" %>
<%@ page import="shop.member.MemberDAO" %>
<%@ page import="java.io.*, java.net.*, org.json.JSONObject" %>

<%
request.setCharacterEncoding("UTF-8");
String code = request.getParameter("code");

if (code == null || code.trim().equals("")) {
    out.println("<script>alert('인가 코드가 유효하지 않습니다.'); window.close();</script>");
    return;
}

// 1. access_token 요청
URL url = new URL("https://kauth.kakao.com/oauth/token");
HttpURLConnection conn = (HttpURLConnection) url.openConnection();
conn.setRequestMethod("POST");
conn.setDoOutput(true);

String param = "grant_type=authorization_code"
    + "&client_id=bc8f1248fe973ce8060a5a525c39e1f9"
    + "&redirect_uri=http://192.168.219.157:8080/shop/member/kakaoReLogin.jsp"
    + "&code=" + code;

OutputStreamWriter writer = new OutputStreamWriter(conn.getOutputStream());
writer.write(param);
writer.flush();

BufferedReader reader;
String result = "";
if (conn.getResponseCode() == 200) {
    reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
} else {
    reader = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
}

String line;
while ((line = reader.readLine()) != null) {
    result += line;
}
reader.close();

if (conn.getResponseCode() != 200) {
    out.println("<script>alert('카카오 인증 실패: " + result + "'); window.close();</script>");
    return;
}

// 2. access_token 추출
JSONObject json = new JSONObject(result);
String access_token = json.getString("access_token");

// 3. 사용자 정보 요청
URL userUrl = new URL("https://kapi.kakao.com/v2/user/me");
HttpURLConnection userConn = (HttpURLConnection) userUrl.openConnection();
userConn.setRequestMethod("GET");
userConn.setRequestProperty("Authorization", "Bearer " + access_token);

BufferedReader userReader = new BufferedReader(new InputStreamReader(userConn.getInputStream()));
String userResult = "", userLine;
while ((userLine = userReader.readLine()) != null) {
    userResult += userLine;
}
userReader.close();

// 4. 사용자 ID 추출 및 회원 조회
JSONObject userJson = new JSONObject(userResult);
String kakao_id = userJson.get("id").toString();

MemberDAO mdao = new MemberDAO();
MemberDTO mdto = mdao.getMemberByKakaoId(kakao_id);  // getMemberByKakaoId → getKakaoMember로 네이밍 통일

if (mdto != null) {
    session.setAttribute("sid", mdto.getMid());
    session.setAttribute("access_token", access_token);
%>
    <form id="kakaoRedirectForm" action="/shop/member/memberDeletePro.jsp" method="post">
        <input type="hidden" name="mid" value="<%=mdto.getMid()%>" />
        <input type="hidden" name="mpw" value="KAKAO" />
    </form>
    <script>
        document.getElementById("kakaoRedirectForm").submit();
    </script>
<%
} else {
    out.println("<script>alert('카카오 계정 정보가 없습니다.'); window.close();</script>");
}
%>
