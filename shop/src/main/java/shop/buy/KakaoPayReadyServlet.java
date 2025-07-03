package shop.buy;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

public class KakaoPayReadyServlet extends HttpServlet {
    private static final String ADMIN_KEY = "8060ceb8b44371ba06fe9af9ee591a81";
    private static final String CID = "TC0ONETIME"; // 테스트용 CID

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 가져온 파라미터 대입
    	String item_name = URLEncoder.encode(request.getParameter("item_name"), "UTF-8");
        String total_amount = request.getParameter("total_amount").trim();
        String quantity = request.getParameter("quantity").trim();
        
        // URL로 외부와 연결
        URL url = new URL("https://kapi.kakao.com/v1/payment/ready");
        // url 타입의 서버 객체 새로 생성
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        
        // 서버 세팅
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Authorization", "KakaoAK " + ADMIN_KEY);
        conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
        conn.setDoOutput(true);
        
        
        // 던져줄 파라미터
        String param = "cid=" + CID +
                "&partner_order_id=1001" +
                "&partner_user_id=USER_ID" +
                "&item_name=" + item_name +
                "&quantity=" + quantity + 
                "&total_amount=" + total_amount +
                "&tax_free_amount=0" +
                "&approval_url=http://localhost:8080/shop/buy/success.jsp" +
                "&cancel_url=http://localhost:8080/shop/buy/cancel.jsp" +
                "&fail_url=http://localhost:8080/shop/buy/fail.jsp";
        
        OutputStream out = conn.getOutputStream();
        out.write(param.getBytes());
        out.flush();
        out.close();
        
        int responseCode = conn.getResponseCode();
        if (responseCode == 200) {
        	// 리더기에서 커넥션에 담은 내용 실행
            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            // 스트링 타입의 빌더 생성
            StringBuilder sb = new StringBuilder();
            String line;
            
            // 다음 줄이 없으면 스트링 빌더에 라인 대입(리더기에서 읽은 내용)
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
            
            // 리더기 닫기
            reader.close();
            conn.disconnect();

            // JSON 파싱 : json에 새로고침할 url 대입
            JSONObject json = new JSONObject(sb.toString());
            String redirectUrl = json.getString("next_redirect_pc_url");
            String tid = json.getString("tid");

            // 세션에 TID 저장 후 redirect
            request.getSession().setAttribute("tid", tid);
            response.sendRedirect(redirectUrl);
        } else {
            BufferedReader errorReader = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
            StringBuilder errorMsg = new StringBuilder();
            String line;
            while ((line = errorReader.readLine()) != null) {
                errorMsg.append(line);
            }
            errorReader.close();
            System.out.println("카카오페이 에러 응답: " + errorMsg.toString());
            throw new RuntimeException("카카오페이 요청 실패: " + errorMsg.toString());
        }
    }
}