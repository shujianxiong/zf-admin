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
    <title>文章阅读记录权限测试</title>
    <link rel="stylesheet" media="screen and (max-width:330px)" href="${ctxMobile}/baseConfig/base320.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:331px) and (max-width:380px)" href="${ctxMobile}/baseConfig/base360.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:381px)" href="${ctxMobile}/baseConfig/base414.css" type="text/css" />
    <link rel="stylesheet/less" href="${ctxMobile}/pages/loginRegist/login.less" />
    <script src="${ctxMobile}/lib/js/less-1.3.3.min.js" type="text/javascript"></script>
    <script src="${ctxMobile}/lib/js/zepto.min.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/zfutils.js" type="text/javascript" ></script>
</head>
<body>
	<input type="text" id="status" 	value="${echos.status }" style="display:none"/>
	<div class="register">
		<div class="input">
		</div>
		<div class="input verif">
			<input type="text" data-notnull id="smsCode" name="smsCode" placeholder="${message}" maxlength="20"  style="text-align: center;"/>
			
		</div>
		<div class="input">
		</div>
	</div>
	<c:if test="${not empty arArticle }">
		<div class="content-wrapper sub-content-wrapper">
			<section class="content">
				<div class="row">
			    	<div class="col-md-12">
			            <div class="box box-primary">
				            <div class="box-body" style="text-align: center;">
								<strong>文章名称</strong>
								<p style="font: 13.3333px Arial;text-shadow: none;">
									${arArticle.name }
								</p>
								<br>
								<strong>文章类别</strong>
								<p style="font: 13.3333px Arial;text-shadow: none;">
									${fns:getDictLabel(arArticle.category, 'spm_ar_article_category', '')}
								</p>
								<br>
								<strong>文章标签</strong>
								<p style="font: 13.3333px Arial;text-shadow: none;">
									${arArticle.tags }
								</p>
								<br>
								<strong>文章标题</strong>
								<p style="font: 13.3333px Arial;text-shadow: none;">
									${arArticle.title }
								</p>
								<br>
								<strong>文章副标题</strong>
								<p style="font: 13.3333px Arial;text-shadow: none;">
									${arArticle.subtitle }
								</p>
								<br>
								<strong>发布时间</strong>
								<p style="font: 13.3333px Arial;text-shadow: none;">
									<fmt:formatDate value="${arArticle.publishTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</p>
								<br>
				            	<strong>分享小图</strong>
								<p>
									<img alt="Photo" data-big src="${imgHost }${arArticle.shareSPhoto }" data-src="${imgHost }${arArticle.shareSPhoto }" class="img-responsive" width="30px" height="30px">
								</p>
								<br>
				            	<strong>分享中图</strong>
								<p>
									<img alt="Photo" data-big src="${imgHost }${arArticle.shareMPhoto }" data-src="${imgHost }${arArticle.shareMPhoto }" class="img-responsive" width="30px" height="30px">
								</p>
								<br>
			    				<strong>简介</strong>
								<p  style="font: 13.3333px Arial;text-shadow: none;">
									${arArticle.summary }
								</p>
								<br>
								<strong>内容</strong>
								<p  style="font: 13.3333px Arial;text-shadow: none;">
									${arArticle.content }
								</p>
								<br>
	    					</div>
	    				</div>
	    			</div>
	    		</div>	
	    	</section>	
		</div>
	</c:if>
<%@ include file="/WEB-INF/views/mobile/include/viewPanel.jsp"%>
</body>
   
</html>