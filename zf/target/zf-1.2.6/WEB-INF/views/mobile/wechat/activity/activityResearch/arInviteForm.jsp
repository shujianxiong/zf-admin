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
    <script src="${ctxMobile}/pages/activity/activityResearch/arInviteForm.js" type="text/javascript" ></script>
   
</head>
<body>
	<input type="hidden" id="status" 	value="${echos.status }"/>
	<form action="${ctxWeb }/arInviteValidate" method="post" name="arInviteForm">
		<input type="hidden" name="arId"	value="${arValidateVO.arId }"/>
		<div class="register">
			<div class="input">
				<input type="tel" 	data-notnull id="phone" 		name="phone" value="${arValidateVO.phone}" placeholder="请输入手机号" maxlength="11"/>
			</div>
			<div class="input verif">
				<input type="text" 	data-notnull id="smsCode" 		name="smsCode" placeholder="请输入验证码" maxlength="20"/>
				<div class="button" data-key="0" id="getSmsCode" 	style="font-size: 16;">获取验证码</div>
			</div>
			<div class="input">
				<input type="text" 	data-notnull id="inviteCode"	name="inviteCode" value="${arValidateVO.inviteCode}" placeholder="请输入活动邀请码" maxlength="50"/>
			</div>
			<p>注册即表示同意<span>《用户注册条例》</span></p>
		</div>
		<div class="register_button" id="onSubmit">确定</div>
	</form>
<%@ include file="/WEB-INF/views/mobile/include/viewPanel.jsp"%>
</body>
   
</html>