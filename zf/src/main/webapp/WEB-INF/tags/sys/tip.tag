<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="content" type="java.lang.String" required="true" description="消息内容"%>
<%@ attribute name="type" type="java.lang.String" description="消息类型：info、success、warning、error、loading"%>
<c:if test="${not empty content}">
	<c:if test="${not empty type}">
		<c:set var="ctype" value="${type}"/>
		<c:set var="ctypeIco" value="${type}"/>
	</c:if>
	<c:if test="${empty type}">
		<c:if test="${fn:indexOf(content,'失败') <= -1}">
			<c:set var="ctype" value="success"/>
			<c:set var="ctypeIco" value="check"/>
		</c:if>
		<c:if test="${fn:indexOf(content,'失败') > -1}">
			<c:set var="ctype" value="danger"/>
			<c:set var="ctypeIco" value="ban"/>
		</c:if>
		<c:if test="${fn:indexOf(content,'错误') > -1}">
			<c:set var="ctype" value="danger"/>
			<c:set var="ctypeIco" value="ban"/>
		</c:if>
		<c:if test="${fn:indexOf(content,'警告') > -1}">
			<c:set var="ctype" value="warning"/>
			<c:set var="ctypeIco" value="warning"/>
		</c:if>
		<c:if test="${fn:indexOf(content,'提示') > -1}">
			<c:set var="ctype" value="info"/>
			<c:set var="ctypeIco" value="info"/>
		</c:if>
	</c:if>
	<div id="tipDiv" class="margin alert alert-${ctype } alert-dismissible">
    	<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
    	<h4><i class="icon fa fa-${ctypeIco }"></i> 操作提示</h4>
    	${content}
    </div>
    <script type="text/javascript">
    	setTimeout(function(){
    		console.log($("#tipDiv").attr('class'));
    		if($("#tipDiv").attr('class') == 'margin alert alert-success alert-dismissible'){
    			$("#tipDiv").remove();    			
    		}
    	},5000);
    </script>
</c:if>