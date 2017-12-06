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
    <title>设计师</title>
     <link rel="stylesheet" media="screen and (max-width:330px)" href="${ctxMobile}/baseConfig/base320.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:331px) and (max-width:380px)" href="${ctxMobile}/baseConfig/base360.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:381px)" href="${ctxMobile}/baseConfig/base414.css" type="text/css" />
    <link rel="stylesheet/less" href="${ctxMobile}/pages/character/designer/designer.less" />
    <script src="${ctxMobile}/lib/js/less-1.3.3.min.js" type="text/javascript"></script>
    <script src="${ctxMobile}/lib/js/zepto.min.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/jquery.unveil.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/iscroll-probe.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/zfutils.js" type="text/javascript" ></script>
</head>
<body>
<div class="designerTop">
	<ul>
		<li>
			<span id="" onclick="window.location.href='${ctxWeb}/bigcast'">时尚大咖</span>
		</li>
		<li class="active">
			<span id="" onclick="window.location.href='${ctxWeb}/designer'">设计师</span>
		</li>
		<li>
			<span id="" onclick="window.location.href='${ctxWeb}/mentor'">时尚导师</span>
		</li>
	</ul>
</div>
<div id="designerWarp" class="designerWarp">
	<div class="designerScroller">
		<div id="headerLoading" style="text-align:center;line-height:30px">
			<img style="height: 26px;width: 26px;margin: 2px 10px;float: none;" src="${ctxMobile}/img/loading.gif"/>
			正在载入...
		</div>
		<div id="designerWarpListView" class="">
			
		</div>
		<div id="listLoadingLi" style="text-align:center;line-height:30px">
			<img style="height: 26px;width: 26px;margin: 2px 10px;float: none;" src="${ctxMobile}/img/loading.gif"/>
			正在载入...
		</div>
	</div>
</div>
<script src="${ctxMobile}/pages/character/designer/designer.js" type="text/javascript" ></script>

</body>
</html>