package shop.admin;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
	// DAO 객체 생성
	private static CategoryDAO dao = new CategoryDAO();

	// DAO를 가져오는 역할
	public static CategoryDAO getDAO() {
		return dao;
	}

	// 객체 생성
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	// DAO 생성자
	private CategoryDAO() {
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
	
	// 카테고리를 등록하는 메소드
	public int insert(CategoryDTO dto) {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "insert into category values(category_seq.nextval, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getCaname());
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return result;
	}
	
	// 카테고리 목록의 갯수를 세는 메소드
	public int selectCount() {
		int result = 0;
		
		try {
			conn = getConnection();
			String sql = "select count(*) from category";
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
	
	// 카테고리 목록을 조회하는 메소드
	public List<CategoryDTO> selectList(int startRow, int endRow) {
		List<CategoryDTO> list = new ArrayList<>();
		
		try {
			conn = getConnection();
			String sql = "select canum, caname, rownum r from (select canum, rownum r, caname from (select canum, caname from category order by canum desc) order by canum desc) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CategoryDTO dto = new CategoryDTO();
				dto.setCanum(rs.getInt("canum"));
				dto.setCaname(rs.getString("caname"));
				list.add(dto);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		
		return list;
	}
	
	// 카테고리의 정보를 가져오는 메소드
	public CategoryDTO select(int canum) {
		CategoryDTO dto = new CategoryDTO();
		try {
			conn = getConnection();
			String sql = "select * from category where canum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, canum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setCanum(canum);
				dto.setCaname(rs.getString("caname"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return dto;
	}
	
	// 카테고리를 수정하는 메소드
	public int update(CategoryDTO dto) {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "update category set caname = ? where canum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getCaname());
			pstmt.setInt(2, dto.getCanum());
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return result;
	}
	
	// 카테고리를 삭제하는 메소드
	public int delete(int canum) {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "delete from category where canum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, canum);
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return result;
	}
}