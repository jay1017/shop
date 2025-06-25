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
	<h1>카테고리 등록</h1>
	<form action="categoryInsertPro.jsp" method="post" onsubmit="checkCategory(event)">
		카테고리 이름 : <input type="text" name="caname" id="caname" />
		<input type="submit" value="등록"/>
	</form>
</body>
</html>