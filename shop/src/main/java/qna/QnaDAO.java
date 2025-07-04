package qna;

import java.sql.*;
import java.util.*;
import java.util.*;

public class QnaDAO {

    // DB 연결
    private Connection getConnection() throws Exception {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        String url = "jdbc:oracle:thin:@192.168.219.198:1521:orcl";
        String user = "team02";
        String password = "1234";
        return DriverManager.getConnection(url, user, password);
    }

    // 1. 문의글 등록
    public void insertQna(QnaDTO dto) {
        String sql = "INSERT INTO qna (qnum, mnum, qtitle, qcontent, qdate) VALUES (qna_seq.NEXTVAL, ?, ?, ?, SYSDATE)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, dto.getMnum());
            pstmt.setString(2, dto.getQtitle());
            pstmt.setString(3, dto.getQcontent());

            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 2. 전체 문의글 목록
    public List<QnaDTO> getQnaList() {
        List<QnaDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM qna ORDER BY qnum DESC";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                QnaDTO dto = new QnaDTO();
                dto.setQnum(rs.getInt("qnum"));
                dto.setMnum(rs.getInt("mnum"));
                dto.setQtitle(rs.getString("qtitle"));
                dto.setQcontent(rs.getString("qcontent"));
                dto.setQdate(rs.getTimestamp("qdate"));
                list.add(dto);
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
                    dto.setQdate(rs.getTimestamp("qdate"));
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

    // (선택) 5. 문의글 삭제
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
}      