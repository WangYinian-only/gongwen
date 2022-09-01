<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
 <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
 <script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
 <script src="https://cdn.staticfile.org/popper.js/1.15.0/umd/popper.min.js"></script>
 <script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<style>
	textarea{
	width:100%;
	height:500px;
	}
	.btnbag{
	width:100%;
	text-align:center;
	}
	.btn{
	width:150px;
	height:40px;
	border:0px;
	border-radius:5px;
	background-color:orange;
	color:black;
	margin-left:auto;
	margin-top:10px
	}
</style>
</head>
<body>
	<h4>请输入公文标题：</h4>
	<div><input type="text" class="form-control" id="title"></div>
	<h4>请在下方书写正文：</h4>
	<div>
		<textarea id="doc" rows="20" cols="40"></textarea>
	</div>
	<div class="btnbag">
		<input type="button" class="btn" value="提交" onclick="submit()"> 
	</div>
</body>
<script type="text/javascript">
	function GetQueryString(name) { 
		  var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i"); 
		  var r = window.location.search.substr(1).match(reg); //获取url中"?"符后的字符串并正则匹配
		  var context = ""; 
		  if (r != null) 
		     context = r[2]; 
		  reg = null; 
		  r = null; 
		  return context == null || context == "" || context == "undefined" ? "" : context; 
	}


	function submit()
	{
		var text=$("#doc").val();
		var user=GetQueryString("user");
		var title=$("#title").val();
		if(text==""||title=="")
		{
			alert("包含空内容！请填写完整！");
		}
		else
		{
			$.post(
				"writedoc_do",
				{text:text,
					user:user,
					title:title},
				function(data){
					if(data=="yes"){
						alert("发送成功");
						$("#title").val("");
						$("#doc").val("");
					}
					else{
						alert("发送失败");
					}
				},
				"text"
			);
		}
	}
</script>
</html>