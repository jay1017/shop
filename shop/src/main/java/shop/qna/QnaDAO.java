package shop.qna;

import java.sql.*;
import java.util.ArrayList;
import java.util.*;


public class QnaDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// Singleton instance
	private static QnaDAO instance = new QnaDAO();

	// 외부에서 생성 못 하도록 private 생성자
	private QnaDAO() {}
	 
	// Singleton 객체 얻는 메서드
	public static QnaDAO getInstance() {
	      return instance;
	   }
	   
	// DB 연결 메서드
	   private Connection getConnection() {
	      try {
	         Class.forName("oracle.jdbc.driver.OracleDriver");
	         String url = "jdbc:oracle:thin:@192.168.219.198:1521:orcl";
	         conn = DriverManager.getConnection(url, "team02", "1234");
	      } catch (Exception e) {
	         e.printStackTrace();
	         
	      }
	      return conn;
	   }

	   //   연결끊는 메서드
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
        	conn = getConnection();  // ✅ 클래스 필드 사용
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

    // 2-1. 전체 문의 목록 (파라미터 없는 버전)
    public List<QnaDTO> getQnaList() {
        List<QnaDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM qna ORDER BY qnum DESC";
        
        try {
            conn = getConnection();  // 클래스 필드 사용
            pstmt = conn.prepareStatement(sql); 
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                QnaDTO dto = new QnaDTO();
                dto.setQnum(rs.getInt("qnum"));
                dto.setMnum(rs.getInt("mnum"));
                dto.setMid(rs.getString("mid"));
                dto.setQtitle(rs.getString("qtitle"));
                dto.setQcontent(rs.getString("qcontent"));
                
                list.add(dto); 
                
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                endConnection();
            }

            return list;
        }
    
    // 2-2. 특정 회원의 문의 목록
    public List<QnaDTO> getQnaList(int mnum) {
        List<QnaDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM qna WHERE mnum = ? ORDER BY qnum DESC";

        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
         
        ) {
            pstmt.setInt(1, mnum);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    QnaDTO dto = new QnaDTO();
                    dto.setQnum(rs.getInt("qnum"));
                    dto.setMnum(rs.getInt("mnum"));
                    dto.setQtitle(rs.getString("qtitle"));
                    dto.setQcontent(rs.getString("qcontent"));
                    dto.setMid(rs.getString("mid"));
                    list.add(dto);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    
 // 2-3. 전체 목록 (페이징 포함)
    public List<QnaDTO> getQnaList(int startRow, int endRow) {
        List<QnaDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM (SELECT qna.*, ROWNUM r FROM (SELECT * FROM qna ORDER BY qnum DESC) qna) WHERE r >= ? AND r <= ?";

        try {
            conn = getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, startRow);
            pstmt.setInt(2, endRow);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                QnaDTO dto = new QnaDTO();
                dto.setQnum(rs.getInt("qnum"));
                dto.setMnum(rs.getInt("mnum"));
                dto.setMid(rs.getString("mid"));
                dto.setQtitle(rs.getString("qtitle"));
                dto.setQcontent(rs.getString("qcontent"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            endConnection();
        }

        return list;
    }

    // 전체 게시글 개수 반환
    public int getQnaCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM qna";

        try {
            conn = getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            endConnection();
        }

        return count;
    }

    
 // 3. 특정 문의글 조회
    public QnaDTO getQna(int qnum) {
        QnaDTO dto = null;
        String sql = "SELECT * FROM qna WHERE qnum = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setInt(1, qnum);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    dto = new QnaDTO();
                    dto.setQnum(rs.getInt("qnum"));
                    dto.setMnum(rs.getInt("mnum"));
                    dto.setQtitle(rs.getString("qtitle"));
                    dto.setQcontent(rs.getString("qcontent"));
                    dto.setMid(rs.getString("mid"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return dto;
    }



    // 4. 문의글 수정
    public void updateQna(QnaDTO dto) {
    	String sql = "UPDATE qna SET qtitle = ?, qcontent = ? WHERE qnum = ? AND mid = ?";

        try (
        	Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {

        	pstmt.setString(1, dto.getQtitle());
        	pstmt.setString(2, dto.getQcontent());
        	pstmt.setInt(3, dto.getQnum());
        	pstmt.setString(4, dto.getMid());

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