package shop.cart;

public class cartDTO {
	private String gname;//상품명
	private int gprice;//판매가
	private String giname;//이미지
	private int gnum;//상품번호
	private int discount;//할인율
	private int cnum;//장바구니 번호
	private int mnum;//회원번호
	private int canum;//카테고리 번호
	private int ccount;//주문수량
	private int ginum;//이미지 번호
	
	public int getDiscount() {
		return discount;
	}
	public void setDiscount(int discount) {
		this.discount = discount;
	}
	public String getGname() {
		return gname;
	}
	public void setGname(String gname) {
		this.gname = gname;
	}
	public int getGprice() {
		return gprice;
	}
	public void setGprice(int gprice) {
		this.gprice = gprice;
	}
	public String getGiname() {
		return giname;
	}
	public void setGiname(String giname) {
		this.giname = giname;
	}
	public int getGnum() {
		return gnum;
	}
	public void setGnum(int gnum) {
		this.gnum = gnum;
	}
	public int getCnum() {
		return cnum;
	}
	public void setCnum(int cnum) {
		this.cnum = cnum;
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
	public int getCcount() {
		return ccount;
	}
	public void setCcount(int ccount) {
		this.ccount = ccount;
	}
	public int getGinum() {
		return ginum;
	}
	public void setGinum(int ginum) {
		this.ginum = ginum;
	}
	
}
