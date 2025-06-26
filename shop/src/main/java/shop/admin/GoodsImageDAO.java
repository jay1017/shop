package shop.admin;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class GoodsImageDAO {
	// DAO 객체 생성
	private static GoodsImageDAO dao = new GoodsImageDAO();

	// DAO를 가져오는 역할
	public static GoodsImageDAO getDAO() {
		return dao;
	}

	// 객체 생성
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	// DAO 생성자
	private GoodsImageDAO() { }

	// 커넥션 연결
	private Connection getConnection() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String url = "jdbc:oracle:thin:@192.168.219.198:1521/orcl";
			String user = "team02";
			String password = "1234";
			conn = DriverManager.getConnection(url, user, password);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("DB 연결 실패");
		}

		return conn;
	}

	// 연결을 끊어주는 메소드
	private void endConnection() {
		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	// 파일명을 테이블에 저장 하는 메소드
	public List<Integer> insert(GoodsImageDTO dto) {
		List<Integer> result = new ArrayList<>();
		try {
			conn = getConnection();
			
			String sql = "select goods_image_seq.nextval from dual";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			int nextVal = 0;
			
			if(rs.next()) {
				nextVal = rs.getInt(1);
				result.add(nextVal);
			}
			
			if(nextVal != 0) {
				sql = "insert into goods_image values(?, ?, ?, ?, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, nextVal);
				pstmt.setString(2, dto.getGiname());
				pstmt.setString(3, dto.getGidetail1());
				pstmt.setString(4, dto.getGidetail2());
				pstmt.setString(5, dto.getGidetail3());
				pstmt.executeUpdate();
				result.add(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return result;
	}
	
	// 파일을 조회하는 메소드
	public GoodsImageDTO select(int ginum) {
		GoodsImageDTO dto = new GoodsImageDTO();
		try {
			conn = getConnection();
			String sql = "select * from goods_image where ginum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ginum);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setGiname(rs.getString("giname"));
				dto.setGidetail1(rs.getString("gidetail1"));
				dto.setGidetail2(rs.getString("gidetail2"));
				dto.setGidetail3(rs.getString("gidetail3"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return dto;
	}
	
	// 파일을 수정하는 메소드
	public int update(GoodsImageDTO dto) {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "update goods_image set giname = ?, gidetail1 = ?, gidetail2= ?, gidetail3 = ? where ginum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getGiname());
			pstmt.setString(2, dto.getGidetail1());
			pstmt.setString(3, dto.getGidetail2());
			pstmt.setString(4, dto.getGidetail3());
			pstmt.setInt(5, dto.getGinum());
			pstmt.executeUpdate();
			result = 1;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return result;
	}
}
