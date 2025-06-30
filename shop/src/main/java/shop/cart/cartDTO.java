package shop.cart;

public class cartDTO {
	private String gname;//상품명
	private int gprice;//판매가
	private String giname;//이미지
	private int gnum;//상품번호
	private int discount;//할인율
	private int disprice;
	
	public int getDisprice() {
		return disprice;
	}
	public void setDisprice(int disprice) {
		this.disprice = disprice;
	}
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
	
}
