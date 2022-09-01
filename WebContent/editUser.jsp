<%@page import="entity.Users"%>
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
		<div>
			<%Users user=(Users)request.getAttribute("user"); %>
			<div class="form-group">
				<label for="type">用户名：</label>
				<input type="text" class="form-control" id="username" value="<%=user.getUsername()%>">
			</div>
			<div class="form-group">
				<label for="type">密码：</label>
				<input type="text" class="form-control" id="password" value="<%=user.getPassword()%>">
			</div>
			<div class="form-group">
				<label for="type">职位：</label>
				<input type="text" class="form-control" id="job" value="<%=user.getJob()%>">
			</div>
			<div>
		    	<input type="button" class="btn" value="确定修改" onclick="update()">
		    </div>
		</div>
	</div>
</body>
<script>
	function update()
	{
		var username=$("#username").val();
		var password=$("#password").val();
		var job=$("#job").val();
		var id=<%=user.getId()%>;
		if(username==""||password==""||job=="")
			alert("请将空信息填写完整！");
		else
		{
			var msg ="确认修改？"; 
			if (confirm(msg)==true){
				$.post(
					"updateUserInfo",
					{
						id:id,
						username:username,
						password:password,
						job:job
					},
					function(data)
					{
						if(data=="yes")
						{
							alert("修改成功！");
							window.location="getAllUser";
						}
						else
							alert("操作失败！");
					}
				);
			}
			else{
				alert("操作取消！");
			}
		}
	}
</script>
</html>