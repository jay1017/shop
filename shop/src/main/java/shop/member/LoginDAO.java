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
	
	//이름과 이메일 값으로 해당하는 mid값 조회
	public String getIdByEmail(String ename, String email) {
		String id = "";
		try {
			conn = getConnection();
			String sql ="select mid from member2 where mname=? and memail=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ename);
			pstmt.setString(2, email);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				id = rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(conn != null)try {conn.close();}catch(Exception e) {}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {}
			if(rs != null)try {rs.close();}catch(Exception e) {}
		}
		return id;
	}
	
	//이름과 전화번호로 mid값 조회
	public String getIdByPhone(String pname, String mphone) {
		String id = "";
		try {
			conn = getConnection();
			String sql = "select mid from member2 where mname=? and mphone=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pname);
			pstmt.setString(2, mphone);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				id = rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(conn != null)try {conn.close();}catch(Exception e) {}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {}
			if(rs != null)try {rs.close();}catch(Exception e) {}
		}
		return id;
	}
	
	//아이디와 전화번호를 통한 비밀번호 조회
	public String getPwByPhone(String id, String phone) {
		String mid = "";
		try {
			conn = getConnection();
			String sql = "select mpw from member2 where mid=? and mphone=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, phone);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				mid = rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(conn != null)try {conn.close();}catch(Exception e) {}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {}
			if(rs != null)try {rs.close();}catch(Exception e) {}
		}
		return mid;
	}
	
	//아이디와 이메일을 통한 비밀번호 조회
	public String getPwByEmail(String id, String email) {
		String mid = "";
		try {
			conn = getConnection();
			String sql = "select mpw from member2 where mid=? and mpw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, email);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				mid = rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(conn != null)try {conn.close();}catch(Exception e) {}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {}
			if(rs != null)try {rs.close();}catch(Exception e) {}
		}
		return mid;
	}
	
	//세션에 저장하기 위한 아이디값과 일치하는 mnum 조회
	public int getMnumById(String id) {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "select mnum from member2 where mid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
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
