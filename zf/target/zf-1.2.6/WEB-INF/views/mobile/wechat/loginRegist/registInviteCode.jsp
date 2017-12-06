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
    <title>注册</title>
    <link rel="stylesheet" media="screen and (max-width:330px)" href="${ctxMobile}/baseConfig/base320.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:331px) and (max-width:380px)" href="${ctxMobile}/baseConfig/base360.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:381px)" href="${ctxMobile}/baseConfig/base414.css" type="text/css" />
    <link rel="stylesheet/less" href="${ctxMobile}/pages/loginRegist/login.less" />
    <script src="${ctxMobile}/lib/js/less-1.3.3.min.js" type="text/javascript"></script>
    <script src="${ctxMobile}/lib/js/zepto.min.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/zfutils.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/pages/loginRegist/getVerificationCode.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/pages/loginRegist/regist.js" type="text/javascript" ></script>
</head>
<body>
	<input type="text" id="status" value="${echos.status }" style="display:none"/>
	<form action="${ctxWeb }/regist" name="smsForm" method="post" >
		<input type="text" name="openid" value="${openid }">
		<div class="register">
			<div class="input">
				<input type="tel" data-notnull id="usercode" name="usercode" value="${usercode}" placeholder="请输入手机号"></input>
			</div>
			<div class="input verif">
				<input type="text" data-notnull id="vaildataCode" name="smsCode" placeholder="请输入验证码"></input>
				<div class="button" data-key="0" id="captchaBtn">获取验证码</div>
			</div>
			<div class="input verif">
				<font color="#999">如果5分钟你您未收到验证码，请点击重新发送验证码。</font>
			</div>
			<div class="input">
				<input type="tel" data-notnull id="inviteCode" name="inviteCode" value="${inviteCode}" placeholder="请填写活动邀请码"></input>
			</div>
		</div>
	</form>
	<div class="register_button" id="onSubmit">下一步</div>
	<p class="registTip">注册成功后立即获得1000元现金券并享专属权益</p>
<%@ include file="/WEB-INF/views/mobile/include/viewPanel.jsp"%>
</body>
   
</html>