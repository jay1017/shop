<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1></h1>
<%
request.setCharacterEncoding("UTF-8");  

String gonum = request.getParameter("gonum");
String gosize = request.getParameter("gosize");
String gocolor = request.getParameter("gocolor");
String gprice = request.getParameter("gprice");
String gnum = request.getParameter("gnum");
String mnum = request.getParameter("mnum");

%>
<%--파라미터값 확인용 페이지입니다 --%>
<h2>넘어온 파라미터 값 확인</h2>
<ul>
  <li>gonum: <%=gonum%></li>
  <li>gosize: <%=gosize%></li>
  <li>gocolor: <%=gocolor%></li>
  <li>gprice: <%=gprice%></li>
  <li>gnum: <%=gnum%></li>
  <li>mnum: <%=mnum%></li>
</ul>
