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
    <title>帮助中心</title>
    <link rel="stylesheet" media="screen and (max-width:330px)" href="${ctxMobile}/baseConfig/base320.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:331px) and (max-width:380px)" href="${ctxMobile}/baseConfig/base360.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:381px)" href="${ctxMobile}/baseConfig/base414.css" type="text/css" />
    <link rel="stylesheet/less" href="${ctxMobile}/pages/myCenter/helpCenter/helpCenter.less" />
    <script src="${ctxMobile}/lib/js/less-1.3.3.min.js" type="text/javascript"></script>
    <script src="${ctxMobile}/lib/js/zepto.min.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/zfutils.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/effect.js" type="text/javascript" ></script>
</head>
<body>
<header id="header" class="header">
	<form action="${ctxWeb}/member/dohelpCenter" name="helpCenterForm" method="post">
		<div class="header_input">
			<input type="search" name="name" id="name" value="" placeholder="请输入关键字"/>
		</div>
		<span id="onSubmit" data-type="yellowButton">搜索</span>
	</form>
</header>
<div class="settingarea">
	<ul>
		<c:forEach items="${hcQuestions}" var="hcQuestions" begin="0" end="3" >
				<li data-type="blackTab">
					<span>${hcQuestions.name}</span>
					<i class="iconfont right">&#xe626;</i>
				</li>
		</c:forEach>
		<c:forEach items="${hcQuestions}" var="hcQuestions" begin="4" end="100" >
				<li data-role="more" data-type="blackTab">
					<span>${hcQuestions.name}</span>
					<i class="iconfont right">&#xe626;</i>
				</li>
		</c:forEach>
		<li id="moreBotton" data-mark="0" data-type="blackTab">
			<i class="iconfont" >&#xe628;</i>
			<!--<i class="iconfont" >&#xe62f;</i>-->
		</li>
	</ul>
</div>
<div class="clasifyArea">
	<ul>
		<li onclick="window.location.href='${ctxWeb }/member/problemList/1'">
			<div data-type="blackTab">
				<i class="iconfont">&#xe642;</i>
				<p>账户问题</p>
				<span>密码、支付密码等</span>
			</div>
		</li>
		<li onclick="window.location.href='${ctxWeb }/member/problemList/2'">
			<div data-type="blackTab">
				<i class="iconfont">&#xe640;</i>
				<p>订单问题</p>
				<span>收货、换货、售后等</span>
			</div>
		</li>
		<li onclick="window.location.href='${ctxWeb }/member/problemList/3'">
			<div data-type="blackTab">
				<i class="iconfont">&#xe641;</i>
				<p>支付问题</p>
				<span>支付方式、钱款流向等</span>
			</div>
		</li>
		<li onclick="window.location.href='${ctxWeb }/member/problemList/4'">
			<div data-type="blackTab">
				<i class="iconfont">&#xe643;</i>
				<p>积分问题</p>
				<span>积分规则、兑换等</span>
			</div>
		</li>
	</ul>
</div>
<div class="bottomArea" onclick="window.location.href='${ctxWeb }/member/feedback'">
	<i class="iconfont">&#xe644;</i>
	<span>意见反馈</span>
	<b>留下您宝贵的意见吧</b>
</div>
<%@ include file="/WEB-INF/views/mobile/include/viewPanel.jsp"%>
</body>
    <script src="${ctxMobile}/pages/myCenter/helpCenter/helpCenter.js" type="text/javascript" ></script>
</html>