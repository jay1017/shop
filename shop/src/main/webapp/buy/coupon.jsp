<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.coupon.CouponDTO" %>
<%@ page import="shop.coupon.CouponDAO" %> 
<%@ page import="org.json.JSONObject" %>   
<%
	request.setCharacterEncoding("UTF-8");
	int cpnum = Integer.parseInt(request.getParameter("cpnum"));
	int total = Integer.parseInt(request.getParameter("total"));
	int total_amount = 0;
	CouponDAO cdao = CouponDAO.getDAO();
	JSONObject json = new JSONObject();
	
	CouponDTO coupon = cdao.select(cpnum);
	int cpvalue = coupon.getCpvalue();
	String cptype = coupon.getCptype();
	
	if(cptype.equals("할인율")) {
		int ta = (int) total - (total * cpvalue / 100);
		total_amount = ta;
	} else {
		total_amount = total - cpvalue;
	}
	json.put("total_amount", total_amount);
	out.print(json.toString());
%>