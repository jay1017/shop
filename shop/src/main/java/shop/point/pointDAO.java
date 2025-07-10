package shop.point;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
	
	//구매후 사용 포인트 메서드
	public void InsertUsePoint(pointDTO usepdto) {
		try {
			conn = getConnection();
			String sql = "insert into point(pnum, mnum, ppoint, ptype, pstat, pcreate, puse) "
					+ "values(point_seq.nextval, ?, ?, ?, ?, null, sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, usepdto.getMnum());
			pstmt.setInt(1, usepdto.getPpoint());
			pstmt.setString(1, usepdto.getPtype());
			pstmt.setInt(1, usepdto.getPstat());
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(conn!=null)try {conn.close();}catch(Exception e) {}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {}
			if(rs!=null)try {rs.close();}catch(Exception e) {}
		}
	}
	
	//해당 회원의 사용가능 포인트 금액 표시
	public int getAllPoint(int mnum) {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "select sum(ppoint) from point where mnum=? and pstat = 1";
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
	
	//해당회원의 적립 내역 전체 보기 메서드
	public List<pointDTO> getPointList(int mnum){
		List<pointDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "select * from point where mnum=? order by pcreate DESC";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				pointDTO pdto = new pointDTO();
				pdto.setPnum(rs.getInt("pnum"));
				pdto.setMnum(rs.getInt("mnum"));
				pdto.setPpoint(rs.getInt("ppoint"));
				pdto.setPtype(rs.getString("ptype"));
				pdto.setPstat(rs.getInt("pstat"));
				pdto.setPcreate(rs.getDate("pcreate"));
				pdto.setPuse(rs.getDate("puse"));
				list.add(pdto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(conn!=null)try {conn.close();}catch(Exception e) {}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {}
			if(rs!=null)try {rs.close();}catch(Exception e) {}
		}
		return list;
	}
}
