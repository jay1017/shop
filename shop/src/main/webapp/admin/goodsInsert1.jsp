<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page</title>
</head>
<body>
	<form action="goodsInsertPro1.jsp" method="post" enctype="multipart/form-data" onsubmit="checkGoods1(event);">
		대표 이미지 : <input type="file" name="giname"/><br />
		상세 이미지 1 : <input type="file" name="gidetail1"/><br />
		상세 이미지 2 : <input type="file" name="gidetail2"/><br />
		상세 이미지 3 : <input type="file" name="gidetail3"/><br />
		<input type="submit" value="저장하고 다음 화면으로" />
	</form>
</body>
</html>