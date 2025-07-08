package shop.faq;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class faqDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	private Connection getConnection() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String url = "jdbc:oracle:thin:@192.168.219.198:1521:orcl";
			conn = DriverManager.getConnection(url,"team02","1234");
		}catch(Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	public List<faqDTO> getFAQList(){
		List<faqDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "select * from faq order by fcnum, fnum";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				faqDTO fdto = new faqDTO();
				fdto.setFnum(rs.getInt("fnum"));
				fdto.setFcnum(rs.getInt("fcnum"));
				fdto.setFquestion(rs.getString("fquestion"));
				fdto.setFanswer(rs.getString("fanswer"));
				list.add(fdto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(conn != null)try {conn.close();}catch(Exception e) {}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {}
			if(rs != null)try {rs.close();}catch(Exception e) {}
		}
		return list;
	}
}
