package shop.goods;

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
	private GoodsDAO() {
		}

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
	
	// 굿즈 상세 정보를 가져오는 메소드
	public GoodsDTO select(int gnum) {
		GoodsDTO dto = new GoodsDTO();
		try {
			conn = getConnection();
			String sql = "select ca.canum, ca.caname, g.gplot, g.gnum, g.gname, g.gprice, g.gcontent, (g.gprice - (g.gprice * (g.discount / 100))) as discount, gi.ginum, gi.giname, gi.gidetail1, gi.gidetail2, gi.gidetail3 from goods g, goods_image gi, category ca where g.canum = ca.canum and g.ginum = gi.ginum and gnum =  ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, gnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setCanum(rs.getInt("canum"));
				dto.setCaname(rs.getString("caname"));
				dto.setGplot(rs.getString("gplot"));
				dto.setGnum(rs.getInt("gnum"));
				dto.setGname(rs.getString("gname"));
				dto.setGprice(rs.getInt("gprice"));
				dto.setGcontent(rs.getString("gcontent"));
				dto.setDiscount(rs.getInt("discount"));
				dto.setGiname(rs.getString("giname"));
				dto.setGinum(rs.getInt("ginum"));
				dto.setGidetail1(rs.getString("gidetail1"));
				dto.setGidetail2(rs.getString("gidetail2"));
				dto.setGidetail3(rs.getString("gidetail3"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return dto;
	}
	
	// 굿즈의 옵션을 불러오는 메소드
	public List<OptionDTO> selectOption(String gname) {
		List<OptionDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "select go.gonum, go.gosize from goods_option go, goods g where g.gnum = go.gnum and g.gname like '%" + gname + "%' order by go.gonum";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OptionDTO dto = new OptionDTO();
				dto.setGonum(rs.getInt("gonum"));
				dto.setGosize(rs.getString("gosize"));
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
