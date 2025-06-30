package shop.goods;

public class categoryDTO {
	private String caname;//카테고리 이름
	private int canum;//카테고리 넘버
	private String gname;//상품 이름
	private int gprice;//가격
	private int discount;
	private String gcontent;//상품설명
	private int gnum;//상품번호
	private int ginum;//상품 이미지번호
	private String giname;
	
	public String getGiname() {
		return giname;
	}
	public void setGiname(String giname) {
		this.giname = giname;
	}
	public String getCaname() {
		return caname;
	}
	public void setCaname(String caname) {
		this.caname = caname;
	}
	public int getCanum() {
		return canum;
	}
	public void setCanum(int canum) {
		this.canum = canum;
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
	public String getGcontent() {
		return gcontent;
	}
	public void setGcontent(String gcontent) {
		this.gcontent = gcontent;
	}
	public int getGnum() {
		return gnum;
	}
	public void setGnum(int gnum) {
		this.gnum = gnum;
	}
	public int getGinum() {
		return ginum;
	}
	public void setGinum(int ginum) {
		this.ginum = ginum;
	}
	public int getDiscount() {
		return discount;
	}
	public void setDiscount(int discount) {
		this.discount = discount;
	}
}
