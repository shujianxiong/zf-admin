<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/mobile/include/taglib.jsp"%>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" /><!--viewport网页缩放-->
	<meta charset="utf-8" /><!-- UTF-8编码 -->
	<meta name="keywords" content="珠宝租赁" /><!-- 关键词 -->
	<meta name="format-detection" content="telephone=no" /><!-- 禁用自动识别电话号码 -->
	<meta name="apple-mobile-web-app-capable" content="yes" /><!-- 强制全屏 -->
	<meta name="msapplication-tap-highlight" content="no" /><!-- 禁用点击高光效果 -->
    <title>消息管理</title>
     <link rel="stylesheet" media="screen and (max-width:330px)" href="${ctxMobile}/baseConfig/base320.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:331px) and (max-width:380px)" href="${ctxMobile}/baseConfig/base360.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:381px)" href="${ctxMobile}/baseConfig/base414.css" type="text/css" />
    <link rel="stylesheet/less" href="${ctxMobile}/pages/myCenter/newsManagement/newsManagement.less" />
    <script src="${ctxMobile}/lib/js/less-1.3.3.min.js" type="text/javascript"></script>
    <script src="${ctxMobile}/lib/js/zepto.min.js" type="text/javascript" ></script>
</head>
<body>
	<div class="newsArea">
		<ul>
			<li onclick="window.location.href='${ctxWeb}/member/systemInform/2'">
				<i class="icon"><img src="${ctxMobile}/pages/myCenter/newsManagement/images/news.png"/></i>
				<p>新闻通知</p>
				<p>周范新款活动强势来袭</p>
			</li>
			<li onclick="window.location.href='${ctxWeb}/member/systemInform/1'">
				<i class="icon"><img src="${ctxMobile}/pages/myCenter/newsManagement/images/systemInforms.png"/></i>
				<p>系统通知</p>
				<p>系统通知消息预览</p>
			</li>
			<li onclick="window.location.href='${ctxWeb}/member/systemInform/3'">
				<i class="icon"><img src="${ctxMobile}/pages/myCenter/newsManagement/images/logistics.png"/></i>
				<p>物流助手</p>
				<p>您有最新的物流消息</p>
			</li>
		</ul>
	</div>
</body>
    <script src="${ctxMobile}/pages/myCenter/newsManagement/newsManagement.js" type="text/javascript" ></script>
</html>