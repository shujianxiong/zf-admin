<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>报警发送设置管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
	<section class="content-header content-header-menu">
		<h1>
         	<small><i class="fa-list-style"></i><a href="${ctx}/msg/uw/warningConfig/list">报警接收设置列表</a></small>
	        
	        <shiro:hasPermission name="msg:uw:warningConfig:edit"><small>|</small><small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/msg/uw/warningConfig/form?id=${warningConfig.id}">报警接收设置${not empty warningConfig.id?'修改':'新增' }</a></small></shiro:hasPermission>
        </h1>
	</section>
	<sys:tip content="${message }" />
	<form:form id="inputForm" modelAttribute="warningConfig" action="${ctx}/msg/uw/warningConfig/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit()">
		<form:hidden path="id"/>
		<section class="content">
			<div class="row">
				<div class="col-md-6">
					<div class="box box-success">
						<div class="box-header with-border zf-query">
							<h5>报警接收信息</h5>
						</div>
						<div class="box-body">
							<div class="form-group">
								<label for="category" class="col-sm-2 control-label">警报类别</label>
								<div class="col-sm-9">
									<sys:selectverify name="category" tip="请选择警报类别，必填项" verifyType="0" dictName="msg_uw_warning_category" id="category"></sys:selectverify>
								</div>
							</div>
							<div class="form-group">
								<label for="type" class="col-sm-2 control-label">警报类型</label>
								<div class="col-sm-9">
									<sys:selectverify name="type" tip="请选择警报类型，必填项" verifyType="0" dictName="msg_uw_warning_type" id="type"></sys:selectverify>
								</div>
							</div>
							<div class="form-group">
								<label for="title" class="col-sm-2 control-label">标题</label>
								<div class="col-sm-9">
									<sys:inputverify name="title" id="title" verifyType="99" tip="请输入标题，必填项" maxlength="50" isSpring="true"></sys:inputverify>
								</div>
							</div>
							<div class="form-group">
								<label for="contentModel" class="col-sm-2 control-label">内容文本模型</label>
								<div class="col-sm-9">
                                    <sys:inputverify name="contentModel" id="contentModel" verifyType="99" tip="请输入文本模型，必填项" maxlength="50" isSpring="true"></sys:inputverify>
								</div>
							</div>
							<div class="form-group">
								<label for="receiveType" class="col-sm-2 control-label">接收类型</label>
								<div class="col-sm-9">
									<sys:selectverify name="receiveType" tip="请选择接收类型，必填项" verifyType="0" dictName="msg_uw_warning_config_receiveType" id="receiveType"></sys:selectverify>
								</div>
							</div>
							<div class="form-group">
								<label for="inputPassword3" class="col-sm-2 control-label">接收人</label>
								<div class="col-sm-9">
									<input type="hidden" id="receiveUserId" name="receiveUser.id" value="${warningConfig.receiveUser.id }"/>
									<sys:inputverify name="receiveUser.name" tip="请选择接收人，接收类型为设置指派时为必填项" verifyType="0" id="receiveUserName" forbidInput="true"
													 value="${fns:getUserById(warningConfig.receiveUser.id).name }" ></sys:inputverify>
									<sys:userselect id="receiveUser" url="${ctx}/sys/office/userTreeData" isMulti="false" title="人员选择" height="550" width="550"></sys:userselect>
								</div>
							</div>
							<div class="form-group">
								<label for="usableFlag" class="col-sm-2 control-label">启用标记</label>
								<div class="col-sm-9">
									<form:radiobuttons path="usableFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="minimal" />
								</div>
							</div>
							<div class="form-group">
								<label for="monitorFlag" class="col-sm-2 control-label">监控标记</label>
								<div class="col-sm-9">
									<form:radiobuttons path="monitorFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="minimal" />
								</div>
							</div>
							<div class="form-group">
								<label for="remarks" class="col-sm-2 control-label">备注信息</label>
								<div class="col-sm-9">
									<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control " />
								</div>
							</div>
						</div>
						<div class="box-footer">
		    				<div class="pull-left box-tools">
				        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
				        	</div>
	    					<div class="pull-right box-tools">
	    					    <c:if test="${empty warningConfig.id }">
					        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
	    					    </c:if>
			               		<shiro:hasPermission name="msg:uw:warningConfig:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
				        	</div>
			            </div>
					</div>
				</div>
			</div>
		</section>
		
		
	</form:form>
</div>
	
	<script type="text/javascript">
		$(function(){
			 //iCheck for checkbox and radio inputs
		    $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
			  radioClass : 'iradio_square-blue',
		    });
			 
			 var init = function(){
				 receiveUserinit({
			   		"selectCallBack":function(list){
	   					$("#receiveUserName").val(list[0].text);
	   					$("#receiveUserName").attr("data-verify",true);
	   					$("#receiveUserName").removeClass("zf-input-err");
	   					$("#receiveUserId").val(list[0].id);
	   					if($("#receiveUserNameErr").length>0){
	   						$("#receiveUserNameErr").remove();
	   					}
					}
				});
			 }
			 
			 
		    $("#receiveUserName").on("click",function(){
		    	init;
			});
		    
// 		    if($("#receiveType").val() == '0'){
		    	
// 		    }
		    
		    
		    $("#receiveType").on("change",function(){
		    	if($("#receiveType").val() == '0'){
		    		$("#receiveUserName").unbind("click",init);//系统指派时去掉click事件
		    		$("#receiveUserName").removeClass("zf-input-readonly");
   					$("#receiveUserName").removeClass("zf-input-err");
   					$("#receiveUserName").val("");
   					$("#receiveUserId").val("");
		    		$("#receiveUserName").attr("data-verify",true);
		    		if($("#receiveUserNameErr").length>0){
   						$("#receiveUserNameErr").remove();
   					}
		    	}else{
		    		$("#receiveUserName").addClass("zf-input-readonly");
		    		$("#receiveUserName").attr("data-verify",false);
		    		$("#receiveUserName").bind("click",init);//其他情况时启用click事件
		    	}
		    })
		})
	</script>
	
</body>
</html>