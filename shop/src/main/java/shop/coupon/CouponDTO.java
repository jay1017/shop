package shop.coupon;

import java.sql.Timestamp;

public class CouponDTO {
	private int ucnum;
	private int mnum;
	private int cpnum;
	private int cp;
	private Timestamp ucdate;
	private int ucuse;
	private String cpname;
	private int cpvalue;
	private Timestamp cpdate;
	private int cpcount;
	
	public int getUcnum() {
		return ucnum;
	}
	public void setUcnum(int ucnum) {
		this.ucnum = ucnum;
	}
	public int getMnum() {
		return mnum;
	}
	public void setMnum(int mnum) {
		this.mnum = mnum;
	}
	public int getCpnum() {
		return cpnum;
	}
	public void setCpnum(int cpnum) {
		this.cpnum = cpnum;
	}
	public int getCp() {
		return cp;
	}
	public void setCp(int cp) {
		this.cp = cp;
	}
	public Timestamp getUcdate() {
		return ucdate;
	}
	public void setUcdate(Timestamp ucdate) {
		this.ucdate = ucdate;
	}
	public int getUcuse() {
		return ucuse;
	}
	public void setUcuse(int ucuse) {
		this.ucuse = ucuse;
	}
	public String getCpname() {
		return cpname;
	}
	public void setCpname(String cpname) {
		this.cpname = cpname;
	}
	public int getCpvalue() {
		return cpvalue;
	}
	public void setCpvalue(int cpvalue) {
		this.cpvalue = cpvalue;
	}
	public Timestamp getCpdate() {
		return cpdate;
	}
	public void setCpdate(Timestamp cpdate) {
		this.cpdate = cpdate;
	}
	public int getCpcount() {
		return cpcount;
	}
	public void setCpcount(int cpcount) {
		this.cpcount = cpcount;
	}
}
