package shop.cart;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import shop.main.GoodsDTO;

public class CartDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	private static CartDAO instance = new CartDAO();

	public static CartDAO getInstance() {
		return instance;
	}

	private CartDAO() {
	}

	//DB 접속
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

	//상품번호에 맞는 상품 정보 가져오기
	public CartDTO getCartGoods(int gnum) {
		CartDTO dto = null;
		try {
			conn = getConnection();
			String sql = "select gnum, gname, gprice, giname, discount from goods where gnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, gnum);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new CartDTO();
				dto.setGnum(rs.getInt("gnum"));
				dto.setGname(rs.getString("gname"));
				dto.setGprice(rs.getInt("gprice"));
				dto.setGiname(rs.getString("giname"));
				dto.setDiscount(rs.getInt("discount"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return dto;
	}

	// 장바구니 조회
	public CartDTO getCart(int gnum) {
		CartDTO dto = null;
		try {
			conn = getConnection();
			String sql = "select gnum, gname, gprice, ginum, discount from goods where gnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, gnum);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				dto = new CartDTO();
				dto.setGnum(rs.getInt("gnum"));
				dto.setGname(rs.getString("gname"));
				dto.setGprice(rs.getInt("gprice"));
				dto.setGinum(rs.getInt("ginum"));
				dto.setDiscount(rs.getInt("discount"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return dto;
	}

	//장바구니에 상품 넣기
	public int insertCart(CartDTO dto) {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "insert into cart values(cart_seq.nextval, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getMnum());
			pstmt.setInt(2, dto.getGnum());
			pstmt.setInt(3, dto.getCanum());
			pstmt.setInt(4, dto.getCcount());
			pstmt.setInt(5, dto.getGinum());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return result;
	}

	// 회원ID로 회원번호 조회
	public int getMnum(String sid) {
		int mnum = 0;
		try {
			conn = getConnection();
			String sql = "select mnum from member2 where mid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				mnum = rs.getInt("mnum");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return mnum;
	}
}
