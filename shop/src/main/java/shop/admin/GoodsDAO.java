package shop.admin;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class GoodsDAO {
	// DAO 객체 생성
	private static GoodsDAO dao = new GoodsDAO();

	// DAO를 가져오는 역할
	public static GoodsDAO getDAO() {
		return dao;
	}

	// 객체 생성
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	// DAO 생성자
	private GoodsDAO() { }

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
	
	// 목록의 갯수를 세는 메소드
	public int selectCount() {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from goods";
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
	public List<GoodsDTO> selectList(int startRow, int endRow) {
		List<GoodsDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "select r, gnum, canum, ginum, gname, gprice, discount, gonum, gocolor, gosize, gocount "
					+ "from (select rownum r, gnum, canum, ginum, gname, gprice, discount, gonum, gocolor, gosize, gocount "
					+ "from (select go.gnum, go.canum, go.ginum, g.gname, g.gprice, g.discount, go.gonum, go.gocolor, go.gosize, go.gocount "
					+ "from goods g, goods_option go where g.gnum = go.gnum order by gnum desc) order by gnum desc) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				GoodsDTO dto = new GoodsDTO();
				dto.setGnum(rs.getInt("gnum"));
				dto.setCanum(rs.getInt("canum"));
				dto.setGinum(rs.getInt("ginum"));
				dto.setGname(rs.getString("gname"));
				dto.setGprice(rs.getInt("gprice"));
				dto.setDiscount(rs.getInt("discount"));
				dto.setGonum(rs.getInt("gonum"));
				dto.setGocolor(rs.getString("gocolor"));
				dto.setGosize(rs.getString("gosize"));
				dto.setGocount(rs.getInt("gocount"));
				list.add(dto);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return list;
	}
	
	// 카테고리 목록을 조회하는 메소드
	public List<CategoryDTO> selectCategory() {
		List<CategoryDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "select * from category";
			pstmt = conn.prepareStatement(sql);
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
 	
	// 상품 정보를 저장하는 메소드
	public List<Integer> insert(GoodsDTO dto) {
		List<Integer> result = new ArrayList<>();
		try {
			conn = getConnection();
			
			String sql = "select goods_seq.nextval from dual";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			int nextVal = 0;
			
			if(rs.next()) {
				nextVal = rs.getInt(1);
				result.add(nextVal);
			}
			
			if(nextVal != 0) {
				sql = "insert into goods values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, nextVal);
				pstmt.setInt(2, dto.getCanum());
				pstmt.setString(3, dto.getGname());
				pstmt.setInt(4, dto.getGprice());
				pstmt.setString(5, dto.getGcontent());
				pstmt.setInt(6, dto.getGinum());
				pstmt.setInt(7, dto.getDiscount());
				pstmt.setInt(8, 0);
				pstmt.setString(9, dto.getGplot());
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
	
	// 상품 정보를 조회하는 메소드
	public GoodsDTO select(int gnum) {
		GoodsDTO dto = new GoodsDTO();
		try {
			conn = getConnection();
			String sql = "select * from goods where gnum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, gnum);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setGprice(rs.getInt("gprice"));
				dto.setDiscount(rs.getInt("discount"));
				dto.setGcontent(rs.getString("gcontent"));
				dto.setGplot(rs.getString("gplot"));
				dto.setGname(rs.getString("gname"));
				dto.setGread(rs.getInt("gread"));
				dto.setCanum(rs.getInt("canum"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return dto;
	}
	
	// 상품 정보를 수정하는 메소드
	public int update(GoodsDTO dto) {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "update goods set canum = ?, gname = ?, gprice = ?, gcontent = ?, discount = ?, ginum = ? where gnum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getCanum());
			pstmt.setString(2, dto.getGname());
			pstmt.setInt(3, dto.getGprice());
			pstmt.setString(4, dto.getGcontent());
			pstmt.setInt(5, dto.getDiscount());
			pstmt.setInt(6, dto.getGinum());
			pstmt.setInt(7, dto.getGnum());
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return result;
	}
	
	// 상품을 삭제하는 메소드
	public int delete(int gnum) {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "delete from goods where gnum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, gnum);
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return result;
	}
}
