<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>智酷旅游网-登录</title>
    <link rel="stylesheet" type="text/css" href="css/common.css">
    <link rel="stylesheet" type="text/css" href="css/login.css">
    <!--导入angularJS文件-->
    <script src="js/angular.min.js"></script>
    <!--导入jquery-->
    <script src="js/jquery-3.3.1.js"></script>
    <script type="text/javascript">
        $(function () {
            //1、用户点击时验证
            $("#sub_login").click(function () {
                return checkUname() && checkPwd();
            });
            //2、离开焦点时验证
            $("#username").blur(checkUname);
            $("#password").blur(checkPwd);
        });

        //验证用户名-由6到15个字母、数字、下划线组成，不符合规则-边框变为红实线并给其提示，否则清空边框及提示信息
        function checkUname() {
            //1、获取值
            var uname = $("#username").val();
            //2、正则表达式
            var reg_uname = /^\w{6,15}$/;
            //3、判断并提示
            if (!reg_uname.test(uname)) {
                $("#username").css("border", "1px solid red");
                $("#errorMsg").html("用户名由6到15个字母、数字、下划线组成！");
                return false;
            }
            //清空边框及提示信息
            $("#username").css("border", "");
            $("#errorMsg").html("");
            return true;
        }

        //验证密码-由6到15个字母、数字、下划线组成，不符合规则-边框变为红实线并给其提示，否则清空边框及提示信息
        function checkPwd() {
            //1、获取值
            var pwd = $("#password").val();
            //2、正则表达式
            var reg_pwd = /^\w{6,15}$/;
            //3、判断并提示
            if (!reg_pwd.test(pwd)) {
                $("#password").css("border", "1px solid red");
                $("#errorMsg").html("密码由6到15个字母、数字、下划线组成！");
                return false;
            }
            //清空边框及提示信息
            $("#password").css("border", "");
            $("#errorMsg").html("");
            return true;
        }
    </script>
</head>

<body>
<!--引入头部-->
<div id="header">
    <%@ include file="header.jsp" %>
</div>
<!-- 头部 end -->
<section id="login_wrap">
    <div class="fullscreen-bg" style="background: url(images/login_bg.png);height: 532px;">

    </div>
    <div class="login-box">
        <div class="title">
            <img src="images/login_logo.png" alt="">
            <span>欢迎登录智酷旅游账户</span>
        </div>
        <div class="login_inner">

            <!--登录错误提示消息-->
            <div id="errorMsg" class="alert alert-danger">${msg==null?'':msg }</div>
            <form id="loginForm" action="doLogin.do" method="post" accept-charset="utf-8">
                <input type="hidden" name="action" value="login"/>
                <input name="username" id="username" type="text" placeholder="请输入账号" autocomplete="off">
                <input name="password" id="password" type="password" placeholder="请输入密码" autocomplete="off">
                <!-- 		<div class="verify">
                        <input name="check" type="text" placeholder="请输入验证码" autocomplete="off">
                        <span><img src="checkCode" alt="" onclick="changeCheckCode(this)"></span>
                        <script type="text/javascript">
                            //图片点击事件
                            function changeCheckCode(img) {
                                img.src="checkCode?"+new Date().getTime();
                            }
                        </script>
                </div> -->
                <div class="submit_btn">
                    <button type="submit" id="sub_login">登录</button>
                    <div class="auto_login">
                        <input type="checkbox" name="" class="checkbox">
                        <span>自动登录</span>
                    </div>
                </div>
            </form>
            <div class="reg">没有账户？<a href="toRegPage.do">立即注册</a></div>
        </div>
    </div>
</section>
<!--引入尾部-->
<div id="footer">
    <%@ include file="footer.jsp" %>
</div>
<script src="js/jquery-1.11.0.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</body>

</html>