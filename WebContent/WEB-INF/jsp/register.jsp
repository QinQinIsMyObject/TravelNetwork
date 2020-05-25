<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>注册</title>
        <link rel="stylesheet" type="text/css" href="css/common.css">
        <link rel="stylesheet" href="css/register.css">
		<script src="js/jquery-3.3.1.js"></script>
    </head>
	<body>
	<!--引入头部-->
	<div id="header"><%@ include file="header.jsp" %></div>
        <!-- 头部 end -->
    	<div class="rg_layout">
    		<div class="rg_form clearfix">
    			<div class="rg_form_left">
    				<p>新用户注册</p>
    				<p>USER REGISTER</p>
    			</div>
    			<div class="rg_form_center">
					<div id="errorMsg" style="color:red;text-align: center"></div>
					<!--注册表单-->
    				<form id="registerForm" action="doReg.do" method="post">
    					<table style="margin-top: 25px;">
    						<tr>
    							<td class="td_left">
    								<label for="username">用户名</label>
    							</td>
    							<td class="td_right">
    								<input type="text" id="username" name="username" placeholder="请输入账号">
    							</td>
    						</tr>
    						<tr>
    							<td class="td_left">
    								<label for="password">密码</label>
    							</td>
    							<td class="td_right">
    								<input type="text" id="password" name="password" placeholder="请输入密码">
    							</td>
    						</tr>
    						<tr>
    							<td class="td_left">
    								<label for="email">Email</label>
    							</td>
    							<td class="td_right">
    								<input type="text" id="email" name="email" placeholder="请输入Email">
    							</td>
    						</tr>
    						<tr>
    							<td class="td_left">
    								<label for="name">姓名</label>
    							</td>
    							<td class="td_right">
    								<input type="text" id="name" name="name" placeholder="请输入真实姓名">
    							</td>
    						</tr>
    						<tr>
    							<td class="td_left">
    								<label for="telephone">手机号</label>
    							</td>
    							<td class="td_right">
    								<input type="text" id="telephone" name="telephone" placeholder="请输入您的手机号">
    							</td>
    						</tr>
    						<tr>
    							<td class="td_left">
    								<label for="sex">性别</label>
    							</td>
    							<td class="td_right gender">
    								<input type="radio" id="sex" name="sex" value="男" checked> 男
    								<input type="radio" name="sex" value="女"> 女
    							</td>
    						</tr>
    						<tr>
    							<td class="td_left">
    								<label for="birthday">出生日期</label>
    							</td>
    							<td class="td_right">
    								<input type="date" id="birthday" name="birthday" placeholder="年/月/日">
    							</td>
    						</tr>
    					<!-- 	<tr>
    							<td class="td_left">
    								<label for="check">验证码</label>
    							</td>
    							<td class="td_right check">
    								<input type="text" id="check" name="check" class="check">
    								<img src="checkCode" height="32px" alt="" onclick="changeCheckCode(this)">
									<script type="text/javascript">
										//图片点击事件
										function changeCheckCode(img) {
											img.src="checkCode?"+new Date().getTime();
                                        }
									</script>
    							</td>
    						</tr> -->
    						<tr>
    							<td class="td_left"> 
    							</td>
    							<td class="td_right check"> 
    								<input type="submit" id="btn1" class="submit" value="注册">
						<span id="msg" style="color: red;">${msg==null?'':msg}</span>
    							</td>
    						</tr>
                            <!-- 提示信息 -->
                            <tr>
    							<td class="td_left"></td>
    							<td class="td_right">
    							    <span id="msg" style="color: red;">${msg==null?'':msg}</span>
    							</td>
                            </tr>
    					</table>
    				</form>
    			</div>
    			<div class="rg_form_right">
    				<p>
    					已有账号？
    					<a href="#">立即登录</a>
    				</p>
    			</div>
    		</div>
    	</div>
        <!--引入尾部-->
    	<div id="footer"><%@ include file="footer.jsp" %></div>
    	<script type="text/javascript">
        //页面初始化
        $(function({
            //点击时验证
            $("#btn1").click(function(){
                $("registerForm").submit(function(){
                    return checkUname() && checkEmail() && checkPhone() &&checkPwd() && checkName() &&checkBirth();
                });
            });
            //离开时验证
            $("#username").blur(checkUname);
            $("#email").blur(checkEmail);
            $("#telephone").blur(checkPhone);
            $("#password").blur(checkPwd);
            $("#name").blur(checkName);
            $("#birthday").blur(checkBirth);
        });
        
            //验证用户名
            function checkUname(){
                var uname=$("#username").val();
               /*  if(uname.length==0){
                    //加红色，实线边框
                    $("#username").css("border","1px solid red");
                    $("#msg").html("用户名不能为空！");
                    return false;
                }else{
                    //清空红色实线边框
                    $("#username").css("border","");
                    //清空消息
                    $("#msg").html("");
                    return 
                } */
                //正则表达式
                var reg=/^\w{6,10}$/;
                if(!reg.test(uname)){
                    //加红色，实线边框
                    $("#username").css("border","1px solid red");
                    $("#msg").html("用户名不能为空且由不为空且由数字、字母、下划线组成的6-10个字符！");
                    return false;
                }
                //清空红色实线边框
                $("#username").css("border","");
                //清空消息
                $("#msg").html("");
                return true;
            }
            //验证邮箱
            function checkEmail(){
                var email=$("#email").val();
                //邮箱正则表达式-xiefucai@qq.com
                var reg=/^[a-z0-9]{3,12}@[a-z0-9]{2,3}\.com$/;
                if(!reg.test(email)){
                    //加红色，实线边框
                    $("#email").css("border","1px solid red");
                    $("#msg").html("邮箱不为空且要合法！");
                    return false;
                }
                //清空红色实线边框
                $("#email").css("border","");
                //清空消息
                $("#msg").html("");
                return true;
            }
            //验证手机号
            function checkPhone(){
                var telephone=$("#telephone").val();
                //手机号正则表达式
                var reg=/^1[356789]\d{9}$/;
                if(!reg.test(telephone)){
                    //加红色，实线边框
                    $("#telephone").css("border","1px solid red");
                    $("#msg").html("手机号不为空且由11位符合规则的数字组成！");
                    return false;
                }
                //清空红色实线边框
                $("#telephone").css("border","");
                //清空消息
                $("#msg").html("");
                return true;
            }
            //验证密码
            function checkPwd(){
                var password=$("#password").val();
                //密码正则表达式
                var reg=/^\w{6,15}$/;
                if(!reg.test(password)){
                    //加红色，实线边框
                    $("#password").css("border","1px solid red");
                    $("#msg").html("手机号不为空且由11位符合规则的数字组成！");
                    return false;
                }
                //清空红色实线边框
                $("#password").css("border","");
                //清空消息
                $("#msg").html("");
                return true;
            }
            //验证姓名
            function checkPwd(){
                var name=$("#name").val();
                if(name.length==0){
                    //加红色，实线边框
                    $("#name").css("border","1px solid red");
                    $("#msg").html("姓名为必填项！");
                    return false;
                }
                //清空红色实线边框
                $("#name").css("border","");
                //清空消息
                $("#msg").html("");
                return true;
            }
            //验证出生日期
            function checkBirth(){
                var birthday=$("#birthday").val();
                if(birthday.length==0){
                    //加红色，实线边框
                    $("#birthday").css("border","1px solid red");
                    $("#msg").html("出生日期为必填项！");
                    return false;
                }
                //清空红色实线边框
                $("#birthday").css("border","");
                //清空消息
                $("#msg").html("");
                return true;
            }
    	</script>
    </body>
</html>