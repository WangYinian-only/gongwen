<%@page import="entity.Doc"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
 <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
 <script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
 <script src="https://cdn.staticfile.org/popper.js/1.15.0/umd/popper.min.js"></script>
 <script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
<title>Insert title here</title>
</head>
<body>
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
	<div>
		<nav class="navbar navbar-expand-sm bg-light">
			<ul class="navbar-nav">
				<li class="nav-item">
					<a class="nav-link" href="#" onclick="showreceived()">已签收公文</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#" onclick="shownotreceived()">未签收公文</a>
				</li>
			</ul>
		</nav>
	</div>
	<div>
		<table class="table table-hover table-striped table-bordered table-sm">
			<tr>
				<th>公文编号</th>
				<th>公文标题</th>
				<th>发送时间</th>
				<th>公文状态</th>
				<th>审核结果</th>
				<th>操作</th>
			</tr>
			<%ArrayList<Doc> list=(ArrayList<Doc>)request.getAttribute("list");%>
			<c:forEach var="l" items="<%=list %>" varStatus="i">
				<tr>
					<td id="id${i.index+1 }">${l.getId() }</td>
					<td><a href="showSug?id=${l.getId()}">${l.getTitle() }</a></td>
					<td>${l.getTime() }</td>
					<td id="status${i.index+1 }">${l.getStatus() }</td>
					<td>${l.getResult() }</td>
					<td><a href="#" onclick="doreceived(${i.index+1})">签收</a></td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
<script>
	function showreceived()
	{
		window.location="getReceivedorNot?type=received&user=<%=value %>";
	}
	function shownotreceived()
	{
		window.location="getReceivedorNot?type=notreceived&user=<%=value%>";
	}
	function doreceived(index)
	{
		var status=$("#status"+index).text();
		if(status==10)
			alert("该公文已签收！");
		else if(status!=8&&status!=9&&status!=4)
			alert("无法签收该公文！因为该公文还未审签！");
		else
		{
			var id=$("#id"+index).text();
			$.post(
				"doReceived",
				{
					id:id
				},
				function(data){
					if(data=="yes")
					{
						alert("签收成功！");
						window.location="getReceivedorNot?user=<%=value%>&type=notreceived"
					}
					else
						alert("签收失败！");
				}
				
			);
		}
	}
</script>
</html>