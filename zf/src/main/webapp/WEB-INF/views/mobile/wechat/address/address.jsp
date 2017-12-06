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
    <title>添加收货地址</title>
     <link rel="stylesheet" media="screen and (max-width:330px)" href="${ctxMobile}/baseConfig/base320.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:331px) and (max-width:380px)" href="${ctxMobile}/baseConfig/base360.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:381px)" href="${ctxMobile}/baseConfig/base414.css" type="text/css" />
    <link rel="stylesheet" type="text/css" href="${ctxMobile}/lib/css/mobile-select-area.css">
    <link rel="stylesheet" type="text/css"href="${ctxMobile}/lib/css/dialog.css" />
    <link rel="stylesheet/less" href="${ctxMobile}/pages/address/address.less" />
    <script src="${ctxMobile}/lib/js/less-1.3.3.min.js" type="text/javascript"></script>
    <script src="${ctxMobile}/lib/js/zepto.min.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/dialog.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/mobile-select-area.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/mobile-select-date.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/zfutils.js" type="text/javascript" ></script>
</head>
<body >
<div class="">
	<form action="${ctxWeb }/member/addressWeb/address" name="addressForm" method="post">
		<div class="address_box">
			<input type="hidden" name="id" value="${address.id}"/>
			<div class="address_input">
				<label class="address_input_left">收货人姓名</label><input type="text" name="receiveName" placeholder="请输入收货人姓名" value="${address.receiveName}" data-notnull/>
			</div>	
			<div class="address_input">
				<label>手机号码</label><input type="tel" id="telephone" name="receiveTel" placeholder="手机号码" value="${address.receiveTel}" data-notnull/>
			</div>	
			<div class="address_select">
				<div>
					<label >省、市、区</label>
					<input type="text" id="txt_area" name="addressArea" placeholder="省、市、区" value="${address.addressArea}"  data-notnull/>
					<i class="iconfont">&#xe628;</i>
				</div>
			</div>	
			<div class="address_input">
				<label>详细地址</label><textarea type="text" name="addressDetail" placeholder="请您输入详细地址" value="${address.addressDetail}" data-notnull></textarea>
			</div>
			<div class="address_radio">
	 		    <input type="hidden" id="defaultFlag" name="defaultFlag" value="${address.defaultFlag}" >
			    <label class="">
			    	<c:choose>
			    		<c:when test="${address.defaultFlag == 1}">
							<i id="checkBoxI" data-val="1" class="iconfont">&#xe622;</i>
			    		</c:when>
			    		<c:otherwise>
							<i id="checkBoxI" data-val="0" class="iconfont">&#xe627;</i>
			    		</c:otherwise>
			    	</c:choose>
					<span class="">设为默认地址<b>(每次购买时会默认使用该地址)</b></span>
			    </label>
			</div>	
		</div>		
		
		<div class="address_button" >保存</div>
	</form>
</div>

	<%@ include file="/WEB-INF/views/mobile/include/viewPanel.jsp"%>
</body>
    <script src="${ctxMobile}/pages/address/address.js" type="text/javascript" ></script>
   
</html>