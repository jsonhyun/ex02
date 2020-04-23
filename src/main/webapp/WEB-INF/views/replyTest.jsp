<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#pagination li{
		border: 1px solid gray;
		float: left;
		margin: 0 5px;
		list-style: none;
		padding: 2px 4px;
	}
	#list .item{
		border-bottom: 1px solid #ddd;
		padding: 5px;
		width: 400px;
		position: relative;
	}
	#list .item .text{
		display: block;
	}
	#list .item .btnWrap{
		position: absolute;
		right: 10px;
		top: 10px;
	}
	
	#modPopup{
		width: 300px;
		height: 100px;
		padding: 5px;
		background-color: lightgray;
		position: absolute;
		top: 20%;
		left: 25%;
		display: none;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript">
	
	var currentPage = 1;
	
	function getPageList( page ) {
		var bno = $("#bno").val()
		$.ajax({
			url: "/ex02/replies/"+bno+"/"+page,
			type: "get",
			data: "json",
			success:function(res){
				console.log(res);
				$("#list").empty();
				$(res.list).each(function (i, obj) {
					var rno = obj.rno;
					var replyer = obj.replyer;
					var replytext = obj.replytext;
					
					var $li = $("<li>");
				
				    var $div1 = $("<div>").addClass("item");
					var $span1 = $("<span>").addClass("rno").html(rno)
					var $span2 = $("<span>").addClass("writer").html(replyer);
					var $span3 = $("<span>").addClass("text").html(replytext);
					
					var $div2 = $("<div>").addClass("btnWrap");
					var $btn1 = $("<button>").addClass("btnMod").html("수정").attr("data-rno", obj.rno).attr("data-text", obj.replytext);
					var $btn2 = $("<button>").addClass("btnDel").html("삭제").attr("data-rno", obj.rno);
					
					var $divWrap = $div2.append($btn1).append($btn2);
					var $divItem = $div1.append($span1).append(" : ").append($span2).append($span3).append($divWrap)
					
					$li.append($divItem);
					
					$("#list").append($li);
				})
				
				$("#pagination").empty();
				for(var i = res.pageMaker.startPage; i<= res.pageMaker.endPage; i++){
					var $li = $("<li>").html(i);
					$("#pagination").append($li);
				}
			}
		})
	}

	$(function () {
		$("#btnList").click(function() {
			getPageList(1);
		})
		
		$("#btnAdd").click(function() {
			//댓글 등록
			var bno = $("#bno").val();
			var replyer = $("#replyer").val();
			var replytext = $("#replytext").val();
			
			//서버 주소 : /replies/
			
			//@RequestBody 서버에서 사용시
			// 1. headers = "Content-Type" : "application/json"
			// 2. 보내는 data는 json String으로 변형해서 보내야됨
			//    - "{bno:bno}"
			
			var json = JSON.stringify({"bno":bno, "replyer":replyer, "replytext":replytext});
			
			$.ajax({
				url:"replies/",
				type:"post",
				headers:{"Content-Type":"application/json"},
				data:json,
				dateType:"text",
				success:function(res){
					console.log(res);
					if(res == "SUCCESS"){
						alert("댓글이 등록되었습니다.");
						//리스트 갱신이 필요
						getPageList(1);
					}
				}
			})
		})
		
		$(document).on("click","#pagination li",function() {
			//click을 한 li태그 번호
			var no = $(this).text();
			currentPage = no;
			getPageList(no);
		})
		
		$(document).on("click",".btnDel", function() {
			var rno = $(this).attr("data-rno");
			console.log(rno);
			
			$.ajax({
				url:"replies/"+rno,
				type:"delete",
				dateType:"text",
				success:function(res){
					console.log(res);
					if(res == "SUCCESS"){
						alert("댓글이 삭제되었습니다.");
						//리스트 갱신이 필요
						getPageList(currentPage);
					}
				}
			})
		})
		
		$(document).on("click",".btnMod", function () {
			var rno = $(this).attr("data-rno");
			var replytext = $(this).attr("data-text");
			$(".modRno").text(rno);
			$("#mod-text").val(replytext);			
			$("#modPopup").show();
		})
		
		$("#btnModSave").click(function() {
			var rno = $(".modRno").text();
			var replytext = $("#mod-text").val();
			var json = JSON.stringify({"replytext":replytext});
			
			$.ajax({
				url:"replies/"+rno,
				type:"put",
				headers:{"Content-Type":"application/json"},
				data:json,
				dateType:"text",
				success:function(res){
					console.log(res);
					if(res == "SUCCESS"){
						alert("댓글이 수정되었습니다.");
						//리스트 갱신이 필요
						getPageList(currentPage);
					}
					$("#modPopup").hide();
				}
			})
		})
		
		$("#btnClose").click(function() {
			$("#modPopup").hide();
		})
	})
</script>
</head>
<body>
	<div id="box">
		<p>
			<label>BNO</label>
			<input type="text" id="bno">
		</p>
		<p>
			<label>Replyer</label>
			<input type="text" id="replyer">
		</p>
		<p>
			<label>Reply Text</label>
			<input type="text" id="replytext">
		</p>
		<p>
			<button id="btnList">List</button>
			<button id="btnAdd">Add</button>
		</p>
	</div>
	<hr>
	<div id="listWrap">
		<ul id="list"></ul>
		<ul id="pagination"></ul>
	</div>
	
	<div id="modPopup">
		<div class="modRno">22</div>
		<div>
			<input type="text" id="mod-text" value="text">
		</div>
		<button id="btnModSave">수정</button>
		<button id="btnClose">닫기</button>
	</div>
</body>
</html>