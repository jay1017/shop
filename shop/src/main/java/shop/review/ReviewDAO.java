package shop.review;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ReviewDAO {
		private static ReviewDAO instance = new ReviewDAO();

		// DAO를 가져오는 역할
		public static ReviewDAO getInstance() {
			return instance;
		}

		// 객체 생성
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		// DAO 생성자
		private ReviewDAO() {
		}

		// 커넥션 연결
		private Connection getConnection() {
			try {
				Class.forName("oracle.jdbc.driver.OracleDriver");
				String url = "jdbc:oracle:thin:@192.168.219.198:1521:orcl";
				conn = DriverManager.getConnection(url, "team02", "1234");
			} catch (Exception e) {
				System.out.print(e.toString());
				e.printStackTrace();
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
	}

