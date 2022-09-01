6<%@page import="entity.Users"%>
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
		<table class="table table-hover table-striped table-bordered table-sm" id="resultshow">
			<tr>
				<th>用户编号</th>
				<th>用户名</th>
				<th>密码</th>
				<th>用户权限ID</th>
				<th>用户职位</th>
				<th>用户状态</th>
				<th>操作</th>
				<th>操作</th>
				<th>操作</th>
				<th>操作</th>
			</tr>
			<%ArrayList<Users> list=(ArrayList<Users>)request.getAttribute("list");%>
			<c:forEach var="l" items="<%=list %>" varStatus="i">
				<tr>
					<td id="id${i.index+1 }">${l.getId() }</td>
					<td>${l.getUsername() }</td>
					<td>${l.getPassword() }</td>
					<td>${l.getPermissionId() }</td>
					<td>${l.getJob() }</td>
					<td id="status${i.index+1 }">${l.getStatus() }</td>
					<td><a href="#" onclick="edit(${i.index+1})">编辑</a></td>
					<td><a href="getAllUser" onclick="pause(${i.index+1})">暂停\释放</a></td>
					<td><a href="#" onclick="editPermission(${i.index+1})">权限管理</a></td>
					<td><a href="" onclick="deleteitem(${i.index+1})">删除</a></td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
<script>
	function edit(i)
	{
		var id=$("#id"+i).text();
		window.location="editUserInfo?id="+id;
	}
	function pause(i)
	{
		var msg ="确认暂停/释放 此用户权限？"; 
		if (confirm(msg)==true){
			var id=$("#id"+i).text();
			var status=$("#status"+i).text();
			var method="pause";
			$.post(
				"users_do",
				{
					id:id,
					status:status,
					method:method
				},
				function(data)
				{
					if(data=="no")
						alert("操作失败！");
					else
					{
						alert("操作成功！");
					}
				},
				"text"
			);
		}
	}
	function deleteitem(i)
	{
		var msg ="确认删除？"; 
		if (confirm(msg)==true){
			var id=$("#id"+i).text();
			var method="delete";
			$.post(
					"users_do",
					{
						method:method,
						id:id
					},
					function(data)
					{
						if(data=="no")
							alert("操作失败！");
						else
						{
							alert("删除成功！");
							//window.location="getAllUser";
						}
					},
					"text"
				);
		}
	}
	
	function editPermission(i)
	{
		var id=$("#id"+i).text();
		window.location="editPermission?id="+id;
	}
</script>
</html>