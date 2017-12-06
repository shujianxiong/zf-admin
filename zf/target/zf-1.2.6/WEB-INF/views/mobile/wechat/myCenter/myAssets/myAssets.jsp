<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/mobile/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" /><!--viewport网页缩放-->
	<meta charset="utf-8" /><!-- UTF-8编码 -->
	<meta name="keywords" content="珠宝租赁" /><!-- 关键词 -->
	<meta name="format-detection" content="telephone=no" /><!-- 禁用自动识别电话号码 -->
	<meta name="apple-mobile-web-app-capable" content="yes" /><!-- 强制全屏 -->
	<meta name="msapplication-tap-highlight" content="no" /><!-- 禁用点击高光效果 -->
    <title>我的资产</title>
     <link rel="stylesheet" media="screen and (max-width:330px)" href="${ctxMobile}/baseConfig/base320.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:331px) and (max-width:380px)" href="${ctxMobile}/baseConfig/base360.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:381px)" href="${ctxMobile}/baseConfig/base414.css" type="text/css" />
    <link rel="stylesheet/less" href="${ctxMobile}/pages/myCenter/myAssets/myAssets.less" />
    <script src="${ctxMobile}/lib/js/less-1.3.3.min.js" type="text/javascript"></script>
    <script src="${ctxMobile}/lib/js/zepto.min.js" type="text/javascript" ></script>
</head>
<body>
<div class="myAssets">
	<div class="moneyBlock">
		<div class="top">
			<div class="pledgeMoney">
				<h3>押金账户</h3>
				<h2>￥${centerVO.depositBalance}</h2>
				<p onclick="window.location.href='${ctxWeb}/member/billDetail'">查看账户明细<i class="iconfont">&#xe626;</i></p>
			</div>
			<div class="right">
				<div class="available">
					<h3>可用</h3>
					<h2>￥${centerVO.usableBalance}</h2>
				</div>
				<div class="blocking">
					<div >
						<h3>冻结</h3>
						<h2>￥${centerVO.frozenBalance}</h2>
					</div>
					<p onclick="window.location.href='${ctxWeb}/member/billDetail'">查看账户明细<i class="iconfont">&#xe626;</i></p>
				</div>
			</div>
		</div>
		<div class="bottom">
			<div id="">
				<i class="iconfont">&#xe63e;</i>
				<span>充值(暂无页面)</span>
			</div>
			<div id="">
				<i class="iconfont">&#xe63f;</i>
				<span>提现(暂无页面)</span>
			</div>
		</div>
	</div>
	<div class="creditsBlock">
		<ul>
			<li>
				<p>我的积分</p>
				<span>${centerVO.point}</span>
			</li>
			<li onclick="window.location.href='${ctxWeb}/member/integralExchange'">
				<p>积分兑换</p>
				<span><i class="iconfont">&#xe626;</i></span>
			</li>
			<li onclick="window.location.href='${ctxWeb}/member/integral'">
				<p>查看明细</p>
				<span><i class="iconfont">&#xe626;</i></span>
			</li>
		</ul>
		<p>会员积分由会员在商城消费获得，每消费人民币10元可获得1个积分</p>
	</div>
	<div class="cardBlock">
		<ul>
			<li>
				<span>银行卡</span>
				<i class="iconfont right">&#xe626;</i>
				<span class="explain">共三张银行卡(暂无页面)</span>
			</li>
			<li>
				<span>会员卡</span>
				<i class="iconfont right">&#xe626;</i>
				<span class="explain">租赁金卡(暂无页面)</span>
			</li>
			<li onclick="window.location.href='${ctxWeb}/member/couponsItem'">
				<span>优惠券</span>
				<i class="iconfont right">&#xe626;</i>
			</li>
		</ul>
	</div>
</div>
</body>
    <script src="${ctxMobile}/pages/myCenter/myAssets/myAssets.js" type="text/javascript" ></script>
</html>