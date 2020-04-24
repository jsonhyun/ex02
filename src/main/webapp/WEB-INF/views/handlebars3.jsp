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
	<div id="wrap"></div>
	<script id="template" type="text/x-handlebars-template">
		<h1>{{title}}</h1>
		<ul>
			{{#each list}}
			<li class="replies">
				<div>
					<p>{{rno}}</p>
					<p>{{replyer}}</p>
					<p>{{replytext}}</p>
					<p>{{dateHelper replydate}}</p>
				</div>	
			</li>
			{{/each}}
		</ul>
	</script>
	<script>
		Handlebars.registerHelper("dateHelper", function (value) {
			var d = new Date(value);
			var year = d.getFullYear();
			var month = d.getMonth()+1;
			var date = d.getDate();
			var day = d.getDay();
			
			var days;
			switch(day){
			case 0:
				var days = "일요일";
				break;
			case 1:
				var days = "월요일";
				break;
			case 2:
				var days = "화요일";
				break;
			case 3:
				var days = "수요일";
				break;
			case 4:
				var days = "목요일";
				break;
			case 5:
				var days = "금요일";
				break;
			case 6:
				var days = "토요일";
				break;
			}
			return year+"/"+month +"/"+date+","+days;
		})
	
		var source = $("#template").html();
		var data = {
				title : "제목입니다.",
				list : [
					{rno:1, replyer:"홍길동1", replytext:"1번 댓글입니다....", replydate:new Date(2019,2,11) },
					{rno:2, replyer:"홍길동2", replytext:"2번 댓글입니다....", replydate:new Date(2020,0,1) },
					{rno:3, replyer:"홍길동3", replytext:"3번 댓글입니다....", replydate:new Date(2020,1,1) },
					{rno:4, replyer:"홍길동4", replytext:"4번 댓글입니다....", replydate:new Date(2020,2,1) },
					{rno:5, replyer:"홍길동5", replytext:"5번 댓글입니다....", replydate:new Date(2020,3,1) }
				]
		};
		var func = Handlebars.compile(source);
		$("#wrap").html(func(data));
	</script>
	
	<table id="list1">
		
	</table>
	
	<script id="template1" type="text/x-handlebars-template">
		<tr>
			<th>이름</th>
			<th>아이디</th>
			<th>메일주소</th>
		</tr>
		{{#each users}}
		<tr>
			<td>{{name}}</td>
			<td>{{id}}</td>
			<td>{{email}}</td>
		</tr>
		{{/each}}
	</script>
	<script>
		var source = $("#template1").html();
		var data = {
				users: [
					{name:"홍길동1", id:"aaa1", email:"aaa1@gmail.com"},
					{name:"홍길동2", id:"aaa2", email:"aaa2@gmail.com"},
					{name:"홍길동3", id:"aaa3", email:"aaa3@gmail.com"},
					{name:"홍길동4", id:"aaa4", email:"aaa4@gmail.com"},
					{name:"홍길동5", id:"aaa5", email:"aaa5@gmail.com"}
			]
		};
		var func = Handlebars.compile(source);
		$("#list1").html(func(data));
	</script>
</body>
</html>