package shop.review;

public class ReviewDTO { //리뷰 테이블 DTO
	private int rnum;	//리뷰번호
	private int gnum;	//상품번호
	private int mnum;	//회원번호
	private int canum;	//카테고리번호
	private int ginum;	//굿즈 이미지 번호
	private String rcontent;//리뷰 내용
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
}
