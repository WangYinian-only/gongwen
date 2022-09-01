<%@page import="java.util.ArrayList"%>
<%@page import="entity.Permission"%>
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
		<table class="table table-hover table-striped table-bordered table-sm" id="resultshow">
			<tr>
				<th style="display:none;">用户权限父Id</th>
				<th>用户权限子Id</th>
				<th>操作</th>
				<th>操作</th>
			</tr>
			<%ArrayList<Permission> list=(ArrayList<Permission>)request.getAttribute("list"); %>
			<c:forEach var="l" items="<%=list %>" varStatus="i">
				<tr>
					<td  style="display:none;" id="id${i.index+1 }">${l.getId() }</td>
					<td id="permission${i.index+1 }">${l.getPermission() }</td>
					<td><a href="" onclick="edit(${i.index+1})">编辑</a></td>
					<td><a href="" onclick="deleteitem(${i.index+1})">删除</a></td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
<script>
	function edit(i)
	{
		var count=prompt("请输入修改后的权限：");
		if(count!=""){
			var id=$("#id"+i).text();
			var permission=$("#permission"+i).text();
			var method="edit";
			$.post(
				"editPermission",
				{
					id:id,
					permission:permission,
					newpermission:count,
					method:method
				},
				function(data){
					if(data=="yes")
						alert("操作成功！");
					else
						alert("操作失败！");
				}
			);
		}
	}
	function deleteitem(i)
	{
		var id=$("#id"+i).text();
		var permission=$("#permission"+i).text();
		var method="delete";
		$.post(
			"editPermission",
			{
				id:id,
				permission:permission,
				method:method
			},
			function(data){
				if(data=="yes")
					alert("操作成功！");
				else
					alert("操作失败！");
			}
		);
	}
</script>
</html>