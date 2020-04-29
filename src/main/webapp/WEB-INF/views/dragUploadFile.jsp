<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#dropBox{
		width: 400px;
		height: 300px;
		border: 1px solid gray;
	}
	#dropBox .divx{
		position: relative;
		float: left;
	}
	#dropBox img{
		height: 100px;
	}
	#dropBox .btnDel{
		position: absolute;
		right: 0;
		top: 0;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>
<body>
	<form id="f1">
		<input type="text" name="test">
		<input type="submit" value="전송">
	</form>
	<br>
	<div id="dropBox"></div>
	
	<script>
		var formData = new FormData();//서버로 보낼 데이타를 담음, file upload시에 반드시 사용함.
		
		$("#dropBox").on("dragenter dragover", function(e){
			e.preventDefault();
		})
		
		$("#dropBox").on("drop", function(e){
			e.preventDefault();
			var files = e.originalEvent.dataTransfer.files;
			var file = files[0];//file 1개만
			console.log(file);
			var reader = new FileReader();
			reader.readAsDataURL(file);
			reader.addEventListener("load", function() {
				var $img = $("<img>").attr("src", reader.result);
				$("#dropBox").append($img);
			})
			
			formData.append("files", file);//key : files에 file data가 추가됨
		})
		
		$("#f1").submit(function(e){
			e.preventDefault();
			
			formData.append("test", $("input[name='test']").val());
			$.ajax({
				url:"drag",
				type:"post",
				data: formData,//image, test
				processData:false,//file을 같이 서버로 보낼시에 셋팅, processData:false/contentType:false
				contentType:false,
				success:function(res){
					console.log(res);
					if(res.length > 0){
						alert("업로드 완료");
						$("#dropBox").empty();
						$(res).each(function(i, obj){
							var $div = $("<div>").addClass("divx");
							var $img = $("<img>").attr("src", "displayFile?filename="+obj);
							var $btn = $("<button>").addClass("btnDel").attr("data-filename", obj).html("X");
							$div.append($img).append($btn);
							$("#dropBox").append($div);
						})
					}
				}
			})
		})
		
		$(document).on("click",".btnDel",function(e) {
			e.preventDefault();
			var filename = $(this).attr("data-filename");
			var $del = $(this).parent();
			$.ajax({
				url:"deleteFile",
				type:"get",
				data:{"filename":filename},
				success:function(res){
					console.log(res);
					if(res == "success"){
						$del.remove();
						alert("삭제 완료");
					}
					
				}
			})
		})
		
	</script>
</body>
</html>