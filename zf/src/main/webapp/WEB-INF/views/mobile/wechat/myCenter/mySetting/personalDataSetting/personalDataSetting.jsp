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
    <title>个人资料设置</title>
     <link rel="stylesheet" media="screen and (max-width:330px)" href="${ctxMobile}/baseConfig/base320.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:331px) and (max-width:380px)" href="${ctxMobile}/baseConfig/base360.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:381px)" href="${ctxMobile}/baseConfig/base414.css" type="text/css" />
    <link rel="stylesheet/less" href="${ctxMobile}/pages/myCenter/mySetting/personalDataSetting/personalDataSetting.less" />
    <script src="${ctxMobile}/lib/js/less-1.3.3.min.js" type="text/javascript"></script>
    <script src="${ctxMobile}/lib/js/zepto.min.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/zepto.cookie.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/zfutils.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/imgUpload.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/pages/myCenter/mySetting/personalDataSetting/personalDataSetting.js" type="text/javascript" ></script>
</head>
<body>
<input type="text" id="status" value="${echos.status }" style="display:none"/>
	<div class="message">
		<i class="iconfont">
			&#xe631;
			<span id="" onclick="window.location.href='${ctxWeb}/member/newsManagement'">${centerVO.messageNum}</span>
		</i>
	</div>
	<form action="${ctxWeb}/member/doPersonalDataSetting" method="post" name="personalDataSettingForm">
		<input id="idGravatarFile" type="file" style="display:none"/>
		<input id="idGravatarText" type="hidden" name="gravatar" value=""/>
		<c:if test="${empty centerVO.member.sex}">
			<input id="sexVal" type="hidden" name="sex" value="2"/>
		</c:if>
		<c:if test="${not empty centerVO.member.sex}">
			<input id="sexVal" type="hidden" name="sex" value="${centerVO.member.sex}"/>
		</c:if>
		<c:if test="${empty centerVO.member.shape}">
			<input id="shapeVal" type="hidden" name="shape" value="2"/>
		</c:if>
		<c:if test="${not empty centerVO.member.shape}">
			<input id="shapeVal" type="hidden" name="shape" value="${centerVO.member.shape}"/>
		</c:if>
	<div class="settingarea">
		<ul>
			<li id="photo" onclick="idGravatarFile.click()">
				<span>小咖头像</span>
				<i class="iconfont right">&#xe626;</i>
				<img id="leftImg" src="${ctx}/${centerVO.member.gravatarPhotoUrl}"/>
			</li>
			<li onclick="window.location.href='${ctxWeb}/member/nicknameSetting'">
				<span>小咖昵称</span>
				<i class="iconfont right">&#xe626;</i>
				<p>${centerVO.member.nickname}</p>
			</li>
			<li id="sex">
				<span>性别</span>
				<i class="iconfont right">&#xe626;</i>
				<p class="sexPval"><c:if test="${centerVO.member.sex == 1}">男</c:if><c:if test="${centerVO.member.sex != 1}">女</c:if></p>
			</li>
			<li onclick="window.location.href='${ctxWeb}/member/heightSetting'">
				<span>身高</span>
				<i class="iconfont right">&#xe626;</i>
				<p>${centerVO.member.height}cm</p>
			</li>
			<li id="shape">
				<span>身形</span>
				<i class="iconfont right">&#xe626;</i>
				<p class="shapePval"><c:if test="${centerVO.member.shape == 1}">上宽下窄</c:if>
				<c:if test="${centerVO.member.shape == 2}">匀称</c:if>
				<c:if test="${centerVO.member.shape == 3}">上窄下宽</c:if>
				<c:if test="${empty centerVO.member.shape}">匀称</c:if></p>
			</li>
		</ul>
	</div>
	<div id="bottomPullUpSelectSex" class="bottomPullUpSelectWarp sex" style="display: none">
		<div class="shade" ></div>
		<div id="selectSex" class="selectArea">
			<ul id="UiSex">
				<li date-val-sex="1">男</li>
				<li date-val-sex="2">女</li>
			</ul>
		</div>
	</div>
	<div id="bottomPullUpSelectSize" class="bottomPullUpSelectWarp size" style="display: none">
		<div class="shade" ></div>
		<div id="selectSize" class="selectArea">
			<ul id="UiShape">
				<li date-val-shape="2">匀称</li>
				<li date-val-shape="1">上宽下窄</li>
				<li date-val-shape="3">上窄下宽</li>
			</ul>
		</div>
	</div>
	<div id="onSubmit" class="button">
		提交
	</div>
	</form>
<%@ include file="/WEB-INF/views/mobile/include/viewPanel.jsp"%>
</body>
</html>