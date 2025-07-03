package shop.admin;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MainDAO {
	// DAO 객체 생성
	private static MainDAO dao = new MainDAO();

	// DAO를 가져오는 역할
	public static MainDAO getDAO() {
		return dao;
	}

	// 객체 생성
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	// DAO 생성자
	private MainDAO() { }

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
	
	// 카테고리별 상품 항목 갯수와 이름 조회
	public List<CategoryGoodsDTO> selectCateGoods() {
		List<CategoryGoodsDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "select caname, count(g.gname) as cnt from goods g, category c where g.canum = c.canum group by caname";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CategoryGoodsDTO cg = new CategoryGoodsDTO();
				cg.setCaname(rs.getString("caname"));
				cg.setGcount(rs.getInt("cnt"));
				list.add(cg);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return list;
	}
}
