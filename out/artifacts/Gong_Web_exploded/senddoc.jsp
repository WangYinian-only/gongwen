<%@page import="util.DBUtil"%>
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
					<a class="nav-link" href="getDoc?type=receive">待发公文</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="getDoc?type=send">已发公文</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="getDoc?type=delete">已删除公文</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="showCall">消息提醒</a>
				</li>
			</ul>
		</nav>
	</div>
	<div>
		<table class="table table-hover table-striped table-bordered table-sm" id="table">
			<tr>
				<th>公文编号</th>
				<th>公文标题</th>
				<th>发送时间</th>
				<th>发送机构</th>
				<th>公文状态</th>
				<th>审核结果</th>
				<th>流转状态</th>
				<th>保存状态</th>
				<th>格式化公文</th>
				<th>发送操作</th>
				<th>删除操作</th>
			</tr>
			<%ArrayList<Doc> list=(ArrayList<Doc>)request.getAttribute("list");%>
			<c:forEach var="l" items="<%=list %>" varStatus="i">
				<tr>
					<td id="id${i.index+1 }">${l.getId() }</td>
					<td>${l.getTitle() }</td>
					<td>${l.getTime() }</td>
					<td>${l.getOwner() }</td>
					<td id="status${i.index+1 }">${l.getStatus() }</td>
					<td>${l.getResult() }</td>
					<td>${l.getReceiver() }</td>
					<td id="delete${i.index+1 }">${l.getDeletestatus() }</td>
					<td><a href="#" onclick="revise(${i.index+1})">格式化</a></td>
					<td><a href="#" onclick="send(${i.index+1})">发送</a></td>
					<td><a href="#" onclick="deletedoc(${i.index+1})">删除</a></td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
<script>
	function send(i)
	{
		
		var status=$("#status"+i).text();
		if(status=="-1")
			alert("请先格式化该公文！");
		else if(status==1||status==4||status==5||status==8||status==9||status==10)
			alert("该公文已流转到相应部门，不具备发送权限！");
		else
		{
			var id=$("#id"+i).text();
			$.post(
				"sendDoc",
				{id:id},
				function(data){
					if(data=="yes")
					{
						alert("发送成功！");
						window.location="getDoc?type=receive";
					}
					else
						alert("发送失败！");
				},
				"text"
			);
		}
	}
		function revise(i)
		{
			var status=$("#status"+i).text();
			if(status!=-1)
				alert("该公文已经格式化！");
			else
			{
				var id=$("#id"+i).text();
				$.post(
					"formatDoc",
					{id:id,
						status:status},
					function(data){
						if(data=="yes")
						{
							alert("格式化成功！");
							window.location="getDoc?type=receive";
						}
						else
							alert("格式化失败！");
					},
					"text"
				);
			}
		}
		
		function deletedoc(i)
		{
			var deletestatus=$("#delete"+i).text();
			if(deletestatus=="1")
			{
				alert("该公文已删除！");
			}
			else{
				var msg = "确定删除？"; 
				if (confirm(msg)==true){
					var status=$("#status"+i).text();
					if(status==2||status==5||status==6||status==8)
						alert("该公文审核或审签已通过，不能删除！")
					else if(status!=10)
						alert("该公文还为被有关部门签收，不能删除！");
					else{
						var id=$("#id"+i).text();
						$.post(
							"deleteDoc",
							{id:id},
							function(data){
								if(data=="yes")
								{
									alert("删除成功！");
									window.location="getDoc?type=delete";
								}
								else
									alert("删除失败！");
							},
							"text"
						);
					}
				}
				else{
					alert("操作取消！");
				}
			}	
		}
		
	
</script>
</html>