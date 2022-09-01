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
<title>登录</title>
<style type="text/css">
*{
padding:0px;
margin:0px;
}
.header{
width:100%;
height:120px;
background-color:gray;
text-align:center;
}
.container{
width:100%;
height:780px;
position:relative;
background-color:blue;
}
.login{
width:500px;
height:auto;
background-color:white;
position:absolute;
top:200px;
left:500px;
border-radius:8px;
}
label{
float:left;
width:100px;
margin-top:7px;
margin-right:5px;
}
.form-control{
width:60%;
}
.logtip{
padding-top:20px;
padding-bottom:20px;
border-bottom:2px solid red;
text-align:center;
}
.form-group{
margin-left:40px;
margin-top:40px;
}
.btn{
height:50px;
width:100px;
float:left;
border-radius:10px;
}
.logbtn{
margin-right:20px;
}

.btnbag{
margin-left:140px;
margin-right:140px;
height:50px;
overflow:hidden;
margin-top:30px;
margin-bottom:40px;
}
</style>
</head>
<body>
	<div class="header"><h2>河北金力集团公文流转系统</h2></div>
	
	<div class="container">
		<div class="login">
			<h2 class="logtip">登录</h2>
			<form action="login_do" method="post">
				<div class="form-group">
					<label for="username">用户名</label>
					<input type="text" class="form-control" id="username" name="username">
				</div>
				<div class="form-group">
					<label for="password">密码</label>
					<input type="password" class="form-control" id="password" name="password">
				</div>
				<div class="btnbag">
					<input type="button" class="btn btn-primary logbtn" onclick="login()" value="登录">
					<input type="button" class="btn btn-primary mangbtn" onclick="entermang()" value="进入管理">
				</div>
			</form>
		</div>
	</div>
	
	<div class="footer"></div>
</body>
<script>
	function login()
	{
		var username=$("#username").val();
		var password=$("#password").val();
		if(username==""||password=="")
			alert("请将信息填写完整！");
		else
		{
			$.post(
				"login_do",
				{username:username,
					password:password},
				function(data){
					if(data=="yes")
					{
						alert("成功登陆！");
						window.location="mainpage.jsp";
					}
					else
						alert("用户名或密码错误！或用户已被暂停使用！");
				},
				"text"
			);
		}
	}
	function entermang()
	{
		var username=$("#username").val();
		var password=$("#password").val();
		if(username==""||password=="")
			alert("请将信息填写完整！");
		else
		{
			$.post(
				"login_do",
				{username:username,
					password:password},
				function(data){
					if(data=="yes")
					{
						alert("成功登陆！");
						window.location="backmainpage.jsp";
					}
					else
						alert("用户名或密码错误！或用户已被暂停使用！");
				},
				"text"
			);
		}
	}
</script>
</html>
