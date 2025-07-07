package shop.admin;

import java.sql.Timestamp;

public class CouponDTO {
	private int cpnum;
	private String cp;
	private int cpvalue;
	private String cpname;
	private String cptype;
	private int cpmop;
	private int cpdate;
	private Timestamp cpreg;
	
	public int getCpnum() {
		return cpnum;
	}
	public void setCpnum(int cpnum) {
		this.cpnum = cpnum;
	}
	public String getCp() {
		return cp;
	}
	public void setCp(String cp) {
		this.cp = cp;
	}
	public int getCpvalue() {
		return cpvalue;
	}
	public void setCpvalue(int cpvalue) {
		this.cpvalue = cpvalue;
	}
	public String getCpname() {
		return cpname;
	}
	public void setCpname(String cpname) {
		this.cpname = cpname;
	}
	public String getCptype() {
		return cptype;
	}
	public void setCptype(String cptype) {
		this.cptype = cptype;
	}
	public int getCpmop() {
		return cpmop;
	}
	public void setCpmop(int cpmop) {
		this.cpmop = cpmop;
	}
	public int getCpdate() {
		return cpdate;
	}
	public void setCpdate(int cpdate) {
		this.cpdate = cpdate;
	}
	public Timestamp getCpreg() {
		return cpreg;
	}
	public void setCpreg(Timestamp cpreg) {
		this.cpreg = cpreg;
	}
}
