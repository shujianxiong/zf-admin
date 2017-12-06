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
    <title>代收货人信息</title>
     <link rel="stylesheet" media="screen and (max-width:330px)" href="${ctxMobile}/baseConfig/base320.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:331px) and (max-width:380px)" href="${ctxMobile}/baseConfig/base360.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:381px)" href="${ctxMobile}/baseConfig/base414.css" type="text/css" />
    <link rel="stylesheet/less" href="${ctxMobile}/pages/myCenter/mySetting/insteadReceiving/insteadReceiving.less" />
    <script src="${ctxMobile}/lib/js/less-1.3.3.min.js" type="text/javascript"></script>
    <script src="${ctxMobile}/lib/js/zepto.min.js" type="text/javascript" ></script>
</head>
<body>
	<div class="address_head">
		您可以在此添加您的代理收货人员信息，帮助您代收货品，添加完成后，代收货人列表中的人员都能帮您代收货品
	</div>
<div class="address_list">
	<div class="list_item">
		<div class="name">
			<span>张三</span>
			<span>13212345689</span>
		</div>
		<div class="address">
			<p>身份证号：65325*************552</p>
		</div>
		<div class="list_botton">
			<span id="" class="edit" onclick="window.location.href='${ctxWeb}/member/insteadReceiverModifyEdit/1'">编辑</span>
			<span id="" class="delete">删除</span>
		</div>
	</div>
</div>
<div class="address_button" onclick="window.location.href='${ctxWeb}/member/insteadReceiveInfoSave'">添加新的代收货人</div>

</body>
    <script src="${ctxMobile}/pages/myCenter/mySetting/insteadReceiving/insteadReceiving.js" type="text/javascript" ></script>
</html>