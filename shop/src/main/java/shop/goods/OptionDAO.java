package shop.goods;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OptionDAO {
	// DAO 객체 생성
		private static OptionDAO instance = new OptionDAO();

		// DAO를 가져오는 역할
		public static OptionDAO getInstance() {
			return instance;
		}

		// 객체 생성
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		// DAO 생성자
		private OptionDAO() {
		}

		// DB 젒고
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
	
	//사이즈 종류 불러오기
		public List<String> getSize() {
			List<String> list = new ArrayList<>();
			try {
				conn = getConnection();
				String sql = "select distinct gosize from goods_option order by gosize asc";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					list.add(rs.getString("gosize"));
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				endConnection();
			}
			return list;
		}
}
