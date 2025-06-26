package shop.member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LoginDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
private static LoginDAO instance = new LoginDAO();
	
	public static LoginDAO getInstance() {
		return instance;
	
	}
	private LoginDAO() {}
	
	//db연결
	private Connection getConnection(){
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String url ="jdbc:oracle:thin:@192.168.219.198:1521:orcl";
			conn = DriverManager.getConnection(url,"team02","1234");
		}catch(Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	//db에 있는 아이디와 패스워드를 비교하여 값이 있으면 1 없으면 0 반환
	//로그인시 사용
	public int LoginCheck(MemberDTO ldto) {
		int result = 0;
		try {
			conn = getConnection();
			String sql ="select * from member2 where mid=? and mpw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ldto.getMid());
			pstmt.setString(2, ldto.getMpw());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = 1;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(conn != null)try {conn.close();}catch(Exception e) {}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {}
			if(rs != null)try {rs.close();}catch(Exception e) {}
		}
		return result;
	}
}
