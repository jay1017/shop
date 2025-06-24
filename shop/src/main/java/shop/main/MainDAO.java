package shop.main;

import java.util.ArrayList;
import java.util.List;
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
			System.out.print("DB연결");
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

	// 트렌드(인기) 상품 목록을 가져오는 메소드 (예시)
	public List<GoodsDTO> getTrendGoods() {
		List<GoodsDTO> goodsList = new ArrayList<>();
		try {
			conn=getConnection();
			String sql="select * from goods where 구매횟수>50";
			pstmt=conn.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			while (rs.next()) {
				GoodsDTO goods = new GoodsDTO();
				
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			endConnection();
		}
		return goodsList;
		}
		
	}

	/*
	 * 신상품 목록을 가져오는 메소드 (예시) 그냥 상품을 가져오고 그 상품의 날짜를 조회하는게 더빠르지않을까? 상품등록일은 쿼리문에서
	 * 조회해야하만 하나? 그냥 select * 해서 조회하고 dto에 담아서 return한다음에 List<GoodsDTO>
	 * goods=dao.getGoods(); 그리고 jsp에서 if문처리하면 되지 않나? if(goods.getreg_date==sysdate)
	 * { for(GoodsDTO dto:goods) { 새로운 상품목록:<div class=""> <%=dto.getImage()%>
	 * <%=dto.getImage()%> <%=dto.getImage()%> </div> } } 구매횟수 많은 상품의 경우는?
	 * if(goods.buycount>100) { for(GoodsDTO dto:goods) { <%=dto.getImage()%>
	 * <%=dto.getGname()%> <%=dto.getGcount()%> 이런느낌 } }
	 */
	public List<GoodsDTO> getNewGoods() {
		List<GoodsDTO> goodsList = new ArrayList<>();
		// DB에 연결하여 신상품들을 조회하고 GoodsList에 추가

		return goodsList;
	}
}
