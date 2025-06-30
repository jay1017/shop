package shop.cart;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import shop.main.GoodsDTO;

public class cartDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	private static cartDAO instance = new cartDAO();

	public static cartDAO getInstance() {
		return instance;
	}

	private cartDAO() {
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

//상품번호에 맞는 상품 정보 가져오기
	public cartDTO getCartGoods(int gnum) {
		cartDTO dto = null;
		try {
			conn = getConnection();
			String sql = "select gnum, gname, gprice, giname, discount from goods where gnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, gnum);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new cartDTO();
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
	//장바구니에 담기
	public cartDTO getCartAdd(int gnum) {
		cartDTO dto = null;
		try {
			conn = getConnection();
			String sql = "select gnum, gname, gprice, giname, discount from goods";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				dto = new cartDTO();
				dto.setGnum(rs.getInt("gnum"));
				dto.setGname(rs.getString("gname"));
				dto.setGprice(rs.getInt("gprice"));
				dto.setGiname(rs.getString("giname"));
				dto.setDiscount(rs.getInt("discount"));	
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			endConnection();
		}
		return dto;
	}
//장바구니에 상품 넣기
	public List<Integer> insertCart(cartDTO dto) {
		List<Integer> result = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "select cart_seq.nextval from dual";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int nextVal = 0;
			if(rs.next()) {
				nextVal = rs.getInt(1);
				result.add(nextVal);
			}
			if(nextVal != 0) {
				sql = "insert into cart values(?, ?, ?, ?, ?, ?, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, nextVal);
				pstmt.setInt(2, dto.getCnum());
				pstmt.setInt(3, dto.getMnum());
				pstmt.setInt(4, dto.getGnum());
				pstmt.setInt(5, dto.getCanum());
				pstmt.setInt(6, dto.getCcount());
				pstmt.setInt(7, dto.getGinum());
				int res = pstmt.executeUpdate();
				result.add(res);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			endConnection();
		}
		return result;
	}
	
}
