<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品列表管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
		
		});
		
		function add(){
			
		}
		
	</script>
</head>
<body>
	<form:form id="inputForm" modelAttribute="produce" action="${ctx}" method="post" class="form-horizontal">
		<form:hidden path="id"/>		
		<div class="control-group">
			<label class="control-label">安全库存：</label>
			<div class="controls">
				<form:input path="safeStock" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">标准库存：</label>
			<div class="controls">
				<form:input path="standardStock" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">警戒库存：</label>
			<div class="controls">
				<form:input path="warningStock" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
	</form:form>
	
</body>
</html>