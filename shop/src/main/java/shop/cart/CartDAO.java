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

	// DB 접속
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

	// 상품번호에 맞는 상품 정보 가져오기
	public CartDTO getCartGoods(int gnum) {
		CartDTO dto = null;
		try {
			conn = getConnection();
			String sql = "select g.gnum, g.gname, g.gprice, gi.giname, (g.gprice-(g.gprice*g.discount/100)) as discount from goods g join goods_image gi on g.ginum=gi.ginum where gnum=?";
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
//	public GoodsDTO selectGoods(int gnum) {
//		GoodsDTO dto = new GoodsDTO();
//		try {
//			conn = getConnection();
//			String sql = "select gnum, canum, gname, gprice, ginum, discount from goods where gnum = ?";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1, gnum);
//			rs = pstmt.executeQuery();
//			while (rs.next()) {
//				dto.setGnum(rs.getInt("gnum"));
//				dto.setCanum(rs.getInt("canum"));
//				dto.setGname(rs.getString("gname"));
//				dto.setGprice(rs.getInt("gprice"));
//				dto.setGinum(rs.getInt("ginum"));
//				dto.setDiscount(rs.getInt("discount"));
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			endConnection();
//		}
//		return dto;
//	}

	// 장바구니에 상품 넣기
	public int insertCart(CartDTO dto) {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "insert into cart values(cart_seq.nextval, ?, ?, ?, ?, ?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getMnum());
			pstmt.setInt(2, dto.getGnum());
			pstmt.setInt(3, dto.getCanum());
			pstmt.setInt(4, dto.getCcount());
			pstmt.setInt(5, dto.getGinum());
			pstmt.setInt(6, dto.getGonum());
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

	// 해당상품의 gonum 옵션번호 불러오기
	public int getGonum(int gnum) {
		int gonum = 0;
		try {
			conn = getConnection();
			String sql = "select go.gonum from goods_option go join goods g on go.gnum=g.gnum where g.gnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, gnum);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				gonum = rs.getInt("gonum");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return gonum;
	}

	// 회원번호로 카트정보 불러오기
	public List<CartDTO> getCartByMnum(int mnum) {
		List<CartDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "select c.cnum,c.gnum,c.canum,c.ccount, c.ginum, c.gonum, g.gname, g.gprice, "
					+ " (g.gprice - (g.gprice * g.discount / 100)) AS discount,gi.giname,go.gosize "
					+ " from cart c join goods g on c.gnum = g.gnum join goods_image gi on g.ginum=gi.ginum join goods_option go on go.gnum=g.gnum where c.mnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				CartDTO dto = new CartDTO();
				dto.setCnum(rs.getInt("cnum"));
				dto.setGnum(rs.getInt("gnum"));
				dto.setCanum(rs.getInt("canum"));
				dto.setCcount(rs.getInt("ccount"));
				dto.setGinum(rs.getInt("ginum"));
				dto.setGonum(rs.getInt("gonum"));
				dto.setGname(rs.getString("gname"));
				dto.setGprice(rs.getInt("gprice"));
				dto.setDiscount(rs.getInt("discount"));
				dto.setGiname(rs.getString("giname"));
				dto.setGosize(rs.getString("gosize"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return list;
	}

	// 장바구니 수정하기(수량)
	public int updateCart(int ccount, int gnum) {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "update cart set ccount=? where gnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ccount);
			pstmt.setInt(2, gnum);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return result;
	}

	// 장바구니에서 상품 삭제하기
	public int deleteCart(int gnum, int mnum) {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "delete from cart where gnum=? and mnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, gnum);
			pstmt.setInt(2, mnum);
			result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			endConnection();
		}
		return result;
	}
	
	//장바구니에 기존 상품 조회
	public boolean goodsEquals(int gnum, int mnum) {
		try {
			conn = getConnection();
			String sql = "select count(*) from cart where gnum=? and mnum=?";
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, gnum);
			pstmt.setInt(2, mnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int count = rs.getInt(1);
				if(count > 0) {
					return true;
					//상품이 있으면 true
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			endConnection();
		}//상품 없으면 false
		return false;
	}
	//기존상품이 있으면 장바구니에 수량증가
	public void updateCount(int mnum, int gnum, int count) {
		try {
			conn = getConnection();
			String sql = "update cart set ccount = ccount + ? where mnum=? and gnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, count);
			pstmt.setInt(2, mnum);
			pstmt.setInt(3, gnum);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			endConnection();
		}
	}
	//구매 후 cart에서 삭제
	public int deleteByBuy(int gnum, int mnum) {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "delete from cart where gnum=? and mnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, gnum);
			pstmt.setInt(2, mnum);
			result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			endConnection();
		}
		return result;
	}
	//gonum에 해당하는 상품번호 가져오기
	public int getGnumByGonum(int gonum) {
		int gnum = 0;
		try {
			conn = getConnection();
			String sql = "select gnum from goods_option where gonum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, gonum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				gnum = rs.getInt("gnum");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			endConnection();
		}
		return gnum;
	}
}
