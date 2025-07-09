package shop.review;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import shop.buy.BuyDTO;

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
	
	public void writeReview(ReviewDTO dto) { //리뷰 작성 메소드
		try {
			conn = getConnection();
			String sql = "insert into review values(review_seq.NEXTVAL,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getBnum());
			pstmt.setInt(2, dto.getGonum());
			pstmt.setInt(3, dto.getGnum());
			pstmt.setInt(4, dto.getMnum());
			pstmt.setInt(5, dto.getCanum());
			pstmt.setInt(6, dto.getGinum());
			pstmt.setString(7, dto.getRcontent());			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
	}
	public List<ReviewDTO> getReview(int gnum, int startRow, int endRow) { //리뷰 출력 메소드
		List<ReviewDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "select * from (select rownum as r,rnum,gnum,mnum,canum,ginum,rcontent,mname,mid "
					+ "from ( select re.rnum,re.gnum,re.mnum,re.canum,re.ginum,re.rcontent,m.mname,m.mid from review re, member2 m where re.gnum=? and m.mnum=re.mnum order by re.rnum DESC ) ) where r>=? and r<=?";
					
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, gnum);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ReviewDTO dto = new ReviewDTO();
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
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return list;
	}
	public boolean reviewCheck(int mnum,int gnum) { //리뷰 작성 가능한 bnum인지 체크
		boolean reviewCheck=false;
		try {
			conn=getConnection();
			String sql="select b.bnum from buyer b Left join review r ON b.bnum=r.bnum where b.mnum =? and b.gnum=? and r.bnum is null";
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			pstmt.setInt(2, gnum);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				reviewCheck=true;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			endConnection();
		}
		return reviewCheck;
	}
	public BuyDTO buyCheck(int mnum,int gnum) { //리뷰 작성 가능한 bnum인지 체크
			BuyDTO bdto=new BuyDTO();
		try {
			conn=getConnection();
			String sql="select b.bnum,b.gonum from buyer b Left join review r ON b.bnum=r.bnum where b.mnum =? and b.gnum=? and r.bnum is null";
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			pstmt.setInt(2, gnum);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				bdto.setBnum(rs.getInt("bnum"));
				bdto.setGonum(rs.getInt("gonum"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			endConnection();
		}
		return bdto;
	}
	
	public ReviewDTO getUserReview(int gnum, int mnum) { //내 리뷰가져오는 메소드
		ReviewDTO dto = null;
		try {
			conn = getConnection();
			String sql = "select * from review where gnum=? and mnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, gnum);
			pstmt.setInt(2, mnum);
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				dto = new ReviewDTO();
				dto.setRnum(rs.getInt("rnum")); 
				dto.setGnum(rs.getInt("gnum"));
				dto.setMnum(rs.getInt("mnum"));
				dto.setCanum(rs.getInt("canum"));
				dto.setGinum(rs.getInt("ginum"));
				dto.setRcontent(rs.getString("rcontent"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return dto;
	}
	
	// JSP에서 사용하는 메서드 - rnum으로 리뷰 가져오기
	public ReviewDTO getReviewByRnum(int rnum) {
		ReviewDTO dto = null;
		try {
			conn = getConnection();
			String sql = "select * from review where rnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rnum);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new ReviewDTO();
				dto.setRnum(rs.getInt("rnum")); 
				dto.setGnum(rs.getInt("gnum"));
				dto.setMnum(rs.getInt("mnum"));
				dto.setCanum(rs.getInt("canum"));
				dto.setGinum(rs.getInt("ginum"));
				dto.setRcontent(rs.getString("rcontent"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return dto;
	}
	
	// JSP에서 사용하는 메서드 - boolean 반환하도록 수정
	public boolean updateReview(ReviewDTO dto) { //리뷰 수정하는 메소드
		boolean result = false;
		try {
			conn = getConnection();
			String sql = "update review set rcontent=? where rnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getRcontent());
			pstmt.setInt(2, dto.getRnum());
			
			int count = pstmt.executeUpdate();
			result = (count > 0);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return result;
	}
	
	// JSP에서 사용하는 메서드 - boolean 반환하도록 수정
	public boolean reviewDelete(int gnum, int mnum, int rnum) { //리뷰 삭제하는 메소드
		boolean result = false;
		try {
			conn = getConnection();
			String sql = "delete from review where gnum=? and mnum=? and rnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, gnum);
			pstmt.setInt(2, mnum);
			pstmt.setInt(3, rnum);
			
			int count = pstmt.executeUpdate();
			result = (count > 0);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		return result;
	}
	
	public int reviewCount(int gnum) {  //상품의 리뷰 개수 가져오기
		int rcount = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) as rcount from review where gnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, gnum);
			
			rs = pstmt.executeQuery();
			rs.next();
			rcount = rs.getInt(1);
			
			System.out.println(rcount);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			endConnection();
		}
		
		return rcount;
	}
	// rnum과 rcontent만으로 리뷰 수정하는 메서드
	public boolean reviewUpdate(int rnum, String rcontent) {
	    boolean result = false;
	    try {
	        conn = getConnection();
	        String sql = "update review set rcontent=? where rnum=?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, rcontent);
	        pstmt.setInt(2, rnum);
	        
	        int count = pstmt.executeUpdate();
	        result = (count > 0);
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        endConnection();
	    }
	    return result;
	}
}


