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
<style>
.form-group{
width:40%;
float:left;
margin-top:30px;
}
label{
width:28%;
float:left;
margin-top:5px;
margin-left:5px;
}
.form-control{
width:67%;
}
.btn{
width:150px;
height:40px;
border:0px;
border-radius:5px;
background-color:orange;
color:black;
margin-left:auto;
margin-top:28px
}
</style>
</head>
<body>
	<div>
		<div class="form-group">
			<label for="type">请输入查询时间段：</label>
			<input type="text" class="form-control" id="begin" placeholder="(格式：yyyy-MM-dd hh:mm:ss)">
		</div>
		<div class="form-group">
			<label for="type">---------------></label>
			<input type="text" class="form-control" id="end" placeholder="(格式：yyyy-MM-dd hh:mm:ss)">
		</div>
		<div>
	    	<input type="button" class="btn" value="查询" onclick="query()">
	    </div>
	</div>
	<div>
		<table class="table table-hover table-striped table-bordered table-sm" id="resultshow">
			<tr>
				<th>公文编号</th>
				<th>公文标题</th>
				<th>发送时间</th>
				<th>发送机构</th>
			</tr>
			<%ArrayList<Doc> list=(ArrayList<Doc>)request.getAttribute("list"); %>
			<c:forEach var="l" items="<%=list %>" varStatus="i">
				<tr>
					<td id="id${i.index+1 }">${l.getId() }</td>
					<td><a href="showSug?id=${l.getId()}">${l.getTitle() }</a></td>
					<td>${l.getTime() }</td>
					<td>${l.getOwner() }</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
<script type="text/javascript">
	function query()
	{
		var begin=$("#begin").val();
		var end=$("#end").val();
		if(begin==""||end=="")
			alert("请将查询条件补充完整！");
		else
		{
			$.post(
				"queryByTime",
				{
					begin:begin,
					end:end
				},
				function(data)
				{
					$("#resultshow").empty();
					$("#resultshow").append("<tr><th>公文编号</th><th>公文标题</th><th>发送时间</th><th>发送机构</th></tr>");
					for(var i=0;i<data.length;i++)
					{
						$("#resultshow").append("<tr id='"+i+"'></tr>");
						$("#"+i).append("<td>"+data[i].id+"</td>");
						$("#"+i).append("<td>"+data[i].title+"</td>");
						$("#"+i).append("<td>"+data[i].time+"</td>");
						$("#"+i).append("<td>"+data[i].owner+"</td>");
					}
				},
				"json"
			);
		}
	}
</script>
</html>