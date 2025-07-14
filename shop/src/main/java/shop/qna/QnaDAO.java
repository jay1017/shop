package shop.qna;

import java.sql.*;
import java.util.ArrayList;
import java.util.*;


public class QnaDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	 private static QnaDAO instance = new QnaDAO();

	   public static QnaDAO getInstance() {
	      return instance;
	   }

	   private QnaDAO() {
	   }
	   
	// DB 접속
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
	   
    // 1. 문의 등록
    public void insertQna(QnaDTO dto) {   
        try{
        	Connection conn = getConnection();
        	String sql = "INSERT INTO QNA (qnum, mnum, qtitle, qcontent, mid) VALUES (qna_seq.NEXTVAL, ?, ?, ?, ?)";
        	pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, dto.getMnum());
            pstmt.setString(2, dto.getQtitle());
            pstmt.setString(3, dto.getQcontent());
            pstmt.setString(4, dto.getMid());
            pstmt.executeUpdate();
            System.out.println("문의 등록 완료");

        } catch (Exception e) {
            e.printStackTrace();
        }finally {
        	endConnection();
        }
    }

    // 2. 전체 목록
    public List<QnaDTO> getQnaList(int mnum) {
        List<QnaDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM qna ORDER BY qnum DESC";
        
        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
            ResultSet rs = pstmt.executeQuery();		
        ) {
            while (rs.next()) {
                QnaDTO dto = new QnaDTO();
                dto.setQnum(rs.getInt("qnum"));
                dto.setMnum(rs.getInt("mnum"));
                dto.setQtitle(rs.getString("qtitle"));
                dto.setQcontent(rs.getString("qcontent"));
                list.add(dto);  
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            return list;
        }
    
 // 2-2. 특정 회원의 문의 목록
    public List<QnaDTO> getQnaList(int mnum) {
        List<QnaDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM qna WHERE mnum = ? ORDER BY qnum DESC";

        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setInt(1, mnum);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    QnaDTO dto = new QnaDTO();
                    dto.setQnum(rs.getInt("qnum"));
                    dto.setMnum(rs.getInt("mnum"));
                    dto.setMid(rs.getString("mid"));
                    dto.setQtitle(rs.getString("qtitle"));
                    dto.setQcontent(rs.getString("qcontent"));
                    list.add(dto);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    
    // 3. 특정 문의글 조회
    public QnaDTO getQna(int qnum) {
        QnaDTO dto = null;
        String sql = "SELECT * FROM qna WHERE qnum = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, qnum);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    dto = new QnaDTO();
                    dto.setQnum(rs.getInt("qnum"));
                    dto.setMnum(rs.getInt("mnum"));
                    dto.setQtitle(rs.getString("qtitle"));
                    dto.setQcontent(rs.getString("qcontent"));
                    
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dto;
    }


    // 4. 문의글 수정
    public void updateQna(QnaDTO dto) {
        String sql = "UPDATE qna SET qtitle = ?, qcontent = ? WHERE qnum = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, dto.getQtitle());
            pstmt.setString(2, dto.getQcontent());
            pstmt.setInt(3, dto.getQnum());

            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 5. 문의글 삭제
    public void deleteQna(int qnum) {
        String sql = "DELETE FROM qna WHERE qnum = ?";

        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setInt(1, qnum);
            pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // 6. 회원 번호에 맞는 아이디를 받아오는 메소드
    public String getId(int mnum) {
        String id = null;
        String sql = "SELECT mid FROM member WHERE mnum = ?";

        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setInt(1, mnum);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    id = rs.getString("mid");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return id;
    }
}