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
		public List<ReviewDTO> getReview(int gnum,int startRow,int endRow) { //리뷰 출력 메소드
			List<ReviewDTO> list=new ArrayList<>();
			try {
				conn=getConnection();
				String sql="select * from (select rownum as r,rnum,gnum,mnum,canum,ginum,rcontent,mname,mid "
						+ "from ( select re.rnum,re.gnum,re.mnum,re.canum,re.ginum,re.rcontent,m.mname,m.mid from review re, member2 m where re.gnum=? and m.mnum=re.mnum order by re.rnum DESC ) ) where r>=? and r<=?";
						
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, gnum);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
				
				rs=pstmt.executeQuery();
				while(rs.next()) {
					ReviewDTO dto=new ReviewDTO();
					dto.setRnum(rs.getInt("rnum"));
					dto.setGnum(rs.getInt("gnum"));
					dto.setMnum(rs.getInt("mnum"));
					dto.setCanum(rs.getInt("canum"));
					dto.setGinum(rs.getInt("ginum"));
					dto.setRcontent(rs.getString("rcontent"));
					dto.setMname(rs.getString("mname"));
					dto.setMid(rs.getString("mid"));
					list.add(dto);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				endConnection();
			}
			return list;
		}
		public ReviewDTO getUserReview(int gnum,int mnum) { //내 리뷰가져오는 메소드
				ReviewDTO dto=null;
			try {
				conn=getConnection();
				String sql="select * from review where gnum=? and mnum=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, gnum);
				pstmt.setInt(2, mnum);
				
				rs=pstmt.executeQuery();
				while(rs.next()) {
					dto = new ReviewDTO();
					dto.setRnum(rs.getInt("rnum")); 
					dto.setGnum(rs.getInt("gnum"));
					dto.setMnum(rs.getInt("mnum"));
					dto.setCanum(rs.getInt("canum"));
					dto.setGinum(rs.getInt("ginum"));
					dto.setRcontent(rs.getString("rcontent"));
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally{
				endConnection();
			}
			return dto;
		}
		public void updateReview(ReviewDTO dto) { //리뷰 수정하는 메소드
			try {
				conn=getConnection();
				String sql="update review set rcontent=? where rnum=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, dto.getRcontent());
				pstmt.setInt(2, dto.getRnum());
				
				pstmt.executeUpdate();
			}catch(Exception e){
				e.printStackTrace();
			}finally {
				endConnection();
			}
		}
		public void reviewDelete(int gnum,int mnum,int rnum) { //리뷰 삭제하는 메소드
			try {
				conn=getConnection();
				String sql="delete from review where gnum=? and mnum=? and rnum=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, gnum);
				pstmt.setInt(2, mnum);
				pstmt.setInt(3, rnum);
				
				pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				endConnection();
			}
		}
		public int reviewCount(int gnum) {  //상품의 리뷰 개수 가져오기
			int rcount=0;
			try {
				
				conn=getConnection();
				String sql="select count(*) as rcount from review where gnum=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, gnum);
				
				rs=pstmt.executeQuery();
				rs.next();
				rcount=rs.getInt(1);
				
				System.out.println(rcount);
			}catch(Exception e) {
				e.printStackTrace();
			}finally{
				endConnection();
			}
			
			return rcount;
		}
		
	}

