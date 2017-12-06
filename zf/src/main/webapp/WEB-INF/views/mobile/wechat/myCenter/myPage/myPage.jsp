<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/mobile/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" /><!--viewport网页缩放-->
	<meta charset="utf-8" /><!-- UTF-8编码 -->
	<meta name="keywords" content="珠宝租赁" /><!-- 关键词 -->
	<meta name="format-detection" content="telephone=no" /><!-- 禁用自动识别电话号码 -->
	<meta name="apple-mobile-web-app-capable" content="yes" /><!-- 强制全屏 -->
	<meta name="msapplication-tap-highlight" content="no" /><!-- 禁用点击高光效果 -->
    <title>我的范儿</title>
       <link rel="stylesheet" media="screen and (max-width:330px)" href="${ctxMobile}/baseConfig/base320.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:331px) and (max-width:380px)" href="${ctxMobile}/baseConfig/base360.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:381px)" href="${ctxMobile}/baseConfig/base414.css" type="text/css" />
    <link rel="stylesheet/less" href="${ctxMobile}/pages/myCenter/myPage/myPage.less" />
    <script src="${ctxMobile}/lib/js/less-1.3.3.min.js" type="text/javascript"></script>
    <script src="${ctxMobile}/lib/js/zepto.min.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/lazyload.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/zfutils.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/effect.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/pages/myCenter/myPage/myPage.js" type="text/javascript"></script>
</head>
<body>

<div class="myPage" >
	<!--消息-->
	<div class="message">
		<i class="iconfont" data-type="fontIcon" onclick="window.location.href='${ctxWeb}/member/mySetting'">&#xe630;</i>
		<i class="iconfont" data-type="fontIcon" >&#xe615;<span id="" onclick="window.location.href='${ctxWeb}/member/newsManagement'">
			${centerVO.messageNum}
		</span></i>
	</div>
	<div class="myPage_top">
		<!--头像-->
		<div class="myPage_info">
			<div class="myPage_info_pic" style="background-image: url(${ctx}/${centerVO.member.gravatarPhotoUrl});"></div>
			<div class="myPage_info_name">
				<p>   
					<c:if test="${empty centerVO.member.nickname}">${centerVO.member.usercode}</c:if>
				    <c:if test="${not empty centerVO.member.nickname}">${centerVO.member.nickname}</c:if>
				<span >
					<!-- 后期确定图片需要修改  可以用登记字符串作为图片名-->
					<c:if test="${centerVO.member.level eq '1'}">
						<img src="${ctxMobile}/pages/myCenter/myPage/images/vip.png"/>
					</c:if>
					<c:if test="${centerVO.member.level eq '2'}">
						<img src="${ctxMobile}/pages/myCenter/myPage/images/vip.png"/>
					</c:if>
					<c:if test="${centerVO.member.level eq '3'}">
						<img src="${ctxMobile}/pages/myCenter/myPage/images/vip.png"/>
					</c:if>
					<c:if test="${centerVO.member.level eq '4'}">
						<img src="${ctxMobile}/pages/myCenter/myPage/images/vip.png"/>
					</c:if>
					<c:if test="${centerVO.member.level eq '5'}">
						<img src="${ctxMobile}/pages/myCenter/myPage/images/vip.png"/>
					</c:if>
					<c:if test="${centerVO.member.level eq '5'}">
						<img src="${ctxMobile}/pages/myCenter/myPage/images/vip.png"/>
					</c:if>
				</span></p>
			</div>
		</div>
	</div>
	<div class="myPage_bottom">
		<ul>
			<li data-type="blackTab" onclick="">
				<span class="sideIcon order"></span>
				<span>我的订单</span>
			</li>
		</ul>
		<ul>
			<li data-type="blackTab" onclick="window.location.href='${ctxWeb}/member/myAssets'">
				<span class="sideIcon assets"></span>
				<span>我的资产</span>
				<i class="iconfont right">&#xe626;</i>
				<span class="explain">押金账户余额</span>
			</li>
		</ul>
		<ul>
			<li data-type="blackTab" onclick="window.location.href='${ctxWeb}/member/addressWeb/toAddressList'">
				<span class="sideIcon address"></span>
				<span>地址管理</span>
				<i class="iconfont right">&#xe626;</i>
				<span class="explain">点击编辑收货地址</span>
			</li>
			<li data-type="blackTab" onclick="window.location.href='${ctxWeb}/member/helpCenter'">
				<span class="sideIcon help"></span>
				<span>帮助中心</span>
				<i class="iconfont right">&#xe626;</i>
				<span class="explain">意见和反馈都在这了</span>
			</li>
		</ul>
	</div>
	<!--猜您喜欢-->
	<div class="guessLike">
		<header class="top">
			<h2>猜您喜欢</h2>
			<span id="recommendBtn" data-type="blackTab">
				<i class="iconfont">&#xe63d;</i>
				换一批
			</span>
		</header>
		<div class="guessLike_goodsBlock">
			<ul id="recommendList">
			</ul>
		</div>
	</div>
	<div class="service">
		<img src="${ctxMobile}/pages/myCenter/myPage/images/Service.png"/>
	</div>
	<p class="footer">关于周范</p>
<div id="" class="index_footer">
	<div class="footNav">
	 	<div class="footNav_sub" onclick="window.location.href='${ctxWeb }/index'">
	 		<i class="iconfont">&#xe611;</i>
	 		<span>首页</span>
	 	</div>
	 	<div class="footNav_sub active" onclick="window.location.href='${ctxWeb }/member/center'">
	 		<i class="iconfont">&#xe605;</i>
	 		<span>我的范儿</span>
	 	</div>
	</div>
</div>
</div>	
</body>
</html>