<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
<!-- 头部 start -->
<header id="header">
    <div class="top_banner">
        <img src="images/top_banner.jpg" alt="">
    </div>
    <div class="shortcut">
        <!-- 未登录状态  -->
        <div class="login_out">
            <a href="toLogin.do">登录</a>
            <a href="toRegPage.do">注册</a>
        </div>
        <!-- 登录状态  -->
        <div class="login">
            <!-- 此user为UserController.java中登录成功后将用户信息保存到session对象当中的user -->
            <span>欢迎，${sessionScope.user.name==null?"游客":sessionScope.user.name}</span>
            <a href="myfavorite.html" class="collection">我的收藏</a>
            <a href="toLogout.do">退出</a>
        </div>
    </div>
    <div class="header_wrap">
        <div class="topbar">
            <div class="logo">
                <a href="/"><img src="images/logo.jpg" alt=""></a>
            </div>
            <div class="search">
                <form action="routeList.do" method="post">
                    <input name="rname" id="rname" type="text" placeholder="请输入路线名称" class="search_input"
                           value="${rname==''?'':rname}">
                    <%-- <input type="hidden" name="cid" value="${cid}"/>
                    <input type="hidden" name="pageNo" value="${pno}"/>--%>
                    <input type="submit" value="搜索" class="search-button"/>
                </form>
            </div>
            <div class="hottel">
                <div class="hot_pic">
                    <img src="images/hot_tel.jpg" alt="">
                </div>
                <div class="hot_tel">
                    <p class="hot_time">客服热线(9:00-6:00)</p>
                    <p class="hot_num">400-619-9898</p>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            $.post('cgList.do', function (res) {
                var html = "";
                for (var i = 0; i < res.length; i++) {
                    html += "<a href='routeList.do?cid=" + res[i].cid + "'>" + res[i].cname + "</a>"
                }
                //将遍历出来的超链接放到li中
                $(".cg").html(html);
            })
        });
    </script>
</header>
<!-- 头部 end -->
<!-- 首页导航 -->
<div class="navitem">
    <ul class="nav" id="category">
        <li class="nav-active"><a href="index.html">首页</a></li>
        <%--<c:forEach items="${cglist}" var="c">
            <li><a href="routelist?cid=${c.cid}">${c.cname}</a></li>
        </c:forEach>--%>
        <li class='cg'></li>
        <li><a href="favoriterank.html">收藏排行榜</a></li>
    </ul>
</div>