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
    <title>修改手机号</title>
     <link rel="stylesheet" media="screen and (max-width:330px)" href="${ctxMobile}/baseConfig/base320.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:331px) and (max-width:380px)" href="${ctxMobile}/baseConfig/base360.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:381px)" href="${ctxMobile}/baseConfig/base414.css" type="text/css" />
    <link rel="stylesheet/less" href="${ctxMobile}/pages/myCenter/mySetting/accountSecurity/modifyCellphone/modifyCellphone.less" />
    <script src="${ctxMobile}/lib/js/less-1.3.3.min.js" type="text/javascript"></script>
    <script src="${ctxMobile}/lib/js/zepto.min.js" type="text/javascript" ></script>
</head>
<body>
	<div class="message">
		请选择一种方式协助我们完成您账户的安全验证
	</div>
	<div class="settingarea">
		<ul>
			<li onclick="window.location.href='${ctxWeb}/member/verifyCellphone'">
				<span>通过“手机验证码”</span>
				<i class="iconfont right">&#xe626;</i>
			</li>
			<li>
				<span>通过“辨别过的商品”</span>
				<i class="iconfont right">&#xe626;</i>
			</li>
		</ul>
	</div>
</body>
    <script src="${ctxMobile}/pages/myCenter/mySetting/accountSecurity/modifyCellphone/modifyCellphone.js" type="text/javascript" ></script>
</html>