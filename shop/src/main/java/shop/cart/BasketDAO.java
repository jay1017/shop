package basket;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import basket.BasketDTO;
import basket.BasketDAO;

public class BasketDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	private static BasketDAO instance = new BasketDAO();

	public static BasketDAO getInstance() {
		return instance;
	}

	private BasketDAO() {
	}

//DB 젒고
	private Connection getConnection() {

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String url = "jdbc:oracle:thin:@192.168.219.198:1521:orcl";
			conn = DriverManager.getConnection(url, "team02", "1234");
			System.out.println("DB연결");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("연결 실패");
		}

		return conn;
	}

	// 연결끊는 메서드
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

	public List<BasketDTO> getCart(String name) {
		List<BasketDTO> list = null;
		try {

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return list;
	}
}
