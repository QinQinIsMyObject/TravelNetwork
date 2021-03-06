# 旅游网

## 1、主要功能
实现旅游网
## 2、主要知识点
### （1）目标
	能正确理解分析旅游网功能需求；
	能正确创建数据库和表；
	能理解并熟练搭建SSM环境；
	掌握基于SSM进行相关功能操作；
	结合以前所学能灵活综合运用到项目中；
	积累项目案例经验。
### （2）任务
```
搭建SSM环境；
完成数据库和表的创建并添加测试数据；
完成旅游网相关功能。
```
### （3）功能说明
#### 主要功能概述
```
旅游网主要有以下八大功能需求：
	登录功能；
	注册功能；
	邮件处理；
	分类数据；
	线路分页；
	线路查询；
	线路详情；
	线路收藏。
```
### （4）数据库表
![image-20200520174547171](RImgs/image-20200520174547171.png)
### （5）功能操作
#### 1.环境搭建
```
导入数据库表及相关测试数据；
导入基础的素材（前端后台）。
```
#### 2.注册功能
##### 去注册页面
a、页面---在header.jsp里面添加这个超链接
```html
<a href="toRegPage.do">注册</a>
```
b、控制层---在UserController.java中
```java
@RequestMapping("/toRegPage.do")
public String toRegPage() {
    return "register";
}
```
##### 验证输入的合法性
###### a、验证规则
**用户名：**不为空且由数字、字母、下划线组成的6-10个字符，不符合要求给出提示信息
**密码：**不为空且由数字、字母、下划线组成的6-15个字符，不符合要求给出提示信息
**姓名：**非空，不符合要求给出提示信息
**出生日期：**非空，不符合要求给出提示信息
**邮箱：**不为空且要合法，不符合要求给出提示信息
**手机号：**不为空且由11位符合规则的数字组成，不符合要求给出提示信息
###### b、验证时机-register.jsp
提交表单时
```js
//点击时验证
$("#btn1").click(function(){
    $("#registerForm").submit(function(){
    	return checkUname() && checkEmail() && checkPhone() &&checkPwd() && checkName() &&checkBirth();
    });
});
```
离开焦点时
```js
//离开时验证
$("#username").blur(checkUname);
$("#email").blur(checkEmail);
$("#telephone").blur(checkPhone);
$("#password").blur(checkPwd);
$("#name").blur(checkName);
$("#birthday").blur(checkBirth);
```
验证代码
```js
//验证用户名
function checkUname(){
    var uname=$("#username").val();
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
    //发送ajax请求
    $.post("checkUname.do",{"username":uname},function(res){
        if(res=="false"){
            //加红色，实线边框
            $("#username").css("border","1px solid red");
            $("#msg").html("用户名重复不可用！");
            return false;
        }else{
            //清空红色实线边框
            $("#username").css("border","");
            //清空消息
            $("#msg").html("");
            return true;
        }
    })
    return true;
}
//验证邮箱
function checkEmail(){
    var email=$("#email").val();
    //邮箱正则表达式-xiefucai@qq.com
    var reg=/^[a-z0-9]{3,12}@[a-z0-9]{2,6}\.com$/;
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
function checkName(){
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
```
##### 用户名合法性
用户名通过验证要发送异步Ajax请求-从后台验证用户名是否重复
###### 数据层-UserMapper.java
```java
/**
 * 根据用户名查询该用户
 */
@Select("select * from tab_user where username=#{username}")
User selectByUname(String username);
```
###### 业务层接口-UserService.java
```java
boolean checkUname(String username);
```
###### 业务层实现-在UserServiceImpl.java中重写以下方法
```java
@Override
public boolean checkUname(String username) {
    User user = uMapper.selectByUname(username);
    if (user != null) {
        return false;
    } else {
        return true;
    }
}
```
###### 控制层-UserController.java
```java
/**
 * 验证用户名是否重复
 */
@RequestMapping("/checkUname.do")
public String checkUserName(String username) {
    boolean flag = uService.checkUname(username);
    if (!flag) {
        // 用户名重复，返回false
        return "false";
    } else {
        return "true";
    }
}
```
###### 表示层-在register.jsp的验证用户名中发送ajax请求部分
```js
//发送ajax请求
$.post("checkUname.do",{"usernane":uname},function(res){
    if(res=="false"){
        //加红色，实线边框
        $("#username").css("border","1px solid red");
        $("#msg").html("用户名重复不可用！");
        return false;
    }else{
        //清空红色实线边框
        $("#username").css("border","");
        //清空消息
        $("#msg").html("");
        return true;
    }
})
```
##### 保存数据
###### 页面情况-register.jsp
```html
<form id="registerForm" action="doReg.do" method="post">
```
###### 数据层-UserMapper.java
```java
/**
 * 增加用户-点击注册，增加数据到数据库中
 * 
 * @param user
 * @return
 */
int addUser(User user);
```
###### 映射文件-/TravelProject/src/com/zk/dao/UserMapper.xml
```xml
<!-- 增加用户|注册 -->
<insert id="addUser" useGeneratedKeys="true" keyProperty="uid">
    insert into
    tab_user(username,password,name,birthday,sex,telephone,email,status,code)
    values(#{username},#{password},#{name},#{birthday},#{sex},#{telephone},#{email},#{status},#{code})
</insert>
```
###### 业务层接口-/TravelProject/src/com/zk/service/UserService.java
```java
/**
 * 只是关心是否增加成功，不关心是如何增加的
 * 
 * @return
 */
boolean registerUser(User user);
```
###### 业务层实现-/TravelProject/src/com/zk/service/impl/UserServiceImpl.java
```java
@Transactional
public boolean registerUser(User user) {
    // 生成随机的激活码
    user.setCode(UuidUtil.getUuid());
    // 设置用户激活状态为N-未激活
    user.setStatus("N");
    int num = uMapper.addUser(user);
    if (num > 0) {
        return true;
    }
    return false;
}
```
###### 控制层-/TravelProject/src/com/zk/controller/UserController.java
```java
/**
 * 注册功能
 * 
 * @param user
 * @return
 */
@RequestMapping("/doReg.do")
public ModelAndView doReg(User user) {
    ModelAndView mv = new ModelAndView();
    boolean flag = uService.registerUser(user);
    if (flag) {
        // 注册成功-去注册成功页面
        mv.setViewName("register_ok");
    } else {
        // 注册失败-重新回到注册页面
        mv.setViewName("register");
        mv.addObject("msg", "注册失败");
    }
    return mv;
}
```
##### 注册失败页面-在/TravelProject/WebContent/WEB-INF/jsp/register.jsp页面注册按钮下
```html
<!-- 提示信息 -->
<tr>
    <td class="td_left"></td>
    <td class="td_right">
        <span id="msg" style="color: red;">${msg==null?'':msg}</span>
    </td>
</tr>
```
#### 3.邮件处理
##### 邮箱设置-/TravelProject/src/com/zk/utils/MailUtils.java
例如：登录自己申请的QQ邮箱，在”设置-账户-POP3/IMAP/SMTP/Exchange/CardDAV/CalDAV服务中开启POP3/SMTP服务“；然后在MailUtils中设置自己的邮箱账号和密码(授权码)。
```java
// 发件人邮箱地址-一般为企业邮箱
private static final String USER = "xxx@qq.com";
// 如果是qq邮箱使用客户端授权码，163邮箱的话就是开启客户端授权码
private static final String PASSWORD = "xxx";
```
##### 发送邮件-在/TravelProject/src/com/zk/service/impl/UserServiceImpl.java中添加邮件发送代码
```java
@Transactional
public boolean registerUser(User user) {
    // 生成随机的激活码
    user.setCode(UuidUtil.getUuid());
    // 设置用户激活状态为N-未激活
    user.setStatus("N");
    int num = uMapper.addUser(user);
    if (num > 0) {
        // 用户的信息已经保存到数据库中
        String context = "<a href='http://localhost:8080/TravelProject/activeMail.do?code=" + user.getCode()
            + "'>点击激活旅游网</a>";
        // 发件人邮箱-发送的内容-发送的标题
        MailUtils.sendMail(user.getEmail(), context, "旅游网激活邮件");
        return true;
    }
    return false;
}
```
#### 4.邮件激活
##### 数据层-/TravelProject/src/com/zk/dao/UserMapper.java
```java
/**
 * 根据激活码查询用户
 * 
 * @param code
 * @return
 */
@Select("select * from tab_user where code=#{code}")
User selectByCode(String code);
/**
 * 更新用户信息
 * 
 * @param user
 * @return
 */
int updateUser(User user);
```
##### 映射文件-/TravelProject/src/com/zk/dao/UserMapper.xml
```xml
<!-- 更新用户信息 -->
<update id="updateUser" parameterType="user">
    update tab_user
    <set>
        <if test="username!=null and username!=''">username=#{username},</if>
        <if test="password!=null and password!=''">password=#{password},</if>
        <if test="name!=null and name!=''">name=#{name},</if>
        <if test="birthday!=null and birthday!=''">birthday=#{birthday},</if>
        <if test="sex!=null and sex!=''">sex=#{sex},</if>
        <if test="telephone!=null and telephone!=''">telephone=#{telephone},</if>
        <if test="email!=null and email!=''">email=#{email},</if>
        <if test="status!=null and status!=''">status=#{status},</if>
        <if test="code!=null and code!=''">code=#{code}</if>
    </set>
    where uid=#{uid}
</update>
```
##### 业务接口-/TravelProject/src/com/zk/service/UserService.java
```java
/**
 * 激活用户
 * 
 * @param user
 * @return
 */
boolean activeUser(String code);
```
##### 业务实现-/TravelProject/src/com/zk/service/impl/UserServiceImpl.java
```java
@Transactional
public boolean activeUser(String code) {
    User user = uMapper.selectByCode(code);
    // 注册了也就是有这个用户存在-去激活-返回true
    if (user != null) {
        // 设置激活状态为Y
        user.setStatus("Y");
        // 更新激活状态为Y
        if (uMapper.updateUser(user) > 0) {
            return true;
        } else {
            return false;
        }
    }
    return false;
}
```
##### 控制层
```java
/**
 * 用户激活；激活成功-去登陆URL； 激活成功-给其提示信息（激活失败，请联系管理员）
 * 
 * @param code
 * @param res
 * @throws IOException
 */
@RequestMapping("/activeMail.do")
private void activeUser(String code, HttpServletResponse res) throws IOException {
    boolean flag = uService.activeUser(code);
    // 提示信息
    String msg = null;
    if (flag) {
        msg = "<h3><a href='toLogin.do'>激活成功，点击登录。</a></h3>";
    } else {
        msg = "<h3>激活失败，请联系管理员！</h3>";
    }
    res.setContentType("text/html;charset=utf-8");
    res.getWriter().write(msg);
}
```
##### 激活成功去登录页面
```java
/**
 * 去登录页面
 * 
 * @return
 */
@RequestMapping("/toLogin.do")
public String toLoginPage() {
    return "login";
}
```
#### 5.用户登录
##### 页面验证
###### 验证规则
用户名：由6到15个字母、数字、下划线组成，不符合规则-边框变为红实线并给其提示，否则清空边框及提示信息
密码：由6到15个字母、数字、下划线组成，不符合规则-边框变为红实线并给其提示，否则清空边框及提示信息
###### 验证时机
用户点击提交时验证
离开焦点时验证
###### 验证实现
```js
<script type="text/javascript">
    $(function(){
    //1、用户点击时验证
    $("#sub_login").click(function(){
        return checkUname() && checkPwd();
    });
    //2、离开焦点时验证
    $("#username").blur(checkUname);
    $("#password").blur(checkPwd);
});

//验证用户名-由6到15个字母、数字、下划线组成，不符合规则-边框变为红实线并给其提示，否则清空边框及提示信息
function checkUname(){
    //1、获取值
    var uname=$("#username").val();
    //2、正则表达式
    var reg_uname=/^\w{6,15}$/;
    //3、判断并提示
    if(!reg_uname.test(uname)){
        $("#username").css("border","1px solid red");
        $("#errorMsg").html("用户名由6到15个字母、数字、下划线组成！");
        return false;
    }
    //清空边框及提示信息
    $("#username").css("border","");
    $("#errorMsg").html("");
    return true;
}
//验证密码-由6到15个字母、数字、下划线组成，不符合规则-边框变为红实线并给其提示，否则清空边框及提示信息
function checkPwd(){
    //1、获取值
    var pwd=$("#password").val();
    //2、正则表达式
    var reg_pwd=/^\w{6,15}$/;
    //3、判断并提示
    if(!reg_pwd.test(pwd)){
        $("#password").css("border","1px solid red");
        $("#errorMsg").html("密码由6到15个字母、数字、下划线组成！");
        return false;
    }
    //清空边框及提示信息
    $("#password").css("border","");
    $("#errorMsg").html("");
    return true;
}
</script>
```
##### 登录实现
###### 数据接口-/TravelProject/src/com/zk/dao/UserMapper.java
```java
/**
 * 登录方法
 * 
 * @param username
 * @param password
 * @return
 */
@Select("select * from tab_user where username=#{username} and password=#{password}")
User login(@Param("username") String username, @Param("password") String password);
```
###### 业务接口-/TravelProject/src/com/zk/service/UserService.java
```java
User login(String username, String password);
```
###### 业务实现-/TravelProject/src/com/zk/service/impl/UserServiceImpl.java
```java
@Override
public User login(String username, String password) {
    return uMapper.login(username, password);
}
```
###### 控制层-/TravelProject/src/com/zk/controller/UserController.java
```java
/**
 * 用户登录
 * 
 * @param username
 * @param password
 * @return
 */
@RequestMapping("/doLogin.do")
public ModelAndView login(String username, String password, HttpServletRequest req) {
    ModelAndView mv = new ModelAndView();
    // 1、用户和密码不正确-用户不存在-去登录页面并给其提示-用户名或密码不正确
    User user = uService.login(username, password);
    if (user == null) {
        mv.addObject("msg", "用户名或密码不正确！");
        mv.setViewName("forward:toLogin.do");
    }
    // 2、用户和密码正确-用户存在-用户的状态不为Y-请去邮箱激活用户
    if (user != null && !"Y".equals(user.getStatus())) {
        mv.addObject("msg", "登录失败，请在邮箱激活！");
        mv.setViewName("forward:toLogin.do");
    }
    // 3、用户和密码正确-用户存在-用户的状态为Y
    if (user != null && "Y".equals(user.getStatus())) {
        // 登录成功后将用户信息保存到session对象当中
        req.getSession().setAttribute("user", user);
        mv.setViewName("forward:indexPage.do");
    }
    return mv;
}
```
##### 登录页面信息错误提示-/TravelProject/WebContent/WEB-INF/jsp/login.jsp
```jsp
<!--登录错误提示消息-->
<div id="errorMsg" class="alert alert-danger" >${msg==null?'':msg }</div>
```
##### 首页用户信息显示-/TravelProject/WebContent/WEB-INF/jsp/header.jsp
```jsp
<!-- 此user为UserController.java中登录成功后将用户信息保存到session对象当中的user -->
<span>欢迎，${sessionScope.user.name==null?"游客":sessionScope.user.name}</span>
```
#### 6.用户退出
退出本质-清空Session
##### 页面连接-/TravelProject/WebContent/WEB-INF/jsp/header.jsp
```jsp
<a href="toLogout.do">退出</a>
```
##### 控制层代码-/TravelProject/src/com/zk/controller/UserController.java
```java
/**
 * 用户退出
 * 
 * @param req
 * @return
 */
@RequestMapping("/toLogout.do")
public ModelAndView logout(HttpServletRequest req) {
    // 清空session
    req.getSession().invalidate();
    return new ModelAndView("forward:indexPage.do");
}
```
#### 7.导航条分类

##### 数据接口-src/com/zk/dao/CategoryMapper.java
```java
@Select("select cid,cname from tab_category")
List<Category> selectAllCategory();
```
##### 映射文件-src/com/zk/dao/CategoryMapper.xml
```xml
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.zk.dao.CategoryMapper">
</mapper>
```
##### 业务接口-src/com/zk/service/CategoryService.java
```java
List<Category> selectAllCategory();
```
##### 业务实现
```java
@Autowired
private CategoryMapper cMapper;

@Override
public List<Category> selectAllCategory() {
    return cMapper.selectAllCategory();
}
```
##### 控制层-src/com/zk/controller/CategoryController.java
```java
@Autowired
private CategoryService categoryService;

/**
 * List可以返回普通的String，可以返回对象，也可以返回list集合包括map
 *
 * @return
 */
@RequestMapping("/cgList.do")
@ResponseBody
public List<Category> getCategoryList() {
    List<Category> categoryList = categoryService.selectAllCategory();
    if (categoryList != null) {
        return categoryList;
    }
    return null;
}
```
##### 页面改造-WebContent/WEB-INF/jsp/header.jsp
```jsp
<!-- 首页导航 -->
<div class="navitem">
    <ul class="nav" id="category">
        <li class="nav-active"><a href="index.html">首页</a></li>
        <li class='cg'></li>
        <li><a href="favoriterank.html">收藏排行榜</a></li>
    </ul>
</div>
```
##### Ajax请求
```js
<script type="text/javascript">
    $(function () {
    $.post('cgList.do', function (res) {
        var html = "";
        for (var i = 0; i < res.length; i++) {
            html += "<a href='#'>" + res[i].cname + "</a>"
        }
        //将遍历出来的超链接放到li中
        $(".cg").html(html);
    })
});
</script>
```
#### 8.分类数据模糊查

##### 页面改造-WebContent/WEB-INF/jsp/header.jsp
```jsp
<form action="routeList.do" method="post">
    <input name="rname" id="rname" type="text" placeholder="请输入路线名称" class="search_input"
           value="${rname==''?'':rname}">
    <input type="submit" value="搜索" class="search-button"/>
</form>
```
###### 分类超链接改造
```jsp
for (var i = 0; i < res.length; i++) {
	html += "<a href='routeList.do?cid=" + res[i].cid + "'>" + res[i].cname + "</a>"
}
```
##### 数据接口-src/com/zk/dao/RouteMapper.java
```java
/**
 * 查询
 * @param cid
 * @param rid
 * @return
 */
List<Route> selectRouteByCidOrRname(@Param("cid") Integer cid, @Param("rname") String rname);
```
##### 映射文件-src/com/zk/dao/RouteMapper.xml
```xml
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.zk.dao.RouteMapper">
    <!--根据分类id或者线路名称进行模糊查询-->
    <select id="selectRouteByCidOrRname" resultType="route">
        select rname,price,routeIntroduce,rimage from tab_route
        <trim prefix="where" prefixOverrides="and || or">
            <if test="cid!=null">
                cid=#{cid}
            </if>
            <if test="rname!=null and rname!=''">
                and rname like concat('%',#{rname},'%')
            </if>
        </trim>
    </select>
</mapper>
```
##### 业务接口-src/com/zk/service/RouteService.java
```java
List<Route> selectRouteByCidOrRname(Integer cid, String rname);
```
##### 业务实现-src/com/zk/service/impl/RouteServiceImpl.java
```java
@Autowired
private RouteMapper routeMapper;

@Override
public List<Route> selectRouteByCidOrRname(Integer cid, String rname) {
    return routeMapper.selectRouteByCidOrRname(cid, rname);
}
```
##### 控制层-src/com/zk/controller/RouteController.java
```java
@Autowired
private RouteService routeService;

@RequestMapping("/routeList.do")
public ModelAndView getRouteList(@RequestParam(name = "pno", required = true, defaultValue = "1") Integer pno,
                                 @RequestParam(name = "cid", required = true, defaultValue = "5") Integer cid,
                                 @RequestParam(name = "rname", required = true, defaultValue = "") String rname) {
    ModelAndView modelAndView = new ModelAndView();
    //开始分页
    PageHelper.startPage(pno, 10);
    List<Route> routeList = routeService.selectRouteByCidOrRname(cid, rname);
    //分好页的数据
    PageInfo<Route> pageInfo = new PageInfo<Route>(routeList);
    if (routeList != null) {
        modelAndView.addObject("rlist", routeList);
        modelAndView.addObject("rname", rname);
        //当前页码
        modelAndView.addObject("pno", pno);
        modelAndView.addObject("page", pageInfo);
        modelAndView.addObject("cid", cid);
        //逻辑视图名
        modelAndView.setViewName("route_list");
        return modelAndView;
    }
    return null;
}
```
##### 页面展示-WebContent/WEB-INF/jsp/route_list.jsp

```jsp
<ul>
    <c:forEach items="${rlist}" var="r">
        <li>
            <div class="img">
                <img width="299px" src="${r.rimage}" alt="">
            </div>
            <div class="text1">
                <p>${r.rname}</p>
                <br/>
                <p>${r.routeIntroduce}</p>
            </div>
            <div class="price">
                <p class="price_num">
                    <span>&yen;</span> <span>${r.price}</span> <span>起</span>
                </p>
                <p>
                    <a href="routeDetail?rid=${r.rid}">查看详情</a>
                </p>
            </div>
        </li>
    </c:forEach>
</ul>
```
##### 百度分页效果分析
```
1、判断上页和下页的形成条件
	上一页：当前页面大于1；
	下一页：当前页码大于1且当前页码小于总页数。
2、上一页和下一页中间遍历部分
	总页数小于等于10；
	总页数大于10时；
	当前页面小于等于6和大于6是的情况。
```
###### 分页效果展示-WebContent/WEB-INF/jsp/route_list.jsp
```jsp
<div class="page_num_inf">
    <i></i> 共 <span>${page.pages}</span>页<span>${page.total}</span>条
</div>
<div class="pageNum">
    <ul>
        <c:if test="${pno > 1}">
            <li class="threeword"><a
                                     href="routeList.do?pno=${page.prePage}&cid=${cid}&rname=${rname}">&lt;上一页</a></li>
        </c:if>
        <c:choose>
            <c:when test="${page.pages<=10}">
                <c:forEach begin="1" end="${page.pages}" var="i">
                    <c:if test="${pno==i}">
                        <li class="curPage"><a
                                               href="routeList.do?pno=${i}&cid=${cid}&rname=${rname}">${i}</a></li>
                    </c:if>
                    <c:if test="${pno!=i}">
                        <li><a href="routeList.do?pno=${i}&cid=${cid}&rname=${rname}">${i}</a></li>
                    </c:if>
                </c:forEach>
            </c:when>
            <c:when test="${page.pages>10}">
                <c:if test="${pno<=6}">
                    <c:forEach begin="1" end="10" var="i">
                        <c:if test="${pno==i}">
                            <li class="curPage"><a
                                                   href="routeList.do?pno=${i}&cid=${cid}&rname=${rname}">${i}</a></li>
                        </c:if>
                        <c:if test="${pno!=i}">
                            <li><a href="routeList.do?pno=${i}&cid=${cid}&rname=${rname}">${i}</a></li>
                        </c:if>
                    </c:forEach>
                </c:if>
                <c:if test="${pno>6}">
                    <c:forEach begin="${pno-5}"
                               end="${(pno+4)>page.pages?page.pages:(pno+4)}" var="i">
                        <c:if test="${pno==i}">
                            <li class="curPage"><a
                                                   href="routeList.do?pno=${i}&cid=${cid}&rname=${rname}">${i}</a></li>
                        </c:if>
                        <c:if test="${pno!=i}">
                            <li><a href="routeList.do?pno=${i}&cid=${cid}&rname=${rname}">${i}</a></li>
                        </c:if>
                    </c:forEach>
                </c:if>
            </c:when>
        </c:choose>
        <c:if test="${pno>=1 && pno<page.pages}">
            <li class="threeword"><a
                                     href="routeList.do?pno=${page.nextPage}&cid=${cid}&rname=${rname}">下一页&gt;</a></li>
        </c:if>
    </ul>
</div>
```
#### 9.线路详情查询

##### 功能分析

```
详情页的数据主要来自3张表：tab_route(线路表)、tab_route_img(线路图片表)、tab_seller(商家表)；
线路表和商家表是一对一关系通过外键sid关联、线路表和线路图片表示一对多关系通过外键rid进行关联；
以线路表为主，在映射文件当中配置一对一和一对多关系。
```
##### 数据接口-src/com/zk/dao/RouteMapper.java
```java
/**
 * 根据线路id查询线路
 * @param rid
 * @return
 */
Route selectByRid(Integer rid);
```
##### 映射文件-src/com/zk/dao/RouteMapper.xml
```xml
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.zk.dao.RouteMapper">
    <resultMap id="rResultMap" type="Route">
        <id property="rid" column="rid"/>
        <result property="rname" column="rname"/>
        <result property="price" column="price"/>
        <result property="routeIntroduce" column="routeIntroduce"/>
        <result property="rflag" column="rflag"/>
        <result property="rdate" column="rdate"/>
        <result property="isThemeTour" column="isThemeTour"/>
        <result property="count" column="count"/>
        <result property="cid" column="cid"/>
        <result property="rimage" column="rimage"/>
        <result property="sid" column="sid"/>
        <result property="sourceId" column="sourceId"/>
        <!--一对一-->
        <association property="seller" javaType="Seller">
            <id property="sid" column="sid"/>
            <result property="sname" column="sname"/>
            <result property="address" column="address"/>
            <result property="consphone" column="consphone"/>
        </association>
        <!--一对多-->
        <collection property="routeImgList" ofType="RouteImg">
            <id property="rgid" column="rgid"/>
            <result property="rid" column="rid"/>
            <result property="bigPic" column="bigPic"/>
            <result property="smallPic" column="smallPic"/>
        </collection>
    </resultMap>
    <!--根据线路id查询线路-->
    <select id="selectByRid" resultMap="rResultMap">
        select r.*, i.*, s.*
        from tab_route r,
             tab_route_img i,
             tab_seller s
        where r.rid = i.rid
          and r.sid = s.sid
          and r.rid = #{rid}
    </select>
</mapper>
```
##### 业务接口-src/com/zk/service/RouteService.java
```java
Route selectByRid(Integer rid);
```
##### 业务实现-src/com/zk/service/impl/RouteServiceImpl.java
```java
@Override
public Route selectByRid(Integer rid) {
    return routeMapper.selectByRid(rid);
}
```
##### 控制层-src/com/zk/controller/RouteController.java
```java
/**
 * 根据线路id查询线路详情
 * @param rid
 * @return
 */
@RequestMapping("/routeDetail.do")
public ModelAndView routeDetail(@RequestParam(name = "rid", required = true, defaultValue = "") Integer rid) {
    ModelAndView modelAndView = new ModelAndView();
    Route route = routeService.selectByRid(rid);
    if (route != null) {
        List<RouteImg> imgList = route.getRouteImgList();
        Seller seller = route.getSeller();
        //线路对象
        modelAndView.addObject("rt", route);
        //图片集合
        modelAndView.addObject("imgList", imgList);
        //商家
        modelAndView.addObject("sl", seller);
        //去线路详情页面
        modelAndView.setViewName("route_detail");
        return modelAndView;
    }
    return null;
}
```
##### 页面展示-WebContent/WEB-INF/jsp/route_detail.jsp
```jsp
<div class="prosum_box">
    <dl class="prosum_left">
        <dt>
            <img alt="" class="big_img" src="${rt.rimage}">
        </dt>
        <dd>
            <a class="up_img up_img_disable"></a>
            <c:forEach items="${imgList}" var="i" varStatus="v">
                <c:if test="${v.count>4}">
                    <a title="" class="little_img" data-bigpic="${i.bigPic}" style="display:none;">
                        <img src="${i.smallPic}">
                    </a>
                </c:if>
                <c:if test="${v.count<=4}">
                    <a title="" class="little_img" data-bigpic="${i.bigPic}">
                        <img src="${i.smallPic}">
                    </a>
                </c:if>
            </c:forEach>
            <a class="down_img down_img_disable" style="margin-bottom: 0;"></a>
        </dd>
    </dl>
    <div class="prosum_right">
        <p class="pros_title">${rt.rname}</p>
        <p class="hot">${rt.routeIntroduce}</p>
        <div class="pros_other">
            <p>经营商家 ：${sl.sname}</p>
            <p>咨询电话 : ${sl.consphone}</p>
            <p>地址 ：${sl.address}</p>
        </div>
        <div class="pros_price">
            <p class="price"><strong>¥${rt.price}</strong><span>起</span></p>
            <p class="collect">
                <a class="btn"><i class="glyphicon glyphicon-heart-empty"></i>点击收藏</a>
                <a class="btn already" disabled="disabled"><i class="glyphicon glyphicon-heart-empty"></i>点击收藏</a>
                <span>已收藏${rt.count}次</span>
            </p>
        </div>
    </div>
</div>
```
#### 10.收藏功能
###### 思路分析
```
	首先用户点击收藏时需要判断用户是否登录，如果没有登录给其提示并且跳转到登录页面;
如果已经登录，需要查询该用户是否已经收藏过该线路，如果有收藏，则提示您已收藏过;
如果已经登录，但是之前没有收藏过此线路，则将收藏的信息保存到数据库并更新线路的收藏次数。
```
###### 底层方法
```
1、根据用户id和线路id查询是否有收藏
2、添加收藏的方法
3、更新线路收藏次数的方法
```
##### 数据接口1-src/com/zk/dao/FavoriteMapper.java
在FavoriteMapper中
```java
/**
 * 根据线路id和用户id查询是否有收藏信息
 *
 * @param rid
 * @param uid
 * @return
 */
@Select("select * from tab_favorite where rid=#{rid} and uid=#{uid}")
Favorite selectFtByRidAndUid(@Param("rid") Integer rid, @Param("uid") Integer uid);

/**
 * @param ft
 * @return
 */
@Insert("insert into tab_favorite(rid, date, uid) values (#{rid},now(),#{uid})")
int addCollect(Favorite ft);
```
##### 数据接口2-src/com/zk/dao/RouteMapper.java
在RouteMapper接口中
```java
/**
 * 更新某个线路的收藏次数
 * @param rid
 * @return
 */
@Update("update tab_route set count=#{count} where rid=#{rid}")
int updateCount(Route rt);
```
##### 业务接口-src/com/zk/service/FavoriteService.java
```java
/**
 * 收藏功能
 * @param favorite
 * @return
 */
boolean doCollect(Favorite favorite);
```
##### 业务实现-src/com/zk/service/impl/FavoriteServiceImpl.java
```java 
@Autowired
private FavoriteMapper favoriteMapper;

@Autowired
private RouteMapper routeMapper;

@Transactional
public boolean doCollect(Favorite favorite) {
    Favorite favorite1 = favoriteMapper.selectFtByRidAndUid(favorite.getRid(), favorite.getUid());
    if (favorite1 == null) {
        if (favoriteMapper.addCollect(favorite) > 0) {
            Route route = routeMapper.selectByRid(favorite.getRid());
            route.setCount(route.getCount() + 1);
            routeMapper.updateCount(route);
            return true;
        }
        return false;
    }
    return false;
}
```
##### 控制层-src/com/zk/controller/FavoriteController.java
```java
@Autowired
private FavoriteService favoriteService;

/**
 * 收藏
 *
 * @param favorite
 * @return
 */
@RequestMapping("/doCollect.do")
@ResponseBody
public String doCollect(Favorite favorite) {
    boolean flag = favoriteService.doCollect(favorite);
    if (flag) {
        return "true";
    }
    return "false";
}
```
##### 页面请求-
```js
<script type="text/javascript">
    $(function () {
        $(".btn").click(function () {
            var uname = '${sessionScope.user.username}';
            if (uname == null || uname == "") {
                alert("请登录在收藏！");
                window.location.href = 'toLogin.do';
                return;
            }
            //已登录-发送ajax判断用户是否有收藏该线路
            var rid = '${rt.rid}';
            var uid = '${sessionScope.user.uid}';
            $.post('doCollect.do', {"rid": rid, "uid": uid}, function (res) {
                if (res == "false") {
                    alert("你已收藏过该线路！");
                    //禁用收藏按钮
                    $(".btn").attr("disabled", "disabled");
                }
                alert("收藏成功！");
                //禁用收藏按钮
                $(".btn").attr("disabled", "disabled");
            })
        });
    })
</script>
```
### （6）项目总结
## 3、说明
### 项目中注意事项
```xml
转自：https://my.oschina.net/kkrgwbj/blog/734530
	通常我们的项目有时候是以jar包的形式发布出去，但是此时如果你直接使用lo4j2的api的话，相当于别人依赖你的jar的项目也必须加入log4j2的jar包。这样是高度耦合的。我们不建议这样使用，log4j2官方给出了适配slf4j，我们只需要在项目中加入以下依赖：
<!-- https://mvnrepository.com/artifact/org.apache.logging.log4j/log4j-slf4j-impl -->
<dependency>
    <groupId>org.apache.logging.log4j</groupId>
    <artifactId>log4j-slf4j-impl</artifactId>
    <version>2.13.3</version>
    <scope>test</scope>
</dependency>
<!-- https://mvnrepository.com/artifact/org.slf4j/slf4j-api -->
<dependency>
    <groupId>org.slf4j</groupId>
    <artifactId>slf4j-api</artifactId>
    <version>1.7.30</version>
</dependency>
```
## 4、出错
### 运行项目出错，控制台无错误输出
```xml
<!DOCTYPE mapper
  PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
  "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.zk.dao.UserMapper">
    
</mapper>

注意：namespace="com.zk.dao.UserMapper"要和包名对应，出错为namespace="com.SSM.dao.UserMapper"，而包名为"com.zk.dao.UserMapper"
```
### 解决idea出现Error:(8, 26) java: 程序包javax.servlet.http不存在
```xml
<dependency>
    <groupId>javax.servlet</groupId>
    <artifactId>servlet-api</artifactId>
    <version>2.5</version>
</dependency>
```
### 出现错误“Uncaught SyntaxError: Invalid left-hand side in assignment”，少些了一个等号；
```js
if (uname == null || uname == "") {
    alert("请登录在收藏！");
    window.location.href = 'toLogin.do';
    return;
}
```
## 5、附加
### sql教程
https://www.runoob.com/sql/sql-tutorial.html
https://www.1keydata.com/cn/sql/
### 临时邮箱
```html
发
https://www.guerrillamail.com/zh/compose
http://tool.chacuo.net/mailsend
https://trashmail.com/

收
http://www.yopmail.com
http://www.linshiyouxiang.net/
转自：https://weibo.com/ttarticle/p/show?id=2309404475875004383440
http://www.bccto.me/ 
https://temp-mail.org/zh/ 
https://10minutemail.net/?lang=zh-cn 
http://10minutemail.com/10MinuteMail/index.html 
https://www.guerrillamail.com/zh/ 
https://www.moakt.com/zh/mail 
http://www.nowmymail.com 
http://www.incognitomail.com/ 
http://24mail.chacuo.net/ 
http://www.yopmail.com/zh/ 
http://www.jetable.org/zh/index 
http://www.mailinator.com
```
### 临时手机号
```html
转自：https://mp.weixin.qq.com/s?src=11&timestamp=1590563602&ver=2363&signature=2Pvmomd4d5SKLNZwUNPrpTbD9iQ0gz*bUPmjDVXiQWXzvZ--XxM*-taCEF*tS3u8MB9exNCM4pCCfbXZMzyU-RT2d0SnLpqkPWWjzYziAtlrhhgAXCbx6u8O9-nxK7Ln&new=1
国内免费临时手机号：
1、http://www.z-sms.com
2、https://www.becmd.com
3、https://www.pdflibr.com
4、https://www.becmd.com
5、http://www.smszk.com

国外免费临时手机号：
1、https://zh.mytrashmobile.com（中文）
2、https://ch.freephonenum.com（中文）
3、SMSReceiveFree：https://smsreceivefree.com
4、Receive SMS Online for FREE：https://www.receive-sms-online.info
5、Receive a SMS Online：https://receive-a-sms.com
6、Free SMS Numbers Online：https://smsnumbersonline.com
7、Receive SMS online for Free：https://sms-online.co/receive-free-sms
8、Receive-SMS：https://receive-sms.com
9、Receive FREE SMS online：http://receivefreesms.com
10、RECEIVE SMS ONLINE：https://www.receivesmsonline.net
11、Free Online Phone：https://www.freeonlinephone.org
12、Receive SMS Online：http://receive-sms-online.com
13、TextNow：https://www.textnow.com
14、Textfree：https://www.pinger.com/text-free/
15、SELLAITE：http://sms.sellaite.com/
16、Twilio：https://www.twilio.com/
17、https://receive-sms.com/
18、http://receive-sms-online.com/
19、http://sms.sel
```
### 正则表达式(Regular Expression)，常简称为regex、regexp
#### 软件
**regexBuilder：**https://github.com/ScottLouvau/RegexBuilder
**Regex Match Tracer：**http://www.regexlab.com/
#### 教程
**菜鸟教程：**https://www.runoob.com/regexp/regexp-tutorial.html
**简单教程：**https://www.twle.cn/l/yufei/regexp/regexp-basic-index.html
**regular：**http://www.regular-expressions.info/
**MDN：**https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Guide/Regular_Expressions
**微软：**https://docs.microsoft.com/zh-cn/dotnet/standard/base-types/regular-expressions
**w3cschool：**https://www.w3cschool.cn/zhengzebiaodashi/regexp-tutorial.html
#### 在线生成
**在线工具：**https://tool.lu/regex/
**regex101：**https://regex101.com/
**Regulex：**https://jex.im/regulex/
**菜鸟教程：**http://c.runoob.com/front-end/854
**JSON在线：**https://www.sojson.com/regex/generate
**脚本之家：**http://tools.jb51.net/regex
**Jsons**http://www.jsons.cn/regcode/
**站长之家：**http://tool.chinaz.com/regex/
**开源中国社区：**https://tool.oschina.net/regex/
**debuggex：**https://www.debuggex.com/
**w3cschool：**https://www.w3cschool.cn/zhengzebiaodashi/regexp-tutorial.html
### web.xml
```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns="http://java.sun.com/xml/ns/javaee"
	xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd"
	id="WebApp_ID" version="3.0">
	<display-name>TravelProject</display-name>
	<welcome-file-list>
		<welcome-file>index.html</welcome-file>
		<welcome-file>index.htm</welcome-file>
		<welcome-file>index.jsp</welcome-file>
		<welcome-file>default.html</welcome-file>
		<welcome-file>default.htm</welcome-file>
		<welcome-file>default.jsp</welcome-file>
	</welcome-file-list>

	<!--加载spring的配置文件 -->
	<context-param>
		<param-name>contextConfigLocation</param-name>
		<param-value>classpath:spring-config.xml</param-value>
	</context-param>
	<!--配置一个监听器 web项目一启动 就加载spring配置文件 -->
	<listener>
		<listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
	</listener>
	
	<!--配置前端控制器-DispatcherServlet并加载springmvc的配置文件 -->
	<servlet>
		<servlet-name>ssm</servlet-name>
		<servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
		<!--初始化参数 加载springmvc配置文件 -->
		<init-param>
			<param-name>contextConfigLocation</param-name>
			<param-value>classpath:springmvc-config.xml</param-value>
		</init-param>
		<load-on-startup>1</load-on-startup>
	</servlet>
	<servlet-mapping>
		<servlet-name>ssm</servlet-name>
		<url-pattern>*.do</url-pattern>
	</servlet-mapping>
	
	<!--加载过滤器-字符编码处理 -->
	<filter>
		<filter-name>encoding</filter-name>
		<filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
		<init-param>
			<param-name>encoding</param-name>
			<param-value>utf-8</param-value>
		</init-param>
	</filter>
	<filter-mapping>
		<filter-name>encoding</filter-name>
		<url-pattern>/*</url-pattern>
	</filter-mapping>
</web-app>
```
### MyBatis
#### 官网：https://mybatis.org/mybatis-3/
#### 中文官网：https://mybatis.org/mybatis-3/zh/index.html
#### mybatis.xml头文件：https://mybatis.org/mybatis-3/getting-started.html
```xml
<!DOCTYPE mapper
  PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
  "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.ssm.dao.UserMapper">
</mapper>
```
#### mybatis-config.xml头文件：https://mybatis.org/mybatis-3/getting-started.html
```xml
官网版
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration
  PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
  "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
	<environments default="development">
		<environment id="development">
			<transactionManager type="JDBC" />
			<dataSource type="POOLED">
				<property name="driver" value="${driver}" />
				<property name="url" value="${url}" />
				<property name="username" value="${username}" />
				<property name="password" value="${password}" />
			</dataSource>
		</environment>
	</environments>
	<mappers>
		<mapper resource="org/mybatis/example/BlogMapper.xml" />
	</mappers>
</configuration>



<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE configuration
  PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
  "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
	<!--取别名 -->
	<typeAliases>
		<!-- <typeAlias type="com.ssm.entity.Student" alias="student"/> -->
		<!--批量设置实体类的别名,默认是类名称首字母小写 -->
		<package name="com.zk.entity" />
	</typeAliases>
	<!-- 加载mybatis分页插件PageHelper -->
	<plugins>
		<plugin interceptor="com.github.pagehelper.PageInterceptor">
			<!-- 设置数据库类型 Oracle,Mysql,MariaDB,SQLite,Hsqldb,PostgreSQL六种数据库方言，说明mysql数据库方言 -->
			<property name="helperDialect" value="mysql" />
		</plugin>
	</plugins>
	<!--映射器批量加载映射关系,告诉mybatis去哪里寻找映射关系 -->
	<mappers>
		<!-- <mapper resource="com/ssm/entity/StudentMapper.xml" /> -->
		<package name="com.zk.dao" />
	</mappers>
</configuration>
```
### Spring
#### 官网：https://spring.io/
#### Spring-Framework：https://spring.io/projects/spring-framework
#### spring-config.xml头文件
https://docs.spring.io/spring/docs/5.3.0-SNAPSHOT/spring-framework-reference/core.html#xsd-schemas-aop
```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:aop="http://www.springframework.org/schema/aop"
	xmlns:context="http://www.springframework.org/schema/context"
	xmlns:tx="http://www.springframework.org/schema/tx"
	xmlns:p="http://www.springframework.org/schema/p"
	xsi:schemaLocation="
        http://www.springframework.org/schema/beans 
        https://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/aop 
        https://www.springframework.org/schema/aop/spring-aop.xsd
        http://www.springframework.org/schema/context 
        https://www.springframework.org/schema/context/spring-context.xsd
        http://www.springframework.org/schema/tx 
        https://www.springframework.org/schema/tx/spring-tx.xsd">
        
	<!--配置数据源 -->
	<bean id="dataSource" class="com.jolbox.bonecp.BoneCPDataSource"
		p:driverClass="com.mysql.jdbc.Driver"
		p:jdbcUrl="jdbc:mysql://localhost:3306/travel" p:username="root"
		p:password="123456" />
	<!--SqlSessionFactory工厂对象 -->
	<bean id="factory"
		class="org.mybatis.spring.SqlSessionFactoryBean"
		p:dataSource-ref="dataSource"
		p:configLocation="classpath:mybatis-config.xml" />
	<!--引入映射器 -->
	<!--p:basePackage指定了批量生成映射器实例的基础包 -->
	<bean class="org.mybatis.spring.mapper.MapperScannerConfigurer"
		p:basePackage="com.zk.dao" />
	<!--配置支持注解扫描的Bean -->
	<context:component-scan base-package="com.zk" />
	<!--配置事务管理器 -->
	<bean id="txManager"
		class="org.springframework.jdbc.datasource.DataSourceTransactionManager"
		p:dataSource-ref="dataSource" />
	<!--配置支持注解 声明式事务 -->
	<tx:annotation-driven
		transaction-manager="txManager" />	
</beans>
```
#### springmvc-config.xml头文件：https://docs.spring.io/spring/docs/5.3.0-SNAPSHOT/spring-framework-reference/web.html#mvc-config
```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:mvc="http://www.springframework.org/schema/mvc"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:context="http://www.springframework.org/schema/context"
	xmlns:p="http://www.springframework.org/schema/p"
	xsi:schemaLocation="
        http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/mvc
        https://www.springframework.org/schema/mvc/spring-mvc.xsd
        http://www.springframework.org/schema/context
        https://www.springframework.org/schema/context/spring-context.xsd">
    
	<!--扫描组件,作用扫描到的spring会自动帮创建对象及资源的注入 -->
	<context:component-scan
		base-package="com.zk.controller" />
	<!--配置支持注解 -->
	<mvc:annotation-driven />
	<!--配置视图解析器 -->
	<bean
		class="org.springframework.web.servlet.view.InternalResourceViewResolver"
		p:prefix="/WEB-INF/jsp/" p:suffix=".jsp" />
</beans>
```
### 用到的依赖
#### 依赖官网：
```xml
<!-- mysql依赖 -->
<!-- https://mvnrepository.com/artifact/mysql/mysql-connector-java -->
<dependency>
	<groupId>mysql</groupId>
	<artifactId>mysql-connector-java</artifactId>
	<version>5.1.48</version>
</dependency>

<!-- mybatis依赖 -->
<!-- https://mvnrepository.com/artifact/org.mybatis/mybatis -->
<dependency>
	<groupId>org.mybatis</groupId>
	<artifactId>mybatis</artifactId>
	<version>3.5.4</version>
</dependency>

<!-- mybatis-spring依赖 -->
<!-- https://mvnrepository.com/artifact/org.mybatis/mybatis-spring -->
<dependency>
	<groupId>org.mybatis</groupId>
	<artifactId>mybatis-spring</artifactId>
	<version>2.0.4</version>
</dependency>

<!-- mybatis分页插件-PageHelper -->
<!-- https://mvnrepository.com/artifact/com.github.pagehelper/pagehelper -->
<dependency>
	<groupId>com.github.pagehelper</groupId>
	<artifactId>pagehelper</artifactId>
	<version>5.1.11</version>
</dependency>

<!-- spring-webmvc依赖 -->
<!-- https://mvnrepository.com/artifact/org.springframework/spring-webmvc -->
<dependency>
	<groupId>org.springframework</groupId>
	<artifactId>spring-webmvc</artifactId>
	<version>5.2.4.RELEASE</version>
</dependency>

<!-- spring-jdbc依赖 -->
<!-- https://mvnrepository.com/artifact/org.springframework/spring-jdbc -->
<dependency>
	<groupId>org.springframework</groupId>
	<artifactId>spring-jdbc</artifactId>
	<version>5.2.4.RELEASE</version>
</dependency>

<!-- bonecp依赖 -->
<!-- https://mvnrepository.com/artifact/com.jolbox/bonecp -->
<dependency>
	<groupId>com.jolbox</groupId>
	<artifactId>bonecp</artifactId>
	<version>0.8.0.RELEASE</version>
</dependency>

<!-- Jstl依赖 -->
<!-- https://mvnrepository.com/artifact/javax.servlet/jstl -->
<dependency>
	<groupId>javax.servlet</groupId>
	<artifactId>jstl</artifactId>
	<version>1.2</version>
</dependency>

<!-- Log4J2依赖 -->
<!-- https://logging.apache.org/log4j/2.x/maven-artifacts.html -->
<dependency>
	<groupId>org.apache.logging.log4j</groupId>
	<artifactId>log4j-api</artifactId>
	<version>2.13.3</version>
</dependency>
<dependency>
	<groupId>org.apache.logging.log4j</groupId>
	<artifactId>log4j-core</artifactId>
	<version>2.13.3</version>
</dependency>
<!-- https://mvnrepository.com/artifact/org.apache.logging.log4j/log4j-slf4j-impl -->
<dependency>
    <groupId>org.apache.logging.log4j</groupId>
    <artifactId>log4j-slf4j-impl</artifactId>
    <version>2.13.3</version>
    <scope>test</scope>
</dependency>
<!-- https://mvnrepository.com/artifact/org.slf4j/slf4j-api -->
<dependency>
    <groupId>org.slf4j</groupId>
    <artifactId>slf4j-api</artifactId>
    <version>1.7.30</version>
</dependency>

<!-- jackson-databind依赖 -->
<!-- https://mvnrepository.com/artifact/com.fasterxml.jackson.core/jackson-databind -->
<dependency>
	<groupId>com.fasterxml.jackson.core</groupId>
	<artifactId>jackson-databind</artifactId>
	<version>2.10.0</version>
</dependency>

<!-- javax.mail依赖 -->
<!-- https://mvnrepository.com/artifact/javax.mail/javax.mail-api -->
<dependency>
	<groupId>javax.mail</groupId>
	<artifactId>javax.mail-api</artifactId>
	<version>1.6.2</version>
</dependency>
<!-- https://mvnrepository.com/artifact/com.sun.mail/javax.mail -->
<dependency>
	<groupId>com.sun.mail</groupId>
	<artifactId>javax.mail</artifactId>
	<version>1.6.2</version>
</dependency>

<!--解决idea出现Error:(8, 26) java: 程序包javax.servlet.http不存在-->
<dependency>
    <groupId>javax.servlet</groupId>
    <artifactId>servlet-api</artifactId>
    <version>2.5</version>
</dependency>
```

