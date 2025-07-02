<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.net.*, org.json.JSONObject" %>

<%
    // 세션에서 access_token 가져오기 (카카오 로그인 시 세션에 저장되어 있다고 가정)
    String accessToken = (String) session.getAttribute("access_token");

    if (accessToken != null) {
        try {
            // 1. 연결 끊기 요청
            URL url = new URL("https://kapi.kakao.com/v1/user/unlink");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);
            conn.setDoOutput(true);

            int responseCode = conn.getResponseCode();

            // 2. 응답 확인
            if (responseCode == 200) {
                // 성공적으로 연결 해제됨
                BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                String line, result = "";
                while ((line = br.readLine()) != null) {
                    result += line;
                }
                br.close();

                JSONObject responseJson = new JSONObject(result);
                String unlinkedId = responseJson.get("id").toString(); // 끊긴 사용자 ID

                // 세션 초기화
                session.invalidate();

                %>
                <script>
                    alert("카카오 연결 해제가 완료되었습니다.\nID: <%= unlinkedId %>");
                    location.href = "/shop/main/main.jsp";
                </script>
                <%
            } else {
                %>
                <script>
                    alert("연결 해제 실패! 응답 코드: <%= responseCode %>");
                    history.back();
                </script>
                <%
            }
        } catch (Exception e) {
            e.printStackTrace();
            %>
            <script>
                alert("오류가 발생했습니다: <%= e.getMessage() %>");
                history.back();
            </script>
            <%
        }
    } else {
        // access_token이 없는 경우
        %>
        <script>
            alert("접근 토큰이 없습니다. 다시 로그인해주세요.");
            location.href = "/shop/member/loginForm.jsp";
        </script>
        <%
    }
%>
