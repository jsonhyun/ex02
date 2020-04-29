<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="inUp" method="post" enctype="multipart/form-data">
		<p>
			<input type="text" name="test" placeholder="작성자이름">
			<input type="file" name="file" value="파일 선택">
			<input type="submit" value="제출">
		</p>
	</form>
</body>
</html>