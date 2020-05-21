<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>注册</title>
        <link rel="stylesheet" type="text/css" href="css/common.css">
        <link rel="stylesheet" href="css/register.css">
		<!--导入jquery-->
		<script src="js/jquery-3.3.1.js"></script>
    </head>
    <body>
    <!--引入头部-->
    <div id="header"><%@ include file="header.jsp" %></div>
        <!-- 头部 end -->
    	<div style="text-align:center;red:yellow;font-weight:bold;height:150px;padding-top:100px;font-size:30px;">
    		<h4>恭喜，注册成功！请登录您注册的邮箱进行账号激活，激活后才能登录。</h4>
    	</div>
        <!--引入尾部-->
    	<div id="footer"><%@ include file="footer.jsp" %></div>
    </body>
</html>