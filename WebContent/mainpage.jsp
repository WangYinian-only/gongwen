<%@page import="util.DBUtil"%>
<%@page import="entity.Permission"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.util.ArrayList"%>
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
	ArrayList<Permission> list=new ArrayList<>();
	if(cookies!=null){
		System.out.println("cookie的长度为:"+cookies.length);
		for(int i=0;i<cookies.length;i++)
		{
			if(cookies[i].getName().equals("username"))
			{
				value=cookies[i].getValue();
			}
			if(cookies[i].getName().equals("pid"))
			{
				Permission permission=new Permission();
				permission.setId(Integer.parseInt(cookies[i].getValue()));
				list=DBUtil.getPermission(permission);
			}
		}
	}
	%>
	$("#informationshow").text("当前登录账户：<%=value %>");
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
		<h2>河北金力集团公文流转系统</h2>
		<div class="loginfoshow" id="userinfor">
			<p id="informationshow"></p>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="" onclick="exitlog(this)">[注销]</a>
			
		</div>
	</div>
	<div class="contain">
		<div class="list-group">
			<%for(Permission s:list)
			{
			if(s.getPermission()==1){%>
			<a id="1" href="writedoc.jsp?user=<%=value %>" class="list-group-item list-group-item-aciton" target="operation">公文拟制</a>
			<%}else if(s.getPermission()==2){ %>
			<a id="2" href="getReceivedorNot?user=<%=value %>&type=received" class="list-group-item list-group-item-aciton" target="operation">签收公文</a>
			<%}else if(s.getPermission()==3){  %>
			<a id="3" href="showAll" class="list-group-item list-group-item-aciton" target="operation">浏览公文</a>
			<%}else if(s.getPermission()==5){  %>
			<a id="5" href="getDoc?type=receive" class="list-group-item list-group-item-aciton" target="operation">公文流转</a>
			<%}else if(s.getPermission()==6){  %>
			<a id="6" href="queryDoc?type=all" class="list-group-item list-group-item-aciton" target="operation">公文查询</a>
			<%}else if(s.getPermission()==7){  %>
			<a id="7" href="checkDoc?type=notchecked" class="list-group-item list-group-item-aciton" target="operation">审核公文</a>
			<%}else if(s.getPermission()==8){  %>
			<a id="8" href="fcheckDoc?type=notchecked" class="list-group-item list-group-item-aciton" target="operation">审签公文</a>
			<%}} %>
		</div>
		<div class="operation">
            <iframe name="operation" src="" width="100%" height="100%" style="background-color: gray;"></iframe>
		</div>
	</div>
	<div class="footer"></div>
</body>
</html>