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
    <title>验证手机</title>
    <link rel="stylesheet" media="screen and (max-width:330px)" href="${ctxMobile}/baseConfig/base320.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:331px) and (max-width:380px)" href="${ctxMobile}/baseConfig/base360.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:381px)" href="${ctxMobile}/baseConfig/base414.css" type="text/css" />
    <link rel="stylesheet/less" href="${ctxMobile}/pages/myCenter/mySetting/accountSecurity/modifyCellphone/modifyCellphone.less" />
    <script src="${ctxMobile}/lib/js/less-1.3.3.min.js" type="text/javascript"></script>
    <script src="${ctxMobile}/lib/js/zepto.min.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/zepto.cookie.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/zfutils.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/pages/loginRegist/getVerificationCode.js" type="text/javascript" ></script>
</head>
<body>
	<input type="text" id="status" value="${echos.status }" style="display:none"/>
	<form action="${ctxWeb }/member/doVerifyCellphone" method="post" name="verifyCellphoneForm">
	<input type="hidden" id="telephone" name="phone" value="${centerVO.member.mobile}"/>
	<div class="modify">
		<p>${centerVO.member.mobile}</p>
		<div class="input verif">
			<input type="tel" data-notnull placeholder="请输入验证码" id="vaildataCode" name="smsCode"></input>
			<div class="button" data-key="0" id="captchaBtn">获取验证码</div>
		</div>
	</div>
	<div class="modify_button" id="onSubmitVerify">下一步</div>
	<span class="modify_span">选择其他方式验证</span>
	</form>
	<%@ include file="/WEB-INF/views/mobile/include/viewPanel.jsp"%>
</body>
<script src="${ctxMobile}/pages/myCenter/mySetting/accountSecurity/modifyCellphone/modifyCellphone.js" type="text/javascript" ></script>   
</html>