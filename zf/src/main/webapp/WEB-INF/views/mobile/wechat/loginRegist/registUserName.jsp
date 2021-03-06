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
    <title>注册</title>
    <link rel="stylesheet" media="screen and (max-width:330px)" href="${ctxMobile}/baseConfig/base320.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:331px) and (max-width:380px)" href="${ctxMobile}/baseConfig/base360.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:381px)" href="${ctxMobile}/baseConfig/base414.css" type="text/css" />
    <link rel="stylesheet/less" href="${ctxMobile}/pages/loginRegist/login.less" />
    <script src="${ctxMobile}/lib/js/less-1.3.3.min.js" type="text/javascript"></script>
    <script src="${ctxMobile}/lib/js/zepto.min.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/zfutils.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/pages/loginRegist/registUserName.js" type="text/javascript" ></script>
   
</head>
<body>
	<input type="text" id="status" value="${echos.status }" style="display:none"/>
	<form action="${ctxWeb }/doRegist" method="post" name="registForm">
		<div class="register">
			<div class="input">
				<input type="text" data-notnull value="${phone}" name="phone" readOnly="true"></input>
			</div>
			<div class="input">
				<input type="text" data-notnull placeholder="请输入用户昵称" value="${nickname}" id="nickname" maxlength="50" name="nickName" ></input>
			</div>
			<div class="input verif">
				<input type="password" data-notnull placeholder="密码长度6~14位,数字,字母,至少包含两种" id="passWord" maxlength="50" name="pwd"></input>
			</div>
			<div class="input verif">
				<input type="password" data-notnull placeholder="请确认登录密码" id="rePassWord" maxlength="50" name="rePwd"></input>
			</div>
			<p>注册即表示同意<span>《用户注册条例》</span></p>
		</div>
		<div class="register_button" id="onSubmit">确定</div>
	</form>
<%@ include file="/WEB-INF/views/mobile/include/viewPanel.jsp"%>
</body>
   
</html>