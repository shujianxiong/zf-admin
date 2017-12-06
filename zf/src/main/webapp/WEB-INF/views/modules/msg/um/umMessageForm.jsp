<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工消息中心管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
		      <small><i class="fa-mail-receive"></i><a href="${ctx}/msg/um/myUmMessage/list">收件箱</a></small>
	          <small>|</small>
	          <small><i class="fa-mail-send"></i><a href="${ctx}/msg/um/myUmMessage/sendList">发件箱</a></small>
	          <small>|</small>
	          <small><i class="fa-mail-all"></i><a href="${ctx}/msg/um/myUmMessage/listAllMy">所有</a></small>
	          
	          <shiro:hasPermission name="msg:um:umMessage:edit">
	              <small>|</small>
	       	      <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/msg/um/umMessage/form?id=${umMessage.id}" >发消息</a></small>
	       	  </shiro:hasPermission>
	       	</h1>
	    </section>
	    
	    <sys:tip content="${message}"/>
	    
		<section class="content">
			
			<div class="row">
				<div class="col-md-6">
					<form:form id="inputForm" modelAttribute="umMessage" action="${ctx}/msg/um/myUmMessage/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit()">
						<form:hidden path="id"/>
						<div class="box box-success">
							<div class="box-header with-border zf-query">
								<h5>新消息表单</h5>
							</div>
							<div class="box-body">
								<div class="form-group">
									<label for="category" class="col-sm-2 control-label">消息类别</label>
									<div class="col-sm-9">
										<sys:selectverify name="category" tip="请选择消息类别，必填项" verifyType="0" dictName="msg_um_message_category" id="categorySelect" ></sys:selectverify>
									</div>
								</div>
								<div class="form-group">
									<label for="category" class="col-sm-2 control-label">消息类型</label>
									<div class="col-sm-9">
										<sys:selectverify name="type" tip="请选择消息类型，必填项" verifyType="0" dictName="msg_um_message_type" id="typeSelect"></sys:selectverify>
									</div>
								</div>
								<div class="form-group">
									<label for="category" class="col-sm-2 control-label">发送用户</label>
									<div class="col-sm-9">
										<form:hidden path="sendUser.id"/>
										<form:input path="sendUser.name" class="form-control" htmlEscape="false" readonly="true"/>
									</div>
								</div>
								<div class="form-group">
									<label for="title" class="col-sm-2 control-label">标题</label>
									<div class="col-sm-9">
										<sys:inputverify name="title" tip="请输入标题，必填项" verifyType="0" id="titleInput"></sys:inputverify>
									</div>
								</div>
								<div class="form-group">
									<label for="content" class="col-sm-2 control-label">内容</label>
									<div class="col-sm-9">
										<form:textarea path="content" htmlEscape="false" rows="4" maxlength="255" class="form-control"/>
									</div>
								</div>
								<div class="form-group">
									<label for="receiveUserName" class="col-sm-2 control-label">接收用户</label>
									<div class="col-sm-9">
										<input type="hidden" id="receiveUserId" name="receiveUser.id"/>
										<sys:inputverify name="receiveUser.name" tip="请选择接收人，必填项" verifyType="0" id="receiveUserName" forbidInput="true" ></sys:inputverify>
  										<sys:userselect id="receiveUser" url="${ctx}/sys/office/userTreeData" isMulti="false" title="人员选择" height="550" width="550"></sys:userselect>
									</div>
								</div>
								<div class="form-group">
									<label for="category" class="col-sm-2 control-label">备注信息</label>
									<div class="col-sm-9">
										<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control"/>
									</div>
								</div>
							</div>
							<div class="box-footer">
		    					<div class="pull-left box-tools">
					        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
					        	</div>
		    					<div class="pull-right box-tools">
					        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
				               		<shiro:hasPermission name="lgt:ps:lgtPsCategory:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
					        	</div>
		    				</div>
						</div>
					</form:form>
				</div>
			</div>
		</section>
	</div>
	
	<script type="text/javascript">
		$(function(){
			//初始化时间选择器
			$(".datepicker").datepicker({
				format:'yy-mm-dd H:m:s'
			});
			
			$("#receiveUserName").addClass("zf-input-readonly");
			
			$("#receiveUserName").on("click",function(){
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
			})
		})
	</script>
	
		
</body>
</html>