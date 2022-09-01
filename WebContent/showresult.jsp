<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="entity.Doc"%>
<%@page import="java.util.ArrayList"%>
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
<style type="text/css">
.contain{
width:100%;
position:relative;
margin-top:40px;
border:1px solid black;
height:400px;
overflow-y:auto;
}
.title{
width:100%;
text-align:center;
}
.underline{
margin-top:-160px;
width:100%;
text-align:center;
}
.tip{
width:100%;
text-align:center;
}
.doctitle{
width:100%;
text-align:center;
}
.content{
margin-left:10px;
margin-right:10px;
margin-top:10px;
}
.time{
position:absolute;
bottom:20px;
right:10px;
}
.tip{
width:100%;
height:200px;
}
.tipcontent{
width:100%;
height:180px;
border:1px solid black;
}
</style>
</head>
<body>
	<%Doc doc=(Doc)request.getAttribute("doc"); %>
	<div>公文来源：<%=doc.getOwner() %>&nbsp;&nbsp;&nbsp;&nbsp;发送日期：<%=doc.getTime() %></div>
	<div class="contain">
		<div class="title"><h2>河北金立集团文件</h2></div>
		<%if(doc.getOwner().equals("salespart")){ %>
		<div class="tip">厂[售] [2019] *号</div>
		<%}else if(doc.getOwner().equals("financepart")){ %>
		<div class="tip">厂[财] [2019] *号</div>
		<%}else{ %>
		<div class="tip">厂[产] [2019] *号</div>
		<%} 
		FileInputStream fileInputStream;
		String text="";
		String tip1="";
		String tip2="";
		System.out.println(doc.getPlace()+" "+doc.getTipplace()+" "+doc.getFtipplace());
		try {
			fileInputStream = new FileInputStream(doc.getPlace());
			BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(fileInputStream));
	        String line = null;
	        try {
				while ((line = bufferedReader.readLine()) != null) {
					text+=line;
				}
			} catch (IOException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
			if(doc.getTipplace()!=null)
			{
				fileInputStream = new FileInputStream(doc.getTipplace());
				BufferedReader bufferedReader1 = new BufferedReader(new InputStreamReader(fileInputStream));
				try {
					while ((line = bufferedReader1.readLine()) != null) {
						tip1+=line;
					}
				} catch (IOException e) {
					// TODO 自动生成的 catch 块
					e.printStackTrace();
				}
			}
	        
			if(doc.getFtipplace()!=null)
			{
				fileInputStream = new FileInputStream(doc.getFtipplace());
				BufferedReader bufferedReader2 = new BufferedReader(new InputStreamReader(fileInputStream));
				try {
					while ((line = bufferedReader2.readLine()) != null) {
						tip2+=line;
					}
				} catch (IOException e) {
					// TODO 自动生成的 catch 块
					e.printStackTrace();
				}
			}
			
	        fileInputStream.close();
		} catch (FileNotFoundException e1) {
			// TODO 自动生成的 catch 块
			e1.printStackTrace();
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		if(text.equals("")!=true){
		%>
		<div class="underline">-------------------------------------------------</div>
		<div class="doctitle"><%=doc.getTitle() %></div>
		<div class="content"><%=text %></div>
		<%}else{ %>
		<div class="underline">-------------------------------------------------</div>
		<div class="doctitle"><%=doc.getTitle() %></div>
		<div class="content">公文内容读取失败！</div>
		<%} 
		String time=doc.getTime();
		String[] date=time.split("-");
		%>
		<div class="time"><%=date[0] %>年<%=date[1] %>月<%=date[2] %>日</div>
	</div>
	<div class="tipshow">
		<div>副厂长审核意见</div>
		<div class="tipcontent"><%=tip1 %></div>
	</div>
	<div class="tipshow">
		<div>厂长审核意见</div>
		<div class="tipcontent"><%=tip2 %></div>
	</div>
</body>
</html>