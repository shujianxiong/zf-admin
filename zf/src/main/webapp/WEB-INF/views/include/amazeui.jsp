
<%@ taglib prefix="shiro" uri="/WEB-INF/tlds/shiros.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fns" uri="/WEB-INF/tlds/fns.tld" %>
<%@ taglib prefix="fnc" uri="/WEB-INF/tlds/fnc.tld" %>

<c:set var="ctx" value="${pageContext.request.contextPath}${fns:getAdminPath()}"/>
<c:set var="ctxWeb" value="${pageContext.request.contextPath}${fns:getFrontPath()}"/>
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static"/>
<c:set var="ctxIco" value="${pageContext.request.contextPath}/images/admin-ico"/>

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<meta name="apple-mobile-web-app-title" content="周范" />
<link href="${ctxStatic}/amazeui/css/amazeui.min.css" rel="stylesheet" />
<link href="${ctxStatic}/amazeui/css/admin.css" rel="stylesheet" />
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="${ctxStatic}/amazeui/js/jquery.min.js"></script>
<!--<![endif]-->
<script src="${ctxStatic}/amazeui/js/amazeui.min.js"></script>
<script src="${ctxStatic}/amazeui/js/app.js"></script>