<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.net.*,org.json.JSONObject" %>
<%@ page import="shop.member.MemberDTO" %>
<%@ page import="shop.member.MemberDAO" %>
<%
	String code = request.getParameter("code");
	String state = request.getParameter("state");
	
	if(code == null || state == null || code.trim().equals("")){
		out.println("<script>alert('잘못된 접근입니다.'); window.close();</script>");
		return;
	}
	
	//access_token 요청
	String redirectURI = URLEncoder.encode("http://localhost:8080/shop/member/naverReLogin.jsp", "UTF-8");
	String apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code"
			+"&client_id=xlKrOZe43aUWrCldbgTq"
			+"&client_secret=ZkIXnpMuhw"
			+"&redirect_uri="+redirectURI
			+"&code="+code
			+"&state="+state;
	
	URL url = new URL(apiURL);
	HttpURLConnection con = (HttpURLConnection)url.openConnection();
	con.setRequestMethod("GET");
	
	BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	String result = "", line;
	while((line = br.readLine()) != null){
		result += line;
	}
	
	JSONObject json = new JSONObject(result);
	String access_token = json.getString("access_token");
	
	//사용자 정보 요청
	URL infoUrl = new URL("https://openapi.naver.com/v1/nid/me");
	HttpURLConnection infoCon = (HttpURLConnection) infoUrl.openConnection();
	infoCon.setRequestProperty("Authorization", "Bearer "+access_token);
	
	BufferedReader infoBr = new BufferedReader(new InputStreamReader(infoCon.getInputStream()));
	String userInfo = "", userLine;
	while((userLine = infoBr.readLine()) != null){
		userInfo += userLine;
	}
	
	JSONObject responseJson = new JSONObject(userInfo).getJSONObject("response");
	String nid = responseJson.getString("id");
	
	MemberDAO mdao = new MemberDAO();
	MemberDTO mdto = mdao.getNaverMember(nid);
	
	if(mdto != null){
		session.setAttribute("sid", mdto.getMid());
		session.setAttribute("access_token", access_token);
		response.sendRedirect("/shop/member/memberDeletePro.jsp?mid="+mdto.getMid()+"&mpw=NAVER");
	}else{
		out.println("<script>alert('네이버 계정 정보가 없습니다.'); window.close();</script>");
	}
%>





