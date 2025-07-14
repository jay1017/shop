package shop.buy;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BuyListDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	private static BuyListDAO instance = new BuyListDAO();

	public static BuyListDAO getInstance() {
		return instance;
	}

	private BuyListDAO() {
	}

	//DB 접속
	private Connection getConnection() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String url = "jdbc:oracle:thin:@192.168.219.198:1521:orcl";
			conn = DriverManager.getConnection(url, "team02", "1234");
			
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
	//회원이 구매한 상품 불러오기
	public List<BuyListDTO> getBuybyMnum(int mnum) {
		List<BuyListDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "select  b.mnum, b.bnum, b.gnum, b.bcount, g.ginum, g.gname,(g.gprice - (g.gprice * g.discount / 100)) AS discount, gi.giname, go.gonum, go.gosize from buyer b join goods g on b.gnum = g.gnum join goods_image gi on g.ginum=gi.ginum join goods_option go on g.gnum=go.gnum where mnum=? order by bnum desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BuyListDTO dto = new BuyListDTO();
				dto.setMnum(rs.getInt("mnum"));
				dto.setBnum(rs.getInt("bnum"));
				dto.setGnum(rs.getInt("gnum"));
				dto.setBcount(rs.getInt("bcount"));
				dto.setGinum(rs.getInt("ginum"));
				dto.setGname(rs.getString("gname"));
				dto.setDiscount(rs.getInt("discount"));
				dto.setGiname(rs.getString("giname"));
				dto.setGonum(rs.getInt("gonum"));
				dto.setGosize(rs.getString("gosize"));
				list.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			endConnection();		
		}
		return list;
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
