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
    <title>我的收藏</title>
     <link rel="stylesheet" media="screen and (max-width:330px)" href="${ctxMobile}/baseConfig/base320.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:331px) and (max-width:380px)" href="${ctxMobile}/baseConfig/base360.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:381px)" href="${ctxMobile}/baseConfig/base414.css" type="text/css" />
    <link rel="stylesheet/less" href="${ctxMobile}/pages/myCenter/myRecord/myRecord.less" />
    <script src="${ctxMobile}/lib/js/less-1.3.3.min.js" type="text/javascript"></script>
    <script src="${ctxMobile}/lib/js/zepto.min.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/jquery.unveil.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/iscroll-probe.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/zfutils.js" type="text/javascript" ></script>
</head>
<body>
	<div class="completeInformation" onclick="window.location.href='${ctxWeb}/member/finishInformation'">
		<p>补充完会员资料即可获得体检资格</p>
		<i class="iconfont">&#xe626;</i>
		<span>完善资料</span>
	</div>
	<div class="myRecordList">
		<div class="top">
			<ul id="myRecordListTop" >
				<li data-type="nav" class="active" id="myRecordListTop_all" >
					<span >全部商品(<b id="goodsNum">${centerVO.goodsNum}</b>)</span>
				</li>
				<!--备注：页面功能待完善 --> 
				<li data-type="nav" id="myRecordListTop_fan">
					<span  >范儿(<b id="fanNum">${centerVO.fanNum}</b>)</span>
				</li>
				<li data-type="nav" id="myRecordListTop_edit">
					<span id="myRecordEdit">编辑</span>
				</li>
			</ul>
		</div>
		<!--
        	作者：40362313@qq.com
        	时间：2016-01-08
        	描述：编辑状态，goodsItem加edit变为class="goodsItem edit"
        -->
		<div class="goodsItem " id="goodsItemWap">
			<div data-type="item" id="myGoodsCollectWrapper" class="myGoodsCollectWrapper">
					<div class="oderCondent" id="oderCondent_goods" style="display: block;">
						<div class="loadingGoods" id="headerLoadingGoods" style="text-align:center;line-height:30px;background: #190d33;"><img style="height: 26px;width: 26px;margin: 2px 10px;float: none;" src="${ctxMobile}/pages/address/images/loading.gif"/>正在载入...</div>
						<div class="loadingGoods" id="bottomLoadingGoods" style="text-align:center;line-height:30px"><img style="height:26px;width:26px;margin:2px 10px;float:none;" src="${ctxMobile}/pages/address/images/loading.gif" />正在载入...</div>
						<%-- <div class="oderItem">
							<!--按钮选中为<i class="iconfont active">&#xe622;</i>-->
							<i class="iconfont" data-val = "0">&#xe627;</i>
							<div class="img"><img src="${ctxMobile}/myCenter/myRecord/images/goods1.png"/></div>
							<div class="text" >
								<h2>美憾凡尘PT950铂金长脚阶梯型精度切割钻石订婚戒指Mylove系列</h2>
								<p>库存5件（解锁时间7天）</p>
								<div class="price">
									<h2>租金:<span>￥52000</span></h2>
									<h2>押金:￥52000</h2>
								</div>
							</div>
							<div class="findAlike">
								找相似
							</div>
						</div> --%>
					</div>
				
			</div>
			<div data-type="item" id="myFanCollectWrapper" class="myFanCollectWrapper">
				<div class="oderCondent" id="oderCondent_fan" style="display: none;">
					<ul id="myFan_Collect">
						<li class="loadingFan" id="headerLoadingFan" style="text-align:center;line-height:30px;background: #190d33;"><img style="height: 26px;width: 26px;margin: 2px 10px;float: none;" src="${ctxMobile}/pages/address/images/loading.gif"/>正在载入...</li>
						<li class="loadingFan" id="bottomLoadingFan" style="text-align:center;line-height:30px"><img style="height:26px;width:26px;margin:2px 10px;float:none;" src="${ctxMobile}/pages/address/images/loading.gif" />正在载入...</li>
				        <%-- <li class="content_main_match_warp">
							<div id="" class="content_main_match_pic">
								<img src="${ctxMobile}/pages/myCenter/myRecord/images/changjing_02.png" />
								<span id="" class="likeNum">
									<i class="iconfont">&#xe613;</i>
									<b>1.2万</b>
								</span>
							</div>
							<ul class="content_main_match_subpic">
						        <li>
						            <img src="${ctxMobile}/pages/myCenter/myRecord/images/changjing_04.png" />
						        </li>
						        <li>
						            <img src="${ctxMobile}/pages/myCenter/myRecord/images/changjing_06.png" />
						        </li>
						    </ul>
				        </li> --%>
				        
				    </ul>
				</div>
			</div>
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
    <script src="${ctxMobile}/pages/myCenter/myRecord/myRecord.js" type="text/javascript" ></script>
</html>