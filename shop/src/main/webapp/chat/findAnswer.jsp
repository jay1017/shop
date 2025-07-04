<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>   
<%@ page import="java.util.ArrayList" %>   
<%@ page import="java.io.BufferedReader" %> 
<%@ page import="java.io.FileReader" %> 

<%
	String type = request.getParameter("type");
	String question = request.getParameter("question");
	String filename = "/resources/chat/" + type + ".txt";
	String path = application.getRealPath(filename);
	
	BufferedReader reader = null;
	List<String> jsonList = new ArrayList<>();
	
	try {
	    reader = new BufferedReader(new FileReader(path));
	    String line;

	    while ((line = reader.readLine()) != null) {
	        String[] plot = line.split("/");
	        if (plot.length == 2) {
	            String q = plot[0].trim();
	            String answer = plot[1].trim();
	            if(question.equals(q)) {
	            	jsonList.add("{\"answer\": \"" + answer + "\"}");
	            }
	        }
	    }
	} catch (Exception e) {
	    e.printStackTrace();
	} finally {
	    if (reader != null) reader.close();
	}
%>  
[<%= String.join(",", jsonList) %>]  