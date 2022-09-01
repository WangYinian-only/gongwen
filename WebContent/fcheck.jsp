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
</head>
<body>
	<div>
		<nav class="navbar navbar-expand-sm bg-light">
			<ul class="navbar-nav">
				<li class="nav-item">
					<a class="nav-link" href="#">待审签公文</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">已审签公文</a>
				</li>
			</ul>
		</nav>
	</div>
	<div>
		<table class="table table-hover table-striped table-bordered table-sm">
			<tr>
				<th>公文标题</th>
				<th>发送时间</th>
				<th>发送机构</th>
				<th>公文状态</th>
				<th>操作</th>
			</tr>
		</table>
	</div>
</body>
</html>