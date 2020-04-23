<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.js"></script>
</head>
<body>
	<ul id="list">
		
	</ul>
	<script id="template" type="text/x-handlebars-template">
		{{#each.}}
		<li class="replies">
			<div>
				<p>{{rno}}</p>
				<p>{{replyer}}</p>
				<p>{{replytext}}</p>
				<p>{{replydate}}</p>
			</div>
		</li>
		{{/each}}
	</script>
	<script>
		var source = $("#template").html();
		var data = [
					{rno:1, replyer:"홍길동1", replytext:"1번 댓글입니다....", replydate:new Date(2019,2,11) },
					{rno:2, replyer:"홍길동2", replytext:"2번 댓글입니다....", replydate:new Date(2020,0,1) },
					{rno:3, replyer:"홍길동3", replytext:"3번 댓글입니다....", replydate:new Date(2020,1,1) },
					{rno:4, replyer:"홍길동4", replytext:"4번 댓글입니다....", replydate:new Date(2020,2,1) },
					{rno:5, replyer:"홍길동5", replytext:"5번 댓글입니다....", replydate:new Date(2020,3,1) }
		];
		var func = Handlebars.compile(source);
		$("#list").html(func(data));
	</script>
</body>
</html>