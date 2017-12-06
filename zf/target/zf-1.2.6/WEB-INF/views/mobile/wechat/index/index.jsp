<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/mobile/include/taglib.jsp"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <META name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" /><!--viewport网页缩放-->
	<META charset="utf-8" /><!-- UTF-8编码 -->
	<META name="keywords" content="珠宝租赁" /><!-- 关键词 -->
	<META name="format-detection" content="telephone=no" /><!-- 禁用自动识别电话号码 -->
	<META name="apple-mobile-web-app-capable" content="yes" /><!-- 强制全屏 -->
	<META name="msapplication-tap-highlight" content="no" /><!-- 禁用点击高光效果 --> 
    <title>一周一范</title>
    <link rel="stylesheet" media="screen and (max-width:330px)" href="${ctxMobile}/baseConfig/base320.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:331px) and (max-width:380px)" href="${ctxMobile}/baseConfig/base360.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:381px)" href="${ctxMobile}/baseConfig/base414.css" type="text/css" />
    <link rel="stylesheet/less" href="${ctxMobile}/pages/index/index.less"/>
    <script src="${ctxMobile}/lib/js/less-1.3.3.min.js" type="text/javascript"></script>
    <script src="${ctxMobile}/lib/js/zepto.min.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/lazyload.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/iscroll-probe.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/zfutils.js" type="text/javascript" ></script>
</head>
<body>
<header id="header" class="header">
	<div class="header_input">
		<input type="text" name="" id="" value="" placeholder="金镶玉" onclick="window.location.href='${ctxWeb }/search'"/>
	</div>
	<i class="iconfont" data-type="fontIconWhite">&#xe615;<span id="" >
			9+
		</span></i>
</header>
<form action="${ctxWeb }/doSearch" name="searchForm" method="post">
	<div class="index_header_input" style="display: none;">
		<input id="searchKey" type="search" maxlength="20" id="" value=""  name="keyWord" />
	</div>
</form>
<div id="warpper" >
	<div id="indexScroll">
		<div id="indexCondent" class="index_content">
			<div id="" class="index_content_rules">
				<ul>
					<li class="active">
						
					</li>
				</ul>
			</div>
			<div id="" class="index_content_like" >
				<div id="" class="index_content_header guessYouLike">
					—— 猜你喜欢 ——
				</div>
				<div id="guessYouLikeList" class="goods_list">
					<div id="bottomLoading" style="text-align:center;">
						<img style="height:26px;width:26px;margin:2px 10px;float:none;" src="${ctxMobile}/img/loading.gif" />即将推出...
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div id="" class="index_footer">
	<div class="footNav">
	 	<div class="footNav_sub active" onclick="window.location.href='${ctxWeb }/index'">
	 		<i class="iconfont">&#xe611;</i>
	 		<span>首页</span>
	 	</div>
	 	<div class="footNav_sub " onclick="window.location.href='${ctxWeb }/member/center'">
	 		<i class="iconfont">&#xe605;</i>
	 		<span>我的范儿</span>
	 	</div>
	</div>
</div>
<%@ include file="/WEB-INF/views/mobile/include/viewPanel.jsp"%>
</body>
    <script src="${ctxMobile}/lib/js/effect.js" type="text/javascript" ></script>
 <script src="${ctxMobile}/pages/index/index.js" type="text/javascript" ></script>

</html>