<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/mobile/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" /><!--viewport网页缩放-->
	<meta charset="utf-8" /><!-- UTF-8编码 -->
	<meta name="keywords" content="珠宝租赁" /><!-- 关键词 -->
	<meta name="format-detection" content="telephone=no" /><!-- 禁用自动识别电话号码 -->
	<meta name="apple-mobile-web-app-capable" content="yes" /><!-- 强制全屏 -->
	<meta name="msapplication-tap-highlight" content="no" /><!-- 禁用点击高光效果 -->
    <c:if test="${type eq 1}"><title>账户问题</title></c:if>
    <c:if test="${type eq 2}"><title>订单问题</title></c:if>
    <c:if test="${type eq 3}"><title>支付问题</title></c:if>
    <c:if test="${type eq 4}"><title>积分问题</title></c:if>
     <link rel="stylesheet" media="screen and (max-width:330px)" href="${ctxMobile}/baseConfig/base320.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:331px) and (max-width:380px)" href="${ctxMobile}/baseConfig/base360.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:381px)" href="${ctxMobile}/baseConfig/base414.css" type="text/css" />
    <link rel="stylesheet/less" href="${ctxMobile}/pages/myCenter/helpCenter/payQuestion/payQuestion.less" />
    <script src="${ctxMobile}/lib/js/less-1.3.3.min.js" type="text/javascript"></script>
    <script src="${ctxMobile}/lib/js/zepto.min.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/effect.js" type="text/javascript" ></script>
</head>
<body>

<div class="settingarea">
	<ul>
		<c:forEach items="${hcQuestions}" var="hcQuestions" >
			<li data-type="blackTab">
				<span>${hcQuestions.name}</span>
				<i class="iconfont right">&#xe626;</i>
			</li>
		</c:forEach>
	</ul>
</div>
<div id="" class="more">
	<p>没有需要的问题？</p>
	<h2>联系客服<span>400-888-888</span></h2>
</div>

</body>
    <script src="${ctxMobile}/pages/myCenter/helpCenter/payQuestion/payQuestion.js" type="text/javascript" ></script>
</html>