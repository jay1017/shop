package shop.goods;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class categoryDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	private static categoryDAO instance = new categoryDAO();

	public static categoryDAO getInstance() {
		return instance;
	}

	private categoryDAO() {}
	
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
		//goods에서 해당 canum에 해당하는 모든 값 추출
	public List<categoryDTO> getGoodsList(int canum){
		List<categoryDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "select * from goods where canum=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, canum);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				categoryDTO dto = new categoryDTO();
				dto.setGname(rs.getString("gname"));
				dto.setGprice(rs.getInt("gprice"));
				dto.setGcontent(rs.getString("gcontent"));
				dto.setGinum(rs.getInt("ginum"));
				dto.setGnum(rs.getInt("gnum"));
				list.add(dto);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			endConnection();
		}
		return list;
	}
	//전체 상품보여주기
	public List<categoryDTO> getGoodsList(){
		List<categoryDTO> list = null;
		try {
			conn = getConnection();
			String sql = "select * from goods";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				categoryDTO dto = new categoryDTO();
				dto.setGname(rs.getString("gname"));
				dto.setGprice(rs.getInt("gprice"));
				dto.setGcontent(rs.getString("gcontent"));
				dto.setGinum(rs.getInt("ginum"));
				list.add(dto);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			endConnection();
		}
		return list;
	}
	// canum에 해당하는 카테고리 이름 추출
	public String getCaname(int canum){
		String caname="";
		try {
			conn = getConnection();
			String sql = "select caname from category where canum=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, canum);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				caname = rs.getString("caname");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			endConnection();
		}
		return caname;
	}
	
}
