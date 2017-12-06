<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fns" uri="/WEB-INF/tlds/fns.tld" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctxWeb" value="${pageContext.request.contextPath}${fns:getMobileIndexPath()}"/>
<c:set var="ctxMobile" value="${pageContext.request.contextPath}/mobile/wechat"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
	var ctxMobile="${pageContext.request.contextPath}/mobile/wechat";
	var ctxWeb="${pageContext.request.contextPath}${fns:getMobileIndexPath()}";
	var ctx="${pageContext.request.contextPath}";
</script>