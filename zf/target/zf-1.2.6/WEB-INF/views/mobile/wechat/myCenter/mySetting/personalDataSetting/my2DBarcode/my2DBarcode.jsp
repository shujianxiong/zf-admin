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
    <title>我的身份二维码</title>
     <link rel="stylesheet" media="screen and (max-width:330px)" href="${ctxMobile}/baseConfig/base320.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:331px) and (max-width:380px)" href="${ctxMobile}/baseConfig/base360.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:381px)" href="${ctxMobile}/baseConfig/base414.css" type="text/css" />
    <link rel="stylesheet/less" href="${ctxMobile}/pages/myCenter/mySetting/personalDataSetting/my2DBarcode/my2DBarcode.less" />
    <script src="${ctxMobile}/lib/js/less-1.3.3.min.js" type="text/javascript"></script>
    <script src="${ctxMobile}/lib/js/zepto.min.js" type="text/javascript" ></script>
</head>
<body>
<div class="my2DBarcode">
	<div id="" class="my2DBarcode_top">
		<div class="pic">
			<img src="${ctx}/${centerVO.member.gravatarPhotoUrl}"/>
		</div>
		<span class="name">
			<p>${centerVO.member.nickname}</p>
		</span>
	</div>
	<div class="img"><img src="${ctxMobile}/pages/myCenter/myAgency/images/code.png"/></div> 
	<h2>身份二维码为你的个人信息，工作人员可以通过扫描二维码确认您的身份</h2>
</div>


</body>
    <script src="${ctxMobile}/pages/myCenter/mySetting/personalDataSetting/my2DBarcode/my2DBarcode.js" type="text/javascript" ></script>
    <script type="text/javascript">
    	$(".pic").height($(".pic").width());
    	$(".img").height($(".img").width())
    </script>
</html>