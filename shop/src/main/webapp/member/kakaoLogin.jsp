<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.member.MemberDTO" %>
<%@ page import="shop.member.MemberDAO" %>
<%@ page import="java.io.*, java.net.*, org.json.JSONObject" %>

<%
    // 카카오 인증 후 리다이렉트될 때 전달된 code 파라미터 받기 (인가 코드)
	String code = request.getParameter("code");

	// 1. 인가 코드(code)를 사용해 access token 요청하기
	URL url = new URL("https://kauth.kakao.com/oauth/token");
	HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	conn.setRequestMethod("POST");         // POST 방식
	conn.setDoOutput(true);                // OutputStream으로 파라미터 전송 가능하게 설정

	// access token 요청에 필요한 파라미터 구성
	String param = "grant_type=authorization_code"
		+ "&client_id=bc8f1248fe973ce8060a5a525c39e1f9" 
		+ "&redirect_uri=http://localhost:8080/shop/member/kakaoLogin.jsp" // 리디렉트 URI (카카오 개발자센터 등록된 것과 동일해야 함)
		+ "&code=" + code;                                      // 위에서 받은 인가 코드 포함

	// 파라미터 전송
	OutputStreamWriter writer = new OutputStreamWriter(conn.getOutputStream());
	writer.write(param);
	writer.flush();

	// 카카오에서 access token 응답을 받음 (JSON 형식)
	BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	String result = "", line;
	while ((line = reader.readLine()) != null) {
		result += line; // 응답 내용을 문자열로 누적
	}

	// 응답 JSON 파싱 → access_token 추출
	JSONObject json = new JSONObject(result);
	String access_token = json.getString("access_token");

	// 2. access_token을 사용해 사용자 정보 요청
	URL userUrl = new URL("https://kapi.kakao.com/v2/user/me");
	HttpURLConnection userConn = (HttpURLConnection) userUrl.openConnection();
	userConn.setRequestMethod("GET");
	userConn.setRequestProperty("Authorization", "Bearer " + access_token); // Authorization 헤더에 토큰 삽입

	// 사용자 정보 응답 읽기
	BufferedReader userReader = new BufferedReader(new InputStreamReader(userConn.getInputStream()));
	String userResult = "", userLine;
	while ((userLine = userReader.readLine()) != null) {
		userResult += userLine; // 사용자 정보 JSON을 문자열로 저장
	}

	// 사용자 정보 JSON 파싱
	JSONObject userJson = new JSONObject(userResult);
	
	String kakao_id = userJson.get("id").toString(); //카카오 고유 id가져옴(난수형태)
	String nickname = userJson.getJSONObject("kakao_account").getJSONObject("profile").getString("nickname");
	
	
	MemberDAO mdao = new MemberDAO();
	MemberDTO member = mdao.getMemberByKakaoId(kakao_id); //카카오아이디 컬럼에 들어있는 해당회원의 모든 정보를 가져옴
	
	// 3. 로그인 세션 등록
	if(member != null){
		session.setAttribute("sid", member.getMid());
		session.setAttribute("access_token", access_token); // unlink용
		response.sendRedirect("/shop/main/main.jsp");
	}else{
		request.setAttribute("kakao_id", kakao_id);
		request.setAttribute("nickname", nickname);
		RequestDispatcher rd = request.getRequestDispatcher("/member/memberForm.jsp");
		rd.forward(request, response);
	}
	
	System.out.println("카카오 사용자 JSON: " + userJson.toString());
%>
