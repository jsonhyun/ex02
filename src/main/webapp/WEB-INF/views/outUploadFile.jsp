<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>
<body>
	<form action="outUp" method="post" enctype="multipart/form-data">
		<p>
			<input type="text" name="test" placeholder="작성자이름">
			<input type="file" name="file" value="파일 선택" id="file">
			<input type="submit" value="제출">
		</p>
	</form>
	<div id="dropBox"></div>
	<script>
		$("#file").change(function(){
			var file = $(this)[0].files[0]; //$(this)[0] :javascript객체
			console.log(file);
			
			var reader = new FileReader();//javascript 객체
			reader.readAsDataURL(file);
			reader.onload = function(e){
				var $img = $("<img>").attr("src", e.target.result);
				$("#dropBox").html($img);
			}
		})
	</script>
</body>
</html>