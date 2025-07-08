package shop.point;

import java.util.Date;

public class pointDTO {
	private int pnum;
	private int mnum;
	private int ppoint;
	private String ptype;
	private int pstat;
	private Date pcreate;
	private Date puse;
	
	
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	public int getMnum() {
		return mnum;
	}
	public void setMnum(int mnum) {
		this.mnum = mnum;
	}
	public int getPpoint() {
		return ppoint;
	}
	public void setPpoint(int ppoint) {
		this.ppoint = ppoint;
	}
	public String getPtype() {
		return ptype;
	}
	public void setPtype(String ptype) {
		this.ptype = ptype;
	}
	public int getPstat() {
		return pstat;
	}
	public void setPstat(int pstat) {
		this.pstat = pstat;
	}
	public Date getPcreate() {
		return pcreate;
	}
	public void setPcreate(Date pcreate) {
		this.pcreate = pcreate;
	}
	public Date getPuse() {
		return puse;
	}
	public void setPuse(Date puse) {
		this.puse = puse;
	}
}
