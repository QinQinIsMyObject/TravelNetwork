<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>路线详情</title>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/common.css">
    <link rel="stylesheet" type="text/css" href="css/route-detail.css">
</head>
<body>
<!--引入头部-->
<div id="header">
    <%@ include file="header.jsp" %>
</div>
<!-- 详情 start -->
<div class="wrap">
    <div class="bread_box">
        <a href="/">首页</a>
        <span> &gt;</span>
        <a href="#">国内游</a><span> &gt;</span>
        <a href="#">全国-曼谷6-7天自由行 泰国出境旅游 特价往返机票自由行二次确认</a>
    </div>
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
    <script type="text/javascript">
        $(function () {
            $(".btn").click(function () {
                var uname = '${sessionScope.user.username}';
                if (uname == null || uname = "") {
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
    <div class="you_need_konw">
        <span>旅游须知</span>
        <div class="notice">
            <p>1、旅行社已投保旅行社责任险。建议游客购买旅游意外保险 <br>

            <p>
                2、旅游者参加打猎、潜水、海边游泳、漂流、滑水、滑雪、滑草、蹦极、跳伞、滑翔、乘热气球、骑马、赛车、攀岩、水疗、水上飞机等属于高风险性游乐项目的，敬请旅游者务必在参加前充分了解项目的安全须知并确保身体状况能适应此类活动；如旅游者不具备较好的身体条件及技能，可能会造成身体伤害。</p>

            <p>
                3、参加出海活动时，请务必穿着救生设备。参加水上活动应注意自己的身体状况，有心脏病、冠心病、高血压、感冒、发烧和饮酒及餐后不可以参加水上活动及潜水。在海里活动时，严禁触摸海洋中各种鱼类，水母，海胆，珊瑚等海洋生物，避免被其蛰伤。老人和小孩必须有成年人陪同才能参加合适的水上活动。在海边游玩时，注意保管好随身携带的贵重物品。</p>

            <p>4、根据中国海关总署的规定，旅客在境外购买的物品，在进入中国海关时可能需要征收关税。详细内容见《中华人民共和国海关总署公告2010年第54号文件》。</p>

            <p>5、建议出发时行李托运，贵重物品、常用物品、常用药品、御寒衣物等请随身携带，尽量不要托运。行李延误属于不可抗力因素，我司将全力协助客人跟进后续工作，但我司对此不承担任何责任。</p>
            <p>1、旅行社已投保旅行社责任险。建议游客购买旅游意外保险 <br>

            <p>
                2、旅游者参加打猎、潜水、海边游泳、漂流、滑水、滑雪、滑草、蹦极、跳伞、滑翔、乘热气球、骑马、赛车、攀岩、水疗、水上飞机等属于高风险性游乐项目的，敬请旅游者务必在参加前充分了解项目的安全须知并确保身体状况能适应此类活动；如旅游者不具备较好的身体条件及技能，可能会造成身体伤害。</p>

            <p>
                3、参加出海活动时，请务必穿着救生设备。参加水上活动应注意自己的身体状况，有心脏病、冠心病、高血压、感冒、发烧和饮酒及餐后不可以参加水上活动及潜水。在海里活动时，严禁触摸海洋中各种鱼类，水母，海胆，珊瑚等海洋生物，避免被其蛰伤。老人和小孩必须有成年人陪同才能参加合适的水上活动。在海边游玩时，注意保管好随身携带的贵重物品。</p>

            <p>4、根据中国海关总署的规定，旅客在境外购买的物品，在进入中国海关时可能需要征收关税。详细内容见《中华人民共和国海关总署公告2010年第54号文件》。</p>

            <p>5、建议出发时行李托运，贵重物品、常用物品、常用药品、御寒衣物等请随身携带，尽量不要托运。行李延误属于不可抗力因素，我司将全力协助客人跟进后续工作，但我司对此不承担任何责任。</p>
        </div>
    </div>
</div>
<!-- 详情 end -->

<!--引入头部-->
<div id="footer">
    <%@ include file="footer.jsp" %>
</div>
<script src="js/jquery-3.3.1.js"></script>
<script src="js/bootstrap.min.js"></script>
<script>
    $(document).ready(function () {
        //焦点图效果
        //点击图片切换图片
        $('.little_img').on('mousemove', function () {
            $('.little_img').removeClass('cur_img');
            var big_pic = $(this).data('bigpic');
            $('.big_img').attr('src', big_pic);
            $(this).addClass('cur_img');
        });
        //上下切换
        var picindex = 0;
        var nextindex = 4;
        $('.down_img').on('click', function () {
            var num = $('.little_img').length;
            if ((nextindex + 1) <= num) {
                $('.little_img:eq(' + picindex + ')').hide();
                $('.little_img:eq(' + nextindex + ')').show();
                picindex = picindex + 1;
                nextindex = nextindex + 1;
            }
        });
        $('.up_img').on('click', function () {
            var num = $('.little_img').length;
            if (picindex > 0) {
                $('.little_img:eq(' + (nextindex - 1) + ')').hide();
                $('.little_img:eq(' + (picindex - 1) + ')').show();
                picindex = picindex - 1;
                nextindex = nextindex - 1;
            }
        });
    });
</script>
</body>
</html>