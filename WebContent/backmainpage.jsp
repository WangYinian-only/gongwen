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
<style type="text/css">
*{
padding:0px;
margin:0px;
}
.header{
width:100%;
height:120px;
background-color:brown;
text-align:center;
position:relative;
}
.contain{
width:100%;
height:780px;
position:relative;
background-color:blue;
}
.list-group{
width:15%;
float:left;
}
a{
text-decoration:none;
width:100%;
}
.list-group a:hover{
font-size:18px;
font-weight:bold;
}
.operation{
width:85%;
height:780px;
float:right;
}
iframe{
border:0px;
}
.loginfoshow{
position:absolute;
width:auto;
text-align:right;
bottom:5px;
right:5px;
}
.loginfoshow a
{
color:#D8D8D8;
cursor:pointer;
}
.loginfoshow a:hover
{
color:white;
}
.loginfoshow p{
float:left;
color:white;
}

</style>
<script>
function onload()
{
	<%
	Cookie[] cookies=request.getCookies();
	String value="";
	if(cookies!=null){
		System.out.println("cookie的长度为:"+cookies.length);
		for(int i=0;i<cookies.length;i++)
		{
			if(cookies[i].getName().equals("username"))
			{
				value=cookies[i].getValue();
				break;
			}
		}
	}
	%>
	$("#informationshow").text("当前登录账户："+"<%=value%>");
}
function exitlog(event)
{
	var msg = "您确定要注销吗？"; 
	if (confirm(msg)==true){ 
		event.href="http://localhost/Gong/index.jsp";
	}
	else{
		alert("操作取消！");
	}
}
</script>
</head>
<body onload="onload()">
	<div class="header">
		<h2>河北金力集团后台管理系统</h2>
		<div class="loginfoshow" id="userinfor">
			<p id="informationshow"></p>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="" onclick="exitlog(this)">[注销]</a>
		</div>
	</div>
	<div class="contain">
		<div class="list-group">
			<%if(value.equals("admit")){ %>
			<a id="1" href="getAllUser" class="list-group-item list-group-item-aciton" target="operation">用户管理</a>
			<%} %>
			<a id="2" href="" class="list-group-item list-group-item-aciton" onclick="updatepwd()">修改密码</a>
				
		</div>
		<div class="operation">
            <iframe name="operation" src="" width="100%" height="100%" style="background-color: gray;"></iframe>
		</div>
	</div>
	<div class="footer"></div>
</body>
<script>
	function updatepwd()
	{
		var username="<%=value%>";
		var password=prompt("请输入修改后的密码：");
		if(password!=""&&password!=null)
		{
			$.post(
					"updateSelf",
					{
						username:username,
						password:password
					},
					function(data)
					{
						if(data=="yes")
							alert("修改成功！");
						else
							alert("修改失败！");
					},
					"text"
				);
		}
	}
</script>
</html>