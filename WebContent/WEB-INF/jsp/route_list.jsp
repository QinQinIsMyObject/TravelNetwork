<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>智酷旅游-搜索</title>
<link rel="stylesheet" type="text/css" href="css/common.css">
<link rel="stylesheet" href="css/search.css">
<script src="js/jquery-3.3.1.js"></script>
</head>
<body>
	<!--引入头部-->
	<div id="header"><%@ include file="header.jsp"%></div>
	<div class="page_one">
		<div class="contant">
			<div class="crumbs">
				<img src="images/search.png" alt="">
				<p>
					智酷旅行><span>搜索结果</span>
				</p>
			</div>
			<div class="xinxi clearfix">
				<div class="left">
					<div class="header">
						<span>商品信息</span> <span class="jg">价格</span>
					</div>
					<ul>
						<c:forEach items="${rlist}" var="r">
							<li>
								<div class="img">
									<img width="299px" src="${r.rimage}" alt="">
								</div>
								<div class="text1">
									<p>${r.rname}</p>
									<br />
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
					<div class="page_num_inf">
						<i></i> 共 <span>${pcount}</span>页<span>${tcount}</span>条
					</div>
					<div class="pageNum">
						<ul>
							<li><a href="routelist?pageNo=1&cid=${cid}&rname=${rname}">首页</a></li>
							<c:if test="${pno > 1}">
								<li class="threeword"><a
									href="routelist?pageNo=${pno-1}&cid=${cid}&rname=${rname}">上一页</a></li>
							</c:if>
							<c:choose>
								<c:when test="${pcount<=10}">
									<c:forEach begin="1" end="${pcount}" var="i">
										<c:if test="${pno==i}">
											<li class="curPage"><a
												href="routelist?pageNo=${i}&cid=${cid}&rname=${rname}">${i}</a></li>
										</c:if>
										<c:if test="${pno!=i}">
											<li><a href="routelist?pageNo=${i}&cid=${cid}&rname=${rname}">${i}</a></li>
										</c:if>
									</c:forEach>
								</c:when>
								<c:when test="${pcount>10}">
									<c:if test="${pno<=6}">
										<c:forEach begin="1" end="10" var="i">
											<c:if test="${pno==i}">
												<li class="curPage"><a
													href="routelist?pageNo=${i}&cid=${cid}&rname=${rname}">${i}</a></li>
											</c:if>
											<c:if test="${pno!=i}">
												<li><a href="routelist?pageNo=${i}&cid=${cid}&rname=${rname}">${i}</a></li>
											</c:if>
										</c:forEach>
									</c:if>
									<c:if test="${pno>6}">
										<c:forEach begin="${pno-5}"
											end="${(pno+4)>pcount?pcount:(pno+4)}" var="i">
											<c:if test="${pno==i}">
												<li class="curPage"><a
													href="routelist?pageNo=${i}&cid=${cid}&rname=${rname}">${i}</a></li>
											</c:if>
											<c:if test="${pno!=i}">
												<li><a href="routelist?pageNo=${i}&cid=${cid}&rname=${rname}">${i}</a></li>
											</c:if>
										</c:forEach>
									</c:if>
								</c:when>
							</c:choose>
							<c:if test="${pno>=1 && pno<pcount}">
								<li class="threeword"><a
									href="routelist?pageNo=${pno+1}&cid=${cid}&rname=${rname}">下一页</a></li>
							</c:if>
							<li class="threeword"><a
								href="routelist?pageNo=${pcount}&cid=${cid}&rname=${rname}">末页</a></li>
						</ul>
					</div>
				</div>
				<div class="right">
					<div class="top">
						<div class="hot">HOT</div>
						<span>热门推荐</span>
					</div>
					<ul>
						<li>
							<div class="left">
								<img src="images/04-search_09.jpg" alt="">
							</div>
							<div class="right">
								<p>清远新银盏温泉度假村酒店/自由行套...</p>
								<p>
									网付价<span>&yen;<span>899</span>起
									</span>
								</p>
							</div>
						</li>
						<li>
							<div class="left">
								<img src="images/04-search_09.jpg" alt="">
							</div>
							<div class="right">
								<p>清远新银盏温泉度假村酒店/自由行套...</p>
								<p>
									网付价<span>&yen;<span>899</span>起
									</span>
								</p>
							</div>
						</li>
						<li>
							<div class="left">
								<img src="images/04-search_09.jpg" alt="">
							</div>
							<div class="right">
								<p>清远新银盏温泉度假村酒店/自由行套...</p>
								<p>
									网付价<span>&yen;<span>899</span>起
									</span>
								</p>
							</div>
						</li>
						<li>
							<div class="left">
								<img src="images/04-search_09.jpg" alt="">
							</div>
							<div class="right">
								<p>清远新银盏温泉度假村酒店/自由行套...</p>
								<p>
									网付价<span>&yen;<span>899</span>起
									</span>
								</p>
							</div>
						</li>
						<li>
							<div class="left">
								<img src="images/04-search_09.jpg" alt="">
							</div>
							<div class="right">
								<p>清远新银盏温泉度假村酒店/自由行套...</p>
								<p>
									网付价<span>&yen;<span>899</span>起
									</span>
								</p>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<!--引入头部-->
	<div id="footer"><%@ include file="footer.jsp"%></div>
</body>

</html>