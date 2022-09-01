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
<style>
.form-group{
width:600px;
margin-left:300px;
}
label{
width:20%;
float:left;
}
.form-control{
width:80%;
}
.btn{
width:150px;
height:50px;
border:0px;
border-radius:5px;
background-color:orange;
color:black;
}
.btnbag{
width:100%;
text-align:center;
}
textarea{
width:100%;
height:500px;
}
</style>
</head>
<body>
	<div>
		<h3>修改公文内容</h3>
	<div>
		<textarea rows="20" cols="40"></textarea>
	</div>
	<form>
		<div class="form-group">
			<label for="geter">请选择收件人：</label>
			<select class="form-control" id="geter">
				<option>厂长</option>
				<option>副厂长</option>
			</select>
		</div>
	</form>
	<div class="btnbag"><input type="button" class="btn" value="发送"></div>
	</div>
</body>
</html>