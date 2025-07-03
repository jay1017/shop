package shop.review;

public class ReviewDTO { //리뷰 테이블 DTO
	private int rnum;	//리뷰번호 pk
	private int gnum;	//상품번호 fk
	private int mnum;	//회원번호 fk
	private int canum;	//카테고리번호 fk
	private int ginum;	//굿즈 이미지 번호 fk
	private String rcontent;//리뷰 내용
	private String mid; //리뷰작성한 유저의 아이디
	private String mname; //리뷰작성한 유저의 이름
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public int getGnum() {
		return gnum;
	}
	public void setGnum(int gnum) {
		this.gnum = gnum;
	}
	public int getMnum() {
		return mnum;
	}
	public void setMnum(int mnum) {
		this.mnum = mnum;
	}
	public int getCanum() {
		return canum;
	}
	public void setCanum(int canum) {
		this.canum = canum;
	}
	public int getGinum() {
		return ginum;
	}
	public void setGinum(int ginum) {
		this.ginum = ginum;
	}
	public String getRcontent() {
		return rcontent;
	}
	public void setRcontent(String rcontent) {
		this.rcontent = rcontent;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
}
