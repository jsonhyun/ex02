<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	$(function () {
		$("#img").click(function() {
			var path=$(this).attr("data-src");
			console.log(path);
			var path1 = path.substring(0, 12);
			var path2 = path.substring(14);
			var $img = $("<img>").attr("src","displayFile?filename="+path1+path2);
			$("#box").append($img);
		})
		
		$(document).on("click", "#box img", function(){
			$(this).remove();
		})
	})
</script>
</head>
<body>
	<p>test:${test }</p>
	<p>file:${file }</p>
	<p><img src="displayFile?filename=${file }" id="img" data-src="${file }"></p>
	<div id="box">
		
	</div>
</body>
</html>