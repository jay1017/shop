package shop.member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MemberDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	private Connection getConnection() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String url = "jdbc:oracle:thin:@192.168.219.198:1521:orcl";
			conn = DriverManager.getConnection(url,"team02","1234");
		}catch(Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	public MemberDTO getMid(String mid) {
		MemberDTO mdto = null;
		
		try {
			conn = getConnection();
			String sql = "select * from member2 where mid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				mdto = new MemberDTO();
				mdto.setMid(rs.getString("mid"));
				mdto.setMpw(rs.getString("mpw"));
				mdto.setMname(rs.getString("mname"));
				mdto.setMphone(rs.getString("mphone"));
				mdto.setMemail(rs.getString("memail"));
				mdto.setMgender(rs.getString("mgender"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(conn != null)try {conn.close();}catch(Exception e) {}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {}
			if(rs != null)try {rs.close();}catch(Exception e) {}
		}
		
		return mdto;
	}
	
	public void InputMember(MemberDTO mdto) {
		try {
			conn = getConnection();
			String sql = "insert into member2(mnum, mid, mpw, mname, mphone, memail, mgender) "
					+ "values(member2_seq.nextval,? ,? ,? ,? ,? ,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mdto.getMid());
			pstmt.setString(2, mdto.getMpw());
			pstmt.setString(3, mdto.getMname());
			pstmt.setString(4, mdto.getMphone());
			pstmt.setString(5, mdto.getMemail());
			pstmt.setString(6, mdto.getMgender());
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(conn != null)try {conn.close();}catch(Exception e) {}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {}
			if(rs != null)try {rs.close();}catch(Exception e) {}
		}
	}
}
