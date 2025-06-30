<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!doctype html>
<html>
<h1>리뷰,,,</h1>
</head>
<body>
	<div>
	<form action="reviewForm.jsp" method="post">
	내용		<input type="text" name="rcontent">
상품 번호		<input type="text" name="gnum"/>	
회원	번호		<input type="text" name="mnum"/>
카테고리번호	<input type="text" name="canum"/>	
상품 이미지번호	<input type="text" name="ginum"/>
리뷰번호		<input type="text" name="rnum"/>		
	<input type="submit" value="버튼"/>
	</form> 
	</div>
	
</body>
</html>