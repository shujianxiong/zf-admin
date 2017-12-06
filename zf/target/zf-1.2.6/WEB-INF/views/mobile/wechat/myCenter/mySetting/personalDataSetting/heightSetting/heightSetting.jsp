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
    <title>填写身高</title>
     <link rel="stylesheet" media="screen and (max-width:330px)" href="${ctxMobile}/baseConfig/base320.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:331px) and (max-width:380px)" href="${ctxMobile}/baseConfig/base360.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:381px)" href="${ctxMobile}/baseConfig/base414.css" type="text/css" />
    <link rel="stylesheet/less" href="${ctxMobile}/pages/myCenter/mySetting/personalDataSetting/heightSetting/heightSetting.less" />
    <script src="${ctxMobile}/lib/js/less-1.3.3.min.js" type="text/javascript"></script>
    <script src="${ctxMobile}/lib/js/zepto.min.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/zepto.cookie.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/zfutils.js" type="text/javascript" ></script>
</head>
<body>
<input type="text" id="status" value="${echos.status }" style="display:none"/>
<form action="${ctxWeb }/member/doHeightSetting" method="post" name="heightSettingForm">
<div class="input">
	<c:if test="${not empty centerVO.member.height}">
		<input type="tel" name="height" data-notnull placeholder="请输入身高cm" id="height" value="${centerVO.member.height}" maxlength="3"></input>
	</c:if>
	<c:if test="${empty centerVO.member.height}">
		<input type="tel" name="height" data-notnull placeholder="请输入身高cm" id="height" value="" maxlength="3"></input>
	</c:if>
	<p>文字说明</p>
</div>
<div class="button" id="onSubmit">保存</div>
</form>
<%@ include file="/WEB-INF/views/mobile/include/viewPanel.jsp"%>
</body>
    <script src="${ctxMobile}/pages/myCenter/mySetting/personalDataSetting/heightSetting/heightSetting.js" type="text/javascript" ></script>
</html>