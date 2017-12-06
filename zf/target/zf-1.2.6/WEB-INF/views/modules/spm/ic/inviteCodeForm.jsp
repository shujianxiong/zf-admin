<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>邀请码列表</title>
	<meta name="decorator" content="adminLte"/>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			 <h1>
				<small><i class="fa-list-style"></i><a href="${ctx}/spm/ic/inviteCode/list">邀请码列表</a></small>
				
				<shiro:hasPermission name="spm:ic:inviteCode:edit"><small>|</small><small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/spm/ic/inviteCode/form?id=${inviteCode.id}">邀请码${not empty inviteCode.id?'修改':'添加'}</a></small></shiro:hasPermission>
		      </h1>
		</section>
		<section class="content">
			<div class="row">
			<div class="col-md-6">
				<form:form id="inputForm" modelAttribute="inviteCode" action="${ctx}/spm/ic/inviteCode/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
					<div class="box box-success">
						<div class="box-header with-border zf-query">
		    				<h5>请完善表单填写</h5>
				            <div class="box-tools">
				               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
				            </div>
		    			</div>
						<div class="box-body">
							<form:hidden path="id" />
							<form:hidden path="createrType"/>
							<form:hidden path="createrId"/>
							<form:hidden path="inviteCode"/>
							
							<%-- <div class="form-group">
								<label class="col-sm-2 control-label">活动邀请人</label>
								<div class="col-sm-9">
									<form:hidden path="member.id" class="form-control" id="memberId"/>
									<form:input path="member.usercode" class="form-control zf-input-readonly" readonly="true" id="memberUsercode"/>
								</div>
							</div> --%>
							
							<div class="form-group">
								<label class="col-sm-2 control-label">邀请码</label>
								<div class="col-sm-9">
									<form:input path="inviteCode" readonly="true" class="form-control zf-input-readonly" disabled="true"/>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-2 control-label">活动</label>
								<div class="col-sm-9">
									<div class="input-group">
										<form:hidden path="activity.id" id="activityId"/>
										<form:input path="activity.name"  class="form-control zf-input-readonly" htmlEscape="false" maxlength="50" placeholder="请选择"  readonly="true" id="activityName" onclick="selectActivity();"/>
										<span class="input-group-addon" onclick="selectActivity();"><i class="fa fa-search"></i></span>										
									</div>
								</div>
							</div>
							
	    					<%-- <div class="form-group">
								<label class="col-sm-2 control-label">创建类型</label>
								<div class="col-sm-9">
									<sys:selectverify name="createrType" tip="请选择创建类型" verifyType="0" dictName="SPM_IC_INVITE_CODE_TYPE" id="createrTypeId"></sys:selectverify>
								</div>
							</div> --%>
							
							<div class="form-group">
								<label class="col-sm-2 control-label">备注</label>
								<div class="col-sm-9">
									<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
								</div>
							</div>
						</div>
						<div class="box-footer">
							<div class="pull-left box-tools">
					        	<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
					        </div>
		    				<div class="pull-right box-tools">
		    					<c:if test="${empty inviteCode.id }">
						        	<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
		    					</c:if>
				               	<shiro:hasPermission name="spm:ic:inviteCode:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
					        </div>
						</div>
					</div>
				</form:form>
			</div>
		</div>
		<%-- <sys:selectmutil id="memberSelect" title="会员列表" url="" isDisableCommitBtn="true" width="1200" height="700" ></sys:selectmutil> --%>
		<sys:selectmutil id="acActivitySelect" title="活动列表" url="" isDisableCommitBtn="true" width="1200" height="700" ></sys:selectmutil>
		</section>
	</div>
<script>
  $(function () {
	  $('input').iCheck({
			checkboxClass : 'icheckbox_minimal-blue',
			radioClass : 'iradio_minimal-blue'
		});
  	
	  /* $("#memberUsercode").on("click", function() {
			$("#memberSelectModalUrl").val("${ctx}/crm/mi/member/select?memberStatus=1&usercodeStatus=1&blackwhiteStatus=1");
      		$("#memberSelectModal").modal('toggle');//显示模态框
	  });
	  
	  $("#activityName").on("click", function() {
			$("#acActivitySelectModalUrl").val("${ctx}/spm/ac/acActivity/select");
      		$("#acActivitySelectModal").modal('toggle');//显示模态框
	  });
	  
	// Modal<iframe>回调事件,获取弹出框选择的货品信息
		$("#memberSelectModal #commitBtn").on("click",function () {
			$("#memberSelectModal").modal("hide");		
			var content = $("#memberSelectModalIframe").contents().find("body");
			$("input[type=radio]", content).each(function(){
				if($(this).prop("checked")){
					//重新选择产品清空原来数据
					$("tr",$("#tableList")).each(function(){
						$(this).remove();
					})
					$("#memberId").val($(this).val());
					$("#memberUsercode").val($(this).attr("data-name"));
				}
			});
		});
	  
	
		$("#acActivitySelectModal #commitBtn").on("click",function () {
			$("#acActivitySelectModal").modal("hide");		
			var content = $("#acActivitySelectModalIframe").contents().find("body");
			$("input[type=radio]", content).each(function(){
				if($(this).prop("checked")){
					//重新选择产品清空原来数据
					$("tr",$("#tableList")).each(function(){
						$(this).remove();
					})
					$("#activityId").val($(this).val());
					$("#activityName").val($(this).attr("data-name"));
				}
			});
		}); */
		
  });
  
  function selectActivity() {
	  var url="${ctx}/spm/ac/acActivity/select";
		$(".modal-title").text("选择活动");
		$("#acActivitySelectModalUrl").val(url);
		$("#commitBtn").unbind("click");
		$("#commitBtn").on("click",function () {
			var content = $("#acActivitySelectModalIframe").contents().find("body");//获取modal下iframe body，未做get封装，外部执行此行代码即可满足body可变性扩展
			$("input[type=radio]", content).each(function(){
				if($(this).prop("checked")){
					//重新选择产品清空原来数据
					$("tr",$("#tableList")).each(function(){
						$(this).remove();
					})
					$("#activityId").val($(this).val());
					$("#activityName").val($(this).attr("data-name"));
					
					$("#acActivitySelectModal").modal('hide');
				}
			});
		});
		$("#acActivitySelectModal").modal('toggle');
  }
</script>
</body>
</html>