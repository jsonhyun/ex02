<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	label{
		float: left;
		width: 100px;
	}
	table{
		border: 1px solid black;
		border-collapse: collapse;
	}
	th,td{
		border: 1px solid black;
	}
	#modal{
		width: 300px;
		height: 205px;
		padding: 5px;
		background-color: lightgray;
		position: absolute;
		top: 20%;
		left: 25%;
		display: none;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.js"></script>
<script id="template" type="text/x-handlebars-template">
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>비밀번호</th>
			<th>이메일</th>
			<th></th>
		</tr>
	{{#each.}}
		<tr>
			<td>{{userid}}</td>
			<td>{{username}}</td>
			<td>{{userpw}}</td>
			<td>{{email}}</td>
			<td>
				<button class="btnMod" data-userid={{userid}} data-username={{username}} data-userpw={{userpw}} data-email={{email}}>수정</button>
				<button class="btnDel" data-userid={{userid}}>삭제</button>
			</td>
		</tr>
	{{/each}}
</script>
<script>
	function getList(){
		$.ajax({
			url:"${pageContext.request.contextPath}/member/",
			type:"get",
			dataType: "json",
			success:function(res){
				console.log(res);
				$("#table").empty();
				var source = $("#template").html();
				var func = Handlebars.compile(source);
				$("#table").append(func(res));
			}
		})
	}

	$(function () {
		$("#btnList").click(function(){
			getList();
		})
		
		$("#btnAdd").click(function() {
			var userid = $("#userid").val();
			var username = $("#username").val();
			var userpw = $("#userpw").val();
			var email = $("#email").val();
			
			var json = JSON.stringify({"userid":userid, "userpw":userpw, "username":username, "email":email});
			
			$.ajax({
				url:"member/",
				type:"post",
				headers:{"Content-Type":"application/json"},
				data:json,
				dataType:"text",
				success:function(res){
					if(res == "SUCCESS"){
						alert("멤버가 추가되었습니다.");
						$("#userid").val("");
						$("#username").val("");
						$("#userpw").val("");
						$("#email").val("");
						getList();
					}
				}
			})
		})
		
		$(document).on("click",".btnDel", function () {
			var userid = $(this).attr("data-userid");
			$.ajax({
				url:"member/"+userid,
				type:"delete",
				dataType: "text",
				success:function(res){
					if(res == "SUCCESS"){
						alert("멤버가 삭제되었습니다.");
						getList();
					}
				}
			})
		})
		
		$(document).on("click", ".btnMod", function(){
			$("#modal").show();
			var userid = $(this).attr("data-userid");
			var username = $(this).attr("data-username");
			var userpw = $(this).attr("data-userpw");
			var email = $(this).attr("data-email");
			
			$("#mod-userid").val(userid);
			$("#mod-username").val(username);
			$("#mod-userpw").val(userpw);
			$("#mod-email").val(email);
		})
		
		$("#btnClose").click(function() {
			$("#modal").hide();
		})
		
		$("#btnModSave").click(function() {
			var userid = $("#mod-userid").val();
			var username = $("#mod-username").val();
			var userpw = $("#mod-userpw").val();
			var email = $("#mod-email").val();
			
			console.log(username);
			var json = JSON.stringify({"username":username, "userpw":userpw, "email":email});
			
			$.ajax({
				url:"member/"+userid,
				type:"put",
				headers:{"Content-Type":"application/json"},
				data:json,
				dataType: "text",
				success:function(res){
					console.log(res);
					if(res == "SUCCESS"){
						alert("멤버 정보가 수정되었습니다.");
						getList();
					}
					$("#modal").hide();
				}
			})
		})
	})
</script>
</head>
<body>
	<div>
		<p>
			<label>아이디</label>
			<input type="text" id="userid">
		</p>
		<p>
			<label>이름</label>
			<input type="text" id="username">
		</p>
		<p>
			<label>비밀번호</label>
			<input type="text" id="userpw">
		</p>
		<p>
			<label>이메일</label>
			<input type="text" id="email">
		</p>
		<p>
			<button id="btnAdd">추가</button>
			<button id="btnList">리스트 가져오기</button>
		</p>
	</div>
	
	<table id="table">
		
	</table>
	
	<div id="modal">
		<p>
			<label>아이디</label>
			<input type="text" id="mod-userid" readonly>
		</p>
		<p>
			<label>이름</label>
			<input type="text" id="mod-username">
		</p>
		<p>
			<label>비밀번호</label>
			<input type="text" id="mod-userpw">
		</p>
		<p>
			<label>이메일</label>
			<input type="text" id="mod-email">
		</p>
		<p>
			<button id="btnModSave">수정</button>
			<button id="btnClose">닫기</button>
		</p>
	</div>
</body>
</html>