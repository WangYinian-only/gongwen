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
<style>
.form-group{
width:35%;
float:left;
margin-left:10px;
margin-top:10px;
}
label{
width:30%;
float:left;
margin-right:5px;
margin-top:5px;
}
.form-control{
width:60%;
}
.btn{
width:100px;
height:40px;
border:0px;
border-radius:5px;
background-color:orange;
color:black;
margin-left:20px;
margin-top:10px
}
</style>
</head>
<body>
	<div>
		<div class="form-group">
			<label for="type">请选择查询类型：</label>
			<select class="form-control" id="type">
				<option value="title">公文标题</option>
				<option value="owner">发送机构</option>
				<option value="receiver">接收机构</option>
				<option value="result">审核结果</option>
			</select>
		</div>
		<div class="form-group">
			<label for="content">请输入查询内容:</label>
			<input type="text" class="form-control" id="content">
	    </div>
	    <div>
	    	<input type="button" class="btn" value="查询" onclick="query()">
	    </div>
	</div>
	<div>
		<table class="table table-hover table-striped table-bordered table-sm">
			<tr>
				<th>公文编号</th>
				<th>公文标题</th>
				<th>发送时间</th>
				<th>发送机构</th>
				<th>接收机构</th>
				<th>公文状态</th>
				<th>审核结果</th>
				<th>流转状态</th>
				<th>公文位置</th>
			</tr>
			<%ArrayList<Doc> list=(ArrayList<Doc>)request.getAttribute("list"); %>
			<c:forEach var="l" items="<%=list %>" varStatus="i">
				<tr>
					<td id="id${i.index+1 }">${l.getId() }</td>
					<td>${l.getTitle() }</td>
					<td>${l.getTime() }</td>
					<td>${l.getOwner() }</td>
					<td>${l.getReceiver() }</td>
					<td id="status${i.index+1 }">${l.getStatus() }</td>
					<td>${l.getResult() }</td>
					<td>${l.getReceiver() }</td>
					<td>${l.getPlace() }</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
<script>
	function query(){
		var sel=document.getElementById("type");
		var type=sel.options[sel.selectedIndex].value;
		var value=$("#content").val();
		window.location="queryDoc?type="+type+"&value="+value;
	}
</script>
</html>