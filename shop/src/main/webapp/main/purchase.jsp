<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1></h1>

<%
String gonum = request.getParameter("gonum");
String gosize = request.getParameter("gosize");
String gocolor = request.getParameter("gocolor");

out.println("선택 옵션: " + gosize + " / " + gocolor + " (번호: " + gonum + ")");
%>
<%--파라미터값 확인용 페이지입니다 --%>
