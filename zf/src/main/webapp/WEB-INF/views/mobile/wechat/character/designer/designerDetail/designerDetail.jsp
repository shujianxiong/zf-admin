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
    <title>设计师详情</title>
     <link rel="stylesheet" media="screen and (max-width:330px)" href="${ctxMobile}/baseConfig/base320.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:331px) and (max-width:380px)" href="${ctxMobile}/baseConfig/base360.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:381px)" href="${ctxMobile}/baseConfig/base414.css" type="text/css" />
    <link rel="stylesheet/less" href="${ctxMobile}/pages/character/designer/designerDetail/designerDetail.less" />
    <script src="${ctxMobile}/lib/js/less-1.3.3.min.js" type="text/javascript"></script>
    <script src="${ctxMobile}/lib/js/zepto.min.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/jquery.unveil.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/iscroll-probe.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/zfutils.js" type="text/javascript" ></script>
</head>
<body>
	<input id="designerId" type="hidden" value="${designerVO.designer.id}" />
	<input id="goodsType" type="hidden" value="${designerVO.goodsType}" />

<div id="topSelectView" class="designerWorksList" style="position: fixed;left: 0px;top: 0px;display: none;z-index: 99;margin: 0;">
	<ul>
		<li data-type = "nav" data-val="1" data-item="allGoods">
			<span>全部作品<b>(${designerVO.goodsCount}+)</b></span>
		</li>
		<li data-type = "nav" data-val="2" data-item="hotGoods">
			<span>热门作品<b>(${designerVO.hotGoodsCount}+)</b></span>
		</li>
		<li data-type = "nav" data-val="3" data-item="foreGoods">
			<span>新款预定<b>(${designerVO.foreGoodsCount}+)</b></span>
		</li>
	</ul>
</div>
<div id="designerWarp" class="designerWarp">
	<div class="designerScroller">
		<div class="designerItem">
			<div id="upsideWarp">
				<div class="headArea" style="background-image: url(${designerVO.designer.displayPhoto});">
					<span class="attentionIcon" id="attentionIcon" data-mark="${designerVO.fansFlag}" onclick="designerFocus('${designerVO.designer.id}')" >
						<c:choose>
							<c:when test="${designerVO.fansFlag == '0'}">
								<i class="iconfont">&#xe624;</i>关注
							</c:when>
							<c:otherwise>
								 <i class="iconfont">&#xe606;</i>已关注 
							</c:otherwise>
						</c:choose>
					</span>
					<span class="shareIcon" id="shareIcon"  >
						<i class="iconfont">&#xe616;</i>
					</span>
					<div class="headPic">
						<img src="${designerVO.designer.gravatarPhotoUrl}"/>
					</div>
					<div class="name">
						<span>${designerVO.designer.name}</span>
						<i class="icon"><img src="${ctxMobile}/pages/character/designer/designerDetail/images/vip.png"/></i>
						<c:choose>
							<c:when test="${designerVO.designer.sex == '1'}">
								<i class="icon"><img src="${ctxMobile}/pages/character/designer/designerDetail/images/boy.png"/></i>
							</c:when>
							<c:otherwise>
								<i class="icon"><img src="${ctxMobile}/pages/character/designer/designerDetail/images/girl.png"/></i>
							</c:otherwise>
						</c:choose>
					</div>
					<p><i class="iconfont">&#xe618;</i>${designerVO.designer.country}</p>
					<ul>
						<li>
							粉丝<span id="fansNum">${designerVO.fansCount}</span>
						</li>
						<li>
							作品热度${designerVO.foreGoodsCount}
						</li>
						<li>
							作品租赁数${designerVO.goodsHotLevelSum}
						</li>
					</ul>
				</div>
				<div class="fansArea" id="fansArea">
					<c:forEach items="${designerVO.fansList}" var="designerFans">
						<span id="${designerFans.member.id}"><img data-type='lazyImg' data-height='false' src='"+ctxMobile+"/img/cachePic.png' data-src="${designerFans.member.gravatarPhotoUrl}"/></span>
					</c:forEach>
					<i class="iconfont">&#xe626;</i>
					<p>粉丝2万</p>
				</div>
				<div class="designerIntro">
					<h2>设计师简介</h2>
					<p>${designerVO.designer.introduction}</p>
				</div>
				<div id="designerWorksView" class="designerWorksList">
					<ul id="designerWorks">
						<li data-type = "nav" data-val="1" data-item="allGoods">
							<span>全部作品<b>(${designerVO.goodsCount}+)</b></span>
						</li>
						<li data-type = "nav" data-val="2" data-item="hotGoods">
							<span>热门作品<b>(${designerVO.hotGoodsCount}+)</b></span>
						</li>
						<li data-type = "nav" data-val="3" data-item="foreGoods">
							<span>新款预定<b>(${designerVO.foreGoodsCount}+)</b></span>
						</li>
					</ul>
				</div>
			</div>
			<div class="designerWorks" id="designerWorksPanel">
				<ul id="allDesignerWorks">
					
					<li id="bottomLoading">
						<img style="height: 26px;width: 26px;margin: 2px 10px;float: none;" src="${ctxMobile}/img/loading.gif"/>正在载入...
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/views/mobile/include/viewPanel.jsp"%>
</body>
	<script src="${ctxMobile}/pages/character/designer/designerDetail/designerDetail.js" type="text/javascript" ></script>
</html>