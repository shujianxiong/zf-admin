<%@ page contentType="text/html;charset=UTF-8" %>
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
    <c:if test="${status == 1}"><title>系统通知</title></c:if>
    <c:if test="${status == 2}"><title>新闻通知</title></c:if>
    <c:if test="${status == 3}"><title>物流消息</title></c:if>
    <link rel="stylesheet" media="screen and (max-width:330px)" href="${ctxMobile}/baseConfig/base320.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:331px) and (max-width:380px)" href="${ctxMobile}/baseConfig/base360.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:381px)" href="${ctxMobile}/baseConfig/base414.css" type="text/css" />
    <link rel="stylesheet/less" href="${ctxMobile}/pages/myCenter/newsManagement/newsManagement.less" />
    <script src="${ctxMobile}/lib/js/less-1.3.3.min.js" type="text/javascript"></script>
    <script src="${ctxMobile}/lib/js/zepto.min.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/iscroll-probe.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/zfutils.js" type="text/javascript" ></script>
</head>
<body>
	<div class="systemInform">
		<input type="hidden" value="${status}" id="status"/>
		<div id="messageCenterWrapper" class="messageCenterWrapper">
			<ul id="messageCenterList">
				<li id="headerLoading" style="text-align:center;line-height:30px"><img style="height: 26px;width: 26px;margin: 2px 10px;float: none;" src="${ctxMobile}/pages/address/images/loading.gif"/>正在载入...</li>
				<li id="bottomLoading" style="text-align:center;line-height:30px"><img style="height:26px;width:26px;margin:2px 10px;float:none;" src="${ctxMobile}/pages/address/images/loading.gif" />正在载入...</li>
				<!-- <li>
					<h1>2015.2.15</h1>
					<div class="order">
						<h3>生日好礼</h3>
						<div>
							<p>您的生日即将到来，送一张20元购买优惠券，周范祝您生日快乐</p>
						</div>
						<h2>阅读全文<i class="iconfont">&#xe626;</i></h2>
					</div>
				</li> -->
			</ul>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/mobile/include/viewPanel.jsp"%>
</body>
<script src="${ctxMobile}/pages/myCenter/newsManagement/systemInform.js" type="text/javascript" ></script>
</html>