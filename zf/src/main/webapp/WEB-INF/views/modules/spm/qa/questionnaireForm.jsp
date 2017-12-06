<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>新建问卷</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small>
					<i class="fa-list-style"></i><a href="${ctx}/spm/qa/questionnaire/">问卷列表</a>
				</small>
				<shiro:hasPermission name="spm:qa:questionnaire:edit">
					<small>|</small>
					<small class="menu-active">
						<i class="fa fa-repeat"></i><a href="${ctx}/spm/qa/questionnaire/form?id=${questionnaire.id}">问卷<shiro:hasPermission name="spm:qa:questionnaire:edit">${not empty questionnaire.id?'修改':'添加'}</shiro:hasPermission></a>
					</small>
				</shiro:hasPermission>
			</h1>
		</section>
		
		<sys:tip content="${message}" />
		
		<section class="content">
			<form:form id="inputForm" onsubmit="return ZF.formSubmit()" modelAttribute="questionnaire" action="${ctx}/spm/qa/questionnaire/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<div class="row">
		    	<div class="col-md-6">
		            <div class="box box-success">
			            <div class="box-header with-border zf-query">
			            	<h5>问卷设置</h5>
			              	<div class="box-tools">
			                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			              	</div>
			            </div>
			            <div class="box-body">
    						<div class="form-group">
    							<label class="col-sm-2 control-label">问卷名称</label>
								<div class="col-sm-9">
									<sys:inputverify id="name" name="name" tip="请输入问卷名称，必填项" verifyType="0" isSpring="true" isMandatory="true"></sys:inputverify>
								</div>
    						</div>
    						<div class="form-group">
    							<label class="col-sm-2 control-label">问卷类别</label>
								<div class="col-sm-9">
									<form:select path="type" htmlEscape="false" maxlength="50" class="form-control select2">
										<form:options items="${fns:getDictList('spm_qa_questionnaire_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
								</div>
    						</div>
    						<div class="form-group">
    							<label class="col-sm-2 control-label">问卷标题</label>
								<div class="col-sm-9">
									<sys:inputverify id="title" name="title" value="${questionnaire.title }" tip="请输入问卷标题，必填项" verifyType="0" isSpring="true" isMandatory="true"></sys:inputverify>
								</div>
    						</div>
    						<div class="form-group">
    							<label class="col-sm-2 control-label">是否奖励积分</label>
								<div class="col-sm-9 zf-check-wrapper-padding">
									<form:radiobuttons path="rewardPointFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" delimiter="&nbsp;&nbsp;&nbsp;&nbsp;" />
								</div>
    						</div>
    						<div class="form-group" id="rewardPointNumDiv">
    							<label class="col-sm-2 control-label">奖励积分总数</label>
								<div class="col-sm-9">
									<sys:inputverify id="rewardPointNum" name="rewardPointNum" value="${questionnaire.rewardPointNum }" tip="请输入奖励积分数量,必填项且必须为正整数" verifyType="4" isSpring="true" maxlength="8" isMandatory="false"></sys:inputverify>
								</div>
    						</div>
    						<div class="form-group">
    							<label class="col-sm-2 control-label">问卷说明</label>
								<div class="col-sm-9">
									<textarea name="description" rows="4" maxlength="255" class="form-control input-xxlarge">${questionnaire.description }</textarea>
								</div>
    						</div>
    					</div>
		    			<div class="box-footer">
	    					<div class="pull-left box-tools">
				        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
				        	</div>
	    					<div class="pull-right box-tools">
				        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
			               		<button type="button" onclick="submitForm()" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button>
				        	</div>
	    				</div>
	    			</div>
    			</div>
    		</div>		
            </form:form>
        </section>
	</div>
	<script type="text/javascript">
		$(function() {
			$("input[type=radio]").iCheck({
				radioClass : 'iradio_minimal-blue'
			});
			
			$("input[type=radio]").on("ifChecked",function(){
				if($(this).val() == 1){
					$("#rewardPointNumDiv").css('display','block');
				}else if($(this).val() == 0){
					$("#rewardPointNum").val(""); //先清空积分值
					$("#rewardPointNumDiv").css('display','none');//隐藏
					$("#rewardPointNum").attr("data-verify",true);
				}
			})
			
		});
		
		function submitForm(){
			$("#inputForm").submit();			
		}
	</script>
</body>
</html>