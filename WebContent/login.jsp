<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="uft-8">
<title>首页</title>
</head>
<body>
<form action="${pageContext.request.contextPath}/blogger/login.do" method="post" onsubmit="return checkForm()">
    <DIV style="background: rgb(255, 255, 255); margin: -100px auto auto; border: 1px solid rgb(231, 231, 231); border-image: none; width: 400px; height: 200px; text-align: center;">
        <DIV style="width: 165px; height: 96px; position: absolute;">
            <DIV class="tou">
            </DIV>
            <DIV class="initial_left_hand" id="left_hand">
            </DIV>
            <DIV class="initial_right_hand" id="right_hand">
            </DIV>
        </DIV>
        <P style="padding: 30px 0px 10px; position: relative;">
            <SPAN class="u_logo"></SPAN>
            <INPUT id="userName" name="userName" class="ipt" type="text" placeholder="请输入用户名" value="${blogger.userName }"> 
        </P>
        <P style="position: relative;">
            <SPAN class="p_logo"></SPAN>         
            <INPUT id="password" name="password" class="ipt"  type="password" placeholder="请输入密码" value="${blogger.password }">   
          </P>
        <DIV style="height: 50px; line-height: 50px; margin-top: 30px; border-top-color: rgb(231, 231, 231); border-top-width: 1px; border-top-style: solid;">
            <P style="margin: 0px 35px 20px 45px;">
            <span><font color="red" id="error">${errorInfo }</font></span>
            <SPAN style="float: right;"> 
                  <input type="submit" style="background: rgb(0, 142, 173); padding: 7px 10px; border-radius: 4px; border: 1px solid rgb(26, 117, 152); border-image: none; color: rgb(255, 255, 255); font-weight: bold;" value="登录"/> 
             </SPAN>         
             </P>
        </DIV>
    </DIV>
</form>
</body>
</html>