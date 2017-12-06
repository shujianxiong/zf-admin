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
    <title>积分明细</title>
     <link rel="stylesheet" media="screen and (max-width:330px)" href="${ctxMobile}/baseConfig/base320.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:331px) and (max-width:380px)" href="${ctxMobile}/baseConfig/base360.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:381px)" href="${ctxMobile}/baseConfig/base414.css" type="text/css" />
    <link rel="stylesheet/less" href="${ctxMobile}/pages/myCenter/myAssets/integral/integral.less" />
    <script src="${ctxMobile}/lib/js/less-1.3.3.min.js" type="text/javascript"></script>
    <script src="${ctxMobile}/lib/js/zepto.min.js" type="text/javascript" ></script>
</head>
<body>
<div class="integralWarp">
	<div>
		<div class="showArea">
			<div class="top">
				<span>当前积分</span>
				<p><i class="iconfont">&#xe623;</i>积分说明</p>
			</div>
			<h2>3000<b>分</b></h2>
			<div class="button">
				积分兑换好礼
			</div>
		</div>
		<h3>积分明细<span>(消费获取积分时不包含押金、保险及银行贷款费用)</span></h3>
		<ul>
			<li>
				<p>2016年1月8号</p>
				<h4><span>通过订单541321311消费</span><span>￥30000</span></h4>
				<h4><span>积分</span><b>+200</b></h4>
			</li> 
			<li>
				<p>2016年1月8号</p>
				<h4><span>通过订单541321311消费</span><span>￥30000</span></h4>
				<h4><span>积分</span><b>+200</b></h4>
			</li> 
			<li>
				<p>2016年1月8号</p>
				<h4><span>通过订单541321311消费</span><span>￥30000</span></h4>
				<h4><span>积分</span><b>+200</b></h4>
			</li>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
		</ul>
	</div>
	
</div>
</body>
    <script src="${ctxMobile}/pages/myCenter/myAssets/integral/integral.js" type="text/javascript" ></script>
</html>