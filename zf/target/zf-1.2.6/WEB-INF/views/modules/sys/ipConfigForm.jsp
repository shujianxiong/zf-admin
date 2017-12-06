<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>IP白名单管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
	      <h1>
       		<small><i class="fa-ip"></i><a href="${ctx}/sys/ipConfig/list">IP白名单列表</a></small>
	        <small>|</small>
			<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/sys/ipConfig/form?id=${ipConfig.id}">IP白名单${not empty ipConfig.id?'修改':'添加'}</a></small>
	      </h1>
	    </section>
	    <sys:tip content="${message}"/>
	    <form:form id="inputForm" modelAttribute="ipConfig" action="${ctx}/sys/ipConfig/save" method="post" class="form-horizontal" onsubmit="return formSubmit();">
	   		<form:hidden path="id"/>
	    	<section class="content">
	    		<div class="row">
	    			<div class="col-md-6">
	    				<div class="box box-success">
			    			<div class="box-header with-border zf-query">
			    				<h5>IP白名单录入表单</h5>
			    			</div>
			    			<div class="box-body">
			    				<div class="form-group">
									<label for="ip" class="col-sm-2 control-label">白名单IP</label>
									<div class="col-sm-9">
									   <c:choose>
									       <c:when test="${empty ipConfig.id }">
									           <input type="text" name="ip" id="ip" placeholder="请录入ip地址，必填项" data-verify="false" value="${ipConfig.ip }" class="form-control"/>
									       </c:when>
									       <c:otherwise>
									           <form:hidden path="ip"/>
									           <form:input path="ip" disabled="true" class="form-control"/>
									       </c:otherwise>
									   </c:choose>
									</div>
								</div>
								<div class="form-group">
									<label for="activeFlag" class="col-sm-2 control-label">是否启用</label>
									<div class="col-sm-9 zf-check-wrapper-padding">
										<form:radiobuttons path="activeFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="minimal"/>
									</div>
								</div>
								<div class="form-group">
									<label for="remarks" class="col-sm-2 control-label">备注</label>
									<div class="col-sm-9">
										<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control" placeholder="请输入备注"/>
									</div>
								</div>
			    			</div>
			    			<div class="box-footer">
			    				<div class="pull-left box-tools">
					        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
					        	</div>
		    					<div class="pull-right box-tools">
		    					    <c:if test="${empty ipConfig.id }">
					        			<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
		    					    </c:if>
				               		<shiro:hasPermission name="sys:ipConfig:edit"><button type="submit"  class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
					        	</div>
				            </div>
			    		</div>
	    			</div>
	    		</div>
	    	</section>
		</form:form>
	</div>
<script>
$(function () {
 //iCheck for checkbox and radio inputs
   $('input[type="radio"]').iCheck({
		radioClass : 'iradio_minimal-blue'
   });
 
   $("#ip").on("change", function() {
       var val = $("#ip").val();
       if($.trim(val).length == 0) {
           ZF.showTip("IP不允许为空！", "warning");
           $(this).focus();
           $("button[type=submit]").attr('disabled',true);
           return false;
       }
       
       if(!ZF.formVerify(true, "8", val)) {
    	   ZF.showTip("IP格式不对，请核查！", "warning");
           $("button[type=submit]").attr('disabled',true);
           return false;
       }
       
       ZF.ajaxQuery(false, "${ctx}/sys/ipConfig/uniqueCheck",{"ip":val} , function(data) {
           if(data) {
               /* $("#loading").hide();
               ZF.showTip("恭喜您，该目录编码可用！", "info"); */
               $("button[type=submit]").attr('disabled',false);
               $(this).attr("data-verify", true);
           } else {
               ZF.showTip("IP重复录入！", "warning");
               $("button[type=submit]").attr('disabled',true);
           }
       });
   });
 
 });
 
 
 function formSubmit() {
	 var ip = $("#ip").val();
	 if(ip == null || ip == "" || ip == undefined) {
		 ZF.showTip("IP不允许为空!","info");
		 return false;
	 }
	 $("#inputForm").submit();
 }
</script>
</body>
</html>