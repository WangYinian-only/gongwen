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
	<div>
		<nav class="navbar navbar-expand-sm bg-light">
			<ul class="navbar-nav">
				<li class="nav-item">
					<a class="nav-link" href="#" onclick="shownotChecked()">待审签公文</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#" onclick="showChecked()">已审签公文</a>
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
				<th>发送机构</th>
				<th>公文状态</th>
				<th>审核结果</th>
				<th>操作</th>
			</tr>
			<%ArrayList<Doc> list=(ArrayList<Doc>)request.getAttribute("list"); %>
			<c:forEach var="l" items="<%=list %>" varStatus="i">
				<tr>
					<td id="id${i.index+1 }">${l.getId() }</td>
					<td>${l.getTitle() }</td>
					<td>${l.getTime() }</td>
					<td>${l.getOwner() }</td>
					<td id="status${i.index+1 }">${l.getStatus() }</td>
					<td>${l.getResult() }</td>
					<td><a href="#" onclick="docheck(${i.index+1})">审签</a></td>
				</tr>
			</c:forEach>
		</table>
		
	</div>
</body>
<script>
	function shownotChecked()
	{
		window.location="fcheckDoc?type=notchecked";
	}
	function showChecked()
	{
		window.location="fcheckDoc?type=checked"
	}
	function docheck(index)
	{
		var status=$("#status"+index).text();
		if(status==5)
		{
			var id=$("#id"+index).text();
			window.location="dofCheck?id="+id;
		}
		else
			alert("不具备权限！");
	}
</script>
</html>