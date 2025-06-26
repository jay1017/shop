package shop.member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MemberDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	//db연결
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
	
	//midcheck.jsp에서 사용
	//회원가입시 입력한 값과 db의 값을 비교하여 일치하는 mid가 있는지 확인하기 위해
	//db에서 해당 mid값으로 정보가 있는지 조회
	public MemberDTO getMidname(String mid) {
		MemberDTO mdto = null;
		try {
			conn = getConnection();
			String sql = "select * from member2 where mid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				mdto = new MemberDTO();
				mdto.setMid(rs.getString("mid"));
				mdto.setMpw(rs.getString("mpw"));
				mdto.setMname(rs.getString("mname"));
				mdto.setMphone(rs.getString("mphone"));
				mdto.setMemail(rs.getString("memail"));
				mdto.setMgender(rs.getString("mgender"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(conn != null)try {conn.close();}catch(Exception e) {}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {}
			if(rs != null)try {rs.close();}catch(Exception e) {}
		}
		return mdto;
	}
	
	//회원가입시 memberForm에서 받은 값을 db에 저장
	public void InputMember(MemberDTO mdto) {
		try {
			conn = getConnection();
			String sql = "insert into member2(mnum, mid, mpw, mname, mphone, memail, mgender) "
					+ "values(member2_seq.nextval,? ,? ,? ,? ,? ,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mdto.getMid());
			pstmt.setString(2, mdto.getMpw());
			pstmt.setString(3, mdto.getMname());
			pstmt.setString(4, mdto.getMphone());
			pstmt.setString(5, mdto.getMemail());
			pstmt.setString(6, mdto.getMgender());
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(conn != null)try {conn.close();}catch(Exception e) {}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {}
			if(rs != null)try {rs.close();}catch(Exception e) {}
		}
	}
	
	//memberInfo.jsp & updateMpwCheckTest.jsp 회원정보 확인
	public MemberDTO getInfo(String sid) {
		MemberDTO mdto = null;
		try {
			conn = getConnection();
			String sql ="select * from member2 where mid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				mdto = new MemberDTO();
				mdto.setMid(rs.getString("mid"));
				mdto.setMpw(rs.getString("mpw"));
				mdto.setMname(rs.getString("mname"));
				mdto.setMphone(rs.getString("mphone"));
				mdto.setMemail(rs.getString("memail"));
				mdto.setMgender(rs.getString("mgender"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(conn != null)try {conn.close();}catch(Exception e) {}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {}
			if(rs != null)try {rs.close();}catch(Exception e) {}
		}
		return mdto;
	}
	
	//성별이 1이면 남자 2이면 여자 출력
	public String setGender(String sid) {
		String Gender = "";
		try {
			conn = getConnection();
			String sql = "select mgender from member2 where mid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String gendercode = rs.getString("mgender");
				if("1".equals(gendercode)) {
					Gender = "남성";
				}else{
					Gender = "여성";
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(conn != null)try {conn.close();}catch(Exception e) {}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {}
			if(rs != null)try {rs.close();}catch(Exception e) {}
		}
		return Gender;
	}
	
}
