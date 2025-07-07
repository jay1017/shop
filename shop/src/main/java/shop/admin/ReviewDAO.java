package shop.admin;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {
	// DAO 객체 생성
	private static ReviewDAO dao = new ReviewDAO();

	// DAO를 가져오는 역할
	public static ReviewDAO getDAO() {
		return dao;
	}

	// 객체 생성
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	// DAO 생성자
	private ReviewDAO() { }

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
	
	// 리뷰의 카운트를 세는 메소드
	public int selectCount() {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from review";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return result;
	}
	
	// 리뷰의 목록을 조회하는 메소드
	public List<ReviewDTO> selectList(int startRow, int endRow) {
		System.out.println(startRow);
		System.out.println(endRow);
		List<ReviewDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "select ro, rnum, mname, gname, rcontent from (select rownum as ro, rnum, mname, gname, rcontent from (select r.rnum, m.mname, g.gname, r.rcontent from review r, member2 m, goods g where r.mnum = m.mnum and g.gnum = r.gnum order by r.rnum desc) order by rnum desc) where ro >= ? and ro <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReviewDTO dto = new ReviewDTO();
				dto.setRnum(rs.getInt("rnum"));
				dto.setGname(rs.getString("gname"));
				dto.setMname(rs.getString("mname"));
				dto.setRcontent(rs.getString("rcontent"));
				list.add(dto);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return list;
	}
	
	// 리뷰를 삭제하는 메소드
	public int delete(int rnum) {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "delete from review where rnum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rnum);
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return result;
	}
}
