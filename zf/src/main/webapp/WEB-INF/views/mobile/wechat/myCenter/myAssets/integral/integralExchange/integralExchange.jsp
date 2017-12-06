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
    <title>积分兑换</title>
    <link rel="stylesheet" media="screen and (max-width:330px)" href="${ctxMobile}/baseConfig/base320.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:331px) and (max-width:380px)" href="${ctxMobile}/baseConfig/base360.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:381px)" href="${ctxMobile}/baseConfig/base414.css" type="text/css" />
    <link rel="stylesheet/less" href="${ctxMobile}/pages/myCenter/myAssets/integral/integralExchange/integralExchange.less" />
    <script src="${ctxMobile}/lib/js/less-1.3.3.min.js" type="text/javascript"></script>
    <script src="${ctxMobile}/lib/js/zepto.min.js" type="text/javascript" ></script>
</head>
<body>
<div class="exchangeWarp">
	<div class="integralText">
		<p>3000积分代金券</p>
	</div>
	<div id="" class="coupon_item">
		<div class="itemLeft">
			<p>￥100</p>
			<span></span>
		</div>
		<div class="itemRight">
			<h2>新手券</h2>
			<h3>满1500使用</h3>
			<p>仅租</p>
			<div class="promptlyExchange">
				立即兑换
			</div>
		</div>
	</div>
	<div id="" class="coupon_item past">
		<div class="itemLeft">
			<p>￥100</p>
			<span>已过期</span>
		</div>
		<div class="itemRight">
			<h2>新手券</h2>
			<h3>满1500使用</h3>
			<p>仅买7</p>
			<div class="promptlyExchange">
				立即兑换
			</div>
		</div>
	</div>
</div>

</body>
    <script src="${ctxMobile}/pages/myCenter/myAssets/integral/integralExchange/integralExchange.js" type="text/javascript" ></script>
</html>