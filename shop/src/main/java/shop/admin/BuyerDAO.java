package shop.admin;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BuyerDAO {
	// DAO 객체 생성
	private static BuyerDAO dao = new BuyerDAO();

	// DAO를 가져오는 역할
	public static BuyerDAO getDAO() {
		return dao;
	}

	// 객체 생성
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	// DAO 생성자
	private BuyerDAO() {
		}

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
			String sql = "select count(*) from buyer";
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
	
	// 주문 내역을 조회하는 메소드
	public List<BuyerDTO> selectList(int startRow, int endRow) {
		List<BuyerDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "select r, bnum, buynum, mid, mname, gname, bcount, address, address2, address3, zip, note, bstatus "
					+ "from (select rownum r, bnum, buynum, mid, mname, gname, bcount, address, address2, address3, zip, note, bstatus "
					+ "from (select bnum, b.buynum, m.mid, m.mname, g.gname, b.bcount, b.address, b.address2, b.address3, b.zip, b.note, b.bstatus "
					+ "from buyer b, member2 m, goods g where b.mnum = m.mnum and b.gnum = g.gnum order by b.bnum desc) order by bnum desc) "
					+ "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BuyerDTO dto = new BuyerDTO();
				dto.setBuynum(rs.getInt("buynum"));
				dto.setMid(rs.getString("mid"));
				dto.setMname(rs.getString("mname"));
				dto.setGname(rs.getString("gname"));
				dto.setBcount(rs.getInt("bcount"));
				dto.setAddress(rs.getString("address"));
				dto.setAddress2(rs.getString("address2"));
				dto.setAddress3(rs.getString("address3"));
				dto.setZip(rs.getString("zip"));
				dto.setNote(rs.getString("note"));
				dto.setBstatus(rs.getInt("bstatus"));
				list.add(dto);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return list;
	}
	
	// 발송 준비중으로 상태 변경
	public int update(int bnum) {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "update buyer set bstatus = 1";
			pstmt = conn.prepareStatement(sql);
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return result;
	}
}
