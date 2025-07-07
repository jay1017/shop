package shop.admin;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

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

	// 글의 갯수를 세는 메소드
	public int selectCount() {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from coupon";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return result;
	}

	// 주문 내역을 조회하는 메소드
	public List<CouponDTO> selectList(int startRow, int endRow) {
		List<CouponDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "select r, cpnum, cp, cpvalue, cpname, cpreg "
					+ "from (select rownum r, cpnum, cp, cpvalue, cpname, cpreg "
					+ "from (select cpnum, cp, cpvalue, cpname, cpreg "
					+ "from coupon order by cpnum desc)) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				CouponDTO dto = new CouponDTO();
				dto.setCpnum(rs.getInt("cpnum"));
				dto.setCp(rs.getString("cp"));
				dto.setCpvalue(rs.getInt("cpvalue"));
				dto.setCpname(rs.getString("cpname"));
				dto.setCpreg(rs.getTimestamp("cpreg"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return list;
	}
	
	// 쿠폰을 등록하는 메소드
	public int insert(CouponDTO dto) {
		int result = 0;
		try {
			String uuid = UUID.randomUUID().toString();
			dto.setCp(uuid); 
			
			conn = getConnection();
			String sql = "insert into coupon values(coupon_seq.nextval, ?, ?, ?, ?, ?, ?, sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getCp());
			pstmt.setInt(2, dto.getCpvalue());
			pstmt.setString(3, dto.getCpname());
			pstmt.setString(4, dto.getCptype());
			pstmt.setInt(5, dto.getCpmop());
			pstmt.setInt(6, dto.getCpdate());
			
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return result;
	}
	
	// 상세 내용을 조회하는 메소드
	public CouponDTO select(int cpnum) {
		CouponDTO dto = new CouponDTO();
		try {
			conn = getConnection();
			String sql = "select * from coupon where cpnum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cpnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setCpvalue(rs.getInt("cpvalue"));
				dto.setCpname(rs.getString("cpname"));
				dto.setCptype(rs.getString("cptype"));
				dto.setCpmop(rs.getInt("cpmop"));
				dto.setCpdate(rs.getInt("cpdate"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return dto;
	}
	
	// 수정하는 메소드
	public int update(CouponDTO dto) {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "update coupon set cpvalue = ?, cpname = ?, cptype = ?, cpmop = ? where cpnum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getCpvalue());
			pstmt.setString(2, dto.getCpname());
			pstmt.setString(3, dto.getCptype());
			pstmt.setInt(4, dto.getCpmop());
			pstmt.setInt(5, dto.getCpnum());
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return result;
	}
}
