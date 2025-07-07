package shop.coupon;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CouponDAO {
	// DAO 객체 생성
	private static CouponDAO dao = new CouponDAO();

	// DAO를 가져오는 역할
	public static CouponDAO getDAO() {
		return dao;
	}

	// 객체 생성
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	// DAO 생성자
	private CouponDAO() { }

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
	
	// 사용자가 가진 쿠폰 갯수 조회
	public int selectCount(int mnum) {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from user_coupon where mnum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mnum);
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
	
	// 사용자가 가진 쿠폰 조회
	public List<CouponDTO> selectList(int mnum) {
		List<CouponDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "select uc.ucnum, c.cpname, c.cpvalue, c.cpreg + c.cpdate as cpdate from user_coupon uc, coupon c where uc.mnum = ? and uc.cpnum = c.cpnum";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CouponDTO dto = new CouponDTO();
				dto.setUcnum(rs.getInt("ucnum"));
				dto.setCpname(rs.getString("cpname"));
				dto.setCpvalue(rs.getInt("cpvalue"));
				dto.setCpdate(rs.getTimestamp("cpdate"));
				list.add(dto);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return list;
	}
	
	// 사용자가 가진 쿠폰 갯수 조회
	public int selectNCount(int mnum) {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from coupon where cpnum not in(select cpnum from user_coupon where mnum = ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mnum);
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
	
	// 사용자가 가지지 않은 쿠폰 조회
	public List<CouponDTO> selectNList(int mnum) {
		List<CouponDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "select cpnum, cpvalue, cpname, cpreg + cpdate as cpdate from coupon where cpnum not in(select cpnum from user_coupon where mnum = ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CouponDTO dto = new CouponDTO();
				dto.setCpnum(rs.getInt("cpnum"));
				dto.setCpname(rs.getString("cpname"));
				dto.setCpvalue(rs.getInt("cpvalue"));
				dto.setCpdate(rs.getTimestamp("cpdate"));
				list.add(dto);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return list;
	}
	
	// 사용자 쿠폰 다운로드
	public int insert(int mnum, int cpnum) {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "insert into user_coupon values(uc_seq.nextval, ?, ?, sysdate, 0)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			pstmt.setInt(2, cpnum);
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return result;
	}
}
