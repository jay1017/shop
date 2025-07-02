package qna;

import java.sql.*;
import java.util.*;

public class QnaDAO {

    private Connection getConnection() throws Exception {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        String url = "jdbc:oracle:thin:@192.168.219.198:1521:orcl";
        String user = "team02";      
        String password = "1234";  
        return DriverManager.getConnection(url, user, password);
    }
    
    
    
    
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

    
    public void updateQna(QnaDTO dto) {
    	String sql = "UPDATE qna SET qtitle=?, qcontent=? WHERE qnum=?";

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

    
    public void deleteQna(int qnum) {
        String sql = "DELETE FROM qna WHERE qnum = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, qnum);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void insertQna(QnaDTO dto) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = getConnection();
            String sql = "INSERT INTO qna (qnum, mnum, qtitle, qcontent) VALUES (qna_seq.nextval, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, dto.getMnum());
            pstmt.setString(2, dto.getQtitle());
            pstmt.setString(3, dto.getQcontent());

            int result = pstmt.executeUpdate();
            System.out.println("insertQna 실행 결과: " + result);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }

    public List<QnaDTO> getQnaList() {
        List<QnaDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = getConnection();
            String sql = "SELECT QNUM, MNUM, QTITLE, QCONTENT FROM QNA ORDER BY QNUM DESC";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                QnaDTO dto = new QnaDTO();
                dto.setQnum(rs.getInt("QNUM"));
                dto.setMnum(rs.getInt("MNUM"));
                dto.setQtitle(rs.getString("QTITLE"));
                dto.setQcontent(rs.getString("QCONTENT"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }

        return list;
    }
}
	        