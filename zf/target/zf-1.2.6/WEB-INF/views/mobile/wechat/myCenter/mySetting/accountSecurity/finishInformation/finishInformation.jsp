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
    <title>完善身份信息</title>
     <link rel="stylesheet" media="screen and (max-width:330px)" href="${ctxMobile}/baseConfig/base320.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:331px) and (max-width:380px)" href="${ctxMobile}/baseConfig/base360.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:381px)" href="${ctxMobile}/baseConfig/base414.css" type="text/css" />
    <link rel="stylesheet/less" href="${ctxMobile}/pages/myCenter/mySetting/accountSecurity/finishInformation/finishInformation.less" />
    <script src="${ctxMobile}/lib/js/less-1.3.3.min.js" type="text/javascript"></script>
    <script src="${ctxMobile}/lib/js/zepto.min.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/zepto.cookie.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/zfutils.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/imgUpload.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/pages/myCenter/mySetting/accountSecurity/finishInformation/finishInformation.js" type="text/javascript" ></script>
</head>
<body>
<input type="text" id="status" value="${echos.status }" style="display:none"/>
<div class="textArea">
	<p>贵重物品交接，需要完善您的身份信息，确保交接过程中的安全，敬请谅解。</p>
	<p style="color: #999;">另：完善身份信息之后就可以使用保险及银行贷款业务，降低成本和风险哦</p>
</div>
<form action="${ctxWeb }/member/doFinishInformation" method="post" name="finishInformationForm">
<div class="inputArea">
	<!-- 加判断 ，判断状态是否为待提交，若不为待提交则设置为readOnly-->
	<c:if test="${centerVO.member.idCardCheckStatus == 0}">
		<input type="text" data-notnull name="name" id="name" value="${centerVO.member.name}" placeholder="请输入您的真实姓名" />
		<input type="tel" data-notnull name="idCard" id="idCard" value="${centerVO.member.idCard}" placeholder="请输入您的身份证号" />
	</c:if>
	<c:if test="${centerVO.member.idCardCheckStatus != 0}">
		<input type="text" data-notnull name="name" id="name" value="${centerVO.member.name}" placeholder="请输入您的真实姓名" readOnly="readonly"/>
		<input type="tel" data-notnull name="idCard" id="idCard" value="${centerVO.member.idCard}" placeholder="请输入您的身份证号" readOnly="readonly"/>
	</c:if>
	
</div>
<div class="uploadingPic">
	<p>请上传身份证正反面照片（请不要遮挡主要信息）</p>
	<div class="operateArea">
		<!-- 加判断 ，判断状态是否为待提交，若不为待提交则不响应click事件-->
			<c:if test="${centerVO.member.idCardCheckStatus == 0}">
		<div id="idCardLeft" class="left" onclick="idCardLeftFile.click()">
			</c:if>
			<c:if test="${centerVO.member.idCardCheckStatus != 0}">
		<div id="idCardLeft" class="left">
			</c:if>
			<input id="idCardLeftFile" type="file" style="display:none"/>
			<input id="idCardLeftText" type="hidden" name="leftIdCardFile" value="${centerVO.member.idCardPhotoFront }"/>
			<c:if test="${not empty centerVO.member.idCardPhotoFront}">
				<img id="leftImg" src="${centerVO.member.idCardPhotoFront}"/>
			</c:if>
		    <c:if test="${empty centerVO.member.idCardPhotoFront}">
		    	<img id="leftImg" src="${ctxMobile}/pages/myCenter/mySetting/accountSecurity/finishInformation/images/example2.png"/>
		    </c:if>
			<p>正面</p>
		</div>
		<!-- 加判断 ，判断状态是否为待提交，若不为待提交则不响应click事件-->
			<c:if test="${centerVO.member.idCardCheckStatus == 0}">
		<div id="idCardRight" class="right" onclick="idCardRightFile.click()">
			</c:if>
			<c:if test="${centerVO.member.idCardCheckStatus != 0}">
		<div id="idCardRight" class="right" >
			</c:if>
			<input id="idCardRightFile" type="file" style="display:none"/>
			<input id="idCardRightText" type="hidden" name="rightIdCardFile" value="${centerVO.member.idCardPhotoBack }"/>
		    <c:if test="${not empty centerVO.member.idCardPhotoBack}">
				<img id="rightImg" src="${centerVO.member.idCardPhotoBack}"/>
			</c:if>
		    <c:if test="${empty centerVO.member.idCardPhotoBack}">
		    	<img id="rightImg" src="${ctxMobile}/pages/myCenter/mySetting/accountSecurity/finishInformation/images/example2.png"/>
		    </c:if>
			<p>反面</p>
		</div>
	</div>
</div>
<div class="uploadingPic">
	<p class="textP">请上传身份证正反面照片（请不要遮挡主要信息）</p>
	<div class="operateArea">
		<div class="left">
			<img src="${ctxMobile}/pages/myCenter/mySetting/accountSecurity/finishInformation/images/id1.png"/>
			<p>正面</p>
		</div>
		<div class="right">
			<img src="${ctxMobile}/pages/myCenter/mySetting/accountSecurity/finishInformation/images/id2.png"/>
			<p>反面</p>
		</div>
	</div>
</div>
<!-- 加判断 ，判断状态是否为待提交，若不为待提交则不显示-->
<c:if test="${centerVO.member.idCardCheckStatus == 0}">
	<div id="onSubmit" class="button">
		提交
	</div>
</c:if>
<c:if test="${centerVO.member.idCardCheckStatus == 1}">
	<div class="button checking" >
		审核中
	</div>
</c:if>
<c:if test="${centerVO.member.idCardCheckStatus == 2}">
	<div class="button succeed" >
		审核成功
	</div>
</c:if>
</form>
<%@ include file="/WEB-INF/views/mobile/include/viewPanel.jsp"%>
</body>
</html>