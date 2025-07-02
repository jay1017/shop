package shop.review;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {
		private static ReviewDAO instance = new ReviewDAO();

		// DAO를 가져오는 역할
		public static ReviewDAO getInstance() {
			return instance;
		}

		// 객체 생성
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		// DAO 생성자
		private ReviewDAO() {
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
		public void writeReview(ReviewDTO dto)	{ //리뷰 작성 메소드
			try {
				conn=getConnection();
				String sql="insert into review values(review_seq.NEXTVAL,?,?,?,?,?)";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, dto.getGnum());
				pstmt.setInt(2, dto.getMnum());
				pstmt.setInt(3, dto.getCanum());
				pstmt.setInt(4, dto.getGinum());
				pstmt.setString(5, dto.getRcontent());
				pstmt.executeUpdate();
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				endConnection();
			}
			
		}
		public List<ReviewDTO> getReview(int gnum) { //리뷰 출력 메소드
			List<ReviewDTO> list=new ArrayList<>();
			try {
				conn=getConnection();
				String sql="select * from review where gnum=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, gnum);
				
				rs=pstmt.executeQuery();
				while(rs.next()) {
					ReviewDTO dto=new ReviewDTO();
					dto.setRnum(rs.getInt("rnum"));
					dto.setGnum(rs.getInt("gnum"));
					dto.setMnum(rs.getInt("mnum"));
					dto.setCanum(rs.getInt("canum"));
					dto.setGinum(rs.getInt("ginum"));
					dto.setRcontent(rs.getString("rcontent"));
					list.add(dto);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				endConnection();
			}
			return list;
		}
		public ReviewDTO getUserReview(int gnum,String sid) {
			try {
				conn=getConnection();
				String sql="select * from review where gnum=? and ";
				pstmt=conn.prepareStatement(sql);
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally{
				endConnection();
			}
			return null;
		}
	}

