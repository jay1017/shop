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
				int res = pstmt.executeUpdate();
				result.add(res);
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
		String sql = "";
		try {
			String giname = "";
			String gidetail1 = "";
			String gidetail2 = "";
			String gidetail3 = "";
			
			conn = getConnection();
			
			if(dto.getGiname() == null || dto.getGiname().equals("")) {
				sql = "select giname from goods_image where ginum = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, dto.getGinum());
				rs = pstmt.executeQuery();
				if(rs.next()) {
					giname = rs.getString("giname");
				}
			} else {
				giname = dto.getGiname();
			}
			
			System.out.println(giname);
			
			if(dto.getGidetail1() == null || dto.getGidetail1().equals("")) {
				sql = "select gidetail1 from goods_image where ginum = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, dto.getGinum());
				rs = pstmt.executeQuery();
				if(rs.next()) {
					gidetail1 = rs.getString("gidetail1");
				}
			} else {
				gidetail1 = dto.getGidetail1();
			}
			
			if(dto.getGidetail2() == null || dto.getGidetail2().equals("")) {
				sql = "select gidetail2 from goods_image where ginum = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, dto.getGinum());
				rs = pstmt.executeQuery();
				if(rs.next()) {
					gidetail2 = rs.getString("gidetail2");
				}
			} else {
				gidetail2 = dto.getGidetail2();
			}
			
			if(dto.getGidetail3() == null || dto.getGidetail3().equals("")) {
				sql = "select gidetail3 from goods_image where ginum = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, dto.getGinum());
				rs = pstmt.executeQuery();
				if(rs.next()) {
					gidetail3 = rs.getString("gidetail3");
				}
			} else {
				gidetail3 = dto.getGidetail3();
			}
			
			sql = "update goods_image set giname = ?, gidetail1 = ?, gidetail2= ?, gidetail3 = ? where ginum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, giname);
			pstmt.setString(2, gidetail1);
			pstmt.setString(3, gidetail2);
			pstmt.setString(4, gidetail3);
			pstmt.setInt(5, dto.getGinum());
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return result;
	}
	
	// 파일을 삭제하는 메소드
	public int delete(int ginum) {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "delete from goods_image where ginum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ginum);
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return result;
	}
}
