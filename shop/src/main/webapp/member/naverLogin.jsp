<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.net.*, org.json.JSONObject" %>
<%@ page import="shop.member.MemberDTO" %>
<%@ page import="shop.member.MemberDAO" %>
<%
	request.setCharacterEncoding("UTF-8");

	String code = request.getParameter("code"); //인가코드
	String state = request.getParameter("state"); //CSRF 공격 방지용 검증값
	
	String clientId = "xlKrOZe43aUWrCldbgTq";
	String clientSecret = "ZkIXnpMuhw";
	String redirectURI = URLEncoder.encode("http://localhost:8080/shop/member/naverLogin.jsp","UTF-8");
	//redirectURI를 URL로 인코딩
	
	// 1. Access Token 요청
	String apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code"
			+"&client_id="+clientId
			+"&client_secret="+clientSecret
			+"&redirect_uri="+redirectURI
			+"&code="+code
			+"&state="+state; //네이버 토큰 발급 요청 URL
	URL url = new URL(apiURL); //apiURL을 URL객체로 변환
	HttpURLConnection con = (HttpURLConnection)url.openConnection(); //해당 URL에 http 요청을 보내는 객체
	con.setRequestMethod("GET"); //get방식 전송
	
	BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	String result = "", line;
	while((line = br.readLine()) != null){
		result += line;
	};
	
	JSONObject json = new JSONObject(result);
	String access_token = json.getString("access_token");
	
	//2.사용자 정보 요청
	URL infoUrl = new URL("https://openapi.naver.com/v1/nid/me");
	HttpURLConnection infoCon = (HttpURLConnection) infoUrl.openConnection();
	infoCon.setRequestProperty("Authorization", "Bearer "+access_token);
	
	BufferedReader infoBr = new BufferedReader(new InputStreamReader(infoCon.getInputStream()));
	String userInfo = "", userLine;
	while((userLine = infoBr.readLine()) != null){
		userInfo += userLine;
	}
	
	JSONObject responseJson = new JSONObject(userInfo).getJSONObject("response");
	String naver_id = responseJson.getString("id");
	String name = responseJson.getString("name");
	String email = responseJson.getString("email");
	String phone = responseJson.has("mobile") ? responseJson.getString("mobile").replaceAll("-", "") : "";
	
	//db체크
	MemberDAO mdao = new MemberDAO();
	MemberDTO mdto = mdao.getNaverMember(naver_id);
	
	if(mdto != null){
		session.setAttribute("sid", mdto.getMid());
		session.setAttribute("access_token", access_token);
		response.sendRedirect("/shop/main/main.jsp");
	}else{
		//신규 회원
		session.setAttribute("naver_id", naver_id);
		session.setAttribute("naver_name", name);
		session.setAttribute("naver_email", email);
		session.setAttribute("naver_phone", phone);
		response.sendRedirect("/shop/member/memberForm.jsp");
	}
%>




