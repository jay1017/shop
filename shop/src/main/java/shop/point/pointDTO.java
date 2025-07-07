package shop.point;

import oracle.sql.DATE;

public class pointDTO {
	private int pnum;
	private int mnum;
	private int ppoint;
	private String ptype;
	private int pstat;
	private DATE pcreate;
	private DATE puse;
	
	
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
	public DATE getPcreate() {
		return pcreate;
	}
	public void setPcreate(DATE pcreate) {
		this.pcreate = pcreate;
	}
	public DATE getPuse() {
		return puse;
	}
	public void setPuse(DATE puse) {
		this.puse = puse;
	}
}
