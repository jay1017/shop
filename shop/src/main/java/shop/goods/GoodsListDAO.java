package shop.goods;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class GoodsListDAO {
	// DAO 객체 생성
	private static GoodsListDAO instance = new GoodsListDAO();

	// DAO를 가져오는 역할
	public static GoodsListDAO getInstance() {
		return instance;
	}

	// 객체 생성
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	// DAO 생성자
	private GoodsListDAO() {
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
 
	// 상품 전체 불러오기 신제품순서
	public List<GoodsListDTO> getGoods() {
		List<GoodsListDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "select gnum,canum,gname,gprice,gcontent,ginum,(gprice - (gprice * discount / 100)) as discount,gread from goods order by gnum desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				GoodsListDTO dto = new GoodsListDTO();
				dto.setGnum(rs.getInt("gnum"));
				dto.setCanum(rs.getInt("canum"));
				dto.setGname(rs.getString("gname"));
				dto.setGprice(rs.getInt("gprice"));
				dto.setGcontent(rs.getString("gcontent"));
				dto.setGinum(rs.getInt("ginum"));
				dto.setDiscount(rs.getInt("discount"));
				dto.setGread(rs.getInt("gread"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return list;
	}
	//한 페이지에 보여줄 상품 수
	public List<GoodsListDTO> getGoods(int start, int end){
		List<GoodsListDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "select * from"
					+ "(select rownum rnum, a.* from(select g.gnum, g.canum, g.gname, g.gprice, g.gcontent, g.ginum, (g.gprice-(g.gprice*g.discount/100)) as discount, g.gread "
					+ ",gi.giname from goods g join goods_image gi on g.ginum = gi.ginum order by g.gnum desc) a where rownum<=?) where rnum >=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, end);
			pstmt.setInt(2, start);
			rs= pstmt.executeQuery();
			while(rs.next()) {
				GoodsListDTO dto = new GoodsListDTO();
				dto.setGnum(rs.getInt("gnum"));
	            dto.setCanum(rs.getInt("canum"));
	            dto.setGname(rs.getString("gname"));
	            dto.setGprice(rs.getInt("gprice"));
	            dto.setGcontent(rs.getString("gcontent"));
	            dto.setGinum(rs.getInt("ginum"));
	            dto.setDiscount(rs.getInt("discount"));
	            dto.setGread(rs.getInt("gread"));
	            list.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			endConnection();
		}
		return list;
	}
	//카테고리 번호,이름 받기
	public List<GoodsListDTO> getCate(){
		List<GoodsListDTO> list = null;
		try {
			conn = getConnection();
			String sql = "select * from category";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				GoodsListDTO dto = new GoodsListDTO();
				dto.setCanum(rs.getInt("canum"));
				dto.setCaname(rs.getString("caname"));
				list.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			endConnection();
		}
		return list;
	}

	//전체 상품 수
	public int getGoodsCount() {
		int count = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from goods";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			endConnection();
		}
		return count;
	}
	//사이즈 별 상품 출력
	public List<GoodsListDTO> getGoodsBySize(String size){
		List<GoodsListDTO> list = new ArrayList<>();
		try {
			GoodsListDTO dto = new GoodsListDTO();
			conn = getConnection();
			String sql = "select g.gnum, g.gname, g.gprice, (g.gprice-(g.gprice*g.discount/100)) as discount, gi.giname from goods g join goods_image gi on g.ginum = gi.ginum "
					+ "join goods_option go on g.gnum = go.gnum where go.gosize = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, size);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				dto.setGnum(rs.getInt("gnum"));
				dto.setGname(rs.getString("gname"));
				dto.setGprice(rs.getInt("gprice"));
				dto.setDiscount(rs.getInt("discount"));
				dto.setGiname(rs.getString("giname"));
				list.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			endConnection();
		}
		return list;
	}
	//가격 별 상품 출력
		public List<GoodsListDTO> getGoodsByPrice(int price,int start, int end){
			List<GoodsListDTO> list = new ArrayList<>();
			try {
				GoodsListDTO dto = new GoodsListDTO();
				conn = getConnection();
				String sql = "SELECT * FROM (SELECT ROWNUM rnum, a.* FROM (SELECT * FROM goods WHERE gprice >= ? AND gprice < ? ORDER BY gnum DESC) a WHERE ROWNUM <= ?) WHERE rnum >= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, price);
				pstmt.setInt(2, price+500000);
				pstmt.setInt(3, end);
				pstmt.setInt(4, start);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					dto.setGnum(rs.getInt("gnum"));
					dto.setGname(rs.getString("gname"));
					dto.setGprice(rs.getInt("gprice"));
					dto.setDiscount(rs.getInt("discount"));
					dto.setGiname(rs.getString("giname"));
					list.add(dto);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				endConnection();
			}
			return list;
		}
		//카테고리 별 상품 출력
				public List<GoodsListDTO> getGoodsByCate(int canum){
					List<GoodsListDTO> list = new ArrayList<>();
					try {
						GoodsListDTO dto = new GoodsListDTO();
						conn = getConnection();
						String sql = "select g.gnum,g.gname, g.gprice, (g.gprice-(g.gprice*g.discount/100)) as discount, gi.giname from goods g "
								+ "join goods_image gi on g.ginum = gi.ginum where canum=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, canum);
						rs = pstmt.executeQuery();
						while(rs.next()) {
							dto.setGnum(rs.getInt("gnum"));
							dto.setGname(rs.getString("gname"));
							dto.setGprice(rs.getInt("gprice"));
							dto.setDiscount(rs.getInt("discount"));
							dto.setGiname(rs.getString("giname"));
							list.add(dto);
						}
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						endConnection();
					}
					return list;
				}
}
