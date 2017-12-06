<%@ page contentType="text/html;charset=UTF-8"%>
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
    <title>搜索</title>
     <link rel="stylesheet" media="screen and (max-width:330px)" href="${ctxMobile}/baseConfig/base320.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:331px) and (max-width:380px)" href="${ctxMobile}/baseConfig/base360.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:381px)" href="${ctxMobile}/baseConfig/base414.css" type="text/css" />
    <link rel="stylesheet/less" href="${ctxMobile}/pages/search/search.less" />
    <script src="${ctxMobile}/lib/js/less-1.3.3.min.js" type="text/javascript"></script>
    <script src="${ctxMobile}/lib/js/zepto.min.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/zfutils.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/pages/search/search.js" type="text/javascript" ></script>
</head>
<body>
	<header id="header" class="header">
		<form action="${ctxWeb }/doSearch" name="searchForm" method="post" onsubmit="formSubmit()">
			<div class="index_header_input">
				<input id="searchKey" type="search" maxlength="20" id="" value="${goodsListVO.keyWord }" placeholder="金镶玉" name="keyWord" />
			</div>
			<span id="searchSubmit">
				确定
			</span>
		</form>
	</header>
	<!--================自动提示========================-->
	<div class="search_autoHint" style="display: none;">
		<ul id="autoHintUl">
			
		</ul>
	</div>
	<!--================搜索历史========================-->
	<div class="search_history" style="display: block;">
		<div >
			<i class="iconfont">&#xe61f;</i>
			<span id="">
				历史搜索
			</span>
			<i id="delSearchCace" data-type="button" class="iconfont" >&#xe61d;</i>
		</div>
		<ul id="searchHistoryUl">
			
		</ul>
	</div>
	<!--================热门搜索========================-->
	<div class="search_history hot" style="display: block;">
		<div >
			<i class="iconfont">&#xe61e;</i>
			<span id="">
				热门搜索
			</span>
		</div>
		<ul>
			
		</ul>
	</div>
</body>
<script src="${ctxMobile}/lib/js/effect.js" type="text/javascript" ></script>
</html>