package shop.admin;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OptionDAO {
	// DAO 객체 생성
	private static OptionDAO dao = new OptionDAO();

	// DAO를 가져오는 역할
	public static OptionDAO getDAO() {
		return dao;
	}

	// 객체 생성
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	// DAO 생성자
	private OptionDAO() {
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
	
	// 목록의 갯수를 조회하는 메소드
	public int selectCount() {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from goods_option";
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
	
	// 목록을 조회하는 메소드
	public List<OptionDTO> selectList(int startRow, int endRow) {
		List<OptionDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "select gonum, gocolor, gosize, r from (select gonum, gocolor, gosize, r from (select gonum, gocolor, gosize, rownum r from goods_option order by gonum desc) order by gonum desc) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OptionDTO dto = new OptionDTO();
				dto.setGonum(rs.getInt("gonum"));
				dto.setGocolor(rs.getString("gocolor"));
				dto.setGosize(rs.getString("gosize"));
				list.add(dto);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return list;
	}
	
	// 옵션을 저장하는 메소드
	public int insert(OptionDTO dto) {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "insert into goods_option values (goods_option_seq.nextVal, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getGnum());
			pstmt.setInt(2, dto.getCanum());
			pstmt.setInt(3, dto.getGinum());
			pstmt.setString(4, dto.getGocolor());
			pstmt.setString(5, dto.getGosize());
			pstmt.setInt(6, dto.getGocount());
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return result;
	}
	
	// 옵션을 불러오는 메소드
	public OptionDTO select(int gonum) {
		OptionDTO dto = new OptionDTO();
		try {
			conn = getConnection();
			String sql = "select * from goods_option where gonum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, gonum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setGosize(rs.getString("gosize"));
				dto.setGocolor(rs.getString("gocolor"));
				dto.setGocount(rs.getInt("gocount"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return dto;
	}
	
	// 옵션을 수정하는 메소드
	public int update(OptionDTO dto) {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "update goods_option set canum = ?, ginum = ?, gosize = ?, gocolor = ? where gonum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getCanum());
			pstmt.setInt(2, dto.getGinum());
			pstmt.setString(3, dto.getGosize());
			pstmt.setString(4, dto.getGocolor());
			pstmt.setInt(5, dto.getGonum());
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return result;
	}
	
	// 옵션을 삭제하는 메소드
	public int delete(int gonum) {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "delete from goods_option where gonum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, gonum);
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return result;
	}
} 
