package shop.buy;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import shop.goods.GoodsDTO;

public class BuyDAO {
	// DAO 객체 생성
	private static BuyDAO dao = new BuyDAO();

	// DAO를 가져오는 역할
	public static BuyDAO getDAO() {
		return dao;
	}

	// 객체 생성
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	// DAO 생성자
	private BuyDAO() { }

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
	
	// 상품의 목록을 가져오는 메소드
	public List<GoodsDTO> selectGoodsList(List<Integer> gnumes) {
		List<GoodsDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			// gnumes에 있는 것 String으로 변환
			String gnum = "";
			for(int i = 0; i < gnumes.size(); i++) {
				int num = gnumes.get(i);
				if(i == gnumes.size() - 1) {
					gnum += num;
				} else {
					gnum += num + ",";
				}
			}
			String sql = "select gnum, gname, gprice, (gprice - (gprice * (discount / 100))) as discount from goods where gnum in(" + gnum + ")";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				GoodsDTO dto = new GoodsDTO();
				dto.setGnum(rs.getInt("gnum"));
				dto.setGname(rs.getString("gname"));
				dto.setGprice(rs.getInt("discount"));
				list.add(dto);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return list;
	}
}
