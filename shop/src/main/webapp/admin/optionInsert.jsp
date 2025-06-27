<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page</title>
<script language="JavaScript" src="/shop/resources/js/admin.js"></script>
</head>
<body>
	<h1>옵션 등록</h1>
	<form action="optionInsertPro.jsp" method="post" onsubmit="checkOption(event)">
		색상 : <input type="text" name="gocolor" id="gocolor" />
		사이즈 : <input type="text" name="gosize" id="gosize" />
		<input type="submit" value="등록"/>
	</form>
</body>
</html>