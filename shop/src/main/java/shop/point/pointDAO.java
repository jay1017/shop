package shop.point;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class pointDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs =  null;
	
	//db연결
	public Connection getConnection() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String url = "jdbc:oracle:thin:@192.168.219.198:1521:orcl";
			conn = DriverManager.getConnection(url,"team02","1234");
		}catch(Exception e) { 
			e.printStackTrace();
		}
		return conn;
	}
	
	//구매후 적립 포인트 메서드
	public void InsertPoint(pointDTO pdto) {
		try {
			conn = getConnection();
			String sql = "insert into point(pnum, mnum, ppoint, ptype, pstat, pcreate, puse) "
					+ "values(point_seq.nextval, ?, ?, ?, ?, sysdate, null)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pdto.getMnum());
			pstmt.setInt(2, pdto.getPpoint());
			pstmt.setString(3, pdto.getPtype());
			pstmt.setInt(4, pdto.getPstat());
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(conn!=null)try {conn.close();}catch(Exception e) {}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {}
			if(rs!=null)try {rs.close();}catch(Exception e) {}
		}
	}
	
	public int getAllPoint(int mnum) {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "select sum(ppoint) from point where mnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(conn!=null)try {conn.close();}catch(Exception e) {}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {}
			if(rs!=null)try {rs.close();}catch(Exception e) {}
		}
		return result;
	}
}
