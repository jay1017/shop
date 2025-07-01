package shop.main;

import java.util.ArrayList;
import java.util.List;
import shop.member.MemberDTO;

import java.sql.*;

public class MainDAO {
	private static MainDAO instance = new MainDAO();

	// DAO를 가져오는 역할
	public static MainDAO getInstance() {
		return instance;
	}

	// 객체 생성
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	// DAO 생성자
	private MainDAO() {
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

	public List<GoodsDTO> getNewGoods() { // 신상품 목록의 상품번호,상품이름을 가져오는 메소드
		List<GoodsDTO> goodsList = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "select gnum,gname from goods ORDER BY reg_date ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				GoodsDTO dto = new GoodsDTO();
				dto.setGnum(rs.getInt("gnum"));
				dto.setGname(rs.getString("gname"));
				goodsList.add(dto);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return goodsList;
	}
	public List<GoodsDTO> getGoods() { // 모든 상품의 정보를 최신순서대로 가져오는 메소드
		List<GoodsDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "select * from goods order by gnum desc";
			pstmt = conn.prepareStatement(sql);
			

			rs = pstmt.executeQuery();
			while (rs.next()) {
				GoodsDTO dto = new GoodsDTO();
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
	public List<GoodsDTO> getGoods(int gnum) { // 특정 상품의 모든정보를 가져오는 메소드
		List<GoodsDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "select * from goods where gnum=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, gnum);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				GoodsDTO dto = new GoodsDTO();
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
	public List<GoodsDTO> getSaleGoods() { // 세일된 상품의 모든정보를 가져오는 메소드
		List<GoodsDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "select gnum,canum,gname,(gprice - (gprice * (discount / 100.0))) as discount,gprice,gcontent,ginum,gread from goods where "
					+ "discount is not null and discount>0";
			pstmt = conn.prepareStatement(sql);
			

			rs = pstmt.executeQuery();
			while (rs.next()) {
				GoodsDTO dto = new GoodsDTO();
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
	public List<GoodsDTO> getTrendGoods() { // 조회수가 일정이상인 상품의 모든정보를 가져오는 메소드
		List<GoodsDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "select * from goods where gread>10";
			pstmt = conn.prepareStatement(sql);
			

			rs = pstmt.executeQuery();
			while (rs.next()) {
				GoodsDTO dto = new GoodsDTO();
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

	public List<GoodsDTO> search(String key,int startRow,int endRow) { // 서치실행 메소드
		List<GoodsDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "select * from ( select rownum as rnum,s.* from"
					+ "(select * from goods where gname like ? or gcontent like ? order by gnum desc) S where rownum<=?) where rnum>=?";
			pstmt = conn.prepareStatement(sql);
	
				pstmt.setString(1 , "%" + key + "%");
				pstmt.setString(2 , "%" + key + "%");
				pstmt.setInt(3, endRow);
				pstmt.setInt(4, startRow);
				
				
			rs = pstmt.executeQuery();
			while (rs.next()) {
				GoodsDTO dto = new GoodsDTO();
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
	public int searchCount(String key) {
	    int count = 0;
	    String sql = "SELECT COUNT(*) FROM goods WHERE gname LIKE ? or gcontent like ?";
	    try (Connection conn = getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setString(1, "%" + key + "%");
	        pstmt.setString(2, "%" + key + "%");
	        ResultSet rs = pstmt.executeQuery();
	        if (rs.next()) count = rs.getInt(1);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return count;
	}

	public List<CategoryDTO> getCate() { // 카테고리명들을 리스트로 받아오는 작업
		List<CategoryDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "select * from category";
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				CategoryDTO dto = new CategoryDTO();
				dto.setCanum(rs.getInt("canum"));
				dto.setCaname(rs.getString("caname"));
				list.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return list;
	}
	public List<GoodsOptionDTO> getGoodsOption(int gnum) { // 상품의 옵션정보를 가져오는 메소드
		List<GoodsOptionDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "select * from goods_option where gnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,gnum);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				GoodsOptionDTO dto = new GoodsOptionDTO();
				dto.setGonum(rs.getInt("gonum"));
				dto.setGnum(rs.getInt("gnum"));
				dto.setCanum(rs.getInt("canum"));
				dto.setGinum(rs.getInt("ginum"));
				dto.setGocolor(rs.getString("gocolor"));
				dto.setGosize(rs.getString("gosize"));
				dto.setGocount(rs.getString("gocount"));  
				list.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return list;
	}
	public void increaseGread(int gnum) {  //조회수 증가
		try {
			conn = getConnection();
			String sql = "update goods set gread=gread+1 where gnum=? ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, gnum);
			rs = pstmt.executeQuery();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
	}
	public int getMnum(String sid) { //mnum 조회하는 메소드
		int mnum=0;
		try {
			conn=getConnection();
			String sql="select mnum from member2 where mid=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, sid); 
			rs=pstmt.executeQuery();
			if(rs.next()) {
				mnum=rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			endConnection();
		}
		return mnum;
	}
}
