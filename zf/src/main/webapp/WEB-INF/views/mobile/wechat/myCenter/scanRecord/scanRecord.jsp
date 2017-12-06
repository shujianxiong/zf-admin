<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/mobile/include/taglib.jsp"%>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" /><!--viewport网页缩放-->
	<meta charset="utf-8" /><!-- UTF-8编码 -->
	<meta name="keywords" content="珠宝租赁" /><!-- 关键词 -->
	<meta name="format-detection" content="telephone=no" /><!-- 禁用自动识别电话号码 -->
	<meta name="apple-mobile-web-app-capable" content="yes" /><!-- 强制全屏 -->
	<meta name="msapplication-tap-highlight" content="no" /><!-- 禁用点击高光效果 -->
    <title>浏览记录</title>
     <link rel="stylesheet" media="screen and (max-width:330px)" href="${ctxMobile}/baseConfig/base320.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:331px) and (max-width:380px)" href="${ctxMobile}/baseConfig/base360.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:381px)" href="${ctxMobile}/baseConfig/base414.css" type="text/css" />
    <link rel="stylesheet/less" href="${ctxMobile}/pages/myCenter/scanRecord/scanRecord.less" />
    <script src="${ctxMobile}/lib/js/less-1.3.3.min.js" type="text/javascript"></script>
    <script src="${ctxMobile}/lib/js/zepto.min.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/iscroll-probe.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/jquery.unveil.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/zfutils.js" type="text/javascript" ></script>
</head>
<body>
	<div class="completeInformation" onclick="window.location.href='${ctxWeb}/member/finishInformation'">
		<p>补充完会员资料即可获得体检资格</p>
		<i class="iconfont">&#xe626;</i>
		<span>完善资料</span>
	</div>
	<div class="scanGoodsList">
		<div class="top">
			<ul id="myRecordListTop">
				<li class="active" id="myRecordListTop_all" data-type="1">
					<span id="" >全部商品<b>(${centerVO.goodsViewNum})</b></span>
				</li>
				<li id="myRecordListTop_fan" data-type="3">
					<span  >不看失效</span>
				</li>
				<li id="myRecordListTop_edit" data-type="2">
					<span id="myRecordEdit">编辑</span>
				</li>
			</ul>
		</div>
		<!--
        	作者：40362313@qq.com
        	时间：2016-01-08
        	描述：编辑状态，goodsItem加edit变为class="goodsItem edit"
        -->
		<div class="goodsItem">
		<input type="hidden" id="goodsStatus" value="${goodsStatus}"/>
			<ul>
				<div id="myGoodsViewWrapper" class="myGoodsViewWrapper">
					<div class="oderCondent" id="oderCondent_goods" >
						<div id="headerLoading" style="text-align:center;line-height:30px"><img style="height: 26px;width: 26px;margin: 2px 10px;float: none;" src="${ctxMobile}/pages/address/images/loading.gif"/>正在载入...</div>
						<div id="bottomLoading" style="text-align:center;line-height:30px"><img style="height:26px;width:26px;margin:2px 10px;float:none;" src="${ctxMobile}/pages/address/images/loading.gif" />正在载入...</div>
					</div>
				</div>
			</ul>
		</div>
	</div>
	<div id="removeBox" class="goodsDetail_funcBar" style="display: none;">
		<div id="remove" class="goodsDetail_funcBar_detail">
			删除
		</div>
		<div id="cancel" class="goodsDetail_funcBar_detail shopCart">
			取消
		</div>
	</div>
<%@ include file="/WEB-INF/views/mobile/include/viewPanel.jsp"%>
</body>
    <script src="${ctxMobile}/pages/myCenter/scanRecord/scanRecord.js" type="text/javascript" ></script>
</html>