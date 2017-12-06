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
    <title>个人设置</title>
     <link rel="stylesheet" media="screen and (max-width:330px)" href="${ctxMobile}/baseConfig/base320.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:331px) and (max-width:380px)" href="${ctxMobile}/baseConfig/base360.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:381px)" href="${ctxMobile}/baseConfig/base414.css" type="text/css" />
    <link rel="stylesheet/less" href="${ctxMobile}/pages/myCenter/mySetting/mySetting.less" />
    <script src="${ctxMobile}/lib/js/less-1.3.3.min.js" type="text/javascript"></script>
    <script src="${ctxMobile}/lib/js/zepto.min.js" type="text/javascript" ></script>
</head>
<body>
	<div class="message">
		<i class="iconfont">
			&#xe615;
			<span id="" onclick="window.location.href='${ctxWeb}/member/newsManagement'">${centerVO.messageNum}</span>
		</i>
	</div>
	<div class="settingarea">
		<ul>
			<li onclick="window.location.href='${ctxWeb}/member/personalDataSetting'">
				<i class="iconfont">&#xe615;</i>
				<span>个人资料</span>
				<i class="iconfont right">&#xe626;</i>
			</li>
			<li onclick="window.location.href='${ctxWeb}/member/accountSecurity'">
				<i class="iconfont">&#xe615;</i>
				<span>账户与安全</span>
				<i class="iconfont right">&#xe626;</i>
			</li>
			<li onclick="window.location.href='${ctxWeb}/member/newsManagement'">
				<i class="iconfont">&#xe615;</i>
				<span>系统消息</span>
				<i class="iconfont right">&#xe626;</i>
			</li>
			<li onclick="window.location.href='${ctxWeb}/member/myBarcode'">
				<i class="iconfont">&#xe615;</i>
				<span>我的身份二维码</span>
				<i class="iconfont right">&#xe626;</i>
			</li>
			<%-- <li onclick="window.location.href='${ctxWeb}/member/insteadReceivingList'">
				<i class="iconfont">&#xe615;</i>
				<span>代收货人信息管理</span>
				<i class="iconfont right">&#xe626;</i>
			</li> --%>
			<li>
				<i class="iconfont">&#xe615;</i>
				<span>关于周范</span>
				<i class="iconfont right">&#xe626;</i>
			</li>
		</ul>
	</div>
</body>
    <script src="${ctxMobile}/pages/myCenter/mySetting/mySetting.js" type="text/javascript" ></script>
</html>