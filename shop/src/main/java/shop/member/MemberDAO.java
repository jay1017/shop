package shop.member;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
				mdto.setMnum(rs.getInt("mnum"));
				mdto.setMid(rs.getString("mid"));
				mdto.setMpw(rs.getString("mpw"));
				mdto.setMname(rs.getString("mname"));
				mdto.setMphone(rs.getString("mphone"));
				mdto.setMemail(rs.getString("memail"));
				mdto.setMgender(rs.getInt("mgender"));
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
			String sql = "insert into member2(mnum, mid, mpw, mname, mphone, memail, mgender, kakao_id, naver_id) "
					+ "values(member2_seq.nextval,? ,? ,? ,? ,? ,? ,? ,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mdto.getMid());
			pstmt.setString(2, mdto.getMpw());
			pstmt.setString(3, mdto.getMname());
			pstmt.setString(4, mdto.getMphone());
			pstmt.setString(5, mdto.getMemail());
			pstmt.setInt(6, mdto.getMgender());
			pstmt.setString(7, mdto.getKakao_id());
			pstmt.setString(8, mdto.getNaver_id());
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(conn != null)try {conn.close();}catch(Exception e) {}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {}
			if(rs != null)try {rs.close();}catch(Exception e) {}
		}
	}
	
	//kakao아이디 조회 메서드
	public MemberDTO getMemberByKakaoId(String kakaoid) {
		MemberDTO mdto = null;
		try {
			conn = getConnection();
			String sql = "select * from member2 where kakao_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, kakaoid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				mdto = new MemberDTO();
				mdto.setMnum(rs.getInt("mnum"));
				mdto.setMid(rs.getString("mid"));
				mdto.setMpw(rs.getString("mpw"));
				mdto.setMname(rs.getString("mname"));
				mdto.setMphone(rs.getString("mphone"));
				mdto.setMemail(rs.getString("memail"));
				mdto.setMgender(rs.getInt("mgender"));
				mdto.setKakao_id(rs.getString("kakao_id"));
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
				mdto.setMnum(rs.getInt("mnum"));
				mdto.setMid(rs.getString("mid"));
				mdto.setMpw(rs.getString("mpw"));
				mdto.setMname(rs.getString("mname"));
				mdto.setMphone(rs.getString("mphone"));
				mdto.setMemail(rs.getString("memail"));
				mdto.setMgender(rs.getInt("mgender"));
				mdto.setKakao_id(rs.getString("kakao_id"));
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
				int gendercode = rs.getInt("mgender");
				if(gendercode == 1) {
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
	
	//회원정보 수정 메서드
	public void updateMember(MemberDTO mdto) {
		try {
			conn = getConnection();
			String sql = "update member2 set mpw=?, mname=?, mphone=?, memail=?, mgender=? where mid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mdto.getMpw());
			pstmt.setString(2, mdto.getMname());
			pstmt.setString(3, mdto.getMphone());
			pstmt.setString(4, mdto.getMemail());
			pstmt.setInt(5, mdto.getMgender());
			pstmt.setString(6, mdto.getMid());
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(conn != null)try {conn.close();}catch(Exception e) {}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {}
			if(rs != null)try {rs.close();}catch(Exception e) {}
		}
	}
	
	//회원탈퇴 정보 메서드
	public int SelectMember(String mid, String mpw) {
		int result = 0;
		try {
			conn = getConnection();
			String sql ="select * from member2 where mid=? and mpw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setString(2, mpw);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = 1;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(conn != null)try {conn.close();}catch(Exception e) {}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {}
			if(rs != null)try {rs.close();}catch(Exception e) {}
		}
		return result;
	}
	
	//회원 db삭제 메서드
	public void DeleteMember(String mid) {
		try {
			conn = getConnection();
			String sql = "delete from member2 where mid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(conn != null)try {conn.close();}catch(Exception e) {}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {}
			if(rs != null)try {rs.close();}catch(Exception e) {}
		}
	}
	
	//세션의 mnum값을 통한 회원의 비밀번호 재설정
	public void PwUpdateMember(int mnum,String pw) {
		try {
			conn = getConnection();
			String sql = "update member2 set mpw=? where mnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pw);
			pstmt.setInt(2, mnum);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(conn != null)try {conn.close();}catch(Exception e) {}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {}
			if(rs != null)try {rs.close();}catch(Exception e) {}
		}
	}
	
	//전화번호 중복 확인
	public String getPhone(String phone) {
		String result = "";
		try {
			conn = getConnection();
			String sql = "select mphone from member2 where mphone=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, phone);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(conn != null)try {conn.close();}catch(Exception e) {}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {}
			if(rs != null)try {rs.close();}catch(Exception e) {}
		}
		return result;
	}
	
	//회원가입 아이디 중복확인
	public String getId(String mid) {
		String id = "";
		try {
			conn = getConnection();
			String sql = "select mid from member2 where mid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				id = rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(conn != null)try {conn.close();}catch(Exception e) {}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {}
			if(rs != null)try {rs.close();}catch(Exception e) {}
		}
		return id;
	}

	//회원탈퇴시 카카오 동의해제 메서드
	public void unlinkKakao(String access_token) {
		if(access_token == null || access_token.isEmpty()) {
			System.out.println("access_token이 없어서 카카오 연결 해제를 건너뜁니다.");
			return;
		}
		try {
			URL url = new URL("https://kapi.kakao.com/v1/user/unlink");
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "Bearer " + access_token);
			conn.setDoOutput(true);
			
			OutputStream os = conn.getOutputStream();
			os.flush();
			os.close();
			
			int responseCode = conn.getResponseCode();
			
			BufferedReader br = new BufferedReader(new InputStreamReader(
					responseCode == 200 ? conn.getInputStream() : conn.getErrorStream(), "UTF-8"));
			StringBuilder sb = new StringBuilder();
			String line;
			while((line = br.readLine()) != null) {
				sb.append(line);
			}
			br.close();
			if(responseCode == 200) {
				System.out.println("카카오 연결 해제 성공: "+sb.toString());
			}else {
				System.out.println("카카오 연결 해제 실패 응답코드: "+responseCode);
				System.out.println("응답 내용: " + sb.toString());
			}
		}catch(Exception e) {
			System.out.println("카카오 연결 해제 중 예외 발생: ");
			e.printStackTrace();
		}finally {
			if(conn != null)try {conn.close();}catch(Exception e) {}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {}
			if(rs != null)try {rs.close();}catch(Exception e) {}
		}
	}
	
	//네이버고유id를 통한 회원정보 조회 메서드
	public MemberDTO getNaverMember(String naver_id) {
		MemberDTO mdto = null;
		try {
			conn = getConnection();
			String sql = "select * from member2 where naver_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, naver_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				mdto = new MemberDTO();
				mdto.setMnum(rs.getInt("mnum"));
				mdto.setMid(rs.getString("mid"));
				mdto.setMpw(rs.getString("mpw"));
				mdto.setMname(rs.getString("mname"));
				mdto.setMphone(rs.getString("mphone"));
				mdto.setMemail(rs.getString("memail"));
				mdto.setMgender(rs.getInt("mgender"));
				mdto.setKakao_id(rs.getString("kakao_id"));
				mdto.setNaver_id(rs.getString("naver_id"));
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
	
	//회원탈퇴시 네이버 동의해제 메서드
	public void unlinkNaver(String access_token) {
		try {
			URL url = new URL("https://nid.naver.com/oauth2.0/token?grant_type=delete"
					+"&client_id=xlKrOZe43aUWrCldbgTq"
					+"&client_secret=ZkIXnpMuhw"
					+"&access_token="+access_token
					+"&service_provider=NAVER");
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			while(br.readLine() != null) {
				br.close();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(conn != null)try {conn.close();}catch(Exception e) {}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {}
			if(rs != null)try {rs.close();}catch(Exception e) {}
		}
	}
	// =========================== admin ==========================================
	// 회원의 수
	public int selectCount() {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from member2";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(conn != null)try {conn.close();}catch(Exception e) {}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {}
			if(rs != null)try {rs.close();}catch(Exception e) {}
		}
		return result;
	}
	
	// 회원 리스트
	public List<MemberDTO> selectList(int startRow, int endRow) {
		List<MemberDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "select r, mnum, mid, mname, mphone, memail, mgender "
					+ "from (select rownum r, mnum, mid, mname, mphone, memail, mgender "
					+ "from (select mnum, mid, mname, mphone, memail, mgender "
					+ "from member2 order by mnum desc) order by mnum desc) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MemberDTO dto = new MemberDTO();
				dto.setMnum(rs.getInt("mnum"));
				dto.setMid(rs.getString("mid"));
				dto.setMname(rs.getString("mname"));
				dto.setMphone(rs.getString("mphone"));
				dto.setMemail(rs.getString("memail"));
				dto.setMgender(rs.getInt("mgender"));
				list.add(dto);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(conn != null)try {conn.close();}catch(Exception e) {}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {}
			if(rs != null)try {rs.close();}catch(Exception e) {}
		}
		return list;
	}
}
